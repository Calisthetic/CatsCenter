using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Models;

public partial class CoatType
{
    public int CoatTypeId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<CoatTypesOfClassification> CoatTypesOfClassifications { get; set; } = new List<CoatTypesOfClassification>();
}
