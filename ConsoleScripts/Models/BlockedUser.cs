using System;
using System.Collections.Generic;

namespace CatsCenterAPI.Model;

public partial class BlockedUser
{
    public int BlockedUserId { get; set; }

    public int UserId { get; set; }

    public string Reason { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
