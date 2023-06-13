using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class CatInfoDto
    {
        public CatInfoDto(Cat cat)
        {
            CatId = cat.CatId;
            CatImage = "https://localhost:7288/api/Cats/" + cat.CatId + (cat.IsKitty ? "1" : "0") + "." +
                (cat.FileType[6..] == "jpeg" ? "jpg" : cat.FileType[6..]);
            AddedUserName = cat.AddedUser == null ? "Admin" : cat.AddedUser.Name;
            Age = cat.IsKitty ? "Kitten" : "Adult";
            Classification = cat.Classification == null ? null : new ClassificationsSearchDto(cat.Classification);
            Categories = new CatsCenterDbContext().Categories.AsEnumerable().Where(x => x.CategoriesOfCats.Any(c => c.CatId == cat.CatId) == true).ToList();
        }

        [JsonPropertyName("id")]
        public int CatId { get; set; }

        [JsonPropertyName("cat_image")]
        public string CatImage { get; set; }

        [JsonPropertyName("added_user")]
        public string AddedUserName { get; set; }

        public string Age { get; set; }

        public virtual List<Category> Categories { get; set; } = new List<Category>();

        public virtual ClassificationsSearchDto? Classification { get; set; }
    }
}
