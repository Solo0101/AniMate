using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace AniMATE_Api.Models;

public class User : IdentityUser
{
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string? Name { get; set; }
       
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string? Country { get; set; }
       
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string? CountyOrState { get; set; }
       
       [Required]
       [StringLength(256, MinimumLength = 3)]
       public string? City { get; set; }
       
       [Required]
       [StringLength(15, MinimumLength = 10)]
       public override string? PhoneNumber { get; set; }
       
       public ICollection<Pet>? Pets { get; set; }
       
       // TODO: Add image property
}