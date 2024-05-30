namespace AniMATE_Api.Interfaces;

public interface IFileService
{
    public Task<Tuple<int, string>> SaveImage(IFormFile imageFile, string subpath);
    public bool DeleteImage(string fileName, string subpath);
}