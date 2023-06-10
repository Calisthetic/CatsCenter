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

            return _context.Cats.Skip(new Random().Next(_context.Cats.Count() - 1 - count)).Take(count)
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
                        string fileType = file.ContentType.Contains("webp") ? "webp" :
                            file.ContentType.Contains("gif") ? "gif" : "jpg";

                        var cat = new Cat();
                        cat.Approved = false;
                        cat.AddedUserId = 1; // change after adding token
                        cat.ClassificationId = catImage.ClassificationId;
                        cat.FileType = fileType;
                        cat.IsKitty = (bool)(catImage.IsKitty == null ? false : catImage.IsKitty);
                        //cat.AddedUser = await _context.Users.FindAsync(1);

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
            //catch (DbEntityValidationException er)
            //{
            //    foreach (var eve in er.EntityValidationErrors)
            //    {
            //        return Ok("Entity of type \"{0}\" in state \"{1}\" has the following validation errors:" +
            //            eve.Entry.Entity.GetType().Name + eve.Entry.State);
            //        //foreach (var ve in eve.ValidationErrors)
            //        //{
            //        //    MessageBox.Show("- Property: \"{0}\", Error: \"{1}\"" +
            //        //        ve.PropertyName + ve.ErrorMessage);
            //        //}
            //    }
            //}
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
