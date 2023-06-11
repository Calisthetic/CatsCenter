using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class Category
{
    [JsonPropertyName("category_id")]
    public int CategoryId { get; set; }

    public string Name { get; set; } = null!;

    [JsonIgnore]
    public virtual ICollection<CategoriesOfCat> CategoriesOfCats { get; set; } = new List<CategoriesOfCat>();
}
