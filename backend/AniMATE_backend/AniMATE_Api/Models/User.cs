using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace AniMATE_Api.Models;

public class User : IdentityUser
{
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string Name { get; set; } = string.Empty;
       
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string Country { get; set; } = string.Empty;
       
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string CountyOrState { get; set; } = string.Empty;
       
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string City { get; set; } = string.Empty;
       
       [Required]
       [StringLength(15, MinimumLength = 10)]
       public override string? PhoneNumber { get; set; }
       
       public ICollection<Pet> Pets { get; set; } = new List<Pet>();
       
       [StringLength(1024)]
       public string Image { get; set; } = string.Empty;
}