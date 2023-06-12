using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class BodyType
{
    public int BodyTypeId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<BodyTypesOfClassification> BodyTypesOfClassifications { get; set; } = new List<BodyTypesOfClassification>();
}
