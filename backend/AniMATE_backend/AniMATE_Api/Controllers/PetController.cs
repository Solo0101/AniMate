using AniMATE_Api.Helper;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace AniMATE_Api.Controllers;

[Route("api/[controller]")]
[ApiController]
[Authorize]
public class PetController : ControllerBase
{
    private readonly IPetService _petService;
    private readonly IUserService _userService;

    public PetController(IPetService petService, IUserService userService)
    {
        _petService = petService;
        _userService = userService;
    }

    [HttpGet("getAll")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetAllPets()
    {
        var pets = _petService.GetAllPets();
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        return Ok(pets);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(200, Type = typeof(Pet))]
    [ProducesResponseType(400)]
    public IActionResult GetPetById(string id)
    {
        if (!_petService.PetExists(id))
        {
            return NotFound();
        }
        var pet = _petService.GetPetById(id);

        return Ok(pet);
    }

    [HttpPost("create")]
    [ProducesResponseType(204, Type = typeof(Pet))]
    [ProducesResponseType(400)]
    public IActionResult CreatePet([FromBody] Pet petCreate, [FromQuery] string ownerId)
    {
        if (petCreate == null)
        {
            return BadRequest(ModelState);
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        petCreate.Owner = _userService.GetUserById(ownerId);

        if (!_petService.CreatePet(petCreate, ownerId))
        {
            ModelState.AddModelError("", "Something went wrong while creating the pet!");
            return StatusCode(500, ModelState);
        }

        return Ok("Pet created successfully!");
    }

    [HttpPut("{id}")]
    [ProducesResponseType(204, Type = typeof(Pet))]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public IActionResult UpdatePet(string id, [FromBody] Pet updatedPet)
    {
        if(updatedPet == null) 
        {
            return BadRequest(ModelState);
        }
        if (!_petService.PetExists(id))
        {
            return NotFound();
        } 
        if(updatedPet.Id != id)
        {
            return BadRequest();
        }
        if (!ModelState.IsValid)
        {
            return BadRequest();
        }
        if(!_petService.UpdatePet(updatedPet))
        {
              ModelState.AddModelError("", "Something went wrong while updating the pet!");
              return StatusCode(500, ModelState);
        }

        return NoContent();
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(204)]
    [ProducesResponseType(400)]
    public IActionResult DeletePet(string id)
    {
        _petService.DeletePet(id);
        return NoContent();
    }

    [HttpGet("owner/{ownerId}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetPetsByOwner(string ownerId)
    {
        var pets = _petService.GetPetsByOwner(ownerId);
        if (pets.Count == 0)
        {
            return NotFound();
        }

        return Ok(pets);
    }

    [HttpGet("type/{type}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetPetsByType(string type)
    {
        var pets = _petService.GetPetsByType(type);
        if (pets.Count == 0)
        {
            return NotFound();
        }

        return Ok(pets);
    }

    [HttpGet("breed/{breed}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetPetsByBreed(string breed)
    {
        var pets = _petService.GetPetsByBreed(breed);
        if (pets.Count == 0)
        {
            return NotFound();
        }

        return Ok(pets);
    }

    [HttpGet("age/{age}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetPetsByAge(int age)
    {
        var pets = _petService.GetPetsByAge(age);
        if (pets.Count == 0)
        {
            return NotFound();
        }

        return Ok(pets);
    }

    [HttpGet("gender/{gender}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetPetsByGender(GenderType gender)
    {
        var pets = _petService.GetPetsByGender(gender);
        if (pets.Count == 0)
        {
            return NotFound();
        }

        return Ok(pets);

    }

    [HttpGet("type/{type}/gender/{gender}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetPetsByTypeAndGender(string type, GenderType gender)
    {
        var pets = _petService.GetPetsByTypeAndGender(type, gender);
        if (pets.Count == 0)
        {
            return NotFound();
        }

        return Ok(pets);
    }

    [HttpGet("type/{type}/breed/{breed}/gender/{gender}")]
    [ProducesResponseType(200, Type = typeof(IEnumerable<Pet>))]
    [ProducesResponseType(400)]
    public IActionResult GetPetsByTypeBreedAndGender(string type, string breed, GenderType gender)
    {
        var pets = _petService.GetPetsByTypeBreedAndGender(type, breed, gender);
        if (pets.Count == 0)
        {
            return NotFound();
        }

        return Ok(pets);
    }
}