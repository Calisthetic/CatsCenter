﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using CatsCenterAPI.Models;
using CatsCenterAPI.Models.DataTransferObjects;
using Microsoft.VisualBasic.FileIO;
using Microsoft.AspNetCore.Cors;
using System.Diagnostics;

namespace CatsCenterAPI.Controllers
{
    [EnableCors("MyPolicy")]
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
        public async Task<ActionResult<List<CatWithImageDto>>> GetCats(int count = 4, int classification_id = 0)
        {
            if (_context.Cats == null)
            {
                return NotFound();
            }
            if (count > 24)
                return BadRequest("\"Count\" can't be bigger than 24");

            return _context.Cats.Where(x => x.Approved == true && x.ClassificationId == (classification_id == 0 ? x.ClassificationId : classification_id)
                && (x.Classification != null && x.Classification.IsBreed) == true).OrderBy(x => Guid.NewGuid()).Take(count)
                .Include(x => x.Classification).Include(x => x.AddedUser).ToList().ConvertAll(x => new CatWithImageDto(x));
        }

        /// <summary>
        /// Описание
        /// </summary>
        /// <param name="id"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        /// <example>GET api/Cats/10000.jpeg</example>
        // GET: api/Cats/5
        [HttpGet("{id}.{type}", Name = nameof(GetCat))]
        public async Task<ActionResult> GetCat(int id, string type)
        {
            try
            {
                if (_context.Cats == null)
                {
                    return NotFound();
                }
                if (id == 0 || string.IsNullOrEmpty(type))
                    return NotFound();

                var cat = await _context.Cats.Where(x => x.CatId == id).Include(x => x.Classification).FirstOrDefaultAsync();
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

        // GET: api/Cats/Total
        [HttpGet("Total")]
        public async Task<ActionResult<int>> GetCatsCount()
        {
            if (_context.Cats == null)
            {
                return NotFound();
            }

            return await _context.Cats.CountAsync();
        }

        // GET: api/Cats/Search
        [HttpGet("Search")]
        public async Task<ActionResult<IEnumerable<CatWithImageDto>>> GetCatsSearch(int count = 4, string body_type = "", string coat_pattern = "", string coat_type = "", string location = "")
        {
            if (_context.Classifications == null)
            {
                return NotFound();
            }
            if (count > 10)
                return BadRequest("\"Count\" can't be bigger than 10");

            int bodyTypeId = int.TryParse(body_type, out int id1) ? id1 : 0;
            int locationId = int.TryParse(location, out int id2) ? id2 : 0;
            int coatTypeId = int.TryParse(coat_type, out int id3) ? id3 : 0;
            int coatPatternId = int.TryParse(coat_pattern, out int id4) ? id4 : 0;

            var result = await _context.Classifications
                .Include(x => x.BodyTypesOfClassifications).ThenInclude(x => x.BodyType)
                .Include(x => x.CoatPatternsOfClassifications).ThenInclude(x => x.CoatPattern)
                .Include(x => x.CoatTypesOfClassifications).ThenInclude(x => x.CoatType)
                .Include(x => x.LocationsOfClassifications).ThenInclude(x => x.Location).Where(
                    x => x.BodyTypesOfClassifications.Any(s => s.BodyType.Name.ToLower().Contains(body_type.ToLower()) == true || s.BodyTypeId == bodyTypeId) == true
                    && x.CoatPatternsOfClassifications.Any(s => s.CoatPattern.Name.ToLower().Contains(coat_pattern.ToLower()) == true || s.CoatPatternId == coatPatternId) == true
                    && x.CoatTypesOfClassifications.Any(s => s.CoatType.Name.ToLower().Contains(coat_type.ToLower()) == true || s.CoatTypeId == coatTypeId) == true
                    && x.LocationsOfClassifications.Any(s => s.Location.Name.ToLower().Contains(location.ToLower()) == true || s.LocationId == locationId) == true
                ).ToListAsync();

            return _context.Cats.Include(x => x.AddedUser).AsEnumerable().Where(x => result.Any(s => s.ClassificationId == x.ClassificationId) == true)
                .OrderBy(x => Guid.NewGuid()).Take(count).ToList().ConvertAll(x => new CatWithImageDto(x));
        }

        [HttpGet("Info/{id}")]
        public async Task<ActionResult<CatInfoDto>> GetCatInfo(int id)
        {
            if (_context.Cats == null)
                return NotFound();

            var cat = _context.Cats.Where(x => x.CatId == id).Include(x => x.AddedUser)
                //.Include(x => x.CategoriesOfCats).ThenInclude(x => x.Category)
                .Include(x => x.Classification).ThenInclude(x => x.BodyTypesOfClassifications).ThenInclude(x => x.BodyType)
                .Include(x => x.Classification).ThenInclude(x => x.LocationsOfClassifications).ThenInclude(x => x.Location)
                .Include(x => x.Classification).ThenInclude(x => x.CoatTypesOfClassifications).ThenInclude(x => x.CoatType)
                .Include(x => x.Classification).ThenInclude(x => x.CoatPatternsOfClassifications).ThenInclude(x => x.CoatPattern)
                .Include(x => x.CategoriesOfCats).ThenInclude(x => x.Category)
            .ToList().ConvertAll(x => new CatInfoDto(x)).FirstOrDefault();
            if (cat == null) 
                return NotFound();

            return cat;
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

        // PUT: api/Cats/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCat(int id, ChangeCatDto cat)
        {
            if (id != cat.CatId && !CatExists(id))
            {
                return BadRequest();
            }

            // Search current cat
            Cat? currentCat = await _context.Cats.Include(x => x.Classification).FirstOrDefaultAsync(x => x.CatId == id);
            string oldFilePath = string.Empty;
            if (currentCat != null)
            {
                // Get current filepath
                oldFilePath = Configuration.imagesPath + "\\" + (currentCat.Classification == null ? "NoClassification" : currentCat.Classification.Name)
                        + "\\" + currentCat.CatId + (currentCat.IsKitty ? "1" : "0") + "." + currentCat.FileType[6..];

                // Search classification and change current cat
                Classification? classification = await _context.Classifications.FirstOrDefaultAsync(x => x.ClassificationId == cat.ClassificationId);
                if (classification != null)
                {
                    currentCat.Classification = classification;
                    currentCat.ClassificationId = cat.ClassificationId;
                }
                currentCat.AddedUserId = cat.AddedUserId;
                currentCat.IsKitty = cat.IsKitty;
                currentCat.Approved = cat.Approved;

                // Set cat categories
                if (cat.CategoryIds != null && _context.CategoriesOfCats != null)
                {
                    for (int i = 0; i < cat.CategoryIds.Length; i++)
                    {
                        // Проверка на существование категории в бд
                        if (await _context.Categories.FirstOrDefaultAsync(e => e.CategoryId == cat.CategoryIds[i]) != null)
                        {
                            // Проверка на существование повтора в бд
                            if (await _context.CategoriesOfCats.FirstOrDefaultAsync(x => x.CategoryId == cat.CategoryIds[i] && x.CatId == cat.CatId) == null)
                            {
                                await _context.CategoriesOfCats.AddAsync(new CategoriesOfCat() { CategoryId = cat.CategoryIds[i], CatId = cat.CatId });
                            }
                        }
                    }
                    // Существующие категории к котикам
                    List<CategoriesOfCat> existCategories = await _context.CategoriesOfCats.Where(x => x.CatId == cat.CatId).ToListAsync();

                    // Удаляем существующие категории если массив новых пуст
                    if (cat.CategoryIds.Length == 0)
                    {
                        _context.CategoriesOfCats.RemoveRange(existCategories);
                    }
                    // Иначе сверяем имеющиеся категории с новыми
                    else
                    {
                        for (int i = 0; i < existCategories.Count(); i++)
                        {
                            // Если старая категория отсутствует в списке новых, тогда удаляем
                            if (cat.CategoryIds.Any(s => s == existCategories[i].CategoryId) == false)
                            {
                                _context.CategoriesOfCats.Remove(existCategories[i]);
                            }
                        }
                    }
                }

                try
                {
                    await _context.SaveChangesAsync();

                    // Changing filenamme and filepath
                    string newFilePath = Configuration.imagesPath + "\\" + (classification == null ? "NoClassification" : classification.Name)
                        + "\\" + currentCat.CatId + (currentCat.IsKitty ? "1" : "0") + "." + currentCat.FileType[6..];
                    if (oldFilePath != newFilePath)
                    {
                        if (System.IO.File.Exists(newFilePath))
                            System.IO.File.Delete(newFilePath);

                        System.IO.File.Copy(oldFilePath, newFilePath);
                        System.IO.File.Delete(oldFilePath);
                    }
                }
                catch (Exception ex)
                {
                    return BadRequest(ex.Message);
                }
                return Ok();
            }
            return NotFound();
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
