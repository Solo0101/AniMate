using AniMATE_Api.Data;
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
    public ICollection<User> GetAllUsers()
    {
       return _context.Users.ToList();
    }

    public User GetUserById(string id)
    {
       return _context.Users.Where(u => u.Id == id).FirstOrDefault();
    }

    public User GetUserByUsername(string username)
    {
       return _context.Users.Where(u => u.UserName == username).FirstOrDefault();
    }

    public User CreateUser(User user)
    {
        return _context.Users.Add(user).Entity;
    }

    public User UpdateUser(User user)
    {
        return _context.Users.Update(user).Entity;
    }

    public void DeleteUser(string id)
    {
       _context.Users.Remove(GetUserById(id));
    }
}