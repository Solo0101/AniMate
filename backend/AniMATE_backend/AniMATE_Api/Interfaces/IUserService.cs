using AniMATE_Api.DTOs;
using AniMATE_Api.Models;

namespace AniMATE_Api.Interfaces;

public interface IUserService
{
    List<User> GetAllUsers();
    User? GetUserById(string id);
    User? GetUserByEmail(string email);
    User CreateUser(User newUser);
    bool UpdateUser(User user);
    void DeleteUser(string id);
    bool UserExists(string id);
    bool Save();
}