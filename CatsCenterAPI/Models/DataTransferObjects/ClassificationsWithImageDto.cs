using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class ClassificationsWithImageDto
    {
        public ClassificationsWithImageDto(Classification classification)
        {
            ClassificationId = classification.ClassificationId;
            Name = classification.Name;
            Cat? cat = new CatsCenterDbContext().Cats.OrderBy(x => Guid.NewGuid()).Where(x => x.ClassificationId == classification.ClassificationId).FirstOrDefault();
            CatImage = cat == null ? null : ("https://localhost:7288/api/Cats/" + cat.CatId + (cat.IsKitty ? "1" : "0") + "." + cat.FileType[6..]);
        }

        [JsonPropertyName("classification_id")]
        public int ClassificationId { get; set; }

        public string Name { get; set; } = null!;

        [JsonPropertyName("cat_image")]
        public string? CatImage { get; set; }
    }
}
