﻿using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class Classification
{
    public int ClassificationId { get; set; }

    public string Name { get; set; } = null!;

    public bool IsBreed { get; set; }

    public virtual ICollection<BodyTypesOfClassification> BodyTypesOfClassifications { get; set; } = new List<BodyTypesOfClassification>();

    public virtual ICollection<Cat> Cats { get; set; } = new List<Cat>();

    public virtual ICollection<CoatPatternsOfClassification> CoatPatternsOfClassifications { get; set; } = new List<CoatPatternsOfClassification>();

    public virtual ICollection<CoatTypesOfClassification> CoatTypesOfClassifications { get; set; } = new List<CoatTypesOfClassification>();

    public virtual ICollection<LocationsOfClassification> LocationsOfClassifications { get; set; } = new List<LocationsOfClassification>();
}
