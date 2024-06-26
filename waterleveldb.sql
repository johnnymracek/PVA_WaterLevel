USE [master]
GO
/****** Object:  Database [WaterLevelIndicationDB]    Script Date: 3/26/2024 11:29:41 PM ******/
CREATE DATABASE [WaterLevelIndicationDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WaterLevelIndicationDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\WaterLevelIndicationDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WaterLevelIndicationDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\WaterLevelIndicationDB_log.ldf' , SIZE = 729088KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WaterLevelIndicationDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WaterLevelIndicationDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WaterLevelIndicationDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET RECOVERY FULL 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET  MULTI_USER 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WaterLevelIndicationDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WaterLevelIndicationDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WaterLevelIndicationDB', N'ON'
GO
ALTER DATABASE [WaterLevelIndicationDB] SET QUERY_STORE = OFF
GO
USE [WaterLevelIndicationDB]
GO
/****** Object:  Schema [HangFire]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[StationNames]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StationNames](
	[Station_ID] [int] IDENTITY(1,1) NOT NULL,
	[Station_Name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Station_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WaterLevelData]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WaterLevelData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BoxID] [int] NULL,
	[Measurement] [decimal](18, 2) NULL,
	[MeasurementDateTime] [datetime] NULL,
	[TriggerStatus] [nvarchar](50) NULL,
	[Label] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WaterLevelDataReplica]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WaterLevelDataReplica](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BoxID] [int] NULL,
	[Measurement] [decimal](18, 2) NULL,
	[MeasurementDateTime] [datetime] NULL,
	[TriggerStatus] [nvarchar](max) NULL,
	[Label] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WaterLevelIndicationUsers]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WaterLevelIndicationUsers](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_HangFire_Counter] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_AggregatedCounter_ExpireAt]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE([StateName]) 
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)
WHERE ([StateName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Server_LastHeartbeat]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server]
(
	[LastHeartbeat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Score]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score] ON [HangFire].[Set]
(
	[Key] ASC,
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_State_CreatedAt]    Script Date: 3/26/2024 11:29:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_State_CreatedAt] ON [HangFire].[State]
(
	[CreatedAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
/****** Object:  StoredProcedure [dbo].[FetchWaterLevelDatabyBoxName]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchWaterLevelDatabyBoxName]
    @BoxName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT BoxID, Measurement, MeasurementDateTime, TriggerStatus, Label
    FROM WaterLevelData
    WHERE Label = @BoxName;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllWaterLevelData]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllWaterLevelData]
AS
BEGIN
    SELECT * FROM WaterLevelData;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllWaterLevelDataReplicaforCurrentBox]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetAllWaterLevelDataReplicaforCurrentBox]
    @Label NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM WaterLevelDataReplica
    WHERE Label = @Label;
END
GO
/****** Object:  StoredProcedure [dbo].[GetLatestHeightForBox2]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLatestHeightForBox2]
    @Label NVARCHAR(100) -- Add parameter for Label
AS
BEGIN
    SET NOCOUNT ON;

    -- Get the latest height for Box2 with the specified Label
    SELECT TOP 1 *
    FROM WaterLevelData
    WHERE Label = @Label -- Use the provided Label parameter
    ORDER BY MeasurementDateTime DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetUniqueLabelsFromWaterLevelData]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetUniqueLabelsFromWaterLevelData]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT [Label]
    FROM [WaterLevelData];
END
GO
/****** Object:  StoredProcedure [dbo].[GetUniqueLabelsFromWaterLevelDataReplica]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUniqueLabelsFromWaterLevelDataReplica]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT [Station_Name]
    FROM [StationNames];
END
GO
/****** Object:  StoredProcedure [dbo].[InsertNewBox]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNewBox]
    @Label NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO WaterLevelData(Label)
    VALUES (@Label);
END
GO
/****** Object:  StoredProcedure [dbo].[InsertNewStation]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[InsertNewStation]
    @Station NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO StationNames(Station_Name)
    VALUES (@Station);
END
GO
/****** Object:  StoredProcedure [dbo].[InsertWaterLevelDataReplica]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[InsertWaterLevelDataReplica]
    @BoxID INT,
    @Measurement DECIMAL(18, 2),
    @MeasurementDateTime DATETIME,	
    @Label NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

	 DECLARE @TriggerStatus NVARCHAR(20)

    IF (@Measurement <= 1.00)
    BEGIN
        SET @TriggerStatus = 'Low'
    END
    ELSE IF (@Measurement >= 5.00)
    BEGIN
        SET @TriggerStatus = 'High'
    END
    ELSE
    BEGIN
        SET @TriggerStatus = 'OK'
    END

    -- Insert data into WaterLevelDataReplica table
    INSERT INTO WaterLevelDataReplica (BoxID, Measurement, MeasurementDateTime, TriggerStatus , Label)
    VALUES (@BoxID, @Measurement, @MeasurementDateTime, @TriggerStatus, @Label);
END
GO
/****** Object:  StoredProcedure [dbo].[SearchWaterLevelDataByBox]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SearchWaterLevelDataByBox]
    @Boxname NVARCHAR(MAX)
AS
BEGIN
    SELECT * FROM WaterLevelData
    WHERE Label LIKE '%' + @Boxname + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateWaterLevelDataByLabel]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateWaterLevelDataByLabel]
    @Label NVARCHAR(100),
    @BoxID INT,
    @Measurement DECIMAL(18, 2),
    @MeasurementDateTime DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TriggerStatus NVARCHAR(20)

    IF (@Measurement <= 1.00)
    BEGIN
        SET @TriggerStatus = 'Low'
    END
    ELSE IF (@Measurement >= 5.00)
    BEGIN
        SET @TriggerStatus = 'High'
    END
    ELSE
    BEGIN
        SET @TriggerStatus = 'OK'
    END

    UPDATE WaterLevelData
    SET BoxID = @BoxID,
        Measurement = @Measurement,
        MeasurementDateTime = @MeasurementDateTime,
        TriggerStatus = @TriggerStatus
    WHERE Label = @Label;
END
GO
/****** Object:  StoredProcedure [dbo].[UserLogin]    Script Date: 3/26/2024 11:29:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserLogin]
    @Username VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the username and password exist in the database
    IF EXISTS (SELECT 1 FROM WaterLevelIndicationUsers WHERE Username = @Username AND Password = @Password)
    BEGIN
        -- Username and password match, return 1
        SELECT 1 AS IsValid;
    END
    ELSE
    BEGIN
        -- Username and password do not match, return 0
        SELECT 0 AS IsValid;
    END
END;
GO
USE [master]
GO
ALTER DATABASE [WaterLevelIndicationDB] SET  READ_WRITE 
GO
