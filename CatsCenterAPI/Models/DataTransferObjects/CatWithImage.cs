namespace CatsCenterAPI.Models.DataTransferObjects
{
    public class CatWithImage
    {
        public CatWithImage(Cat cat)
        {
            CatImage = "https://localhost:7288/api/Cat/" + cat.CatId;
            AddedUserName = cat.AddedUser.Name;
            IsKitty = cat.IsKitty;
            ClassificationName = cat.Classification == null ? "none" : cat.Classification.Name;
        }
        public string CatImage { get; set; }

        public string? AddedUserName { get; set; }

        public bool IsKitty { get; set; }
        public string ClassificationName { get; set; }
    }
}
