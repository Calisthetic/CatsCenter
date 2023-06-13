namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class ClassificationsSearchDto
    {
        public ClassificationsSearchDto(Classification classification)
        {
            id = classification.ClassificationId;
            name = classification.Name;
            type = classification.IsBreed ? "Breed" : "Felidae";
            body_types = new CatsCenterDbContext().BodyTypes.AsEnumerable().Where(x => classification.BodyTypesOfClassifications.Any(s => s.BodyTypeId == x.BodyTypeId) == true).ToList();
            coat_patterns = new CatsCenterDbContext().CoatPatterns.AsEnumerable().Where(x => classification.CoatPatternsOfClassifications.Any(s => s.CoatPatternId == x.CoatPatternId) == true).ToList();
            coat_types = new CatsCenterDbContext().CoatTypes.AsEnumerable().Where(x => classification.CoatTypesOfClassifications.Any(s => s.CoatTypeId == x.CoatTypeId) == true).ToList();
            locations = new CatsCenterDbContext().Locations.AsEnumerable().Where(x => classification.LocationsOfClassifications.Any(s => s.LocationId == x.LocationId) == true).ToList();
        }

        public int id { get; set; }
        public string name { get; set; }
        public string type { get; set; }
        public List<BodyType> body_types { get; set; }
        public List<CoatPattern> coat_patterns { get; set; }
        public List<CoatType> coat_types { get; set; }
        public List<Location> locations { get; set; }
    }
}
