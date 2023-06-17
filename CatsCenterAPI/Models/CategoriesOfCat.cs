using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Models;

public partial class CategoriesOfCat
{
    public int CategoryOfCatId { get; set; }

    public int CatId { get; set; }

    public int CategoryId { get; set; }

    public virtual Cat? Cat { get; set; } = null!;

    public virtual Category? Category { get; set; } = null!;
}
