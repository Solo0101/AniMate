namespace AniMATE_Api.Interfaces;

public interface IFileService
{
    public Tuple<int, string> SaveImage(IFormFile imageFile);
    public bool DeleteImage(string fileName);
}