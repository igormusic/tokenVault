USE [master]
GO
/****** Object:  Database [TokenVault]    Script Date: 2016-03-31 9:20:11 PM ******/
CREATE DATABASE [TokenVault]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TokenVault', FILENAME = N'E:\Program Files_C\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TokenVault.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TokenVault_log', FILENAME = N'E:\Program Files_C\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TokenVault_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TokenVault] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TokenVault].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TokenVault] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TokenVault] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TokenVault] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TokenVault] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TokenVault] SET ARITHABORT OFF 
GO
ALTER DATABASE [TokenVault] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TokenVault] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TokenVault] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TokenVault] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TokenVault] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TokenVault] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TokenVault] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TokenVault] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TokenVault] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TokenVault] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TokenVault] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TokenVault] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TokenVault] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TokenVault] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TokenVault] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TokenVault] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TokenVault] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TokenVault] SET RECOVERY FULL 
GO
ALTER DATABASE [TokenVault] SET  MULTI_USER 
GO
ALTER DATABASE [TokenVault] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TokenVault] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TokenVault] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TokenVault] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TokenVault] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TokenVault', N'ON'
GO
USE [TokenVault]
GO
/****** Object:  User [tokenVaultAdmin]    Script Date: 2016-03-31 9:20:11 PM ******/
CREATE USER [tokenVaultAdmin] FOR LOGIN [tokenVaultAdmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [tokenVaultAdmin]
GO
/****** Object:  Table [dbo].[AccessToken]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessToken](
	[id] [uniqueidentifier] NOT NULL,
	[ttl] [int] NULL,
	[created] [datetime] NULL,
	[userId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ACL]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACL](
	[model] [nvarchar](255) NULL,
	[property] [nvarchar](255) NULL,
	[accessType] [nvarchar](255) NULL,
	[permission] [nvarchar](255) NULL,
	[principalType] [nvarchar](255) NULL,
	[principalId] [nvarchar](255) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](255) NULL,
	[created] [datetime] NULL,
	[modified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoleMapping]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMapping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[principalType] [nvarchar](255) NULL,
	[principalId] [nvarchar](255) NULL,
	[roleId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tenant]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tenant](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Tenant] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[realm] [nvarchar](255) NULL,
	[username] [nvarchar](255) NULL,
	[password] [nvarchar](255) NOT NULL,
	[credentials] [nvarchar](255) NULL,
	[challenges] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[emailVerified] [bit] NULL,
	[verificationToken] [nvarchar](255) NULL,
	[status] [nvarchar](255) NULL,
	[created] [datetime] NULL,
	[lastUpdated] [datetime] NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Value]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Value](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tenantId] [int] NOT NULL,
	[valueTypeId] [int] NOT NULL,
	[encryptedValue] [nvarchar](500) NOT NULL,
	[tokenValue] [nvarchar](1000) NOT NULL,
	[maskedValue] [nvarchar](500) NULL,
 CONSTRAINT [PK_Value] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ValueType]    Script Date: 2016-03-31 9:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValueType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](50) NOT NULL,
	[tenantId] [int] NOT NULL,
 CONSTRAINT [PK_ValueType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[AccessToken] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[Value]  WITH CHECK ADD  CONSTRAINT [FK_Value_Tenant] FOREIGN KEY([tenantId])
REFERENCES [dbo].[Tenant] ([id])
GO
ALTER TABLE [dbo].[Value] CHECK CONSTRAINT [FK_Value_Tenant]
GO
ALTER TABLE [dbo].[Value]  WITH CHECK ADD  CONSTRAINT [FK_Value_ValueType] FOREIGN KEY([valueTypeId])
REFERENCES [dbo].[ValueType] ([id])
GO
ALTER TABLE [dbo].[Value] CHECK CONSTRAINT [FK_Value_ValueType]
GO
ALTER TABLE [dbo].[ValueType]  WITH CHECK ADD  CONSTRAINT [FK_ValueType_Tenant] FOREIGN KEY([tenantId])
REFERENCES [dbo].[Tenant] ([id])
GO
ALTER TABLE [dbo].[ValueType] CHECK CONSTRAINT [FK_ValueType_Tenant]
GO
USE [master]
GO
ALTER DATABASE [TokenVault] SET  READ_WRITE 
GO
