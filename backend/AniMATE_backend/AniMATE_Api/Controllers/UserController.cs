using AniMATE_Api.AuthModels;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace AniMATE_Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class UserController : ControllerBase
{
    private readonly IUserService _userService;
    private readonly UserManager<User> _userManager;
    private readonly SignInManager<User> _signInManager;

    public UserController(IUserService userService, UserManager<User> userManager, SignInManager<User> signInManager)
    {
        _userService = userService;
        _userManager = userManager;
        _signInManager = signInManager;
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
    
    [HttpGet("get/{id}")]
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
    
    [HttpPost("register")]
    [ProducesResponseType(201, Type = typeof(User))]
    [ProducesResponseType(400)]
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
    [ProducesResponseType(400)]
    public async Task<IActionResult> LoginUser(LoginModel model)
    {
        var user = await _userManager.FindByEmailAsync(model.Email!);
        if(user != null && !_userService.UserExists(user.Id))
        {
            return NotFound();
        }
        var result = await _signInManager.CheckPasswordSignInAsync(user!, model.Password!, false);
        if(!result.Succeeded)
        {
            return BadRequest();
        }
        return Ok(user);
    }
    
    [HttpPut("update/{id}")]
    [ProducesResponseType(200, Type = typeof(User))]
    [ProducesResponseType(400)]
    public IActionResult UpdateUser(string id, [FromBody] User user)
    {
        if(!_userService.UserExists(id))
        {
            return NotFound();
        }
        var updatedUser = _userService.UpdateUser(user);
        if(!ModelState.IsValid)
        {
            return BadRequest();
        }
        return Ok(updatedUser);
    }
    
    [HttpDelete("delete/{id}")]
    [ProducesResponseType(204)]
    [ProducesResponseType(400)]
    public IActionResult DeleteUser(string id)
    {
        if(!_userService.UserExists(id))
        {
            return NotFound();
        }
        _userService.DeleteUser(id);
        return NoContent();
    }
    
}