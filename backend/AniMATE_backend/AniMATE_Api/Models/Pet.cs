using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AniMATE_Api.Models;

public enum GenderType
{
    Male,
    Female
}

public class Pet
{   
    [Required]
    [StringLength(1024)]
    public string? Id { get; set; }
    
    [Required]
    [StringLength(256, MinimumLength = 3)]
    public string? Name { get; set; }
    
    [Required]
    [StringLength(256, MinimumLength = 3)]
    public string? AnimalType { get; set; } // TODO: Change to updatable enum
    
    [Required]
    [StringLength(256, MinimumLength = 3)]
    public string? Breed { get; set; }
    
    [Required]
    public int Age { get; set; }
    
    [Required]
    public GenderType Gender { get; set; }
    
    [StringLength(1024)]
    public string? Description { get; set; }
    
    public User? Owner { get; set; }
    
    // TODO: Add image property
    
    // TODO: Add matches property
    
    // TODO: ?Add pedigree property
}