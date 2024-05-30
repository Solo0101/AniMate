using AniMATE_Api.Data;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;

namespace AniMATE_Api.Services;

public class MatchService : IMatchService
{
    private readonly DataContext _context;
    public MatchService(DataContext context)
    {
        _context = context;
    }
    public ICollection<Match> GetallMatches()
    {
        return _context.Matches.ToList();
    }

    public Match? GetMatchById(string id)
    {
        return _context.Matches.FirstOrDefault(m => m.Id == id);
    }

    public Match? GetMatchByPetIdAndMatchedPetId(string petId, string matchedPetId)
    {
        return _context.Matches.FirstOrDefault(m => m.PetId == petId && m.MatchedPetId == matchedPetId);
    }

    public ICollection<Match> GetMatchesByPetId(string petId)
    {
        return _context.Matches.Where(m => m.PetId == petId).ToList();
    }
    
    public ICollection<Match> GetConfirmedMatchesByPetId(string petId)
    {
        return _context.Matches.Where(m => m.PetId == petId && m.Matched).ToList();
    }
    
    public ICollection<Match> GetPendingMatchesByPetId(string petId)
    {
        return _context.Matches.Where(m => m.PetId == petId && !m.Matched).ToList();
    }
    
    public bool CreateMatch(string petId, string matchedPetId)
    {
        var match = new Match
        {
            PetId = petId,
            MatchedPetId = matchedPetId
        };
        
        var existingMatchId =  PendingMatchExists(match.PetId, match.MatchedPetId);
        if(existingMatchId != string.Empty)
        {
            var existingMatch = GetMatchById(existingMatchId);
            if(existingMatch != null)
            {
                existingMatch.Matched = true;
                _context.Matches.Update(existingMatch);
                match.Id = Guid.NewGuid().ToString();
                match.Matched = true;
                _context.Matches.Add(match);
                return Save();
            }
        }
        match.Id = Guid.NewGuid().ToString();
        _context.Matches.Add(match);
        return Save();
    }

    public bool DeleteMatch(string id)
    {
        var match = GetMatchById(id);
        var correspondingMatch= _context.Matches.FirstOrDefault(m => m.PetId == match!.MatchedPetId && m.MatchedPetId == match.PetId);
        _context.Matches.Remove(GetMatchById(match!.Id)!);
        _context.Matches.Remove(GetMatchById(correspondingMatch!.Id)!);
        return Save();
    }

    public bool MatchExists(string id)
    {
        return _context.Matches.Any(m => m.Id == id);
    }

    public string PendingMatchExists(string petId, string matchedPetId)
    {
        var match = _context.Matches.FirstOrDefault(m => m.PetId == matchedPetId && m.MatchedPetId == petId && !m.Matched);
        return match == null ? string.Empty : match.Id;
    }

    public bool Save()
    {
        var saved = 0;
        try
        {
            saved = _context.SaveChanges();
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return false;    
        }
        return saved > 0;
    }
}