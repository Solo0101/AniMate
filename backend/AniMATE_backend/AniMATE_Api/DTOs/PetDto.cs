using AniMATE_Api.Models;

namespace AniMATE_Api.DTOs;

public class PetDto
{
    public string Name { get; set; } = string.Empty;
    
    public string AnimalType { get; set; } = string.Empty;// TODO: Change to updatable enum
    
    public string Breed { get; set; } = string.Empty;
    
    public int Age { get; set; }
    
    public GenderType Gender { get; set; }
    
    public string Description { get; set; } = string.Empty;
}