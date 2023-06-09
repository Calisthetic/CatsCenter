USE [master]
GO
/****** Object:  Database [CatsCenterDB]    Script Date: 09.06.2023 18:44:32 ******/
CREATE DATABASE [CatsCenterDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CatsCenterDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CatsCenterDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CatsCenterDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CatsCenterDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CatsCenterDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CatsCenterDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CatsCenterDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CatsCenterDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CatsCenterDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CatsCenterDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CatsCenterDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CatsCenterDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CatsCenterDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CatsCenterDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CatsCenterDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CatsCenterDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CatsCenterDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CatsCenterDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CatsCenterDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CatsCenterDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CatsCenterDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CatsCenterDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CatsCenterDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CatsCenterDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CatsCenterDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CatsCenterDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CatsCenterDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CatsCenterDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CatsCenterDB] SET RECOVERY FULL 
GO
ALTER DATABASE [CatsCenterDB] SET  MULTI_USER 
GO
ALTER DATABASE [CatsCenterDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CatsCenterDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CatsCenterDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CatsCenterDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CatsCenterDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CatsCenterDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CatsCenterDB', N'ON'
GO
ALTER DATABASE [CatsCenterDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [CatsCenterDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CatsCenterDB]
GO
/****** Object:  Table [dbo].[BlockedUsers]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlockedUsers](
	[BlockedUserId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Reason] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_BlockedUsers] PRIMARY KEY CLUSTERED 
(
	[BlockedUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BodyTypes]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BodyTypes](
	[BodyTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_BodyTypes] PRIMARY KEY CLUSTERED 
(
	[BodyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BodyTypesOfClassifications]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BodyTypesOfClassifications](
	[BodyTypeOfClassificationId] [int] IDENTITY(1,1) NOT NULL,
	[BodyTypeId] [int] NOT NULL,
	[ClassificationId] [int] NOT NULL,
 CONSTRAINT [PK_BodyTypesOfClassifications] PRIMARY KEY CLUSTERED 
(
	[BodyTypeOfClassificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cats]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cats](
	[CatId] [int] IDENTITY(1,1) NOT NULL,
	[ClassificationId] [int] NULL,
	[AddedUserId] [int] NULL,
	[IsKitty] [bit] NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Cats] PRIMARY KEY CLUSTERED 
(
	[CatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classifications]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classifications](
	[ClassificationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NOT NULL,
	[IsBreed] [bit] NOT NULL,
 CONSTRAINT [PK_Classifications] PRIMARY KEY CLUSTERED 
(
	[ClassificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoatPatterns]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoatPatterns](
	[CoatPatternId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_CoatPatterns] PRIMARY KEY CLUSTERED 
(
	[CoatPatternId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoatPatternsOfClassifications]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoatPatternsOfClassifications](
	[CoatPatternOfClassificationId] [int] IDENTITY(1,1) NOT NULL,
	[CoatPatternId] [int] NOT NULL,
	[ClassificationId] [int] NOT NULL,
 CONSTRAINT [PK_CoatPatternsOfClassifications] PRIMARY KEY CLUSTERED 
(
	[CoatPatternOfClassificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoatTypes]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoatTypes](
	[CoatTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_CoatTypes] PRIMARY KEY CLUSTERED 
(
	[CoatTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoatTypesOfClassifications]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoatTypesOfClassifications](
	[CoatTypeOfClassificationId] [int] IDENTITY(1,1) NOT NULL,
	[CoatTypeId] [int] NOT NULL,
	[ClassificationId] [int] NOT NULL,
 CONSTRAINT [PK_CoatTypesOfClassifications] PRIMARY KEY CLUSTERED 
(
	[CoatTypeOfClassificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationsOfClassifications]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationsOfClassifications](
	[LocationOfClassificationId] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [int] NOT NULL,
	[ClassificationId] [int] NOT NULL,
 CONSTRAINT [PK_LocationsOfClassifications] PRIMARY KEY CLUSTERED 
(
	[LocationOfClassificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09.06.2023 18:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Email] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[Token] [nvarchar](20) NOT NULL,
	[UsageCount] [int] NOT NULL,
	[LastUsage] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BodyTypes] ON 

INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (1, N'Semi-foreign')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (2, N'Moderate')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (3, N'Cobby')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (4, N'Foreign')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (5, N'Normal')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (6, N'Lean')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (7, N'Svelte')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (8, N'Dwarf')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (9, N'Large')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (10, N'Semi-cobby')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (11, N'Muscular')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (12, N'Oriental')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (13, N'Small')
INSERT [dbo].[BodyTypes] ([BodyTypeId], [Name]) VALUES (14, N'Medium')
SET IDENTITY_INSERT [dbo].[BodyTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[BodyTypesOfClassifications] ON 

INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (1, 1, 1)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (2, 2, 2)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (3, 3, 3)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (4, 1, 4)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (5, 4, 5)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (6, 3, 6)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (7, 5, 7)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (8, 6, 8)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (9, 11, 8)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (10, 2, 9)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (11, 11, 9)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (12, 2, 10)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (13, 2, 11)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (14, 2, 12)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (15, 1, 13)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (16, 8, 14)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (17, 9, 15)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (18, 3, 16)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (19, 3, 17)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (20, 5, 18)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (21, 3, 19)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (22, 3, 20)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (23, 1, 21)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (24, 10, 21)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (25, 10, 22)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (26, 2, 23)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (27, 3, 24)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (28, 3, 25)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (29, 11, 25)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (30, 5, 26)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (31, 4, 27)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (32, 4, 28)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (33, 10, 29)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (34, 6, 30)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (35, 11, 30)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (36, 1, 31)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (37, 1, 32)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (38, 1, 33)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (39, 5, 34)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (40, 5, 35)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (41, 8, 36)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (42, 2, 37)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (43, 11, 37)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (44, 2, 38)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (45, 3, 39)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (46, 3, 40)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (47, 1, 41)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (48, 1, 42)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (49, 2, 43)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (50, 3, 44)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (51, 3, 45)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (52, 2, 46)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (53, 12, 47)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (54, 12, 48)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (55, 1, 49)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (56, 2, 50)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (57, 8, 51)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (58, 1, 52)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (59, 10, 52)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (60, 11, 52)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (61, 2, 53)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (62, 13, 54)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (63, 10, 55)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (65, 8, 57)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (66, 2, 58)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (67, 2, 59)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (68, 9, 60)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (69, 2, 61)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (70, 2, 62)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (71, 8, 63)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (72, 8, 64)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (73, 8, 65)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (74, 4, 66)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (75, 3, 67)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (76, 3, 68)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (77, 9, 69)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (78, 2, 70)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (79, 12, 72)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (80, 12, 73)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (81, 12, 74)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (82, 3, 75)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (83, 3, 76)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (84, 12, 77)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (85, 14, 78)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (86, 3, 79)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (87, 3, 80)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (88, 3, 81)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (89, 2, 82)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (90, 2, 83)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (91, 12, 83)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (92, 2, 84)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (93, 2, 85)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (94, 2, 86)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (95, 2, 87)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (96, 9, 88)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (97, 3, 89)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (98, 3, 90)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (99, 9, 90)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (100, 2, 91)
GO
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (101, 10, 92)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (102, 2, 93)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (103, 3, 94)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (104, 13, 95)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (105, 2, 96)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (106, 2, 97)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (107, 3, 98)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (108, 12, 99)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (109, 2, 100)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (110, 2, 101)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (111, 2, 102)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (112, 2, 103)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (113, 2, 104)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (114, 2, 105)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (115, 12, 106)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (116, 8, 107)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (117, 2, 108)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (118, 10, 109)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (119, 10, 110)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (121, 2, 112)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (122, 2, 113)
INSERT [dbo].[BodyTypesOfClassifications] ([BodyTypeOfClassificationId], [BodyTypeId], [ClassificationId]) VALUES (123, 7, 111)
SET IDENTITY_INSERT [dbo].[BodyTypesOfClassifications] OFF
GO
SET IDENTITY_INSERT [dbo].[Classifications] ON 

INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (1, N'Abyssinian', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (2, N'Aegean', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (3, N'American Bobtail', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (4, N'American Curl', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (5, N'American Ringtail', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (6, N'American Shorthair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (7, N'American Wirehair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (8, N'Aphrodite Giant', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (9, N'Arabian Mau', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (10, N'Asian', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (11, N'Asian Semi-longhair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (12, N'Australian Mist', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (13, N'Balinese', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (14, N'Bambino', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (15, N'Bengal', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (16, N'Birman', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (17, N'Bombay', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (18, N'Brazilian Shorthair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (19, N'British Longhair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (20, N'British Shorthair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (21, N'Burmese', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (22, N'Burmilla', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (23, N'California Spangled', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (24, N'Chantilly-Tiffany', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (25, N'Chartreux', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (26, N'Chausie', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (27, N'Colorpoint Shorthair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (28, N'Cornish Rex', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (29, N'Cymric or Manx Longhair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (30, N'Cyprus', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (31, N'Devon Rex', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (32, N'Donskoy', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (33, N'Don Sphynx', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (34, N'Dragon Li', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (35, N'Chinese Li Hua', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (36, N'Dwelf', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (37, N'Egyptian Mau', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (38, N'European Shorthair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (39, N'Exotic Shorthair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (40, N'Foldex', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (41, N'German Rex', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (42, N'Havana Brown', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (43, N'Highlander', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (44, N'Himalayan', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (45, N'Colorpoint Persian', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (46, N'Japanese Bobtail', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (47, N'Javanese', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (48, N'Colorpoint Longhair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (49, N'Kanaani', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (50, N'Khao Manee', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (51, N'Kinkalow', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (52, N'Korat', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (53, N'Korean Bobtail', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (54, N'Korn Ja', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (55, N'Kurilian Bobtail or', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (57, N'Lambkin', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (58, N'LaPerm', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (59, N'Lykoi', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (60, N'Maine Coon', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (61, N'Manx', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (62, N'Mekong Bobtail', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (63, N'Minskin', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (64, N'Minuet', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (65, N'Munchkin', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (66, N'Nebelung', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (67, N'Neva Masquerade (colorpoint Siberian)', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (68, N'Norwegian Forest Cat', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (69, N'Ocicat', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (70, N'Ojos Azules', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (71, N'Oregon Rex', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (72, N'Oriental Bicolor', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (73, N'Oriental Longhair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (74, N'Oriental Shorthair', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (75, N'Persian (modern)', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (76, N'Persian (traditional)', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (77, N'Peterbald', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (78, N'Pixie-bob', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (79, N'Ragamuffin', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (80, N'Liebling (obsolete)', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (81, N'Ragdoll', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (82, N'Raas', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (83, N'Russian Blue', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (84, N'Russian White', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (85, N'Russian Black', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (86, N'Russian Tabby', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (87, N'Sam Sawet', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (88, N'Savannah', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (89, N'Scottish Fold', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (90, N'Selkirk Rex', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (91, N'Serengeti', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (92, N'Serrade Petit', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (93, N'Siamese (modern)', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (94, N'Siberian', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (95, N'Singapura', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (96, N'Snowshoe', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (97, N'Sokoke', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (98, N'Somali', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (99, N'Sphynx', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (100, N'Suphalak', 1)
GO
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (101, N'Siamese', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (102, N'Wichien Maat', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (103, N'Thai Lilac', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (104, N'Thai Blue Point', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (105, N'Thai Lilac Point', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (106, N'Tonkinese', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (107, N'Toybob', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (108, N'Toyger', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (109, N'Turkish Angora', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (110, N'Turkish Van', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (111, N'Turkish Vankedisi', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (112, N'Ukrainian Levkoy', 1)
INSERT [dbo].[Classifications] ([ClassificationId], [Name], [IsBreed]) VALUES (113, N'York Chocolate', 1)
SET IDENTITY_INSERT [dbo].[Classifications] OFF
GO
SET IDENTITY_INSERT [dbo].[CoatPatterns] ON 

INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (1, N'All')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (2, N'All but colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (3, N'All excluding chocolate and colourpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (4, N'All without white and without siamese pointing')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (5, N'All; except chocolate, lilac, cinnamon, and fawn')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (6, N'Bicolor')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (7, N'Black')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (8, N'Black grizzled tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (9, N'Black roan')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (10, N'Black ticked tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (11, N'Blue point')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (12, N'Chocolate')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (13, N'Chocolate spotted tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (14, N'Cinnamon colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (15, N'Cinnamon spotted tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (16, N'Classic tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (17, N'Colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (18, N'Lilac point')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (19, N'Mackerel tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (20, N'Marbled')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (21, N'Mink')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (22, N'Mitted')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (23, N'Mitted colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (24, N'Multi-color')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (25, N'Orange')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (26, N'Rosetted')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (27, N'Silver tipped patterns')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (28, N'Solid')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (29, N'Solid black')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (30, N'Solid blue')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (31, N'Solid brown')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (32, N'Solid chocolate')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (33, N'Solid cinnamon')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (34, N'Solid gray')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (35, N'Solid lilac')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (36, N'Solid orange')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (37, N'Solid reddish-brown')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (38, N'Solid tan')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (39, N'Solid taupe')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (40, N'Solid white')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (41, N'Solid with shaded silver')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (42, N'Spotted')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (43, N'Spotted or marbled')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (44, N'Spotted tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (45, N'Tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (46, N'Ticked tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (47, N'Tortoiseshell')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (48, N'Van pattern')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (49, N'Varying shades of blue')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (50, N'White hairless')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (51, N'White bicolor')
SET IDENTITY_INSERT [dbo].[CoatPatterns] OFF
GO
SET IDENTITY_INSERT [dbo].[CoatPatternsOfClassifications] ON 

INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (1, 46, 1)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (2, 24, 2)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (3, 1, 3)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (4, 1, 4)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (5, 1, 5)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (6, 1, 6)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (7, 1, 7)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (8, 1, 8)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (9, 1, 9)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (10, 4, 10)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (11, 4, 11)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (12, 43, 12)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (13, 17, 13)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (14, 50, 14)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (15, 7, 14)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (16, 42, 15)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (17, 26, 15)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (18, 20, 15)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (19, 23, 16)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (20, 29, 17)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (21, 1, 18)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (22, 1, 19)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (23, 1, 20)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (24, 47, 21)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (25, 28, 21)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (26, 41, 22)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (27, 27, 22)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (28, 44, 23)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (29, 28, 24)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (30, 16, 24)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (31, 44, 24)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (32, 46, 24)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (33, 49, 25)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (34, 29, 26)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (35, 8, 26)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (36, 10, 26)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (37, 17, 27)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (38, 1, 28)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (39, 1, 29)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (41, 1, 30)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (42, 1, 31)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (43, 28, 32)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (44, 28, 33)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (45, 46, 34)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (46, 46, 35)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (47, 1, 36)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (48, 44, 37)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (49, 1, 38)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (50, 1, 39)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (51, 1, 40)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (52, 1, 41)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (53, 31, 42)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (54, 1, 43)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (55, 17, 44)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (56, 17, 45)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (57, 1, 46)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (58, 17, 47)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (59, 17, 48)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (60, 29, 49)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (61, 13, 49)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (62, 15, 49)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (63, 40, 50)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (64, 1, 51)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (65, 30, 52)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (66, 1, 53)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (67, 29, 54)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (68, 1, 55)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (69, 1, 57)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (70, 1, 58)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (71, 9, 59)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (72, 3, 60)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (73, 1, 61)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (74, 17, 62)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (75, 1, 63)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (76, 1, 64)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (77, 1, 65)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (78, 30, 66)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (79, 17, 67)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (80, 12, 68)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (81, 25, 68)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (82, 51, 68)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (83, 44, 69)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (84, 1, 70)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (85, 6, 72)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (86, 1, 73)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (87, 1, 74)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (88, 2, 75)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (89, 2, 76)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (90, 1, 77)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (91, 44, 78)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (92, 1, 79)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (93, 1, 80)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (94, 17, 81)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (95, 22, 81)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (96, 6, 81)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (97, 14, 82)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (98, 30, 82)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (99, 33, 82)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (100, 30, 83)
GO
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (101, 40, 84)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (102, 29, 84)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (103, 45, 84)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (104, 28, 87)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (105, 42, 88)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (106, 1, 89)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (107, 1, 90)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (108, 42, 91)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (109, 40, 85)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (110, 29, 85)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (111, 45, 85)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (112, 40, 86)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (113, 29, 86)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (114, 45, 86)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (115, 38, 92)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (116, 36, 92)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (117, 40, 92)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (118, 17, 93)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (119, 5, 94)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (120, 46, 95)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (121, 23, 96)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (122, 46, 97)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (123, 46, 98)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (124, 1, 99)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (125, 37, 100)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (126, 17, 101)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (127, 17, 102)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (128, 35, 103)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (129, 11, 103)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (130, 18, 103)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (131, 35, 104)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (132, 11, 104)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (133, 18, 104)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (135, 35, 105)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (136, 11, 105)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (137, 18, 105)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (138, 17, 106)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (139, 21, 106)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (140, 28, 106)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (141, 1, 107)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (142, 19, 108)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (143, 1, 109)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (144, 48, 110)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (145, 34, 112)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (147, 32, 113)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (148, 35, 113)
INSERT [dbo].[CoatPatternsOfClassifications] ([CoatPatternOfClassificationId], [CoatPatternId], [ClassificationId]) VALUES (149, 39, 113)
SET IDENTITY_INSERT [dbo].[CoatPatternsOfClassifications] OFF
GO
SET IDENTITY_INSERT [dbo].[CoatTypes] ON 

INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (1, N'Short')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (2, N'Semi-long')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (3, N'Rex')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (4, N'All')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (5, N'Long')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (6, N'Hairless')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (7, N'Velour')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (8, N'Brush')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (9, N'Straight coat')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (10, N'Sparse haired')
SET IDENTITY_INSERT [dbo].[CoatTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[CoatTypesOfClassifications] ON 

INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (1, 1, 1)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (2, 2, 2)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (3, 2, 3)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (4, 2, 4)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (5, 2, 5)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (6, 1, 6)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (7, 3, 7)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (8, 4, 8)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (9, 1, 9)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (10, 1, 10)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (11, 2, 11)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (12, 1, 12)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (13, 5, 13)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (14, 1, 14)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (15, 1, 15)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (16, 2, 16)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (17, 1, 17)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (18, 1, 18)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (19, 2, 19)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (20, 1, 20)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (21, 1, 21)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (22, 1, 22)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (23, 1, 23)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (24, 5, 24)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (25, 1, 25)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (26, 1, 26)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (27, 1, 27)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (28, 3, 28)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (29, 5, 29)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (30, 4, 30)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (31, 3, 31)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (32, 6, 32)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (33, 6, 33)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (34, 1, 34)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (35, 1, 35)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (36, 6, 36)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (37, 1, 37)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (38, 1, 38)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (39, 1, 39)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (40, 1, 40)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (41, 3, 41)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (42, 1, 42)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (43, 1, 43)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (44, 5, 43)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (45, 5, 44)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (46, 5, 45)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (47, 1, 46)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (48, 5, 46)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (49, 5, 47)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (50, 5, 48)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (51, 1, 49)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (52, 1, 50)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (53, 1, 51)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (54, 1, 52)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (55, 1, 53)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (56, 5, 53)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (57, 1, 54)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (58, 1, 55)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (59, 5, 55)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (60, 3, 57)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (61, 3, 58)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (62, 10, 59)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (63, 2, 60)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (64, 5, 60)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (65, 1, 61)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (66, 5, 61)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (67, 1, 62)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (68, 6, 63)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (69, 1, 64)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (70, 5, 64)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (71, 1, 65)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (72, 5, 65)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (73, 2, 66)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (74, 5, 67)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (75, 5, 68)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (76, 1, 69)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (77, 1, 70)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (78, 3, 71)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (79, 1, 72)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (80, 2, 73)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (81, 1, 74)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (83, 5, 75)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (84, 5, 76)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (85, 6, 77)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (86, 7, 77)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (87, 8, 77)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (88, 9, 77)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (89, 1, 78)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (90, 5, 79)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (91, 5, 80)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (92, 5, 81)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (93, 1, 82)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (94, 1, 83)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (95, 1, 84)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (96, 1, 85)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (97, 1, 86)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (98, 1, 87)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (99, 1, 88)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (100, 1, 89)
GO
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (101, 5, 89)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (102, 1, 90)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (103, 5, 90)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (104, 2, 90)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (105, 1, 91)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (106, 1, 92)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (107, 1, 93)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (108, 5, 94)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (109, 1, 95)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (110, 1, 96)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (111, 1, 97)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (112, 5, 98)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (113, 6, 99)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (114, 1, 100)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (115, 1, 101)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (116, 1, 102)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (117, 1, 103)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (118, 1, 104)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (119, 1, 105)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (120, 1, 106)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (121, 1, 107)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (122, 1, 108)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (123, 2, 109)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (124, 2, 110)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (125, 5, 111)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (126, 6, 112)
INSERT [dbo].[CoatTypesOfClassifications] ([CoatTypeOfClassificationId], [CoatTypeId], [ClassificationId]) VALUES (128, 5, 113)
SET IDENTITY_INSERT [dbo].[CoatTypesOfClassifications] OFF
GO
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (1, N'Afro-Asia')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (2, N'Asia')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (3, N'Australia')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (4, N'Brazil')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (5, N'Buckfastleigh')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (6, N'Burma (Myanmar)')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (7, N'Canada')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (8, N'China')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (9, N'Continental Europe')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (10, N'Cornwall')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (11, N'Cyprus')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (12, N'Devon')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (13, N'Egypt')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (14, N'Europe')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (15, N'France')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (16, N'Germany')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (17, N'Greater Iran')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (18, N'Greece')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (19, N'Indonesia')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (20, N'Israel')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (21, N'Japan')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (22, N'Kenya')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (23, N'Korea')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (24, N'Kuril Islands')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (25, N'North Pacific')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (26, N'Norway')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (27, N'Raas Island')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (28, N'Russia')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (29, N'Scotland')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (30, N'Singapore')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (31, N'Southeast Asia')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (32, N'Thailand')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (33, N'the Arabian Peninsula')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (34, N'the Isle of Man')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (35, N'the United Kingdom')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (36, N'the United States')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (37, N'Turkey')
INSERT [dbo].[Locations] ([LocationId], [Name]) VALUES (38, N'Ukraine')
SET IDENTITY_INSERT [dbo].[Locations] OFF
GO
SET IDENTITY_INSERT [dbo].[LocationsOfClassifications] ON 

INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (1, 1, 1)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (2, 18, 2)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (3, 36, 3)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (4, 36, 4)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (6, 36, 5)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (7, 36, 6)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (8, 36, 7)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (9, 11, 8)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (10, 33, 9)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (11, 35, 10)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (12, 35, 11)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (13, 3, 12)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (14, 36, 13)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (15, 32, 13)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (16, 36, 14)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (17, 36, 15)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (18, 2, 15)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (19, 6, 16)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (20, 15, 16)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (21, 6, 17)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (22, 36, 17)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (23, 4, 18)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (24, 35, 19)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (25, 35, 20)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (26, 6, 21)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (27, 35, 22)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (28, 36, 23)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (29, 36, 24)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (30, 15, 25)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (31, 36, 26)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (32, 35, 27)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (33, 35, 28)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (34, 10, 28)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (35, 36, 29)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (36, 34, 29)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (37, 7, 29)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (38, 11, 30)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (39, 5, 31)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (40, 12, 31)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (41, 35, 31)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (43, 28, 32)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (44, 28, 33)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (45, 8, 34)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (46, 8, 35)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (47, 36, 36)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (48, 13, 37)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (49, 14, 38)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (50, 36, 39)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (51, 7, 40)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (52, 32, 42)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (53, 35, 42)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (54, 36, 43)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (55, 36, 44)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (56, 35, 44)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (57, 36, 45)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (58, 35, 45)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (59, 16, 41)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (60, 21, 46)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (61, 7, 47)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (62, 36, 47)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (63, 31, 47)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (64, 20, 49)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (65, 32, 50)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (66, 36, 51)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (67, 32, 52)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (68, 23, 53)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (69, 7, 48)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (70, 36, 48)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (71, 31, 48)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (72, 32, 54)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (73, 25, 55)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (74, 24, 55)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (75, 36, 57)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (76, 36, 58)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (77, 36, 59)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (78, 36, 60)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (79, 34, 61)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (80, 28, 62)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (81, 31, 62)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (82, 36, 63)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (83, 36, 64)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (84, 36, 65)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (85, 36, 66)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (86, 28, 67)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (87, 26, 68)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (88, 36, 69)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (89, 36, 70)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (90, 36, 71)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (91, 36, 72)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (92, 35, 72)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (93, 32, 72)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (94, 14, 72)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (95, 35, 73)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (96, 36, 73)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (97, 32, 73)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (98, 35, 74)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (99, 36, 74)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (100, 32, 74)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (101, 36, 75)
GO
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (102, 14, 75)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (103, 17, 75)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (104, 17, 76)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (105, 28, 77)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (106, 36, 78)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (107, 36, 79)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (108, 36, 80)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (109, 36, 81)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (110, 27, 82)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (111, 19, 82)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (112, 28, 83)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (113, 3, 84)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (114, 28, 84)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (115, 3, 85)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (116, 28, 85)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (117, 3, 86)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (118, 28, 86)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (119, 32, 87)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (120, 36, 88)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (121, 26, 89)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (122, 35, 89)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (123, 36, 90)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (124, 36, 91)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (125, 15, 92)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (126, 36, 93)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (127, 14, 93)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (128, 32, 93)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (129, 38, 94)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (130, 28, 94)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (131, 36, 95)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (132, 30, 95)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (133, 36, 96)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (134, 22, 97)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (135, 36, 98)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (136, 7, 98)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (137, 7, 99)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (138, 14, 99)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (139, 32, 100)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (140, 32, 101)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (141, 14, 101)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (142, 32, 102)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (143, 14, 102)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (144, 32, 103)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (145, 32, 104)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (146, 32, 105)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (147, 7, 106)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (148, 36, 106)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (149, 28, 107)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (150, 36, 108)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (151, 37, 109)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (152, 35, 110)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (153, 37, 110)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (155, 38, 112)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (156, 36, 113)
INSERT [dbo].[LocationsOfClassifications] ([LocationOfClassificationId], [LocationId], [ClassificationId]) VALUES (157, 37, 111)
SET IDENTITY_INSERT [dbo].[LocationsOfClassifications] OFF
GO
ALTER TABLE [dbo].[BlockedUsers]  WITH CHECK ADD  CONSTRAINT [FK_BlockedUsers_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BlockedUsers] CHECK CONSTRAINT [FK_BlockedUsers_Users]
GO
ALTER TABLE [dbo].[BodyTypesOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_BodyTypesOfClassifications_BodyTypes] FOREIGN KEY([BodyTypeId])
REFERENCES [dbo].[BodyTypes] ([BodyTypeId])
GO
ALTER TABLE [dbo].[BodyTypesOfClassifications] CHECK CONSTRAINT [FK_BodyTypesOfClassifications_BodyTypes]
GO
ALTER TABLE [dbo].[BodyTypesOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_BodyTypesOfClassifications_Classifications] FOREIGN KEY([ClassificationId])
REFERENCES [dbo].[Classifications] ([ClassificationId])
GO
ALTER TABLE [dbo].[BodyTypesOfClassifications] CHECK CONSTRAINT [FK_BodyTypesOfClassifications_Classifications]
GO
ALTER TABLE [dbo].[Cats]  WITH CHECK ADD  CONSTRAINT [FK_Cats_Classifications] FOREIGN KEY([ClassificationId])
REFERENCES [dbo].[Classifications] ([ClassificationId])
GO
ALTER TABLE [dbo].[Cats] CHECK CONSTRAINT [FK_Cats_Classifications]
GO
ALTER TABLE [dbo].[Cats]  WITH CHECK ADD  CONSTRAINT [FK_Cats_Users] FOREIGN KEY([AddedUserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Cats] CHECK CONSTRAINT [FK_Cats_Users]
GO
ALTER TABLE [dbo].[CoatPatternsOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_CoatPatternsOfClassifications_Classifications] FOREIGN KEY([ClassificationId])
REFERENCES [dbo].[Classifications] ([ClassificationId])
GO
ALTER TABLE [dbo].[CoatPatternsOfClassifications] CHECK CONSTRAINT [FK_CoatPatternsOfClassifications_Classifications]
GO
ALTER TABLE [dbo].[CoatPatternsOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_CoatPatternsOfClassifications_CoatPatterns] FOREIGN KEY([CoatPatternId])
REFERENCES [dbo].[CoatPatterns] ([CoatPatternId])
GO
ALTER TABLE [dbo].[CoatPatternsOfClassifications] CHECK CONSTRAINT [FK_CoatPatternsOfClassifications_CoatPatterns]
GO
ALTER TABLE [dbo].[CoatTypesOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_CoatTypesOfClassifications_Classifications] FOREIGN KEY([ClassificationId])
REFERENCES [dbo].[Classifications] ([ClassificationId])
GO
ALTER TABLE [dbo].[CoatTypesOfClassifications] CHECK CONSTRAINT [FK_CoatTypesOfClassifications_Classifications]
GO
ALTER TABLE [dbo].[CoatTypesOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_CoatTypesOfClassifications_CoatTypes] FOREIGN KEY([CoatTypeId])
REFERENCES [dbo].[CoatTypes] ([CoatTypeId])
GO
ALTER TABLE [dbo].[CoatTypesOfClassifications] CHECK CONSTRAINT [FK_CoatTypesOfClassifications_CoatTypes]
GO
ALTER TABLE [dbo].[LocationsOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_LocationsOfClassifications_Classifications] FOREIGN KEY([ClassificationId])
REFERENCES [dbo].[Classifications] ([ClassificationId])
GO
ALTER TABLE [dbo].[LocationsOfClassifications] CHECK CONSTRAINT [FK_LocationsOfClassifications_Classifications]
GO
ALTER TABLE [dbo].[LocationsOfClassifications]  WITH CHECK ADD  CONSTRAINT [FK_LocationsOfClassifications_Locations] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO
ALTER TABLE [dbo].[LocationsOfClassifications] CHECK CONSTRAINT [FK_LocationsOfClassifications_Locations]
GO
USE [master]
GO
ALTER DATABASE [CatsCenterDB] SET  READ_WRITE 
GO
