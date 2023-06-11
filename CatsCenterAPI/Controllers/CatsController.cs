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

        public CatsController(CatsCenterDbContext context)
        {
            _context = context;
        }

        // GET: api/Cats
        [HttpGet]
        public async Task<ActionResult<List<CatWithImage>>> GetCats(int count = 1)
        {
            if (_context.Cats == null)
            {
                return NotFound();
            }

            return _context.Cats.Where(x => x.Approved == false && x.Classification.IsBreed == true).OrderBy(x => Guid.NewGuid()).Take(count)
                .Include(x => x.Classification).Include(x => x.AddedUser).ToList().ConvertAll(x => new CatWithImage(x));
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
        [HttpGet("{id}")]
        public async Task<ActionResult<Cat>> GetCat(int id)
        {
            try
            {
                if (_context.Cats == null)
                {
                    return NotFound();
                }

                var cat = await _context.Cats.Where(x => x.CatId == id).Include(x => x.Classification).FirstOrDefaultAsync();
                if (cat == null)
                    return NotFound("There's no image in database");
                if (cat.Approved == true)
                    return NotFound("Picture not available now...");

                string classificationFolder = "NoClassification";
                if (cat.Classification != null)
                    classificationFolder = cat.Classification.Name;

                string fileType = cat.FileType.Contains("svg") ? "svg" : cat.FileType[6..];
                string path = @"C:\cat_images\" + classificationFolder + "\\" + cat.CatId + "." + fileType;
                if (System.IO.File.Exists(path))
                {
                    byte[] bytes = await System.IO.File.ReadAllBytesAsync(path);
                    return File(bytes, cat.FileType);
                }

                return NotFound("There's no image in collection");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message.ToString());
            }
        }

        [HttpPost]
        public async Task<ActionResult<Cat>> UploadCatImage([FromForm] UploadCatImage catImage)
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


                string path = @"C:\cat_images";

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

                int filesSended = 0;
                foreach (var file in catImage.File)
                {
                    if (file.ContentType.StartsWith("image/"))
                    {
                        string fileType = file.ContentType.Contains("svg") ? "svg" : file.ContentType[6..];

                        var cat = new Cat
                        {
                            Approved = false,
                            AddedUserId = 1, // change after adding token
                            ClassificationId = catImage.ClassificationId,
                            FileType = file.ContentType,
                            IsKitty = (bool)(catImage.IsKitty == null ? false : catImage.IsKitty)
                        };

                        _context.Cats.Add(cat);
                        await _context.SaveChangesAsync();

                        string filepath = Path.Combine(path, cat.CatId + "." + fileType);
                        using (Stream stream = new FileStream(filepath, FileMode.Create))
                        {
                            file.CopyTo(stream);
                        }
                        filesSended++;
                    }
                }

                if (filesSended == 0)
                    return BadRequest("Incorrect file type");

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

            return NoContent();
        }

        private bool CatExists(int id)
        {
            return (_context.Cats?.Any(e => e.CatId == id)).GetValueOrDefault();
        }
    }
}
