# CatsCenter

## Dev

Connection string to localhost

```bash
Scaffold-DbContext "Data Source=DESKTOP-GJJERNN;Initial Catalog=CatsCenterDB;Integrated Security=True;TrustServerCertificate=True" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -force
```

### with password

```bash
Scaffold-DbContext "Data Source=192.168.0.117\SQLEXPRESS;Initial Catalog=db_name;User ID=User;Password=db_password;Trusted_Connection=true;TrustServerCertificate=true;Integrated Security=false;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -force
```

###

- [Cors](https://learn.microsoft.com/en-us/aspnet/web-api/overview/security/enabling-cross-origin-requests-in-web-api)
- [Cors for api](https://learn.microsoft.com/en-us/aspnet/core/security/cors?view=aspnetcore-7.0)

## Links

- [Cat breeds](https://en.wikipedia.org/wiki/List_of_cat_breeds)
- [Cat classifications](https://en.wikipedia.org/wiki/Felidae)
- [Felidae](https://en.wikipedia.org/wiki/Felidae)
- [Image types](https://developer.mozilla.org/en-US/docs/Web/Media/Formats/Image_types)
