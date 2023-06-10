using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class Cat
{
    public int CatId { get; set; }

    public int? ClassificationId { get; set; }

    public int AddedUserId { get; set; }
    public string FileType { get; set; } = null!;

    public bool IsKitty { get; set; }

    public bool? Approved { get; set; }

    public virtual User? AddedUser { get; set; }// = new User();
    [JsonIgnore]
    public virtual ICollection<CategoriesOfCat> CategoriesOfCats { get; set; } = new List<CategoriesOfCat>();

    public virtual Classification? Classification { get; set; }
}
