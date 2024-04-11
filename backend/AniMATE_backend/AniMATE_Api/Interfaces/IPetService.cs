using AniMATE_Api.Models;

namespace AniMATE_Api.Interfaces;

public interface IPetService
{
    ICollection<Pet?> GetAllPets();
    Pet? GetPetById(string id);
    ICollection<Pet?> GetPetsByOwner(string ownerId);
    ICollection<Pet?> GetPetsByType(string type);
    ICollection<Pet?> GetPetsByBreed(string breed);
    ICollection<Pet?> GetPetsByAge(int age);
    ICollection<Pet?> GetPetsByGender(GenderType gender);
    ICollection<Pet?> GetPetsByTypeAndGender(string type, GenderType gender);
    ICollection<Pet?> GetPetsByTypeBreedAndGender(string type, string breed, GenderType gender);
    bool CreatePet(Pet pet, string ownerId);
     bool UpdatePet(Pet pet);
    void DeletePet(string id);
    bool PetExists(string id);
    bool Save();
}