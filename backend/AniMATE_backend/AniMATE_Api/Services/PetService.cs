using AniMATE_Api.Data;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;

namespace AniMATE_Api.Services;

public class PetService : IPetService
{
    private readonly DataContext _context;
    
    public PetService(DataContext context)
    {
        _context = context;
    }
    public ICollection<Pet> GetAllPets()
    {
        return _context.Pets.ToList();
    }

    public Pet? GetPetById(string id)
    {
        return _context.Pets.FirstOrDefault(p => p.Id == id);
    }

    public ICollection<Pet> GetPetsByOwner(string ownerId)
    {
        return _context.Pets.Where(p => p.Owner.Id == ownerId).ToList();
    }

    public ICollection<Pet> GetPetsByType(string type)
    {
        return _context.Pets.Where(p => p.AnimalType == type).ToList();
    }

    public ICollection<Pet> GetPetsByBreed(string breed)
    {
        return _context.Pets.Where(p => p.Breed == breed).ToList();
    }

    public ICollection<Pet> GetPetsByAge(int age)
    {
       return _context.Pets.Where(p => p.Age == age).ToList();
    }

    public ICollection<Pet> GetPetsByGender(GenderType gender)
    {
        return _context.Pets.Where(p => p.Gender == gender).ToList();
    }

    public ICollection<Pet> GetPetsByTypeAndGender(string type, GenderType gender)
    {
        return _context.Pets.Where(p => p.AnimalType == type && p.Gender == gender).ToList();
    }

    public ICollection<Pet> GetPetsByTypeBreedAndGender(string type, string breed, GenderType gender)
    {
        return _context.Pets.Where(p => p.AnimalType == type && p.Breed == breed && p.Gender == gender).ToList();
    }

    public bool CreatePet(Pet pet, string ownerId)
    { 
        pet.Id = Guid.NewGuid().ToString();
        pet.Owner = _context.Users.FirstOrDefault(u => u.Id == ownerId)!;
        _context.Pets.Add(pet);
        return Save();
    }

    public bool UpdatePet(Pet pet)
    {
       _context.Pets.Update(pet);
       return Save();
    }

    public bool DeletePet(string id)
    {
        _context.Pets.Remove(GetPetById(id)!);
        return Save();
    }

    public bool PetExists(string id)
    {
        return _context.Pets.Any(p => p.Id == id);
    }

    public bool Save()
    {
        var saved = _context.SaveChanges();
        return saved > 0;
    }
}