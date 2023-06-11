using CatsCenterAPI.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace CatsCenterAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RandomController : ControllerBase
    {
        private readonly string imagesPath = @"C:\cat_images";
        private readonly CatsCenterDbContext _context;

        public RandomController(CatsCenterDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult> GetRandomImage()
        {
            for (int i = 0; i < 10; i++)
            {
                var cat = await _context.Cats.Where(x => x.Approved == true).OrderBy(x => Guid.NewGuid()).FirstOrDefaultAsync();

                if (cat == null)
                    continue;

                string classificationFolder = "NoClassification";
                if (cat.Classification != null)
                    classificationFolder = cat.Classification.Name;

                string fileType = cat.FileType.Contains("svg") ? "svg" : cat.FileType[6..];
                string path = imagesPath + "\\" + classificationFolder + "\\" + cat.CatId + "." + fileType;
                if (System.IO.File.Exists(path))
                {
                    byte[] bytes = await System.IO.File.ReadAllBytesAsync(path);
                    return File(bytes, cat.FileType);
                }
                else
                {
                    _context.Cats.Remove(cat);
                    await _context.SaveChangesAsync();
                }
            }
            return NotFound("There's no image in collection");
        }

        [HttpGet("Cat")]
        public async Task<ActionResult> GetRandomCatImage()
        {
            for (int i = 0; i < 10; i++)
            {
                var cat = await _context.Cats.Where(x => x.Approved == true && x.Classification.IsBreed == false).OrderBy(x => Guid.NewGuid()).FirstOrDefaultAsync();

                if (cat == null)
                    continue;

                string classificationFolder = "NoClassification";
                if (cat.Classification != null)
                    classificationFolder = cat.Classification.Name;

                string fileType = cat.FileType.Contains("svg") ? "svg" : cat.FileType[6..];
                string path = imagesPath + "\\" + classificationFolder + "\\" + cat.CatId + "." + fileType;
                if (System.IO.File.Exists(path))
                {
                    byte[] bytes = await System.IO.File.ReadAllBytesAsync(path);
                    return File(bytes, cat.FileType);
                }
                else
                {
                    _context.Cats.Remove(cat);
                    await _context.SaveChangesAsync();
                }
            }
            return NotFound("There's no image in collection");
        }

        [HttpGet("Felidae")]
        public async Task<ActionResult> GetRandomFelidaeImage()
        {
            for (int i = 0; i < 10; i++)
            {
                var cat = await _context.Cats.Where(x => x.Approved == true && x.Classification.IsBreed == true).OrderBy(x => Guid.NewGuid()).FirstOrDefaultAsync();

                if (cat == null)
                    continue;

                string classificationFolder = "NoClassification";
                if (cat.Classification != null)
                    classificationFolder = cat.Classification.Name;

                string fileType = cat.FileType.Contains("svg") ? "svg" : cat.FileType[6..];
                string path = imagesPath + "\\" + classificationFolder + "\\" + cat.CatId + "." + fileType;
                if (System.IO.File.Exists(path))
                {
                    byte[] bytes = await System.IO.File.ReadAllBytesAsync(path);
                    return File(bytes, cat.FileType);
                }
                else
                {
                    _context.Cats.Remove(cat);
                    await _context.SaveChangesAsync();
                }

            }
            return NotFound("There's no image in collection");
        }
    }
}
