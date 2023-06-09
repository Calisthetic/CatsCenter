using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class CoatPatternsOfClassification
{
    public int CoatPatternOfClassificationId { get; set; }

    public int CoatPatternId { get; set; }

    public int ClassificationId { get; set; }

    [JsonIgnore]
    public virtual Classification Classification { get; set; } = null!;

    public virtual CoatPattern CoatPattern { get; set; } = null!;
}
