using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace AniMATE_Api.Controllers;

public class MatchController : ControllerBase
{
    private readonly IMatchService _matchService;

    public MatchController(IMatchService matchService)
    {
        _matchService = matchService;
    }
    
    [HttpGet("getAll")]
    [ProducesResponseType(200, Type = typeof(ICollection<Match>))]
    [ProducesResponseType(400)]
    public IActionResult GetAllPets()
    {
        var matches = _matchService.GetallMatches();
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        
        return Ok(matches);
    }
    
    [HttpGet("{id}")]
    [ProducesResponseType(200, Type = typeof(ICollection<Match>))]
    [ProducesResponseType(400)]
    public IActionResult GetMatchById(string id)
    {
        if (!_matchService.MatchExists(id))
        {
            return NotFound();
        }
        var response = _matchService.GetMatchById(id);
        return Ok(response);
    }
    
    [HttpGet("matches/{petId}")]
    [ProducesResponseType(200, Type = typeof(ICollection<Match>))]
    [ProducesResponseType(400)]
    public IActionResult GetMatchesByPetId(string petId)
    {   
        var response = _matchService.GetMatchesByPetId(petId);
        
        return Ok(response);
    }
    
    
    [HttpGet("matches/confirmed/{petId}")]
    [ProducesResponseType(200, Type = typeof(ICollection<Match>))]
    [ProducesResponseType(400)]
    public IActionResult GetConfirmedMatchesByPetId(string petId)
    {   
        var response = _matchService.GetConfirmedMatchesByPetId(petId);
        
        return Ok(response);
    }
    
    [HttpGet("matches/pending/{petId}")]
    [ProducesResponseType(200, Type = typeof(Match))]
    [ProducesResponseType(400)]
    public IActionResult GetPendingMatchesByPetId(string petId)
    {   
        var response = _matchService.GetPendingMatchesByPetId(petId);
        
        return Ok(response);
    }
    
    [HttpGet("match/{petId}/{matchedPetId}")]
    [ProducesResponseType(200, Type = typeof(Match))]
    [ProducesResponseType(400)]
    public IActionResult GetMatchByPetIdAndMatchedPetId(string petId, string matchedPetId)
    {   
        var response = _matchService.GetMatchByPetIdAndMatchedPetId(petId, matchedPetId);
        if(response == null)
        {
            ModelState.AddModelError("", "Match not found!");
            return BadRequest(ModelState);
        }
        return Ok(response);
    }
    
    [HttpPost("create")]
    [ProducesResponseType(204)]
    [ProducesResponseType(400)]
    public IActionResult CreateMatch(string petId, string matchedPetId)
    {
        if (petId == string.Empty || matchedPetId == string.Empty)
        {
            ModelState.AddModelError("", "PetId and MatchedPetId are required!");
            return BadRequest(ModelState);
        }
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        
        if (!_matchService.CreateMatch(petId, matchedPetId))
        {
            ModelState.AddModelError("", "Something went wrong while creating the match!");
            return StatusCode(500, ModelState);
        }
        var matched = _matchService.GetMatchByPetIdAndMatchedPetId(petId, matchedPetId)!.Matched;
        return Ok("Match created successfully! Matched: " + matched);
    }
    
    [HttpDelete("{id}")]
    [ProducesResponseType(204)]
    [ProducesResponseType(400)]
    public IActionResult DeleteMatch(string id)
    {
        _matchService.DeleteMatch(id);
        return NoContent();
    }
}