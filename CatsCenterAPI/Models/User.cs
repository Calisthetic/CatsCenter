using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Models;

public partial class User
{
    public int UserId { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Token { get; set; } = null!;

    public int UsageCount { get; set; }

    public DateTime LastUsage { get; set; }

    public virtual ICollection<BlockedUser> BlockedUsers { get; set; } = new List<BlockedUser>();

    public virtual ICollection<Cat> Cats { get; set; } = new List<Cat>();
}
