using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class Location
{
    public int LocationId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<LocationsOfClassification> LocationsOfClassifications { get; set; } = new List<LocationsOfClassification>();
}
