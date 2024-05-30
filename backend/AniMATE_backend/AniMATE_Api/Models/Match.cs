using System.ComponentModel.DataAnnotations;

namespace AniMATE_Api.Models;

public class Match
{
    [Key]
    [StringLength(1024)]
    public string Id { get; set; } = string.Empty;
    
    [Required]
    [StringLength(1024)]
    public string PetId { get; set; } = string.Empty;
    
    [Required]
    [StringLength(1024)]
    public string MatchedPetId { get; set; } = string.Empty;
    
    public bool Matched { get; set; } = false;
}