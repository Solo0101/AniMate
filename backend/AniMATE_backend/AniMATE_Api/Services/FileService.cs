using AniMATE_Api.Interfaces;

namespace AniMATE_Api.Services;

public class FileService : IFileService
{
    private readonly IWebHostEnvironment _webHostEnvironment;
    
    public FileService(IWebHostEnvironment webHostEnvironment)
    {
        _webHostEnvironment = webHostEnvironment;
    }
    public async Task<Tuple<int, string>> SaveImage(IFormFile imageFile, string subpath)
    {
        try
        {
            var contentPath = _webHostEnvironment.WebRootPath;
            var path = Path.Combine(contentPath, "uploads", subpath);
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            // Check the allowed extensions
            var ext = Path.GetExtension(imageFile.FileName);
            var allowedExtensions = new string[] { ".jpg", ".png", ".jpeg", ".webp" };
            if (!allowedExtensions.Contains(ext))
            {
                var msg = $"Only {string.Join(",", allowedExtensions)} extensions are allowed";
                return new Tuple<int, string>(0, msg);
            }
            var uniqueString = Guid.NewGuid().ToString();
            // we are trying to create a unique filename here
            var newFileName = uniqueString + ext;
            var fileWithPath = Path.Combine(path, newFileName);
            var stream = new FileStream(fileWithPath, FileMode.Create);
            await imageFile.CopyToAsync(stream);
            stream.Close();
            return new Tuple<int, string>(1, newFileName);
        }
        catch (Exception ex)
        {
            return new Tuple<int, string>(0, "Error has occured! " + ex.Message);
        }
    }

    public bool DeleteImage(string fileName, string subpath)
    {
        try
        {
            var contentPath = _webHostEnvironment.WebRootPath;
            var path = Path.Combine(contentPath, "uploads", subpath, fileName);
            if (File.Exists(path))
            {
                File.Delete(path);
                return true;
            }
            return false;
        }
        catch (Exception ex)
        {
            throw new Exception("Error has occured!" + ex.Message);
        }
    }
}