using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CatsCenterAPI.Models;
using CatsCenterAPI.Models.DataTransferObjects;

namespace CatsCenterAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CatsController : ControllerBase
    {
        private readonly CatsCenterDbContext _context;
        private readonly static string[] imagetypes = new string[] { 
            "apng", "png",
            "avif", "gif",
            "jpg", "jfif",
            "jpeg", "pjpeg",
            "pjp", "webp"
        };

        public CatsController(CatsCenterDbContext context)
        {
            _context = context;
        }

        // GET: api/Cats
        [HttpGet]
        public async Task<ActionResult<List<CatWithImageDto>>> GetCats(int count = 1, int classification_id = 0)
        {
            if (_context.Cats == null)
            {
                return NotFound();
            }
            if (count > 10)
                return BadRequest("\"Count\" can't be bigger than 10");

            return _context.Cats.Where(x => x.Approved == true && x.ClassificationId == (classification_id == 0 ? x.ClassificationId : classification_id) && (x.Classification == null ? false : x.Classification.IsBreed) == true).OrderBy(x => Guid.NewGuid()).Take(count)
                .Include(x => x.Classification).Include(x => x.AddedUser).ToList().ConvertAll(x => new CatWithImageDto(x));
        }

        [HttpGet("Total")]
        public async Task<ActionResult<int>> GetCatsCount()
        {
            if (_context.Cats == null)
            {
                return NotFound();
            }

            return await _context.Cats.CountAsync();
        }

        // GET: api/Cats/5
        [HttpGet("{id}.{type}")]
        public async Task<ActionResult<Cat>> GetCat(int id, string type)
        {
            try
            {
                if (_context.Cats == null)
                {
                    return NotFound();
                }
                if (id == 0 || string.IsNullOrEmpty(type))
                    return NotFound();

                var cat = await _context.Cats.Where(x => x.CatId == id / 10).Include(x => x.Classification).FirstOrDefaultAsync();
                if (cat == null)
                    return NotFound("There's no image in database");
                if (cat.Approved == false)
                    return NotFound("Picture not available now...");

                string classificationFolder = "NoClassification";
                if (cat.Classification != null)
                    classificationFolder = cat.Classification.Name;

                string fileType = imagetypes.Any(str => str == type.ToLower()) ? "image/" + type : string.Empty;
                if (string.IsNullOrEmpty(fileType))
                    return NotFound("Incorrect file type");

                string path = Configuration.imagesPath + "\\" + classificationFolder + "\\" + cat.CatId + (cat.IsKitty ? "1" : "0") + "." + cat.FileType[6..];
                if (System.IO.File.Exists(path))
                {
                    byte[] bytes = await System.IO.File.ReadAllBytesAsync(path);
                    return File(bytes, imagetypes.Any(str => str == type.ToLower()) ? "image/" + type : cat.FileType);
                }
                else
                {
                    _context.Cats.Remove(cat);
                    await _context.SaveChangesAsync();
                }

                return NotFound("There's no image in collection");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message.ToString());
            }
        }

        [HttpGet("Info/{id}")]
        public async Task<ActionResult<Cat>> GetCatInfo(int id)
        {
            if (_context.Cats == null)
                return NotFound();

            var cat = _context.Cats.Where(x => x.CatId == id).Include(x => x.AddedUser)
                .Include(x => x.Classification).ThenInclude(x => x.BodyTypesOfClassifications).ThenInclude(x => x.BodyType)
                .Include(x => x.Classification).ThenInclude(x => x.LocationsOfClassifications).ThenInclude(x => x.Location)
                .Include(x => x.Classification).ThenInclude(x => x.CoatTypesOfClassifications).ThenInclude(x => x.CoatType)
                .Include(x => x.Classification).ThenInclude(x => x.CoatPatternsOfClassifications).ThenInclude(x => x.CoatPattern)
            .ToList().ConvertAll(x => new CatInfoDto(x)).FirstOrDefault();
            if (cat == null) 
                return NotFound();

            return Ok(cat);
        }

        [HttpPost]
        public async Task<ActionResult<Cat>> UploadCatImage([FromForm] UploadCatImageDto catImage)
        {
            try
            {
                if (catImage == null) 
                    return BadRequest("No data");
                if (catImage.File.Count() < 1)
                    return BadRequest("No files sended");
                if (catImage.IsKitty == null)
                    return BadRequest("Is it Kitty?");
                if (_context.Users == null)
                    return BadRequest("DataBase error");


                string path = Configuration.imagesPath;

                if (catImage.ClassificationId != null)
                {
                    string classificationFolder = _context.Classifications.Where(x => x.ClassificationId == catImage.ClassificationId).First().Name;
                    if (!string.IsNullOrEmpty(classificationFolder))
                        path += @"\" + classificationFolder;
                    else
                        path += @"\NoClassification";
                }
                else
                {
                    path += @"\NoClassification";
                }

                if (!Directory.Exists(path))
                    Directory.CreateDirectory(path);

                foreach (var file in catImage.File)
                {
                    if (file.ContentType.StartsWith("image/") && !file.ContentType.Contains("svg"))
                    {
                        string fileType = file.ContentType[6..];

                        // Add new value to database or change old
                        var cat = new Cat
                        {
                            Approved = true,
                            AddedUserId = 1, // change after adding token
                            ClassificationId = catImage.ClassificationId,
                            FileType = file.ContentType,
                            IsKitty = (bool)(catImage.IsKitty == null ? false : catImage.IsKitty)
                        };

                        _context.Cats.Add(cat);
                        await _context.SaveChangesAsync();

                        // If image already exist
                        if (Path.Exists(path + "\\" + cat.CatId + (cat.IsKitty ? "1" : "0") + "." + fileType))
                        {
                            // Get that file(s)
                            string[] repeatedFiles = Directory.GetFiles(path, cat.CatId + (cat.IsKitty ? "1" : "0") + "." + fileType);

                            if (!Directory.Exists(Configuration.imagesPath + "\\Unexpected"))
                                Directory.CreateDirectory(Configuration.imagesPath + "\\Unexpected");
                            foreach (var repeatedFilePath in repeatedFiles)
                            {
                                string unexpectedFilePath = Configuration.imagesPath + "\\Unexpected\\" + cat.CatId + (cat.IsKitty ? "1" : "0") + "." + fileType;
                                if (System.IO.File.Exists(unexpectedFilePath))
                                    System.IO.File.Delete(unexpectedFilePath);

                                // Copy unexpected file to Unexpected folder
                                System.IO.File.Copy(repeatedFilePath, unexpectedFilePath);
                                System.IO.File.Delete(repeatedFilePath);
                            }
                        }
                        // Add image
                        string filepath = Path.Combine(path, cat.CatId + (cat.IsKitty ? "1" : "0") + "." + fileType);
                        using (Stream stream = new FileStream(filepath, FileMode.Create))
                        {
                            file.CopyTo(stream);
                        }
                    }
                    else
                    {
                        return BadRequest("Incorrect file type");
                    }
                }

                return Ok(catImage);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message.ToString());
            }
        }

        // DELETE: api/Cats/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCat(int id)
        {
            if (_context.Cats == null)
            {
                return NotFound();
            }
            var cat = await _context.Cats.FindAsync(id);
            if (cat == null)
            {
                return NotFound();
            }

            _context.Cats.Remove(cat);
            await _context.SaveChangesAsync();

            string classificationFolder = "NoClassification";
            if (cat.Classification != null)
                classificationFolder = cat.Classification.Name;

            string fileType = cat.FileType[6..];
            string path = Configuration.imagesPath + "\\" + classificationFolder + "\\" + cat.CatId + (cat.IsKitty ? "1" : "0") + "." + fileType;
            if (System.IO.File.Exists(path))
                System.IO.File.Delete(path);

            return Ok("Successfully deleted");
        }

        private bool CatExists(int id)
        {
            return (_context.Cats?.Any(e => e.CatId == id)).GetValueOrDefault();
        }
    }
}
