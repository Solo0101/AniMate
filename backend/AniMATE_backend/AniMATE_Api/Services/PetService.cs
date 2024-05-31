using AniMATE_Api.Data;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;

namespace AniMATE_Api.Services;

public class PetService : IPetService
{
    private readonly DataContext _context;
    private readonly IFileService _fileService;

    public PetService(DataContext context, IFileService fileService)
    {
        _context = context;
        _fileService = fileService;
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
        var oldPet = GetPetById(pet.Id);
        if (oldPet != null)
        {
            oldPet.Name = pet.Name;
            oldPet.AnimalType = pet.AnimalType;
            oldPet.Breed = pet.Breed;
            oldPet.Age = pet.Age;
            oldPet.Description = pet.Description;
            if (oldPet.Image != pet.Image)
            {
                if (oldPet.Image != string.Empty)
                    _fileService.DeleteImage(oldPet.Image, "pets");
                oldPet.Image = pet.Image;
            }
            _context.Pets.Update(oldPet);
        }

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
        var saved = 0;
        try
        {
            saved = _context.SaveChanges();
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            return false;    
        }
        return saved > 0;
    }
}