using AniMATE_Api.Models;

namespace AniMATE_Api.Views;

public class PetView
{
    public string Id { get; set; } = string.Empty;
    
    public string Name { get; set; } = string.Empty;
    
    public string AnimalType { get; set; } = string.Empty;// TODO: Change to updatable enum
    
    public string Breed { get; set; } = string.Empty;
    
    public int Age { get; set; }
    
    public GenderType Gender { get; set; }
    
    public string Description { get; set; } = string.Empty;
    public string Image { get; set; } = string.Empty;
}