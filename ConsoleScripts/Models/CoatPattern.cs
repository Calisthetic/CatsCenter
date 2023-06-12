using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class CoatPattern
{
    public int CoatPatternId { get; set; }

    public string Name { get; set; } = null!;

    public bool? IsExtra { get; set; }

    public virtual ICollection<CoatPatternsOfClassification> CoatPatternsOfClassifications { get; set; } = new List<CoatPatternsOfClassification>();
}
