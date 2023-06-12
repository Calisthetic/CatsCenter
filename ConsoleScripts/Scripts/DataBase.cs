using CatsCenterAPI.Model;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace ConsoleScripts.Scripts
{
    internal class DataBase
    {
        private static readonly string imagesPath = @"C:\cat_images";
        private static CatsCenterDbContext context = new CatsCenterDbContext();

        public static async Task GetImagesByFolder(string path, int? classificationId = null, bool isKitty = false)
        {
            try
            {
                if (string.IsNullOrEmpty(path))
                    return;
                var filesFromDir = Directory.GetFiles(path);
                foreach (var filePath in filesFromDir)
                {
                    // Get classification by parent folder
                    string parentFolder = path[(path.LastIndexOf('\\') + 1)..];
                    Classification? classification = await context.Classifications.Where(x => x.Name == parentFolder).FirstOrDefaultAsync();

                    // Search breed or felids from parameter
                    Classification? breed = null;
                    if (classificationId != null)
                        breed = await context.Classifications.FindAsync(classificationId);

                    // Get file format, image bytes and 0 or 1 as bool for cat.IsKitty
                    string fileFormat = System.IO.Path.GetExtension(filePath) == ".jpg" ? ".jpeg" : System.IO.Path.GetExtension(filePath);
                    var bytes = await File.ReadAllBytesAsync(filePath);
                    var kittyTrigger = Path.GetFileName(filePath).Substring(Path.GetFileName(filePath).IndexOf(".") - 1, 1);

                    Cat newCat = new Cat()
                    {
                        Approved = true,
                        // trying to check last letter from file name
                        IsKitty = int.TryParse(kittyTrigger, out int amIKitty) ? (amIKitty == 1 ? true : (amIKitty == 0 ? false : isKitty)) : isKitty,
                        ClassificationId = classification == null ? (breed == null ? null : breed.ClassificationId) : classification.ClassificationId,
                        AddedUserId = 1,
                        FileType = "image/" + fileFormat[1..],
                    };

                    await context.AddAsync(newCat);
                    await context.SaveChangesAsync();

                    // Get classification folder
                    string folderName = classification == null ? (breed == null ? "NoClassification" : breed.Name) : classification.Name;
                    if (!Directory.Exists(imagesPath + "\\" + folderName))
                        Directory.CreateDirectory(imagesPath + "\\" + folderName);

                    // Get new file path and copy new image to new file path
                    string newFilePath = imagesPath + "\\" + folderName + "\\" + newCat.CatId + (newCat.IsKitty ? "1" : "0") + fileFormat;
                    File.Copy(filePath, newFilePath);
                }

                // Recursion for other directories
                var directoriesFromDir = Directory.GetDirectories(path);
                foreach (string directory in directoriesFromDir)
                {
                    await GetImagesByFolder(directory, classificationId, isKitty);
                }
            }
            catch { }
        }
    }
}
