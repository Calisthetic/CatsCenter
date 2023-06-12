using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class LocationsOfClassification
{
    public int LocationOfClassificationId { get; set; }

    public int LocationId { get; set; }

    public int ClassificationId { get; set; }

    public virtual Classification Classification { get; set; } = null!;

    public virtual Location Location { get; set; } = null!;
}
