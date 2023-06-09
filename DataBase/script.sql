USE [master]
GO
/****** Object:  Database [CatsCenterDB]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[BlockedUsers]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[BodyTypes]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[BodyTypesOfClassifications]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[Cats]    Script Date: 09.06.2023 9:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cats](
	[CatId] [int] IDENTITY(1,1) NOT NULL,
	[ClassificationId] [int] NULL,
	[AddedUserId] [int] NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[Approved] [bit] NULL,
 CONSTRAINT [PK_Cats] PRIMARY KEY CLUSTERED 
(
	[CatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classifications]    Script Date: 09.06.2023 9:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classifications](
	[ClassificationId] [int] IDENTITY(1,1) NOT NULL,
	[CoatTypeId] [int] NULL,
	[CoatPatternId] [int] NULL,
	[BodyTypeId] [int] NULL,
	[IsBreed] [bit] NOT NULL,
	[Name] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_Classifications] PRIMARY KEY CLUSTERED 
(
	[ClassificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoatPatterns]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[CoatPatternsOfClassifications]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[CoatTypes]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[CoatTypesOfClassifications]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[Locations]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[LocationsOfClassifications]    Script Date: 09.06.2023 9:04:12 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 09.06.2023 9:04:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
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
SET IDENTITY_INSERT [dbo].[CoatPatterns] ON 

INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (1, N'all')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (2, N'all but colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (3, N'all excluding chocolate and colourpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (4, N'all without white and without siamese pointing')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (5, N'all; except chocolate, lilac, cinnamon, and fawn')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (6, N'bicolor')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (7, N'black')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (8, N'black grizzled tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (9, N'black roan')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (10, N'black ticked tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (11, N'blue point')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (12, N'chocolate bicolor')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (13, N'chocolate spotted tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (14, N'cinnamon colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (15, N'cinnamon spotted tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (16, N'classic tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (17, N'colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (18, N'lilac point')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (19, N'mackerel tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (20, N'marbled')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (21, N'mink')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (22, N'mitted')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (23, N'mitted colorpoint')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (24, N'multi-color')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (25, N'orange and white bicolor')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (26, N'rosetted')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (27, N'solid')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (28, N'solid black')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (29, N'solid blue')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (30, N'solid brown')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (31, N'solid chocolate')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (32, N'solid cinnamon')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (33, N'solid gray')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (34, N'solid lilac')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (35, N'solid orange')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (36, N'solid reddish-brown')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (37, N'solid tan')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (38, N'solid taupe')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (39, N'solid white')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (40, N'solid with shaded silver and silver tipped patterns')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (41, N'spotted')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (42, N'spotted or marbled')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (43, N'spotted tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (44, N'tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (45, N'ticked tabby')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (46, N'tortoiseshell')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (47, N'van pattern')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (48, N'varying shades of blue')
INSERT [dbo].[CoatPatterns] ([CoatPatternId], [Name]) VALUES (49, N'white hairless')
SET IDENTITY_INSERT [dbo].[CoatPatterns] OFF
GO
SET IDENTITY_INSERT [dbo].[CoatTypes] ON 

INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (1, N'Short')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (2, N'Semi-long')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (3, N'Rex')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (4, N'All')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (5, N'Long')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (6, N'Hairless')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (7, N'Short/long')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (8, N'Sparse haired')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (9, N'Semi-long/long')
INSERT [dbo].[CoatTypes] ([CoatTypeId], [Name]) VALUES (10, N'Hairless, velour, brush, or straight coat')
SET IDENTITY_INSERT [dbo].[CoatTypes] OFF
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
