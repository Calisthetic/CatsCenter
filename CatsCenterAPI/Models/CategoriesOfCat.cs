﻿using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class CategoriesOfCat
{
    public int CategoryOfCatId { get; set; }

    public int CatId { get; set; }

    public int CategoryId { get; set; }

    [JsonIgnore]
    public virtual Cat Cat { get; set; } = null!;

    [JsonIgnore]
    public virtual Category Category { get; set; } = null!;
}
