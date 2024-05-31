using System.ComponentModel.DataAnnotations;

namespace AniMATE_Api.DTOs;

public class RegisterDto
{
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    
    [Required, Display(Name = "Password")]
    public string Password { get; set; } = string.Empty;
    [Required, Compare(nameof(Password), ErrorMessage = "Confirm password doesn't match, Type again !")]
    public string ConfirmPassword { get; set; } = string.Empty;
    
    public string Country { get; set; } = string.Empty;
    
    public string CountyOrState { get; set; } = string.Empty;
    
    public string City { get; set; } = string.Empty;
    
    public string PhoneNumber { get; set; } = string.Empty;
    
    public IFormFile? ImageFile { get; set; }
}