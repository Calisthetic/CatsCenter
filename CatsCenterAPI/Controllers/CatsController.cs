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
        public async Task<ActionResult<IEnumerable<Cat>>> GetCats()
        {
          if (_context.Cats == null)
          {
              return NotFound();
          }
            return await _context.Cats.ToListAsync();
        }

        // GET: api/Cats/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Cat>> GetCat(int id)
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

            return cat;
        }

        [HttpPost]
        public async Task<ActionResult<Cat>> UploadCatImage([FromForm] UploadCatImage catImage)
        {
            try
            {
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

                if (catImage.File.Count() < 1)
                    return BadRequest("No files sended");

                int filesSended = 0;
                foreach (var file in catImage.File)
                {
                    if (file.ContentType.StartsWith("image/"))
                    {
                        var cat = new Cat();
                        cat.Approved = false;
                        cat.AddedUserId = 1; // change after adding token
                        cat.ClassificationId = catImage.ClassificationId;
                        cat.IsKitty = (bool)(catImage.IsKitty == null ? false : catImage.IsKitty);

                        _context.Cats.Add(cat);
                        await _context.SaveChangesAsync();

                        string filepath = Path.Combine(path, cat.CatId + ".jpg");
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
