namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class UploadCatImage
    {
        public List<IFormFile> File { get; set; }

        public int? ClassificationId { get; set; }

        public bool? IsKitty { get; set; }
    }
}
