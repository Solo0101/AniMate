namespace AniMATE_Api.AuthModels;

public class RegisterModel
{
    public string? Name { get; set; }
    public string? Email { get; set; }
    
    public string? Password { get; set; }
    
    public string? Country { get; set; }
    
    public string? CountyOrState { get; set; }
    
    public string? City { get; set; }
    
    public string? PhoneNumber { get; set; }
}