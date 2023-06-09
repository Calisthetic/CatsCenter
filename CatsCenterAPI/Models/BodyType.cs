using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Models;

public partial class BodyType
{
    public int BodyTypeId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Classification> Classifications { get; set; } = new List<Classification>();
}
