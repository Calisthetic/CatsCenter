using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class LocationsOfClassification
{
    public int LocationOfClassificationId { get; set; }

    public int LocationId { get; set; }

    public int ClassificationId { get; set; }

    [JsonIgnore]
    public virtual Classification Classification { get; set; } = null!;

    public virtual Location Location { get; set; } = null!;
}
