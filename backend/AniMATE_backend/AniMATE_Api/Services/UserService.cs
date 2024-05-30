using AniMATE_Api.Data;
using AniMATE_Api.DTOs;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;

namespace AniMATE_Api.Services;

public class UserService : IUserService
{
    private readonly DataContext _context;
    private readonly IFileService _fileService;

    public UserService(DataContext context, IFileService fileService)
    {
        _context = context;
        _fileService = fileService;
    }
    public List<User> GetAllUsers()
    {
       return _context.Users.ToList();
    }

    public User? GetUserById(string id)
    {
       return _context.Users.FirstOrDefault(u => u.Id == id);
    }

    public User? GetUserByEmail(string email)
    {
       return _context.Users.FirstOrDefault(u => u.Email == email);
    }

    public User CreateUser(User newUser)
    {
        return _context.Users.Add(newUser).Entity;
    }

    public bool UpdateUser(User newUser)
    {
        var oldUser = GetUserById(newUser.Id);
        oldUser!.City = newUser.City;
        oldUser.Country = newUser.Country;
        oldUser.Email = newUser.Email;
        oldUser.Name = newUser.Name;
        oldUser.PhoneNumber = newUser.PhoneNumber;
        oldUser.CountyOrState = newUser.CountyOrState;
        oldUser.UserName = newUser.Email;
        oldUser.NormalizedEmail = newUser.Email?.ToUpper();
        oldUser.NormalizedUserName = newUser.UserName?.ToUpper();
        _context.Users.Update(oldUser);
        if (oldUser.Image != newUser.Image)
        {
            if (oldUser.Image != string.Empty)
                _fileService.DeleteImage(newUser.Image, "users");
            oldUser.Image = newUser.Image;
        }
        return Save();
    }

    public bool DeleteUser(string id)
    {
       _context.Users.Remove(GetUserById(id)!);
       return Save(); 
    }

    public bool UserExists(string id)
    {
        return _context.Users.Any(u => u.Id == id);
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