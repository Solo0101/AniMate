using System.ComponentModel.DataAnnotations;

namespace AniMATE_Api.Views;

public class LoginResponseView
{
    public string? Id { get; set; }
    public string? Name { get; set; }
    [Required, EmailAddress]
    public string? Email { get; set; } = string.Empty;
    public string? Country { get; set; } = string.Empty;
    public string? CountyOrState { get; set; } = string.Empty;
    public string? City { get; set; } = string.Empty;
    public string? PhoneNumber { get; set; } = string.Empty;
    public string? Token { get; set; } = string.Empty;
    // public string? Image { get; set; }
    
}