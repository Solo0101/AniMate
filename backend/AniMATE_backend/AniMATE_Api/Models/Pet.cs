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
    [Key]
    [StringLength(1024)]
    public string Id { get; set; } = string.Empty;
    
    [Required]
    [StringLength(256, MinimumLength = 3)]
    public string Name { get; set; } = string.Empty;
    
    [Required]
    [StringLength(256, MinimumLength = 3)]
    public string AnimalType { get; set; } = string.Empty;// TODO: Change to updatable enum
    
    [Required]
    [StringLength(256, MinimumLength = 3)]
    public string Breed { get; set; } = string.Empty;
    
    [Required]
    public int Age { get; set; }
    
    [Required]
    public GenderType Gender { get; set; }
    
    [StringLength(1024)]
    public string Description { get; set; } = string.Empty;
    

    [StringLength(1024)]
    public string Image { get; set; } = string.Empty;

    public User Owner { get; set; } = null!;
}