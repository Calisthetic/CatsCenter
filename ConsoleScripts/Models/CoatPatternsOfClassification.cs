using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class CoatPatternsOfClassification
{
    public int CoatPatternOfClassificationId { get; set; }

    public int CoatPatternId { get; set; }

    public int ClassificationId { get; set; }

    public virtual Classification Classification { get; set; } = null!;

    public virtual CoatPattern CoatPattern { get; set; } = null!;
}
