using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class Category
{
    public int CategoryId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<CategoriesOfCat> CategoriesOfCats { get; set; } = new List<CategoriesOfCat>();
}
