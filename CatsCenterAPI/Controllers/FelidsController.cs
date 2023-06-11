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
    public class FelidsController : ControllerBase
    {
        private readonly string imagesPath = @"C:\cat_images";
        private readonly CatsCenterDbContext _context;

        public FelidsController(CatsCenterDbContext context)
        {
            _context = context;
        }

        // GET: api/Felids
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CatWithImage>>> GetCats(int count = 1)
        {
          if (_context.Cats == null)
          {
              return NotFound();
          }
            return _context.Cats.Where(x => x.Approved == true && (x.Classification == null ? false : x.Classification.IsBreed) == false).OrderBy(x => Guid.NewGuid()).Take(count)
                .Include(x => x.Classification).Include(x => x.AddedUser).ToList().ConvertAll(x => new CatWithImage(x));
        }

        // GET: api/Felids/5
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

        // PUT: api/Felids/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCat(int id, Cat cat)
        {
            if (id != cat.CatId)
            {
                return BadRequest();
            }

            _context.Entry(cat).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CatExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Felids
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Cat>> PostCat(Cat cat)
        {
          if (_context.Cats == null)
          {
              return Problem("Entity set 'CatsCenterDbContext.Cats'  is null.");
          }
            _context.Cats.Add(cat);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCat", new { id = cat.CatId }, cat);
        }

        // DELETE: api/Felids/5
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
