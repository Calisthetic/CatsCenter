using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CatsCenterAPI.Models;
using Microsoft.CodeAnalysis;
using CatsCenterAPI.Models.DataTransferObjects;
using Microsoft.Extensions.Primitives;

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
        public async Task<ActionResult<IEnumerable<ClassificationsSearch>>> GetClassifications(string find = "", string body_type = "", string coat_pattern = "", string coat_type = "", string location = "")
        {
            //// Header value
            //StringValues values;
            //string result = "none";
            //if (Request.Headers.TryGetValue("Authorization", out values))
            //    result = values.FirstOrDefault();
            //return Ok(result);

            if (_context.Classifications == null)
            {
                return NotFound();
            }
            var result = await _context.Classifications
                .Include(x => x.BodyTypesOfClassifications).ThenInclude(x => x.BodyType)
                .Include(x => x.CoatPatternsOfClassifications).ThenInclude(x => x.CoatPattern)
                .Include(x => x.CoatTypesOfClassifications).ThenInclude(x => x.CoatType)
                .Include(x => x.LocationsOfClassifications).ThenInclude(x => x.Location).ToListAsync();

            if (find.ToLower() != "")
            {
                result = result.Where(x => x.Name.ToLower().Contains(find) == true).ToList();
            }
            if (body_type.ToLower() != "")
            {
                result = result.Where(x => x.BodyTypesOfClassifications.Any(str => str.BodyType.Name.ToLower().Contains(body_type.ToLower()) == true) == true).ToList();
            }
            if (coat_pattern.ToLower() != "")
            {
                result = result.Where(x => x.CoatPatternsOfClassifications.Any(str => str.CoatPattern.Name.ToLower().Contains(coat_pattern.ToLower()) == true) == true).ToList();
            }
            if (coat_type.ToLower() != "")
            {
                result = result.Where(x => x.CoatTypesOfClassifications.Any(str => str.CoatType.Name.ToLower().Contains(coat_type.ToLower()) == true) == true).ToList();
            }
            if (location.ToLower() != "")
            {
                result = result.Where(x => x.LocationsOfClassifications.Any(str => str.Location.Name.ToLower().Contains(location.ToLower()) == true) == true).ToList();
            }
            return result.ConvertAll(x => new ClassificationsSearch(x));
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
            return await _context.CoatPatterns.Where(x => x.IsExtra == false).ToListAsync();
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

        [HttpGet("Classifications")]
        public async Task<ActionResult<IEnumerable<Models.Category>>> GetClassifications()
        {
            if (_context.Categories == null)
            {
                return NotFound();
            }
            return await _context.Categories.ToListAsync();
        }

        private bool ClassificationExists(int id)
        {
            return (_context.Classifications?.Any(e => e.ClassificationId == id)).GetValueOrDefault();
        }
    }
}
