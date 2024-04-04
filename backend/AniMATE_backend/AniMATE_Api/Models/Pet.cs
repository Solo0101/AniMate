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
    public string Id { get; set; }
    
    [Required]
    public string Name { get; set; }
    
    [Required]
    public string AnimalType { get; set; } // TODO: Change to updatable enum
    
    [Required]
    public string Breed { get; set; }
    
    [Required]
    public int Age { get; set; }
    
    [Required]
    public GenderType Gender { get; set; }
    
    public string Description { get; set; }
    
    public User Owner { get; set; }
    
    // TODO: Add image property
    
    // TODO: Add matches property
    
    // TODO: ?Add pedigree property
}