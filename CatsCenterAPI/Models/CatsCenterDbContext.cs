using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace CatsCenterAPI.Models;

public partial class CatsCenterDbContext : DbContext
{
    public CatsCenterDbContext()
    {
    }

    public CatsCenterDbContext(DbContextOptions<CatsCenterDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<BlockedUser> BlockedUsers { get; set; }

    public virtual DbSet<BodyType> BodyTypes { get; set; }

    public virtual DbSet<Cat> Cats { get; set; }

    public virtual DbSet<Classification> Classifications { get; set; }

    public virtual DbSet<CoatPattern> CoatPatterns { get; set; }

    public virtual DbSet<CoatType> CoatTypes { get; set; }

    public virtual DbSet<Location> Locations { get; set; }

    public virtual DbSet<LocationsOfClassification> LocationsOfClassifications { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DESKTOP-GJJERNN;Initial Catalog=CatsCenterDB;Integrated Security=True;Trusted_Connection=true;TrustServerCertificate=true");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<BlockedUser>(entity =>
        {
            entity.HasOne(d => d.User).WithMany(p => p.BlockedUsers)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BlockedUsers_Users");
        });

        modelBuilder.Entity<BodyType>(entity =>
        {
            entity.Property(e => e.BodyTypeId).ValueGeneratedNever();
            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<Cat>(entity =>
        {
            entity.Property(e => e.CatId).ValueGeneratedNever();
            entity.Property(e => e.FileName).HasMaxLength(100);

            entity.HasOne(d => d.AddedUser).WithMany(p => p.Cats)
                .HasForeignKey(d => d.AddedUserId)
                .HasConstraintName("FK_Cats_Users");

            entity.HasOne(d => d.Classification).WithMany(p => p.Cats)
                .HasForeignKey(d => d.ClassificationId)
                .HasConstraintName("FK_Cats_Classifications");
        });

        modelBuilder.Entity<Classification>(entity =>
        {
            entity.Property(e => e.ClassificationId).ValueGeneratedNever();
            entity.Property(e => e.Name).HasMaxLength(50);

            entity.HasOne(d => d.BodyType).WithMany(p => p.Classifications)
                .HasForeignKey(d => d.BodyTypeId)
                .HasConstraintName("FK_Classifications_BodyTypes");

            entity.HasOne(d => d.CoatPattern).WithMany(p => p.Classifications)
                .HasForeignKey(d => d.CoatPatternId)
                .HasConstraintName("FK_Classifications_CoatPatterns");

            entity.HasOne(d => d.CoatType).WithMany(p => p.Classifications)
                .HasForeignKey(d => d.CoatTypeId)
                .HasConstraintName("FK_Classifications_CoatTypes");
        });

        modelBuilder.Entity<CoatPattern>(entity =>
        {
            entity.Property(e => e.CoatPatternId).ValueGeneratedNever();
            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<CoatType>(entity =>
        {
            entity.Property(e => e.CoatTypeId).ValueGeneratedNever();
            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<Location>(entity =>
        {
            entity.Property(e => e.LocationId).ValueGeneratedNever();
            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<LocationsOfClassification>(entity =>
        {
            entity.HasKey(e => e.LocationOfClassificationId);

            entity.Property(e => e.LocationOfClassificationId).ValueGeneratedNever();

            entity.HasOne(d => d.Classification).WithMany(p => p.LocationsOfClassifications)
                .HasForeignKey(d => d.ClassificationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LocationsOfClassifications_Classifications");

            entity.HasOne(d => d.Location).WithMany(p => p.LocationsOfClassifications)
                .HasForeignKey(d => d.LocationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LocationsOfClassifications_Locations");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.LastUsage).HasColumnType("datetime");
            entity.Property(e => e.Password).HasMaxLength(50);
            entity.Property(e => e.Token).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
