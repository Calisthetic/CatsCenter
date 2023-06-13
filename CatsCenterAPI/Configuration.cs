using CatsCenterAPI.Models;

namespace CatsCenterAPI
{
    public class Configuration
    {
        public static readonly string imagesPath = @"C:\cat_images";
        public static readonly CatsCenterDbContext db = new CatsCenterDbContext();
    }
}
