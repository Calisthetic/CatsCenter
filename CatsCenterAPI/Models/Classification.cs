using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Models;

public partial class Classification
{
    public int ClassificationId { get; set; }

    public int? CoatTypeId { get; set; }

    public int? CoatPatternId { get; set; }

    public int? BodyTypeId { get; set; }

    public bool IsBreed { get; set; }

    public string Name { get; set; } = null!;

    public virtual BodyType? BodyType { get; set; }

    public virtual ICollection<Cat> Cats { get; set; } = new List<Cat>();

    public virtual CoatPattern? CoatPattern { get; set; }

    public virtual CoatType? CoatType { get; set; }

    public virtual ICollection<LocationsOfClassification> LocationsOfClassifications { get; set; } = new List<LocationsOfClassification>();
}
