namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class UploadCatImageDto
    {
        public List<IFormFile> File { get; set; }

        public int? ClassificationId { get; set; }

        public int[]? CategoryId { get; set; }

        public bool? IsKitty { get; set; }
    }
}
