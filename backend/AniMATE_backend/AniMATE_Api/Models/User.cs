using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace AniMATE_Api.Models;

public class User : IdentityUser
{
       [Required]
       public string Id { get; set; }
       
       [Required]
       public string UserName { get; set; }
       
       [Required]
       public string Country { get; set; }
       
       [Required]
       public string County_or_State { get; set; }
       
       [Required]
       public string City { get; set; }
       
       [Required]
       public string PhoneNumber { get; set; }
       
       public ICollection<Pet> Pets { get; set; }
       
       // TODO: Add image property
}