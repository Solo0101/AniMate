﻿using AniMATE_Api.AuthModels;
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

    public User CreateUser(RegisterModel model)
    {
        var user = new User();
        {
            user.Email = model.Email;
            user.PasswordHash = model.Password;
            user.Name = model.Name;
            user.UserName = model.Email;
            user.Country = model.Country;
            user.CountyOrState = model.CountyOrState;
            user.City = model.City;
            user.PhoneNumber = model.PhoneNumber;
        }
        return _context.Users.Add(user).Entity;
    }

    public User UpdateUser(User user)
    {
        return _context.Users.Update(user).Entity;
    }

    public void DeleteUser(string id)
    {
       _context.Users.Remove(GetUserById(id)!);
    }

    public bool UserExists(string id)
    {
        return _context.Users.Any(u => u.Id == id);
    }
    
}