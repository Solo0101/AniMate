using AniMATE_Api.Models;

namespace AniMATE_Api.Interfaces;

public interface IUserService
{
    ICollection<User> GetAllUsers();
    User GetUserById(string id);
    User GetUserByUsername(string username);
    User CreateUser(User user);
    User UpdateUser(User user);
    void DeleteUser(string id);
}