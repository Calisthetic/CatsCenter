using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class ChangeCatDto
    {
        [JsonPropertyName("cat_id")]
        public int CatId { get; set; }

        [JsonPropertyName("classification_id")]
        public int? ClassificationId { get; set; }

        [JsonPropertyName("added_user_id")]
        public int AddedUserId { get; set; }

        [JsonPropertyName("is_kitty")]
        public bool IsKitty { get; set; }

        [JsonPropertyName("approved")]
        public bool? Approved { get; set; }

        [JsonPropertyName("category_ids")]
        public int[]? CategoryIds { get; set; }
    }
}
