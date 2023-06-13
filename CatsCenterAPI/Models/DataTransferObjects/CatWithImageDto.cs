namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class CatWithImageDto
    {
        public CatWithImageDto(Cat cat)
        {
            CatImage = "https://localhost:7288/api/Cats/" + cat.CatId + (cat.IsKitty ? "1" : "0") + "." + cat.FileType[6..];
            AddedUserName = cat.AddedUser == null ? null : cat.AddedUser.Name;
            IsKitty = cat.IsKitty;
            ClassificationName = cat.Classification == null ? "none" : cat.Classification.Name;
        }
        public string CatImage { get; set; }

        public string? AddedUserName { get; set; }

        public bool IsKitty { get; set; }
        public string ClassificationName { get; set; }
    }
}
