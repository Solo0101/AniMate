using AniMATE_Api.AuthModels;
using AniMATE_Api.Data;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace AniMATE_Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class UserController : ControllerBase
{
    private readonly DataContext _context;
    private readonly IUserService _userService;
    private readonly UserManager<User> _userManager;
    private readonly SignInManager<User> _signInManager;

    public UserController(IUserService userService, DataContext context, UserManager<User> userManager, SignInManager<User> signInManager)
    {
        _userService = userService;
        _context = context;
        _userManager = userManager;
        _signInManager = signInManager;
    }

    [HttpGet("getAll")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<User>))]
    public IActionResult  GetAllUsers()
    {
        var users = _userService.GetAllUsers();
        if(!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        return Ok(users);
    }
    
    [HttpGet("get/{id}")]
    [ProducesResponseType(200, Type = typeof(User))]
    public IActionResult GetUserById(string id)
    {
        var user = _userService.GetUserById(id);
        if(user == null)
        {
            return NotFound();
        }
        return Ok(user);
    }
    
    [HttpPost("register")]
    [ProducesResponseType(201, Type = typeof(User))]
    public async Task<IActionResult> CreateUser(RegisterModel model)
    {
        var newUser = _userService.CreateUser(model);
        var result = await _userManager.CreateAsync(newUser, newUser.PasswordHash!);
        if(!result.Succeeded)
        {
            return BadRequest(result.Errors);
        }
        
        return CreatedAtAction("GetUserById", new { id = newUser.Id }, newUser);
    }
    
    [HttpPost("login")]
    [ProducesResponseType(200, Type = typeof(User))]
    public async Task<IActionResult> LoginUser(LoginModel model)
    {
        var user = await _userManager.FindByEmailAsync(model.Email!);
        if(user == null)
        {
            return NotFound();
        }
        var result = await _signInManager.CheckPasswordSignInAsync(user, model.Password!, false);
        if(!result.Succeeded)
        {
            return BadRequest();
        }
        return Ok(user);
    }
    
    [HttpPut("update/{id}")]
    [ProducesResponseType(200, Type = typeof(User))]
    public IActionResult UpdateUser(string id, [FromBody] User user)
    {
        if(id != user.Id)
        {
            return BadRequest();
        }
        var updatedUser = _userService.UpdateUser(user);
        if(updatedUser == null)
        {
            return NotFound();
        }
        return Ok(updatedUser);
    }
    
    [HttpDelete("delete/{id}")]
    [ProducesResponseType(204)]
    public IActionResult DeleteUser(string id)
    {
        _userService.DeleteUser(id);
        return NoContent();
    }
}