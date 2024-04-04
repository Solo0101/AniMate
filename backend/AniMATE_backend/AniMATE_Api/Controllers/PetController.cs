using AniMATE_Api.Data;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AniMATE_Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class PetController : ControllerBase
{
    private readonly IPetService _petService;

    public PetController(IPetService petService)
    {
        _petService = petService;
    }
    
    [HttpGet]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    public IActionResult GetAllPets()
    {
        var pets = _petService.GetAllPets();
        if(ModelState.IsValid)
        {
            return BadRequest(ModelState);
        } 
        
        return Ok(pets);
    }
    
    [HttpGet("{id}")]
    [ProducesResponseType(200, Type = typeof(Pet))]
    public IActionResult GetPetById(string id)
    {
        var pet = _petService.GetPetById(id);
        if(pet == null)
        {
            return NotFound();
        }
        return Ok(pet);
    }
    
    [HttpPost]
    [ProducesResponseType(201, Type = typeof(Pet))]
    public IActionResult CreatePet([FromBody] Pet pet)
    {
        var newPet = _petService.CreatePet(pet);
        if(newPet == null)
        {
            return BadRequest();
        }
        return CreatedAtAction("GetPetById", new { id = newPet.Id }, newPet);
    }
    
    [HttpPut("{id}")]
    [ProducesResponseType(200, Type = typeof(Pet))]
    public IActionResult UpdatePet(string id, [FromBody] Pet pet)
    {
        if(id != pet.Id)
        {
            return BadRequest();
        }
        var updatedPet = _petService.UpdatePet(pet);
        if(updatedPet == null)
        {
            return NotFound();
        }
        return Ok(updatedPet);
    }
    
    [HttpDelete("{id}")]
    [ProducesResponseType(204)]
    public IActionResult DeletePet(string id)
    {
        _petService.DeletePet(id);
        return NoContent();
    }
    
    [HttpGet("owner/{ownerId}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    public IActionResult GetPetsByOwner(string ownerId)
    {
        var pets = _petService.GetPetsByOwner(ownerId);
        if(pets == null)
        {
            return NotFound();
        }
        return Ok(pets);
    }
    
    [HttpGet("type/{type}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    public IActionResult GetPetsByType(string type)
    {
        var pets = _petService.GetPetsByType(type);
        if(pets == null)
        {
            return NotFound();
        }
        return Ok(pets);
    }
    
    [HttpGet("breed/{breed}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    public IActionResult GetPetsByBreed(string breed)
    {
        var pets = _petService.GetPetsByBreed(breed);
        if(pets == null)
        {
            return NotFound();
        }
        return Ok(pets);
    }
    
    [HttpGet("age/{age}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    public IActionResult GetPetsByAge(int age)
    {
        var pets = _petService.GetPetsByAge(age);
        if(pets == null)
        {
            return NotFound();
        }
        return Ok(pets);
    }
    
}