using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class BodyType
{
    [JsonPropertyName("body_type_id")]
    public int BodyTypeId { get; set; }

    public string Name { get; set; } = null!;

    [JsonIgnore]
    public virtual ICollection<BodyTypesOfClassification> BodyTypesOfClassifications { get; set; } = new List<BodyTypesOfClassification>();
}
