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
        public async Task<ActionResult<IEnumerable<ClassificationsSearchDto>>> GetClassifications(string find = "", string body_type = "", string coat_pattern = "", string coat_type = "", string location = "")
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
                .Include(x => x.LocationsOfClassifications).ThenInclude(x => x.Location)
                .Where(x => x.Name.ToLower().Contains(find.ToLower()) == true)
                .Where(x => x.BodyTypesOfClassifications.Any(str => str.BodyType.Name.ToLower().Contains(body_type.ToLower()) == true) == true)
                .Where(x => x.CoatPatternsOfClassifications.Any(str => str.CoatPattern.Name.ToLower().Contains(coat_pattern.ToLower()) == true) == true)
                .Where(x => x.CoatTypesOfClassifications.Any(str => str.CoatType.Name.ToLower().Contains(coat_type.ToLower()) == true) == true)
                .Where(x => x.LocationsOfClassifications.Any(str => str.Location.Name.ToLower().Contains(location.ToLower()) == true) == true)
                .ToListAsync();

            return result.ConvertAll(x => new ClassificationsSearchDto(x));
        }

        [HttpGet("{section}")]
        public async Task<ActionResult> GetFelidsClassifications(string section)
        {

            switch (section.ToLower())
            {
                case "fl":
                case "felids":
                    if (_context.Classifications == null)
                        return NotFound();
                    return Ok(_context.Classifications.Where(x => x.IsBreed == false).ToList().ConvertAll(x => new ClassificationsWithImageDto(x)));
                case "br":
                case "breeds":
                    if (_context.Classifications == null)
                        return NotFound();
                    return Ok(_context.Classifications.Where(x => x.IsBreed == true).ToList().ConvertAll(x => new ClassificationsWithImageDto(x)));
                case "ct":
                case "coattypes":
                case "coat_types":
                    if (_context.CoatTypes == null)
                        return NotFound();
                    return Ok(await _context.CoatTypes.ToListAsync());
                case "cp":
                case "coatpatterns":
                case "coat_patterns":
                    if (_context.CoatPatterns == null)
                        return NotFound();
                    return Ok(await _context.CoatPatterns.Where(x => x.IsExtra == false).ToListAsync());
                case "bt":
                case "bodytypes":
                case "body_types":
                    if (_context.BodyTypes == null)
                        return NotFound();
                    return Ok(await _context.BodyTypes.ToListAsync());
                case "loc":
                case "locations":
                    if (_context.Locations == null)
                        return NotFound();
                    return Ok(await _context.Locations.ToListAsync());
                case "ctg":
                case "categories":
                    if (_context.Classifications == null)
                        return NotFound();
                    return Ok(await _context.Categories.ToListAsync());
                default:
                    return BadRequest("Wrong {section}");
            }
        }
    }
}
