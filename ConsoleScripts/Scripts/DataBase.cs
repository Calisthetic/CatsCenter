using CatsCenterAPI.Model;
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
                    if (!File.Exists(filePath))
                        return;

                    Classification? breed = null;
                    if (classificationId != null)
                        breed = await context.Classifications.FindAsync(classificationId);

                    var bytes = await File.ReadAllBytesAsync(filePath);
                    Cat newCat = new Cat()
                    {
                        Approved = true,
                        IsKitty = isKitty,
                        ClassificationId = breed == null ? null : breed.ClassificationId,
                        AddedUserId = 1,
                        FileType = "image/" + System.IO.Path.GetExtension(filePath)[1..],
                    };

                    await context.AddAsync(newCat);
                    await context.SaveChangesAsync();

                    string folderName = breed == null ? "NoClassification" : breed.Name;
                    if (!Directory.Exists(imagesPath + "\\" + folderName))
                        Directory.CreateDirectory(imagesPath + "\\" + folderName);

                    string newFilePath = imagesPath + "\\" + folderName + "\\" + newCat.CatId + (newCat.IsKitty ? "1" : "0") + System.IO.Path.GetExtension(filePath);
                    File.Copy(filePath, newFilePath);
                }
            }
            catch { }
        }
    }
}
