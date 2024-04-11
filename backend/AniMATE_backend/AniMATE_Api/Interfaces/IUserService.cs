using AniMATE_Api.AuthModels;
using AniMATE_Api.Models;

namespace AniMATE_Api.Interfaces;

public interface IUserService
{
    List<User> GetAllUsers();
    User? GetUserById(string id);
    User? GetUserByEmail(string email);
    User CreateUser(RegisterModel model);
    bool  UpdateUser(User user);
    void DeleteUser(string id);
    bool UserExists(string id);
    bool Save();
}