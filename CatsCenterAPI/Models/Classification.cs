using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class Classification
{
    [JsonPropertyName("classification_id")]
    public int ClassificationId { get; set; }

    public string Name { get; set; } = null!;

    [JsonIgnore]
    public bool IsBreed { get; set; }

    [JsonIgnore]
    public virtual ICollection<BodyTypesOfClassification> BodyTypesOfClassifications { get; set; } = new List<BodyTypesOfClassification>();

    [JsonIgnore]
    public virtual ICollection<Cat> Cats { get; set; } = new List<Cat>();

    [JsonIgnore]
    public virtual ICollection<CoatPatternsOfClassification> CoatPatternsOfClassifications { get; set; } = new List<CoatPatternsOfClassification>();

    [JsonIgnore]
    public virtual ICollection<CoatTypesOfClassification> CoatTypesOfClassifications { get; set; } = new List<CoatTypesOfClassification>();

    [JsonIgnore]
    public virtual ICollection<LocationsOfClassification> LocationsOfClassifications { get; set; } = new List<LocationsOfClassification>();
}
