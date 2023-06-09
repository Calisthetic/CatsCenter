using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CatsCenterAPI.Models;
using Microsoft.CodeAnalysis;

namespace CatsCenterAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClassificationsController : ControllerBase
    {
        private readonly CatsCenterDbContext _context;

        public ClassificationsController(CatsCenterDbContext context)
        {
            _context = context;
        }

        // GET: api/Classifications
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Classification>>> GetClassifications()
        {
            if (_context.Classifications == null)
            {
                return NotFound();
            }
            return await _context.Classifications.Where(x => x.IsBreed == false).ToListAsync();
        }

        [HttpGet("Felids")]
        public async Task<ActionResult<IEnumerable<Classification>>> GetFelidsClassifications()
        {
            if (_context.Classifications == null)
            {
                return NotFound();
            }
            return await _context.Classifications.Where(x => x.IsBreed == false).ToListAsync();
        }

        [HttpGet("Breeds")]
        public async Task<ActionResult<IEnumerable<Classification>>> GetBreedsClassifications()
        {
            if (_context.Classifications == null)
            {
                return NotFound();
            }
            return await _context.Classifications.Where(x => x.IsBreed == true).ToListAsync();
        }

        // Other classifications

        [HttpGet("CoatTypes")]
        public async Task<ActionResult<IEnumerable<CoatType>>> GetCoatTypes()
        {
            if (_context.CoatTypes == null)
            {
                return NotFound();
            }
            return await _context.CoatTypes.ToListAsync();
        }

        [HttpGet("CoatPatterns")]
        public async Task<ActionResult<IEnumerable<CoatPattern>>> GetCoatPatterns()
        {
            if (_context.CoatTypes == null)
            {
                return NotFound();
            }
            return await _context.CoatPatterns.ToListAsync();
        }

        [HttpGet("BodyTypes")]
        public async Task<ActionResult<IEnumerable<BodyType>>> GetBodyTypes()
        {
            if (_context.BodyTypes == null)
            {
                return NotFound();
            }
            return await _context.BodyTypes.ToListAsync();
        }

        [HttpGet("Locations")]
        public async Task<ActionResult<IEnumerable<Models.Location>>> GetLocations()
        {
            if (_context.Locations == null)
            {
                return NotFound();
            }
            return await _context.Locations.ToListAsync();
        }

        //// GET: api/Classifications/5
        //[HttpGet("{id}")]
        //public async Task<ActionResult<Classification>> GetClassification(int id)
        //{
        //  if (_context.Classifications == null)
        //  {
        //      return NotFound();
        //  }
        //    var classification = await _context.Classifications.FindAsync(id);

        //    if (classification == null)
        //    {
        //        return NotFound();
        //    }

        //    return classification;
        //}

        //// PUT: api/Classifications/5
        //// To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        //[HttpPut("{id}")]
        //public async Task<IActionResult> PutClassification(int id, Classification classification)
        //{
        //    if (id != classification.ClassificationId)
        //    {
        //        return BadRequest();
        //    }

        //    _context.Entry(classification).State = EntityState.Modified;

        //    try
        //    {
        //        await _context.SaveChangesAsync();
        //    }
        //    catch (DbUpdateConcurrencyException)
        //    {
        //        if (!ClassificationExists(id))
        //        {
        //            return NotFound();
        //        }
        //        else
        //        {
        //            throw;
        //        }
        //    }

        //    return NoContent();
        //}

        //// POST: api/Classifications
        //// To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        //[HttpPost]
        //public async Task<ActionResult<Classification>> PostClassification(Classification classification)
        //{
        //  if (_context.Classifications == null)
        //  {
        //      return Problem("Entity set 'CatsCenterDbContext.Classifications'  is null.");
        //  }
        //    _context.Classifications.Add(classification);
        //    try
        //    {
        //        await _context.SaveChangesAsync();
        //    }
        //    catch (DbUpdateException)
        //    {
        //        if (ClassificationExists(classification.ClassificationId))
        //        {
        //            return Conflict();
        //        }
        //        else
        //        {
        //            throw;
        //        }
        //    }

        //    return CreatedAtAction("GetClassification", new { id = classification.ClassificationId }, classification);
        //}

        //// DELETE: api/Classifications/5
        //[HttpDelete("{id}")]
        //public async Task<IActionResult> DeleteClassification(int id)
        //{
        //    if (_context.Classifications == null)
        //    {
        //        return NotFound();
        //    }
        //    var classification = await _context.Classifications.FindAsync(id);
        //    if (classification == null)
        //    {
        //        return NotFound();
        //    }

        //    _context.Classifications.Remove(classification);
        //    await _context.SaveChangesAsync();

        //    return NoContent();
        //}

        private bool ClassificationExists(int id)
        {
            return (_context.Classifications?.Any(e => e.ClassificationId == id)).GetValueOrDefault();
        }
    }
}
