using AniMATE_Api.Data;
using AniMATE_Api.DTOs;
using AniMATE_Api.Interfaces;
using AniMATE_Api.Models;

namespace AniMATE_Api.Services;

public class UserService : IUserService
{
    private readonly DataContext _context;
    
    public UserService(DataContext context)
    {
        _context = context;
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

    public bool UpdateUser(User user)
    {
        user.UserName = user.Email;
        user.NormalizedEmail = user.Email?.ToUpper();
        user.NormalizedUserName = user.Email?.ToUpper();
        _context.Users.Update(user);
        return Save();
    }

    public void DeleteUser(string id)
    {
       _context.Users.Remove(GetUserById(id)!);
    }

    public bool UserExists(string id)
    {
        return _context.Users.Any(u => u.Id == id);
    }
    public bool Save()
    {
        return _context.SaveChanges() >= 0;
    }
}