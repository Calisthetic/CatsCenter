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

    public virtual DbSet<BodyTypesOfClassification> BodyTypesOfClassifications { get; set; }

    public virtual DbSet<Cat> Cats { get; set; }

    public virtual DbSet<Classification> Classifications { get; set; }

    public virtual DbSet<CoatPattern> CoatPatterns { get; set; }

    public virtual DbSet<CoatPatternsOfClassification> CoatPatternsOfClassifications { get; set; }

    public virtual DbSet<CoatType> CoatTypes { get; set; }

    public virtual DbSet<CoatTypesOfClassification> CoatTypesOfClassifications { get; set; }

    public virtual DbSet<Location> Locations { get; set; }

    public virtual DbSet<LocationsOfClassification> LocationsOfClassifications { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Data Source=DESKTOP-GJJERNN;Initial Catalog=CatsCenterDB;Integrated Security=True;TrustServerCertificate=True");

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
            entity.Property(e => e.Name).HasMaxLength(60);
        });

        modelBuilder.Entity<BodyTypesOfClassification>(entity =>
        {
            entity.HasKey(e => e.BodyTypeOfClassificationId);

            entity.HasOne(d => d.BodyType).WithMany(p => p.BodyTypesOfClassifications)
                .HasForeignKey(d => d.BodyTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BodyTypesOfClassifications_BodyTypes");

            entity.HasOne(d => d.Classification).WithMany(p => p.BodyTypesOfClassifications)
                .HasForeignKey(d => d.ClassificationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BodyTypesOfClassifications_Classifications");
        });

        modelBuilder.Entity<Cat>(entity =>
        {
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
            entity.Property(e => e.Name).HasMaxLength(60);
        });

        modelBuilder.Entity<CoatPattern>(entity =>
        {
            entity.Property(e => e.Name).HasMaxLength(60);
        });

        modelBuilder.Entity<CoatPatternsOfClassification>(entity =>
        {
            entity.HasKey(e => e.CoatPatternOfClassificationId);

            entity.HasOne(d => d.Classification).WithMany(p => p.CoatPatternsOfClassifications)
                .HasForeignKey(d => d.ClassificationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CoatPatternsOfClassifications_Classifications");

            entity.HasOne(d => d.CoatPattern).WithMany(p => p.CoatPatternsOfClassifications)
                .HasForeignKey(d => d.CoatPatternId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CoatPatternsOfClassifications_CoatPatterns");
        });

        modelBuilder.Entity<CoatType>(entity =>
        {
            entity.Property(e => e.Name).HasMaxLength(60);
        });

        modelBuilder.Entity<CoatTypesOfClassification>(entity =>
        {
            entity.HasKey(e => e.CoatTypeOfClassificationId);

            entity.HasOne(d => d.Classification).WithMany(p => p.CoatTypesOfClassifications)
                .HasForeignKey(d => d.ClassificationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CoatTypesOfClassifications_Classifications");

            entity.HasOne(d => d.CoatType).WithMany(p => p.CoatTypesOfClassifications)
                .HasForeignKey(d => d.CoatTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CoatTypesOfClassifications_CoatTypes");
        });

        modelBuilder.Entity<Location>(entity =>
        {
            entity.Property(e => e.Name).HasMaxLength(60);
        });

        modelBuilder.Entity<LocationsOfClassification>(entity =>
        {
            entity.HasKey(e => e.LocationOfClassificationId);

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
            entity.Property(e => e.Email).HasMaxLength(20);
            entity.Property(e => e.LastUsage).HasColumnType("datetime");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(20);
            entity.Property(e => e.Token).HasMaxLength(20);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
