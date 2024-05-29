using AniMATE_Api.DTOs;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using AniMATE_Api.Services;
using AniMATE_Api.Views;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace AniMATE_Api.Controllers;

[Route("api/[controller]")]
[ApiController]
// [Helper.Authorize]
public class PetController : ControllerBase
{
    private readonly IPetService _petService;
    private readonly IUserService _userService;
    private readonly IMapper _mapper;
    private readonly IFileService _fileService;

    public PetController(IPetService petService, IUserService userService, IMapper mapper, IFileService fileService)
    {
        _petService = petService;
        _userService = userService;
        _mapper = mapper;
        _fileService = fileService;
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
    [ProducesResponseType(200, Type = typeof(PetView))]
    [ProducesResponseType(400)]
    public IActionResult GetPetById(string id)
    {
        if (!_petService.PetExists(id))
        {
            return NotFound();
        }
        var pet = _petService.GetPetById(id);
        var response = _mapper.Map<PetView>(pet);
        return Ok(response);
    }

    [HttpPost("create")]
    [ProducesResponseType(204, Type = typeof(PetView))]
    [ProducesResponseType(400)]
    public IActionResult CreatePet([FromBody] PetDto petCreate, [FromQuery] string ownerId)
    {
        var request = _mapper.Map<Pet>(petCreate);
        if (request == null)
        {
            return BadRequest(ModelState);
        }

        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        
        var fileResult = _fileService.SaveImage(request.ImageFile);
        if (fileResult.Item1 == 1)
        {
            request.Image = fileResult.Item2;
        }
        else
        {
            ModelState.AddModelError("", fileResult.Item2);
            return BadRequest(ModelState);
        }
        
        request.Owner = _userService.GetUserById(ownerId)!;
        request.Owner.Pets.Add(request);
        
        if (!_petService.CreatePet(request, ownerId))
        {
            ModelState.AddModelError("", "Something went wrong while creating the pet!");
            return StatusCode(500, ModelState);
        }

        return Ok("Pet created successfully!");
    }

    [HttpPut("{id}")]
    [ProducesResponseType(204, Type = typeof(PetView))]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public IActionResult UpdatePet(string id, [FromBody] PetDto updatedPet)
    {   
        var request = _mapper.Map<Pet>(updatedPet);
        if(request == null) 
        {
            return BadRequest(ModelState);
        }
        if (!_petService.PetExists(id))
        {
            return NotFound();
        } 
        if(request.Id != id)
        {
            return BadRequest();
        }
        if (!ModelState.IsValid)
        {
            return BadRequest();
        }
        var fileResult = _fileService.SaveImage(request.ImageFile);
        if (fileResult.Item1 == 1)
        {
            request.Image = fileResult.Item2;
        }
        else
        {
            ModelState.AddModelError("", fileResult.Item2);
            return BadRequest(ModelState);
        }
        
        if(!_petService.UpdatePet(request))
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
        var response = _mapper.Map<IEnumerable<PetView>>(pets);
        return Ok(response);
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
        var response = _mapper.Map<ICollection<PetView>>(pets);
        return Ok(response);
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
        var response = _mapper.Map<ICollection<PetView>>(pets);
        return Ok(response);
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
        var response = _mapper.Map<ICollection<PetView>>(pets);
        return Ok(response);

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
        var response = _mapper.Map<IEnumerable<PetView>>(pets);
        return Ok(response);
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
        var response = _mapper.Map<IEnumerable<PetView>>(pets);
        return Ok(response);
    }
}