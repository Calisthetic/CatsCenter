namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class ChangeCatDto
    {
        public int CatId { get; set; }

        public int? ClassificationId { get; set; }

        public int AddedUserId { get; set; }

        public bool IsKitty { get; set; }

        public bool? Approved { get; set; }
    }
}
