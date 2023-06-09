using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace CatsCenterAPI.Models;

public partial class BodyTypesOfClassification
{
    public int BodyTypeOfClassificationId { get; set; }

    public int BodyTypeId { get; set; }

    public int ClassificationId { get; set; }

    public virtual BodyType BodyType { get; set; } = null!;

    [JsonIgnore]
    public virtual Classification Classification { get; set; } = null!;
}
