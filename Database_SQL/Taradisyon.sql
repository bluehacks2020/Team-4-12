USE [master]
GO
/****** Object:  Database [Taradisyon]    Script Date: 2/23/2020 10:15:53 AM ******/
CREATE DATABASE [Taradisyon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Taradisyon', FILENAME = N'D:\SQL2016\MSSQL13.MSSQLSERVER2\MSSQL\DATA\Taradisyon.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Taradisyon_log', FILENAME = N'D:\SQL2016\MSSQL13.MSSQLSERVER2\MSSQL\DATA\Taradisyon_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Taradisyon] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Taradisyon].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Taradisyon] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Taradisyon] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Taradisyon] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Taradisyon] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Taradisyon] SET ARITHABORT OFF 
GO
ALTER DATABASE [Taradisyon] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Taradisyon] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Taradisyon] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Taradisyon] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Taradisyon] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Taradisyon] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Taradisyon] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Taradisyon] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Taradisyon] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Taradisyon] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Taradisyon] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Taradisyon] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Taradisyon] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Taradisyon] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Taradisyon] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Taradisyon] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Taradisyon] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Taradisyon] SET RECOVERY FULL 
GO
ALTER DATABASE [Taradisyon] SET  MULTI_USER 
GO
ALTER DATABASE [Taradisyon] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Taradisyon] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Taradisyon] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Taradisyon] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Taradisyon] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Taradisyon', N'ON'
GO
ALTER DATABASE [Taradisyon] SET QUERY_STORE = OFF
GO
USE [Taradisyon]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Taradisyon]
GO
/****** Object:  Table [dbo].[Administrator]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrator](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[EmailAddress] [varchar](30) NOT NULL,
	[Password] [char](64) NOT NULL,
 CONSTRAINT [PK_Administrator] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Challenge]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Challenge](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](30) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[AdministratorID] [int] NOT NULL,
	[Emblem] [varchar](128) NOT NULL,
	[Point] [int] NOT NULL,
	[Picture] [varchar](128) NOT NULL,
 CONSTRAINT [PK_Challenge] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Collection]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collection](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[ChallengeID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Location]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](5) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Nationality]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nationality](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Nationality] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Token]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Token](
	[ID] [int] NOT NULL,
	[ChallengeID] [int] NOT NULL,
	[Token] [char](6) NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[Claimed] [int] NOT NULL,
 CONSTRAINT [PK_Token] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[Gender] [char](1) NOT NULL,
	[EmailAddress] [varchar](30) NOT NULL,
	[Password] [char](64) NOT NULL,
	[Birthdate] [date] NOT NULL,
	[NationalityID] [int] NOT NULL,
	[Point] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Challenge]  WITH CHECK ADD  CONSTRAINT [FK_Challenge_Administrator] FOREIGN KEY([AdministratorID])
REFERENCES [dbo].[Administrator] ([ID])
GO
ALTER TABLE [dbo].[Challenge] CHECK CONSTRAINT [FK_Challenge_Administrator]
GO
ALTER TABLE [dbo].[Challenge]  WITH CHECK ADD  CONSTRAINT [FK_Challenge_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Challenge] CHECK CONSTRAINT [FK_Challenge_Category]
GO
ALTER TABLE [dbo].[Challenge]  WITH CHECK ADD  CONSTRAINT [FK_Challenge_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([ID])
GO
ALTER TABLE [dbo].[Challenge] CHECK CONSTRAINT [FK_Challenge_Location]
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD  CONSTRAINT [FK_Collection_Challenge] FOREIGN KEY([ChallengeID])
REFERENCES [dbo].[Challenge] ([ID])
GO
ALTER TABLE [dbo].[Collection] CHECK CONSTRAINT [FK_Collection_Challenge]
GO
ALTER TABLE [dbo].[Collection]  WITH CHECK ADD  CONSTRAINT [FK_Collection_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Collection] CHECK CONSTRAINT [FK_Collection_User]
GO
ALTER TABLE [dbo].[Token]  WITH CHECK ADD  CONSTRAINT [FK_Token_Challenge] FOREIGN KEY([ChallengeID])
REFERENCES [dbo].[Challenge] ([ID])
GO
ALTER TABLE [dbo].[Token] CHECK CONSTRAINT [FK_Token_Challenge]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Nationality] FOREIGN KEY([NationalityID])
REFERENCES [dbo].[Nationality] ([ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Nationality]
GO
/****** Object:  StoredProcedure [dbo].[LoginAdmin]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LoginAdmin]
	-- Add the parameters for the stored procedure here
	@Email varchar(30),
	@Password char(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID, EmailAddress, [Password]
	FROM dbo.Administrator
	WHERE EmailAddress = @Email AND [Password] = @Password
END

GO
/****** Object:  StoredProcedure [dbo].[LoginUser]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LoginUser]
	-- Add the parameters for the stored procedure here
	@Email varchar(30),
	@Password char(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ID, EmailAddress, [Password]
	FROM [User]
	WHERE EmailAddress = @Email AND [Password] = @Password
END

GO
/****** Object:  StoredProcedure [dbo].[UpdatePoint]    Script Date: 2/23/2020 10:15:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePoint]
	-- Add the parameters for the stored procedure here
	@ID int,
	@NewPoint int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [User] 
	SET [User].Point = @NewPoint
	WHERE [User].ID = @ID
END

GO
USE [master]
GO
ALTER DATABASE [Taradisyon] SET  READ_WRITE 
GO
