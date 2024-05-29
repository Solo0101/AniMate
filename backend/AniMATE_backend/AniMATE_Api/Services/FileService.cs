using AniMATE_Api.Interfaces;

namespace AniMATE_Api.Services;

public class FileService : IFileService
{
    private readonly IWebHostEnvironment _webHostEnvironment;
    
    public FileService(IWebHostEnvironment webHostEnvironment)
    {
        _webHostEnvironment = webHostEnvironment;
    }
    public Tuple<int, string> SaveImage(IFormFile imageFile)
    {
        try
        {
            var contentPath = _webHostEnvironment.ContentRootPath;
            // path = "c://projects/productminiapi/uploads" ,not exactly something like that
            var path = Path.Combine(contentPath, "Uploads");
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            // Check the allowed extenstions
            var ext = Path.GetExtension(imageFile.FileName);
            var allowedExtensions = new string[] { ".jpg", ".png", ".jpeg" };
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
            imageFile.CopyTo(stream);
            stream.Close();
            return new Tuple<int, string>(1, newFileName);
        }
        catch (Exception ex)
        {
            return new Tuple<int, string>(0, "Error has occured");
        }
    }

    public bool DeleteImage(string fileName)
    {
        try
        {
            var contentPath = _webHostEnvironment.ContentRootPath;
            var path = Path.Combine(contentPath, $"Uploads", fileName);
            if (File.Exists(path))
            {
                File.Delete(path);
                return true;
            }
            return false;
        }
        catch (Exception ex)
        {
            throw new Exception("Error has occured");
        }
    }
}