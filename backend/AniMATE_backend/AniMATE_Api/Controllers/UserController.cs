using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using AniMATE_Api.DTOs;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using AniMATE_Api.Views;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using JwtRegisteredClaimNames = Microsoft.IdentityModel.JsonWebTokens.JwtRegisteredClaimNames;

namespace AniMATE_Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class UserController : ControllerBase
{
    private readonly IUserService _userService;
    private readonly UserManager<User> _userManager;
    private readonly SignInManager<User> _signInManager;
    private readonly IConfiguration _config;
    private readonly IMapper _mapper;

    public UserController(IUserService userService, UserManager<User> userManager, SignInManager<User> signInManager, IConfiguration config, IMapper mapper)
    {
        _userService = userService;
        _userManager = userManager;
        _signInManager = signInManager;
        _config = config;
        _mapper = mapper;
    }

    [HttpGet("getAll")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<User>))]
    [ProducesResponseType(400)]
    public IActionResult  GetAllUsers()
    {
        var users = _userService.GetAllUsers();
        if(!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        return Ok(users);
    }
    
    [HttpGet("{id}")]
    [ProducesResponseType(200, Type = typeof(User))]
    [ProducesResponseType(400)]
    public IActionResult GetUserById(string id)
    {
        var user = _userService.GetUserById(id);
        if(!_userService.UserExists(id))
        {
            return NotFound();
        }
        return Ok(user);
    }
    
    [HttpGet($"get/{{email}}")]
    [ProducesResponseType(200, Type = typeof(User))]
    [ProducesResponseType(400)]
    public IActionResult GetUserByEmail(string email)
    {
        var user = _userService.GetUserByEmail(email);
        if(email == null)
        {
            return BadRequest();
        }
        if(user == null)
        {
            return NotFound();
        }
        if(!_userService.UserExists(user.Id))
        {
            return NotFound();
        }
        return Ok(user);
    }
    
    [HttpPost("register")]
    [ProducesResponseType(201, Type = typeof(User))]
    [ProducesResponseType(400)]
    [AllowAnonymous]
    public async Task<IActionResult> CreateUser(RegisterDto userRegisterDto)
    {
        var existingUser = await _userManager.FindByEmailAsync(userRegisterDto.Email);
        var request = _mapper.Map<User>(userRegisterDto);
        if (request != null)
        {
            return BadRequest("User with this email already exists!");
        }
        if(!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        var newUser = _userService.CreateUser(request!);
        var result = await _userManager.CreateAsync(newUser, newUser.PasswordHash!);
        if(!result.Succeeded)
        {
            return BadRequest(result);
        }
        return CreatedAtAction("GetUserById", new { id = newUser.Id }, newUser);
    }
    
    [HttpPost("login")]
    [ProducesResponseType(200, Type = typeof(User))]
    [ProducesResponseType(400)]
    [AllowAnonymous]
    public async Task<IActionResult> LoginUser(LoginDto userLoginDto)
    {
        var user = await _userManager.FindByEmailAsync(userLoginDto.Email!);
        if(user == null)
        {
            return NotFound();
        }
        var result = await _signInManager.CheckPasswordSignInAsync(user, userLoginDto.Password!, false);
        string encodedToken;
        if(!result.Succeeded)
        {
            return BadRequest();
        }
        else
        {
            encodedToken = GenerateEncodedToken(user.Id, "Mobile", DateTime.UtcNow.AddYears(1));

        }
        var response = _mapper.Map<LoginResponseView>(user);
        response.Token = encodedToken;
        return Ok(response);
    }
    
    [HttpPut("update/{id}")]
    [ProducesResponseType(204)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    // [Helper.Authorize]
    public IActionResult UpdateUser(string id, [FromBody] ManageUserDto updatedUser)
    {
        if(updatedUser == null)
        {
            return BadRequest(ModelState);
        }
        var userUpdateValue = _mapper.Map<User>(updatedUser);
        if(!_userService.UserExists(id))
        {
            return NotFound();
        }
        if(updatedUser.Id != id)
        {
            return BadRequest();
        }
        if(!ModelState.IsValid)
        {
            return BadRequest();
        }
        if(!_userService.UpdateUser(userUpdateValue))
        {
            ModelState.AddModelError("", "Something went wrong while updating the user!");
            return StatusCode(500, ModelState);
        }
        
        return NoContent();
    }
    
    [HttpDelete("delete/{id}")]
    [ProducesResponseType(204)]
    [ProducesResponseType(400)]
    // [Helper.Authorize]
    public IActionResult DeleteUser(string id)
    {
        if(!_userService.UserExists(id))
        {
            return NotFound();
        }
        _userService.DeleteUser(id);
        return NoContent();
    }
    
    private string GenerateEncodedToken(string userId, string device, DateTime expire, IList<string> roles = null!)
    {
        // Initialize a list of claims for the JWT. These include the user's ID and device information,
        // a unique identifier for the JWT, and the time the token was issued.
        List<Claim> claims =
        [
            new Claim(JwtRegisteredClaimNames.Sub, userId),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.Ticks.ToString(), ClaimValueTypes.Integer64),
            new Claim(ClaimTypes.System, device)
        ];

        // If any roles are provided, add them to the list of claims. Each role is a separate claim.
        // if (roles.Any())
        // {
        //     foreach (var role in roles)
        //     {
        //         claims.Add(new Claim(ClaimTypes.Role, role));
        //     }
        // }

        // Create the JWT security token and encode it.
        // The JWT includes the claims defined above, the issuer and audience from the config, and an expiration time.
        // It's signed with a symmetric key, also from the config, and the HMAC-SHA256 algorithm.
        var token = new JwtSecurityToken(
            issuer: _config["Jwt:Issuer"],
            audience: _config["Jwt:Audience"],
            claims: claims,
            expires: expire,
            signingCredentials: new SigningCredentials(
                new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]!)),
                SecurityAlgorithms.HmacSha256)
        );

        // Convert the JWT into a string format that can be included in an HTTP header.
        var encodedToken = new JwtSecurityTokenHandler().WriteToken(token);

        return encodedToken;
    }
}