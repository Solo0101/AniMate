using AniMATE_Api.Models;

namespace AniMATE_Api.Interfaces;

public interface IMatchService
{
    ICollection<Match> GetallMatches();
    Match? GetMatchById(string id);
    Match? GetMatchByPetIdAndMatchedPetId(string petId, string matchedPetId);
    ICollection<Match> GetMatchesByPetId(string petId);
    ICollection<Match> GetConfirmedMatchesByPetId(string petId);
    ICollection<Match> GetPendingMatchesByPetId(string petId);
    bool CreateMatch(string petId, string matchedPetId);
    bool DeleteMatch(string id);
    bool MatchExists(string id);
    string PendingMatchExists(string petId, string matchedPetId);
    bool Save();
}