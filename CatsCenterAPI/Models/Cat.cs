using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Models;

public partial class Cat
{
    public int CatId { get; set; }

    public int? ClassificationId { get; set; }

    public int? AddedUserId { get; set; }

    public string FileName { get; set; } = null!;

    public bool? Approved { get; set; }

    public virtual User? AddedUser { get; set; }

    public virtual Classification? Classification { get; set; }
}
