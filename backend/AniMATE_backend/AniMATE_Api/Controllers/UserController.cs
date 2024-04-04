using AniMATE_Api.Data;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace AniMATE_Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class UserController : ControllerBase
{
    private readonly DataContext _context;
    private readonly IUserService _userService;

    public UserController(IUserService userService)
    {
        _userService = userService;
    }

    [HttpGet]
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
    
    [HttpGet("{id}")]
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
    
    [HttpPost]
    [ProducesResponseType(201, Type = typeof(User))]
    public IActionResult CreateUser([FromBody] User user)
    {
        var newUser = _userService.CreateUser(user);
        if(newUser == null)
        {
            return BadRequest();
        }
        return CreatedAtAction("GetUserById", new { id = newUser.Id }, newUser);
    }
    
    [HttpPut("{id}")]
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
    
    [HttpDelete("{id}")]
    [ProducesResponseType(204)]
    public IActionResult DeleteUser(string id)
    {
        _userService.DeleteUser(id);
        return NoContent();
    }
}