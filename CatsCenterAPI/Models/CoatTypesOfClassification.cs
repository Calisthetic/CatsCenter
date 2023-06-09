using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Models;

public partial class CoatTypesOfClassification
{
    public int CoatTypeOfClassificationId { get; set; }

    public int CoatTypeId { get; set; }

    public int ClassificationId { get; set; }

    public virtual Classification Classification { get; set; } = null!;

    public virtual CoatType CoatType { get; set; } = null!;
}
