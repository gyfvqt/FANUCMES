USE [master]
GO
/****** Object:  Database [FANUCMES]    Script Date: 2019/5/1 22:18:15 ******/
CREATE DATABASE [FANUCMES]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FANUCMES', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\FANUCMES.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FANUCMES_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\FANUCMES_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FANUCMES] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FANUCMES].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FANUCMES] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FANUCMES] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FANUCMES] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FANUCMES] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FANUCMES] SET ARITHABORT OFF 
GO
ALTER DATABASE [FANUCMES] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FANUCMES] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FANUCMES] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FANUCMES] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FANUCMES] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FANUCMES] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FANUCMES] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FANUCMES] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FANUCMES] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FANUCMES] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FANUCMES] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FANUCMES] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FANUCMES] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FANUCMES] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FANUCMES] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FANUCMES] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FANUCMES] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FANUCMES] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FANUCMES] SET  MULTI_USER 
GO
ALTER DATABASE [FANUCMES] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FANUCMES] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FANUCMES] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FANUCMES] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [FANUCMES] SET DELAYED_DURABILITY = DISABLED 
GO
USE [FANUCMES]
GO
/****** Object:  Table [dbo].[AMCommentAlarm]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMCommentAlarm](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [int] NULL,
	[AlarmContent] [nvarchar](64) NULL,
	[Xdate] [int] NULL,
	[AlarmTime] [nvarchar](64) NULL,
 CONSTRAINT [PK_AMCommentAlarm] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AMConfiguration]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMConfiguration](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [int] NULL,
	[PeriodType] [nvarchar](64) NULL,
	[Xweek] [int] NULL,
	[WeekDate] [nvarchar](64) NULL,
	[Month] [int] NULL,
	[Day] [int] NULL,
	[BeginDate] [date] NULL,
	[EndDate] [date] NULL,
 CONSTRAINT [PK_AMConfiguration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AMEquipment]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMEquipment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [int] NULL,
	[EquipmentId] [int] NULL,
 CONSTRAINT [PK_AMEquipment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AMProcessSheet]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMProcessSheet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [int] NULL,
	[DOCName] [nvarchar](256) NULL,
	[UpLoadTime] [datetime] NULL,
	[URL] [nvarchar](256) NULL,
 CONSTRAINT [PK_AMProcessSheet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AMTicket]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMTicket](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketNo] [nvarchar](64) NULL,
	[TicketName] [nvarchar](64) NULL,
	[UserId] [int] NULL,
	[TicketDesc] [nvarchar](256) NULL,
	[TicketReturn] [nvarchar](1024) NULL,
	[Creator] [int] NULL,
	[ExecuteStatus] [nvarchar](64) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_AMTicket] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AMTicketSplit]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMTicketSplit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketDetailCode] [nvarchar](64) NULL,
	[TicketId] [int] NULL,
	[ExecuteDate] [date] NULL,
	[Stratus] [nvarchar](64) NULL,
	[UpdateTime] [datetime] NULL,
	[SplitReturn] [nvarchar](1024) NULL,
	[URL] [nvarchar](256) NULL,
 CONSTRAINT [PK_AMTicketSplit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AndonConfiguration]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AndonConfiguration](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AndonNo] [nvarchar](64) NULL,
	[AndonName] [nvarchar](64) NULL,
	[LineId] [nvarchar](64) NULL,
	[LineName] [nvarchar](64) NULL,
	[AndonIP] [nvarchar](64) NULL,
 CONSTRAINT [PK_AndonConfiguration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CallList]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CallList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CallCode] [nvarchar](64) NULL,
	[MaterialCallPointId] [int] NULL,
	[CallCount] [int] NULL,
	[CallStatus] [nvarchar](64) NULL,
	[CallTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_CallList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CuttorAlarmConfiguration]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuttorAlarmConfiguration](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SNO] [nvarchar](64) NULL,
 CONSTRAINT [PK_CuttorAlarmConfiguration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CuttorAlarmConfigurationStation]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuttorAlarmConfigurationStation](
	[StationId] [int] NOT NULL,
	[TipId] [int] NOT NULL,
	[StationCode] [nvarchar](64) NULL,
 CONSTRAINT [PK_CuttorAlarmConfigurationStation] PRIMARY KEY CLUSTERED 
(
	[StationId] ASC,
	[TipId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CuttorAlarmConfigurationUser]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuttorAlarmConfigurationUser](
	[UserId] [int] NOT NULL,
	[TipId] [int] NOT NULL,
	[UserName] [nvarchar](64) NULL,
 CONSTRAINT [PK_CuttorAlarmConfigurationUser] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[TipId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CuttorInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuttorInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CutterCode] [nvarchar](64) NULL,
	[CutterName] [nvarchar](64) NULL,
	[CutterSupplier] [nvarchar](64) NULL,
	[CutterDesc] [nvarchar](64) NULL,
	[CutterImg] [nvarchar](64) NULL,
	[StoreId] [int] NULL,
	[Speed] [int] NULL,
	[LimitTime] [int] NULL,
	[AlarmTime] [int] NULL,
	[StationId] [int] NULL,
	[SingleTime] [int] NULL,
	[UsedTime] [int] NULL,
	[Status] [nvarchar](32) NULL,
	[LastUseTime] [datetime] NULL,
 CONSTRAINT [PK_CuttorInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EndProduct]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EndProduct](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ERPID] [int] NULL,
	[EndProductSN] [nvarchar](64) NULL,
	[ProductionId] [int] NULL,
	[ProductionCode] [nvarchar](64) NULL,
	[ProductionName] [nvarchar](64) NULL,
	[ProductionSheet] [nvarchar](64) NULL,
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_EndProduct_UpdateTime]  DEFAULT (getdate()),
	[ERPDetailCode] [nvarchar](64) NULL,
	[DetailOrderSN] [nvarchar](64) NULL,
	[Status] [int] NULL CONSTRAINT [DF_EndProduct_Status]  DEFAULT ((1)),
	[ERPDetailId] [int] NULL,
	[EndTime] [datetime] NULL,
 CONSTRAINT [PK_EndProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EquipmentData]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[EquipmentCode] [nvarchar](64) NULL,
	[EquipmentName] [nvarchar](64) NULL,
	[EquipmentDesc] [nvarchar](64) NULL,
	[Team] [nvarchar](16) NULL,
	[EquipmentImg] [nvarchar](256) NULL,
	[PLCIP] [nvarchar](64) NULL,
	[PLCDB] [nvarchar](64) NULL,
	[IsPayPoint] [int] NULL,
	[DesignCycletime] [int] NULL,
	[DesignJPH] [int] NULL,
	[EquipmentSupplier] [nvarchar](64) NULL,
	[Counter] [int] NULL,
 CONSTRAINT [PK_EquipmentData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ERPInterface]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERPInterface](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FTPIP] [nvarchar](64) NULL,
	[FileName] [nvarchar](64) NULL,
	[Path] [nvarchar](256) NULL,
	[GetRate] [int] NULL,
	[IsEnable] [int] NULL,
 CONSTRAINT [PK_ERPInterface] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ERPInterfaceRule]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERPInterfaceRule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ColumnName] [nvarchar](64) NULL,
	[BeginChar] [int] NULL,
	[DataLength] [int] NULL,
 CONSTRAINT [PK_ERPInterfaceRule] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ERPOrder]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERPOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ERPOrderId] [nvarchar](64) NULL,
	[ProductionId] [nvarchar](64) NULL,
	[ProductionName] [nvarchar](64) NULL,
	[EndDate] [date] NULL,
	[ERPOrderName] [nvarchar](64) NULL,
	[ProductionImg] [nvarchar](256) NULL,
	[PlanCount] [int] NULL,
	[ERPStatus] [int] NULL,
	[Createdate] [datetime] NULL DEFAULT (getdate()),
 CONSTRAINT [PK_ERPOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ERPOrderDetails]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERPOrderDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ERPID] [int] NULL,
	[ERPDetailCode] [nvarchar](64) NULL,
	[ProductionCode] [nvarchar](64) NULL,
	[SN] [nvarchar](64) NULL,
	[LineId] [int] NULL,
	[ProductionName] [nvarchar](64) NULL,
	[DetailCount] [int] NULL,
	[Status] [int] NULL,
	[EndDate] [date] NULL,
	[CreateTime] [datetime] NULL,
	[Creator] [nvarchar](64) NULL,
	[OrderSeq] [nvarchar](10) NULL,
 CONSTRAINT [PK_ERPOrderDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ErrorLogs]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLogs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime] NULL,
	[OptionDesc] [text] NULL,
 CONSTRAINT [PK_ErrorLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExchangStore]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangStore](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialId] [int] NULL,
	[MaterialDataName] [nvarchar](64) NULL,
	[MaterialDataNo] [nvarchar](64) NULL,
	[ExchangeType] [nvarchar](64) NULL,
	[TicketNumber] [int] NULL,
	[WarehouseId] [int] NULL,
	[StoreId] [int] NULL,
	[InWarehouseId] [int] NULL,
	[InStoreId] [int] NULL,
	[ExStatus] [nvarchar](64) NULL,
	[CuserId] [int] NULL,
	[Creator] [nvarchar](64) NULL,
	[CreateTime] [datetime] NULL,
	[UuserId] [int] NULL,
	[Updator] [nvarchar](64) NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_ExchangStore] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FaultCodeInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaultCodeInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentId] [int] NULL,
	[FaultCode] [nvarchar](64) NULL,
	[FaultDesc] [nvarchar](256) NULL,
	[FaultType] [nvarchar](64) NULL,
	[PLCDB] [nvarchar](64) NULL,
 CONSTRAINT [PK_FaultCodeInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FaultNotice]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaultNotice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TicketNo] [nvarchar](64) NULL,
	[FaultName] [nvarchar](64) NULL,
	[FaultDesc] [nvarchar](256) NULL,
	[EquipmentId] [int] NULL,
	[UserId] [int] NULL,
	[FaultReturn] [nvarchar](1024) NULL,
	[Creator] [int] NULL,
	[ExecuteStatus] [nvarchar](64) NULL,
	[CreateTime] [datetime] NULL,
 CONSTRAINT [PK_FaultNotice] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FaultUserInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FaultUserInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentId] [int] NULL,
	[EquipmentName] [nvarchar](64) NULL,
	[UserId] [int] NULL,
	[UserName] [nvarchar](64) NULL,
 CONSTRAINT [PK_FaultUserInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LineInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LineInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineId] [nvarchar](64) NULL,
	[LineName] [nvarchar](64) NULL,
	[LineType] [nvarchar](64) NULL,
	[DesignCycle] [int] NULL,
	[PlanCycle] [int] NULL,
	[IsEnable] [int] NULL,
 CONSTRAINT [PK_LineInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ManufacturingLogs]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturingLogs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime] NULL,
	[PLCIP] [nvarchar](64) NULL,
	[OptionDesc] [nvarchar](512) NULL,
 CONSTRAINT [PK_ManufacturingLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Material_W_S]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material_W_S](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialId] [int] NULL,
	[WarehouseId] [int] NULL,
	[StoreId] [int] NULL,
	[MTotal] [int] NULL DEFAULT ((0)),
	[exchangecount] [int] NULL DEFAULT ((0)),
 CONSTRAINT [PK_Material_W_S] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaterialCallPoint]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialCallPoint](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialCallCode] [nvarchar](64) NULL,
	[MaterialId] [int] NULL,
	[CallType] [nvarchar](64) NULL,
	[DeductionCountor] [int] NULL,
	[DeliverType] [nvarchar](64) NULL,
	[SaveNumber] [int] NULL,
	[DelayTime] [int] NULL,
	[DeliverWay] [nvarchar](64) NULL,
	[StationId] [int] NULL,
	[WHCount] [int] NULL,
	[StoreId] [int] NULL,
 CONSTRAINT [PK_MaterialCallPoint] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaterialData]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialDataNo] [nvarchar](64) NULL,
	[MaterialDataName] [nvarchar](64) NULL,
	[BoxType] [nvarchar](64) NULL,
	[BoxTotalNo] [int] NULL,
	[KG] [float] NULL,
	[Supplier] [nvarchar](64) NULL,
	[IsEnable] [int] NULL DEFAULT ((1)),
 CONSTRAINT [PK_MaterialData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Menus]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](64) NULL,
	[MenuDesc] [nvarchar](256) NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_Menus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PBOM]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBOM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductionId] [int] NULL,
	[MaterialId] [int] NULL,
	[MaterialCode] [nvarchar](64) NULL,
	[UseCount] [int] NULL,
 CONSTRAINT [PK_PBOM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PCStationProcessSheet]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCStationProcessSheet](
	[PCStationId] [int] NULL,
	[ProcessId] [int] IDENTITY(1,1) NOT NULL,
	[ProcessName] [nvarchar](64) NULL,
	[ProcessDesc] [nvarchar](256) NULL,
	[ProcessType] [nvarchar](64) NULL,
 CONSTRAINT [PK_PCStationProcessSheet] PRIMARY KEY CLUSTERED 
(
	[ProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PCStationQuality]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCStationQuality](
	[PCStationId] [int] NULL,
	[QualityId] [int] IDENTITY(1,1) NOT NULL,
	[QualityDesc] [nvarchar](64) NULL,
	[QualityStandard] [nvarchar](512) NULL,
 CONSTRAINT [PK_PCStationQuality] PRIMARY KEY CLUSTERED 
(
	[QualityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PCTraceability]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCTraceability](
	[PCStationId] [int] NULL,
	[TraceabilityId] [int] IDENTITY(1,1) NOT NULL,
	[TraceabilityDesc] [nvarchar](64) NULL,
 CONSTRAINT [PK_PCTraceability] PRIMARY KEY CLUSTERED 
(
	[TraceabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[RoleId] [int] NULL,
	[MenuId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PickDetailList]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickDetailList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PickId] [int] NULL,
	[CallId] [int] NULL,
 CONSTRAINT [PK_PickDetailList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PickList]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PickCode] [nvarchar](64) NULL,
	[DeliverWay] [nvarchar](64) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[Creator] [nvarchar](64) NULL,
	[PickPdfUrl] [nvarchar](256) NULL,
 CONSTRAINT [PK_PickList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PLCAPInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLCAPInfo](
	[PLCStationId] [int] NULL,
	[PLCAPId] [int] IDENTITY(1,1) NOT NULL,
	[PLCAPDBAddress] [nvarchar](64) NULL,
	[APDataLength] [int] NULL,
	[APDataDesc] [nvarchar](256) NULL,
 CONSTRAINT [PK_PLCAPInfo] PRIMARY KEY CLUSTERED 
(
	[PLCAPId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PLCTemplateInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLCTemplateInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PLCTemplateName] [nvarchar](64) NULL,
	[UpdateTime] [datetime] NULL CONSTRAINT [DF_PLCTemplateInfo_UpdateTime]  DEFAULT (getdate()),
	[Updator] [nvarchar](64) NULL,
 CONSTRAINT [PK_PLCTemplateInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PLCTemplateInfoDetail]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLCTemplateInfoDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PLCTemplateID] [int] NULL,
	[PLCUPDBAddress] [nvarchar](64) NULL,
	[UPDataLength] [int] NULL,
	[UPDataDesc] [nvarchar](256) NULL,
 CONSTRAINT [PK_PLCTemplateInfoDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PLCTemplateOperationInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLCTemplateOperationInfo](
	[PLCStationId] [int] NULL,
	[PLCTemplateId] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PLCTrigger] [nvarchar](64) NULL,
	[CommunicateType] [nvarchar](64) NULL,
	[CheckAddress] [nvarchar](64) NULL,
	[PLCDB] [nvarchar](64) NULL,
	[ActionCode] [nvarchar](64) NULL,
	[CommunicateName] [nvarchar](64) NULL,
	[ReturnLength] [int] NULL,
 CONSTRAINT [PK_PLCTemplateOperationInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PLCUPInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLCUPInfo](
	[PLCStationId] [int] NULL,
	[PLCUPId] [int] IDENTITY(1,1) NOT NULL,
	[PLCUPDBAddress] [nvarchar](64) NULL,
	[UPDataLength] [int] NULL,
	[UPDataDesc] [nvarchar](256) NULL,
 CONSTRAINT [PK_PLCUPInfo] PRIMARY KEY CLUSTERED 
(
	[PLCUPId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductDefectInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDefectInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[ProductCode] [nvarchar](64) NULL,
	[DefectCode] [nvarchar](64) NULL,
	[DefectDesc] [nvarchar](64) NULL,
	[StationName] [nvarchar](64) NULL,
	[LastStatus] [nvarchar](64) NULL,
	[LastUpdator] [nvarchar](64) NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_ProductDefectInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductionInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductionId] [nvarchar](64) NULL,
	[ProductionName] [nvarchar](64) NULL,
	[ProductionType] [nvarchar](64) NULL,
	[ProductionSheet] [nvarchar](64) NULL,
	[LineId] [int] NULL,
	[Batch] [int] NULL,
	[StoreId] [int] NULL,
	[ProductionImg] [nvarchar](256) NULL,
	[ProductionDesc] [nvarchar](256) NULL,
	[IsEnable] [int] NULL DEFAULT ((1)),
 CONSTRAINT [PK_ProductionInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductPLCTraceabilityInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductPLCTraceabilityInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[ProductCode] [nvarchar](64) NULL,
	[PLCDataDesc] [nvarchar](64) NULL,
	[PLCDataResult] [nvarchar](64) NULL,
	[LastStatus] [nvarchar](64) NULL,
	[Updator] [nvarchar](64) NULL,
	[UpdateTime] [datetime] NULL,
	[StationName] [varchar](64) NULL,
	[PLCAPID] [int] NULL,
 CONSTRAINT [PK_ProductPLCTraceabilityInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductTraceabilityInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTraceabilityInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[ProductCode] [nvarchar](64) NULL,
	[StationName] [nvarchar](64) NULL,
	[ParkSn] [nvarchar](256) NULL,
	[TransitTime] [datetime] NULL,
	[ItemID] [int] NULL,
 CONSTRAINT [PK_ProductTraceabilityInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductTransitInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTransitInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[ProductCode] [nvarchar](64) NULL,
	[StationName] [nvarchar](64) NULL,
	[StationDesc] [nvarchar](256) NULL,
	[StationType] [nvarchar](64) NULL,
	[TransitTime] [datetime] NULL,
	[QualityStatus] [nvarchar](64) NULL,
 CONSTRAINT [PK_ProductTransitInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rest]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ShiftCode] [nvarchar](64) NULL,
	[ShiftName] [nvarchar](64) NULL,
	[BeginTime] [nvarchar](64) NULL,
	[EndTime] [nvarchar](64) NULL,
 CONSTRAINT [PK_Rest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StationInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StationInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StationCode] [nvarchar](64) NULL,
	[StationName] [nvarchar](64) NULL,
	[StationDesc] [nvarchar](256) NULL,
	[StationType] [nvarchar](64) NULL,
	[StationPosition] [nvarchar](64) NULL,
	[StationAsset] [nvarchar](64) NULL,
	[Team] [nvarchar](64) NULL,
	[IP] [nvarchar](64) NULL,
	[ProcessSheet] [nvarchar](256) NULL,
	[IsEnable] [int] NULL CONSTRAINT [DF_StationInfo_IsEnable]  DEFAULT ((1)),
	[LineId] [int] NULL,
	[LineName] [nvarchar](64) NULL,
	[IsFirstStation] [int] NULL DEFAULT ((0)),
 CONSTRAINT [PK_StationInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Store]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseId] [int] NULL,
	[StoreNo] [nvarchar](64) NULL,
	[StoreName] [nvarchar](64) NULL,
	[PickArea] [nvarchar](64) NULL,
	[KG] [float] NULL,
	[MaxNo] [int] NULL,
	[IsEnable] [int] NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemLogs]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemLogs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime] NULL,
	[UserId] [nvarchar](64) NULL,
	[UserName] [nvarchar](64) NULL,
	[RoleName] [nvarchar](64) NULL,
	[OptionDesc] [nvarchar](512) NULL,
 CONSTRAINT [PK_SystemLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](64) NULL,
	[LastName] [nvarchar](16) NULL,
	[FirstName] [nvarchar](16) NULL,
	[RoleId] [int] NULL,
	[Email] [nvarchar](64) NULL,
	[PhoneNumber] [nvarchar](32) NULL,
	[UserDesc] [nvarchar](256) NULL,
	[UserImagic] [nvarchar](256) NULL,
	[Password] [nvarchar](64) NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](64) NULL,
	[RoleDesc] [nvarchar](256) NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseNo] [nvarchar](64) NULL,
	[WarehouseType] [nvarchar](64) NULL,
	[WarehouseName] [nvarchar](64) NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkCalendar]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkCalendar](
	[WorkDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkShift]    Script Date: 2019/5/1 22:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkShift](
	[ID] [nvarchar](8) NULL,
	[BeginTime] [nvarchar](64) NULL,
	[EndTime] [nvarchar](64) NULL
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[AMCommentAlarm] ON 

GO
INSERT [dbo].[AMCommentAlarm] ([ID], [TicketId], [AlarmContent], [Xdate], [AlarmTime]) VALUES (1, 1, N'不要忘记啊赶紧开搞2', 5, N'08:00')
GO
INSERT [dbo].[AMCommentAlarm] ([ID], [TicketId], [AlarmContent], [Xdate], [AlarmTime]) VALUES (3, 3, N'111111', 2, N'08:58:58')
GO
INSERT [dbo].[AMCommentAlarm] ([ID], [TicketId], [AlarmContent], [Xdate], [AlarmTime]) VALUES (4, 4, N'月度提醒', 2, N'08:00')
GO
INSERT [dbo].[AMCommentAlarm] ([ID], [TicketId], [AlarmContent], [Xdate], [AlarmTime]) VALUES (5, 5, N'年度提醒', 1, N'08:00')
GO
SET IDENTITY_INSERT [dbo].[AMCommentAlarm] OFF
GO
SET IDENTITY_INSERT [dbo].[AMConfiguration] ON 

GO
INSERT [dbo].[AMConfiguration] ([ID], [TicketId], [PeriodType], [Xweek], [WeekDate], [Month], [Day], [BeginDate], [EndDate]) VALUES (3, 3, N'每天', NULL, NULL, NULL, NULL, CAST(N'2019-03-28' AS Date), CAST(N'2019-04-30' AS Date))
GO
INSERT [dbo].[AMConfiguration] ([ID], [TicketId], [PeriodType], [Xweek], [WeekDate], [Month], [Day], [BeginDate], [EndDate]) VALUES (5, 1, N'每周', 1, N'|1|2|3|5|6', NULL, NULL, CAST(N'2019-04-01' AS Date), CAST(N'2019-04-30' AS Date))
GO
INSERT [dbo].[AMConfiguration] ([ID], [TicketId], [PeriodType], [Xweek], [WeekDate], [Month], [Day], [BeginDate], [EndDate]) VALUES (6, 4, N'每月', NULL, NULL, NULL, 31, CAST(N'2019-03-30' AS Date), CAST(N'2020-04-30' AS Date))
GO
INSERT [dbo].[AMConfiguration] ([ID], [TicketId], [PeriodType], [Xweek], [WeekDate], [Month], [Day], [BeginDate], [EndDate]) VALUES (9, 5, N'每年', NULL, NULL, 12, 31, CAST(N'2019-03-30' AS Date), CAST(N'2021-04-10' AS Date))
GO
SET IDENTITY_INSERT [dbo].[AMConfiguration] OFF
GO
SET IDENTITY_INSERT [dbo].[AMEquipment] ON 

GO
INSERT [dbo].[AMEquipment] ([ID], [TicketId], [EquipmentId]) VALUES (1, 1, 4)
GO
INSERT [dbo].[AMEquipment] ([ID], [TicketId], [EquipmentId]) VALUES (3, 3, 3)
GO
INSERT [dbo].[AMEquipment] ([ID], [TicketId], [EquipmentId]) VALUES (4, 4, 3)
GO
INSERT [dbo].[AMEquipment] ([ID], [TicketId], [EquipmentId]) VALUES (5, 5, 3)
GO
SET IDENTITY_INSERT [dbo].[AMEquipment] OFF
GO
SET IDENTITY_INSERT [dbo].[AMProcessSheet] ON 

GO
INSERT [dbo].[AMProcessSheet] ([ID], [TicketId], [DOCName], [UpLoadTime], [URL]) VALUES (1, 1, N'2月份电话发票-陈秦.pdf', CAST(N'2019-03-28 21:29:33.680' AS DateTime), N'/ProcessSheet/20190328212933.pdf')
GO
INSERT [dbo].[AMProcessSheet] ([ID], [TicketId], [DOCName], [UpLoadTime], [URL]) VALUES (3, 1, N'Clean Cache (4).pdf', CAST(N'2019-03-28 21:31:45.447' AS DateTime), N'/ProcessSheet/20190328213145.pdf')
GO
INSERT [dbo].[AMProcessSheet] ([ID], [TicketId], [DOCName], [UpLoadTime], [URL]) VALUES (4, 3, N'Clean Cache (4).pdf', CAST(N'2019-03-28 21:53:56.127' AS DateTime), N'/ProcessSheet/20190328215356.pdf')
GO
INSERT [dbo].[AMProcessSheet] ([ID], [TicketId], [DOCName], [UpLoadTime], [URL]) VALUES (5, 4, N'Clean Cache (4).pdf', CAST(N'2019-03-30 14:02:42.447' AS DateTime), N'/ProcessSheet/20190330140242.pdf')
GO
INSERT [dbo].[AMProcessSheet] ([ID], [TicketId], [DOCName], [UpLoadTime], [URL]) VALUES (6, 5, N'Clean Cache (4).pdf', CAST(N'2019-03-30 15:52:24.687' AS DateTime), N'/ProcessSheet/20190330155224.pdf')
GO
SET IDENTITY_INSERT [dbo].[AMProcessSheet] OFF
GO
SET IDENTITY_INSERT [dbo].[AMTicket] ON 

GO
INSERT [dbo].[AMTicket] ([ID], [TicketNo], [TicketName], [UserId], [TicketDesc], [TicketReturn], [Creator], [ExecuteStatus], [CreateTime]) VALUES (1, N'FN-20190328000001', N'维护1号机器人', 1, N'1414141414qrqr55776', N'', 1, N'新建', CAST(N'2019-03-28 16:35:49.403' AS DateTime))
GO
INSERT [dbo].[AMTicket] ([ID], [TicketNo], [TicketName], [UserId], [TicketDesc], [TicketReturn], [Creator], [ExecuteStatus], [CreateTime]) VALUES (3, N'03', N'3号机器人维护任务', 1, N'14141414', N'开搞，完成', 1, N'新建', CAST(N'2019-03-28 21:53:10.490' AS DateTime))
GO
INSERT [dbo].[AMTicket] ([ID], [TicketNo], [TicketName], [UserId], [TicketDesc], [TicketReturn], [Creator], [ExecuteStatus], [CreateTime]) VALUES (4, N'FN-20190330000004', N'月度维护计划', 1, N'141414141', N'', 1, N'执行', CAST(N'2019-03-30 14:01:04.040' AS DateTime))
GO
INSERT [dbo].[AMTicket] ([ID], [TicketNo], [TicketName], [UserId], [TicketDesc], [TicketReturn], [Creator], [ExecuteStatus], [CreateTime]) VALUES (5, N'FN-20190330000005', N'年度维护计划', 1, N'qrqrqrqr', N'', 1, N'执行', CAST(N'2019-03-30 15:51:39.300' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[AMTicket] OFF
GO
SET IDENTITY_INSERT [dbo].[AMTicketSplit] ON 

GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (1, N'FN-20190330000004-0001', 4, CAST(N'2019-03-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.093' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (2, N'FN-20190330000004-0002', 4, CAST(N'2019-04-30' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.310' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (3, N'FN-20190330000004-0003', 4, CAST(N'2019-05-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.430' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (4, N'FN-20190330000004-0004', 4, CAST(N'2019-06-30' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.500' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (5, N'FN-20190330000004-0005', 4, CAST(N'2019-07-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.573' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (6, N'FN-20190330000004-0006', 4, CAST(N'2019-08-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.737' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (7, N'FN-20190330000004-0007', 4, CAST(N'2019-09-30' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.807' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (8, N'FN-20190330000004-0008', 4, CAST(N'2019-10-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.873' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (9, N'FN-20190330000004-0009', 4, CAST(N'2019-11-30' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.877' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (10, N'FN-20190330000004-0010', 4, CAST(N'2019-12-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.877' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (11, N'FN-20190330000004-0011', 4, CAST(N'2020-01-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.877' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (12, N'FN-20190330000004-0012', 4, CAST(N'2020-02-29' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.890' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (13, N'FN-20190330000004-0013', 4, CAST(N'2020-03-31' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.890' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (14, N'FN-20190330000004-0014', 4, CAST(N'2020-04-30' AS Date), N'执行', CAST(N'2019-03-30 15:50:55.893' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (15, N'FN-20190330000005-0001', 5, CAST(N'2019-12-31' AS Date), N'完成', CAST(N'2019-03-30 16:26:12.703' AS DateTime), N'QQQQ', NULL)
GO
INSERT [dbo].[AMTicketSplit] ([ID], [TicketDetailCode], [TicketId], [ExecuteDate], [Stratus], [UpdateTime], [SplitReturn], [URL]) VALUES (16, N'FN-20190330000005-0002', 5, CAST(N'2020-12-31' AS Date), N'执行', CAST(N'2019-03-30 16:26:12.720' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[AMTicketSplit] OFF
GO
SET IDENTITY_INSERT [dbo].[AndonConfiguration] ON 

GO
INSERT [dbo].[AndonConfiguration] ([ID], [AndonNo], [AndonName], [LineId], [LineName], [AndonIP]) VALUES (2, N'FANUC_Andon00001', N'andon02', N'FANUC00001', N'FANUC-TL1', N'')
GO
INSERT [dbo].[AndonConfiguration] ([ID], [AndonNo], [AndonName], [LineId], [LineName], [AndonIP]) VALUES (3, N'FANUC_Andon00003', N'andon03', N'FANUC00001', N'FANUC-TL1', N'')
GO
SET IDENTITY_INSERT [dbo].[AndonConfiguration] OFF
GO
SET IDENTITY_INSERT [dbo].[CallList] ON 

GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (1, N'FANUC-C-00001', 2, 24, N'关闭', CAST(N'2019-03-25 09:38:38.000' AS DateTime), CAST(N'2019-03-25 11:49:15.250' AS DateTime))
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (2, N'FANUC-C-00002', 3, 12, N'关闭', CAST(N'2019-03-25 09:38:38.000' AS DateTime), CAST(N'2019-03-25 11:49:15.250' AS DateTime))
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (3, N'FANUC-C-00003', 4, 12, N'触发', CAST(N'2019-03-25 09:38:38.000' AS DateTime), NULL)
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (4, NULL, 4, 24, N'触发', CAST(N'2019-04-30 11:22:20.087' AS DateTime), NULL)
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (5, N'FANUC-C-00005', 4, 24, N'触发', CAST(N'2019-04-30 11:23:11.070' AS DateTime), NULL)
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (6, N'FANUC-C-000006', 4, 24, N'触发', CAST(N'2019-04-30 11:36:45.410' AS DateTime), NULL)
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (7, N'FANUC-C-00007', 4, 24, N'触发', CAST(N'2019-04-30 11:37:10.593' AS DateTime), NULL)
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (8, N'FANUC-C-00008', 4, 24, N'触发', CAST(N'2019-04-30 11:37:11.400' AS DateTime), NULL)
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (9, N'FANUC-C-00009', 4, 24, N'触发', CAST(N'2019-04-30 11:37:12.100' AS DateTime), NULL)
GO
INSERT [dbo].[CallList] ([ID], [CallCode], [MaterialCallPointId], [CallCount], [CallStatus], [CallTime], [UpdateTime]) VALUES (10, N'FANUC-C-00010', 4, 24, N'触发', CAST(N'2019-04-30 11:37:12.690' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[CallList] OFF
GO
SET IDENTITY_INSERT [dbo].[CuttorAlarmConfiguration] ON 

GO
INSERT [dbo].[CuttorAlarmConfiguration] ([ID], [SNO]) VALUES (1, N'SN_000001')
GO
SET IDENTITY_INSERT [dbo].[CuttorAlarmConfiguration] OFF
GO
INSERT [dbo].[CuttorAlarmConfigurationStation] ([StationId], [TipId], [StationCode]) VALUES (4, 1, N'FANUC-S-C-00004')
GO
INSERT [dbo].[CuttorAlarmConfigurationStation] ([StationId], [TipId], [StationCode]) VALUES (5, 1, N'FANUC-S-C-    5')
GO
INSERT [dbo].[CuttorAlarmConfigurationUser] ([UserId], [TipId], [UserName]) VALUES (1, 1, N'系统管理员')
GO
INSERT [dbo].[CuttorAlarmConfigurationUser] ([UserId], [TipId], [UserName]) VALUES (2, 1, N'陈生生')
GO
SET IDENTITY_INSERT [dbo].[CuttorInfo] ON 

GO
INSERT [dbo].[CuttorInfo] ([ID], [CutterCode], [CutterName], [CutterSupplier], [CutterDesc], [CutterImg], [StoreId], [Speed], [LimitTime], [AlarmTime], [StationId], [SingleTime], [UsedTime], [Status], [LastUseTime]) VALUES (1, N'CUTX1-0001', N'CUTX1-0001', N'CUTX1-0001', N'CUTX1-0001', N'CUTX1-0001', 3, 2000, 2000, 1800, 6, 1, 100, N'使用中', NULL)
GO
SET IDENTITY_INSERT [dbo].[CuttorInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[EndProduct] ON 

GO
INSERT [dbo].[EndProduct] ([ID], [ERPID], [EndProductSN], [ProductionId], [ProductionCode], [ProductionName], [ProductionSheet], [UpdateTime], [ERPDetailCode], [DetailOrderSN], [Status], [ERPDetailId], [EndTime]) VALUES (1, 1, N'0101', NULL, N'P20190302', N'气缸', N'P20190302', CAST(N'2019-03-06 14:48:14.943' AS DateTime), N'P20190304-0001', N'01', 3, 1, NULL)
GO
INSERT [dbo].[EndProduct] ([ID], [ERPID], [EndProductSN], [ProductionId], [ProductionCode], [ProductionName], [ProductionSheet], [UpdateTime], [ERPDetailCode], [DetailOrderSN], [Status], [ERPDetailId], [EndTime]) VALUES (2, 1, N'0101', NULL, N'P20190302', N'气缸', N'P20190302', CAST(N'2019-03-07 21:12:15.340' AS DateTime), N'P20190304-0001', N'01', 1, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[EndProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[EquipmentData] ON 

GO
INSERT [dbo].[EquipmentData] ([ID], [ParentId], [EquipmentCode], [EquipmentName], [EquipmentDesc], [Team], [EquipmentImg], [PLCIP], [PLCDB], [IsPayPoint], [DesignCycletime], [DesignJPH], [EquipmentSupplier], [Counter]) VALUES (1, 0, N'724', N'梦工厂', N'发梦的地方', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EquipmentData] ([ID], [ParentId], [EquipmentCode], [EquipmentName], [EquipmentDesc], [Team], [EquipmentImg], [PLCIP], [PLCDB], [IsPayPoint], [DesignCycletime], [DesignJPH], [EquipmentSupplier], [Counter]) VALUES (2, 1, N'FANUC-L-0001', N'内饰线', N'内饰线', N'01', NULL, N'192.168.0.1', N'DB2314.X97', 1, 57, 50, N'FANUC', 10)
GO
INSERT [dbo].[EquipmentData] ([ID], [ParentId], [EquipmentCode], [EquipmentName], [EquipmentDesc], [Team], [EquipmentImg], [PLCIP], [PLCDB], [IsPayPoint], [DesignCycletime], [DesignJPH], [EquipmentSupplier], [Counter]) VALUES (3, 2, N'C01', N'C01', N'站点1', N'01', N'/UserImg/20190314165642.jpg', N'0.0.0.0', N'DB2314.X1', 1, 57, 50, N'FANUC', 10)
GO
INSERT [dbo].[EquipmentData] ([ID], [ParentId], [EquipmentCode], [EquipmentName], [EquipmentDesc], [Team], [EquipmentImg], [PLCIP], [PLCDB], [IsPayPoint], [DesignCycletime], [DesignJPH], [EquipmentSupplier], [Counter]) VALUES (4, 2, N'C02', N'C02', N'控制器', N'01', N'/UserImg/20190314170547.jpg', N'0.0.0.0', N'DB0000.X0', 1, 57, 50, N'FANUC', 10)
GO
SET IDENTITY_INSERT [dbo].[EquipmentData] OFF
GO
SET IDENTITY_INSERT [dbo].[ERPInterface] ON 

GO
INSERT [dbo].[ERPInterface] ([ID], [FTPIP], [FileName], [Path], [GetRate], [IsEnable]) VALUES (1, N'10.27.189.84', N'*.txt', N'/ftp/po', 120, 1)
GO
SET IDENTITY_INSERT [dbo].[ERPInterface] OFF
GO
SET IDENTITY_INSERT [dbo].[ERPInterfaceRule] ON 

GO
INSERT [dbo].[ERPInterfaceRule] ([ID], [ColumnName], [BeginChar], [DataLength]) VALUES (1, N'计划编号', 1, 12)
GO
INSERT [dbo].[ERPInterfaceRule] ([ID], [ColumnName], [BeginChar], [DataLength]) VALUES (2, N'计划名称', 0, 0)
GO
INSERT [dbo].[ERPInterfaceRule] ([ID], [ColumnName], [BeginChar], [DataLength]) VALUES (3, N'产品编号', 0, 0)
GO
INSERT [dbo].[ERPInterfaceRule] ([ID], [ColumnName], [BeginChar], [DataLength]) VALUES (4, N'计划数量', 0, 0)
GO
INSERT [dbo].[ERPInterfaceRule] ([ID], [ColumnName], [BeginChar], [DataLength]) VALUES (5, N'计划下线时间', 0, 0)
GO
SET IDENTITY_INSERT [dbo].[ERPInterfaceRule] OFF
GO
SET IDENTITY_INSERT [dbo].[ERPOrder] ON 

GO
INSERT [dbo].[ERPOrder] ([ID], [ERPOrderId], [ProductionId], [ProductionName], [EndDate], [ERPOrderName], [ProductionImg], [PlanCount], [ERPStatus], [Createdate]) VALUES (1, N'P20190304', N'P20190302', NULL, CAST(N'2019-03-04' AS Date), N'测试', N'P2019', 25, 1, CAST(N'2019-03-04 21:34:44.570' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ERPOrder] OFF
GO
SET IDENTITY_INSERT [dbo].[ERPOrderDetails] ON 

GO
INSERT [dbo].[ERPOrderDetails] ([ID], [ERPID], [ERPDetailCode], [ProductionCode], [SN], [LineId], [ProductionName], [DetailCount], [Status], [EndDate], [CreateTime], [Creator], [OrderSeq]) VALUES (1, 1, N'P20190304-0001', N'P20190302', N'01', 1, N'气缸', 10, 4, CAST(N'2019-03-04' AS Date), CAST(N'2019-03-05 15:13:26.000' AS DateTime), N'系统管理员', N'0001')
GO
INSERT [dbo].[ERPOrderDetails] ([ID], [ERPID], [ERPDetailCode], [ProductionCode], [SN], [LineId], [ProductionName], [DetailCount], [Status], [EndDate], [CreateTime], [Creator], [OrderSeq]) VALUES (2, 1, N'P20190304-0002', N'P20190302', N'03', 1, N'气缸', 10, 3, CAST(N'2019-03-04' AS Date), CAST(N'2019-03-05 15:13:26.000' AS DateTime), N'系统管理员', N'0003')
GO
INSERT [dbo].[ERPOrderDetails] ([ID], [ERPID], [ERPDetailCode], [ProductionCode], [SN], [LineId], [ProductionName], [DetailCount], [Status], [EndDate], [CreateTime], [Creator], [OrderSeq]) VALUES (3, 1, N'P20190304-0003', N'P20190302', N'02', 1, N'气缸', 5, 4, CAST(N'2019-03-04' AS Date), CAST(N'2019-03-05 15:13:26.000' AS DateTime), N'系统管理员', N'0002')
GO
SET IDENTITY_INSERT [dbo].[ERPOrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[ExchangStore] ON 

GO
INSERT [dbo].[ExchangStore] ([ID], [MaterialId], [MaterialDataName], [MaterialDataNo], [ExchangeType], [TicketNumber], [WarehouseId], [StoreId], [InWarehouseId], [InStoreId], [ExStatus], [CuserId], [Creator], [CreateTime], [UuserId], [Updator], [UpdateTime]) VALUES (1, 3, N'半轴（右）', N'FANUC_M00003', N'库存入库', 26, 3, 2, NULL, NULL, N'确认', 1, N'系统管理员', CAST(N'2019-03-20 21:34:53.000' AS DateTime), 1, N'系统管理员', CAST(N'2019-03-20 22:28:12.000' AS DateTime))
GO
INSERT [dbo].[ExchangStore] ([ID], [MaterialId], [MaterialDataName], [MaterialDataNo], [ExchangeType], [TicketNumber], [WarehouseId], [StoreId], [InWarehouseId], [InStoreId], [ExStatus], [CuserId], [Creator], [CreateTime], [UuserId], [Updator], [UpdateTime]) VALUES (2, 3, N'半轴（右）', N'FANUC_M00003', N'库存转储', 28, 3, 2, 3, 3, N'确认', 1, N'系统管理员', CAST(N'2019-03-20 22:31:57.000' AS DateTime), 1, N'系统管理员', CAST(N'2019-03-20 23:06:32.000' AS DateTime))
GO
INSERT [dbo].[ExchangStore] ([ID], [MaterialId], [MaterialDataName], [MaterialDataNo], [ExchangeType], [TicketNumber], [WarehouseId], [StoreId], [InWarehouseId], [InStoreId], [ExStatus], [CuserId], [Creator], [CreateTime], [UuserId], [Updator], [UpdateTime]) VALUES (3, 3, N'半轴（右）', N'FANUC_M00003', N'库存出库', 24, 3, 3, NULL, NULL, N'确认', 1, N'系统管理员', CAST(N'2019-03-20 22:36:47.000' AS DateTime), 1, N'系统管理员', CAST(N'2019-03-20 23:06:18.000' AS DateTime))
GO
INSERT [dbo].[ExchangStore] ([ID], [MaterialId], [MaterialDataName], [MaterialDataNo], [ExchangeType], [TicketNumber], [WarehouseId], [StoreId], [InWarehouseId], [InStoreId], [ExStatus], [CuserId], [Creator], [CreateTime], [UuserId], [Updator], [UpdateTime]) VALUES (4, 3, N'半轴（右）', N'FANUC_M00003', N'库存转储', 12, 3, 2, 3, 3, N'发起', 1, N'系统管理员', CAST(N'2019-03-20 23:40:24.000' AS DateTime), NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ExchangStore] OFF
GO
SET IDENTITY_INSERT [dbo].[FaultCodeInfo] ON 

GO
INSERT [dbo].[FaultCodeInfo] ([ID], [EquipmentId], [FaultCode], [FaultDesc], [FaultType], [PLCDB]) VALUES (1, 3, N'01', N'宕机', N'故障', N'DB1234.X1')
GO
SET IDENTITY_INSERT [dbo].[FaultCodeInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[FaultNotice] ON 

GO
INSERT [dbo].[FaultNotice] ([ID], [TicketNo], [FaultName], [FaultDesc], [EquipmentId], [UserId], [FaultReturn], [Creator], [ExecuteStatus], [CreateTime]) VALUES (1, N'FN-20190326000001', N'1号机器人挂了', N'1号机器人挂了', 4, 1, N'真的 挂了 ？ ', 1, N'执行', CAST(N'2019-03-26 12:09:35.740' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[FaultNotice] OFF
GO
SET IDENTITY_INSERT [dbo].[FaultUserInfo] ON 

GO
INSERT [dbo].[FaultUserInfo] ([ID], [EquipmentId], [EquipmentName], [UserId], [UserName]) VALUES (8, 4, N'C02', 2, N'陈生生')
GO
INSERT [dbo].[FaultUserInfo] ([ID], [EquipmentId], [EquipmentName], [UserId], [UserName]) VALUES (9, 4, N'C02', 1, N'系统管理员')
GO
INSERT [dbo].[FaultUserInfo] ([ID], [EquipmentId], [EquipmentName], [UserId], [UserName]) VALUES (16, 3, N'C01', 1, N'系统管理员')
GO
SET IDENTITY_INSERT [dbo].[FaultUserInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[LineInfo] ON 

GO
INSERT [dbo].[LineInfo] ([ID], [LineId], [LineName], [LineType], [DesignCycle], [PlanCycle], [IsEnable]) VALUES (1, N'01', N'FANUC-TL1', N'M-Assembly', 50, 47, 1)
GO
INSERT [dbo].[LineInfo] ([ID], [LineId], [LineName], [LineType], [DesignCycle], [PlanCycle], [IsEnable]) VALUES (3, N'03', N'内饰线', N'M-Assembly', 50, 48, 1)
GO
INSERT [dbo].[LineInfo] ([ID], [LineId], [LineName], [LineType], [DesignCycle], [PlanCycle], [IsEnable]) VALUES (4, N'04', N'底盘线', N'M-Assembly', 50, 48, 1)
GO
SET IDENTITY_INSERT [dbo].[LineInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[ManufacturingLogs] ON 

GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (1, CAST(N'2019-02-21 00:00:00.000' AS DateTime), N'192.168.1.10', N'交互握手')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (2, CAST(N'2019-04-11 20:34:09.000' AS DateTime), N'Order2PLC', N'值不在预期的范围内。')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (3, CAST(N'2019-04-11 20:40:41.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (4, CAST(N'2019-04-11 20:44:48.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (5, CAST(N'2019-04-11 21:00:13.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (6, CAST(N'2019-04-11 21:02:14.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (7, CAST(N'2019-04-11 21:06:36.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (8, CAST(N'2019-04-11 21:15:30.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (9, CAST(N'2019-04-11 21:18:20.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (10, CAST(N'2019-04-11 21:18:34.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (11, CAST(N'2019-04-11 21:26:09.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (12, CAST(N'2019-04-11 21:30:51.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (13, CAST(N'2019-04-11 21:38:22.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (14, CAST(N'2019-04-11 21:46:44.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (15, CAST(N'2019-04-11 22:24:37.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (16, CAST(N'2019-04-11 22:25:04.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第二次握手PLC发送0400信号，表示线体接受订单成功！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (17, CAST(N'2019-04-11 22:25:17.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:更新订单状态为4生产！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (18, CAST(N'2019-04-11 22:25:44.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:更新订单状态为4生产，成功！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (19, CAST(N'2019-04-11 22:25:45.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:重置PLC握手信号，0000！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (20, CAST(N'2019-04-13 07:45:47.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (21, CAST(N'2019-04-13 07:58:02.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (22, CAST(N'2019-04-13 07:58:06.000' AS DateTime), N'Order2PLC', N'Channel1.Device3初始化站点编码：01006')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (23, CAST(N'2019-04-13 07:58:09.000' AS DateTime), N'Order2PLC', N'未将对象引用设置到对象的实例。')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (24, CAST(N'2019-04-13 08:07:10.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (25, CAST(N'2019-04-13 08:07:10.000' AS DateTime), N'Order2PLC', N'Channel1.Device3初始化站点编码：01006')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (26, CAST(N'2019-04-13 08:07:10.000' AS DateTime), N'Order2PLC', N'Channel1.Device2初始化站点编码：04007')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (27, CAST(N'2019-04-13 08:07:57.000' AS DateTime), N'Order2PLC', N'Channel1.Device2.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (28, CAST(N'2019-04-13 08:07:57.000' AS DateTime), N'Order2PLC', N'Channel1.Device2.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (29, CAST(N'2019-04-13 08:07:57.000' AS DateTime), N'Order2PLC', N'Channel1.Device2.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (30, CAST(N'2019-04-13 08:07:57.000' AS DateTime), N'Order2PLC', N'Channel1.Device2.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (31, CAST(N'2019-04-13 08:07:57.000' AS DateTime), N'Order2PLC', N'Channel1.Device2.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (32, CAST(N'2019-04-13 08:10:59.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (33, CAST(N'2019-04-13 08:10:59.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (34, CAST(N'2019-04-13 08:10:59.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (35, CAST(N'2019-04-13 08:10:59.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (36, CAST(N'2019-04-13 08:10:59.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (37, CAST(N'2019-04-13 08:10:59.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单顺序号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (38, CAST(N'2019-04-13 08:10:59.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发产品编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (39, CAST(N'2019-04-13 08:13:47.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (40, CAST(N'2019-04-13 08:13:47.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (41, CAST(N'2019-04-13 08:13:47.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (42, CAST(N'2019-04-13 08:13:47.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (43, CAST(N'2019-04-13 08:13:47.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (44, CAST(N'2019-04-13 08:13:56.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单顺序号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (45, CAST(N'2019-04-13 08:16:21.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (46, CAST(N'2019-04-13 08:16:21.000' AS DateTime), N'Order2PLC', N'Channel1.Device3初始化站点编码：01006')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (47, CAST(N'2019-04-13 08:16:21.000' AS DateTime), N'Order2PLC', N'Channel1.Device2初始化站点编码：04007')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (48, CAST(N'2019-04-13 08:16:34.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (49, CAST(N'2019-04-13 08:16:34.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (50, CAST(N'2019-04-13 08:16:34.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (51, CAST(N'2019-04-13 08:16:34.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (52, CAST(N'2019-04-13 08:16:34.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (53, CAST(N'2019-04-13 08:16:44.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单顺序号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (54, CAST(N'2019-04-13 08:16:46.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发产品编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (55, CAST(N'2019-04-13 08:16:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单数量！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (56, CAST(N'2019-04-13 08:16:51.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发完成,写0300标志！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (57, CAST(N'2019-04-13 08:19:09.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第二次握手PLC发送0400信号，表示线体接受订单成功！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (58, CAST(N'2019-04-13 08:19:09.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:更新订单状态为4生产！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (59, CAST(N'2019-04-13 08:19:09.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:更新订单状态为4生产，成功！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (60, CAST(N'2019-04-13 08:19:09.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:重置PLC握手信号，0000！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (61, CAST(N'2019-04-13 09:48:00.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (62, CAST(N'2019-04-13 09:48:00.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (63, CAST(N'2019-04-13 09:48:00.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (64, CAST(N'2019-04-13 09:48:00.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (65, CAST(N'2019-04-13 09:48:00.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (66, CAST(N'2019-04-13 09:48:23.000' AS DateTime), N'Order2PLC', N'无订单下达！写0301标志')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (67, CAST(N'2019-04-13 10:28:45.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (68, CAST(N'2019-04-13 10:28:45.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (69, CAST(N'2019-04-13 10:28:45.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (70, CAST(N'2019-04-13 10:28:45.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (71, CAST(N'2019-04-13 10:28:45.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (72, CAST(N'2019-04-13 10:28:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单顺序号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (73, CAST(N'2019-04-13 10:28:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发产品编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (74, CAST(N'2019-04-13 10:28:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单数量！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (75, CAST(N'2019-04-13 10:28:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发完成,写0300标志！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (76, CAST(N'2019-04-13 10:29:40.000' AS DateTime), N'Order2PLC', N'添加监控标签！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (77, CAST(N'2019-04-13 10:29:40.000' AS DateTime), N'Order2PLC', N'Channel1.Device3初始化站点编码：01006')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (78, CAST(N'2019-04-13 10:29:40.000' AS DateTime), N'Order2PLC', N'Channel1.Device2初始化站点编码：04007')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (79, CAST(N'2019-04-13 10:29:58.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (80, CAST(N'2019-04-13 10:29:58.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (81, CAST(N'2019-04-13 10:29:58.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (82, CAST(N'2019-04-13 10:29:58.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (83, CAST(N'2019-04-13 10:29:58.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (84, CAST(N'2019-04-13 10:30:06.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单顺序号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (85, CAST(N'2019-04-13 10:30:06.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发产品编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (86, CAST(N'2019-04-13 10:30:06.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单数量！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (87, CAST(N'2019-04-13 10:30:06.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发完成,写0300标志！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (88, CAST(N'2019-04-13 10:30:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:第一次握手！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (89, CAST(N'2019-04-13 10:30:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取站点编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (90, CAST(N'2019-04-13 10:30:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取上一订单号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (91, CAST(N'2019-04-13 10:30:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体code！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (92, CAST(N'2019-04-13 10:30:49.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:获取线体下一订单！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (93, CAST(N'2019-04-13 10:30:54.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单顺序号！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (94, CAST(N'2019-04-13 10:30:54.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发产品编码！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (95, CAST(N'2019-04-13 10:30:54.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发订单数量！')
GO
INSERT [dbo].[ManufacturingLogs] ([ID], [CreateTime], [PLCIP], [OptionDesc]) VALUES (96, CAST(N'2019-04-13 10:30:54.000' AS DateTime), N'Order2PLC', N'Channel1.Device3.Order0Init:下发完成,写0300标志！')
GO
SET IDENTITY_INSERT [dbo].[ManufacturingLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[Material_W_S] ON 

GO
INSERT [dbo].[Material_W_S] ([ID], [MaterialId], [WarehouseId], [StoreId], [MTotal], [exchangecount]) VALUES (2, 1, 3, 2, 0, NULL)
GO
INSERT [dbo].[Material_W_S] ([ID], [MaterialId], [WarehouseId], [StoreId], [MTotal], [exchangecount]) VALUES (3, 1, 3, 3, 0, NULL)
GO
INSERT [dbo].[Material_W_S] ([ID], [MaterialId], [WarehouseId], [StoreId], [MTotal], [exchangecount]) VALUES (4, 2, 3, 2, 12, NULL)
GO
INSERT [dbo].[Material_W_S] ([ID], [MaterialId], [WarehouseId], [StoreId], [MTotal], [exchangecount]) VALUES (5, 3, 3, 2, 60, -28)
GO
INSERT [dbo].[Material_W_S] ([ID], [MaterialId], [WarehouseId], [StoreId], [MTotal], [exchangecount]) VALUES (6, 3, 3, 3, 14, -24)
GO
SET IDENTITY_INSERT [dbo].[Material_W_S] OFF
GO
SET IDENTITY_INSERT [dbo].[MaterialCallPoint] ON 

GO
INSERT [dbo].[MaterialCallPoint] ([ID], [MaterialCallCode], [MaterialId], [CallType], [DeductionCountor], [DeliverType], [SaveNumber], [DelayTime], [DeliverWay], [StationId], [WHCount], [StoreId]) VALUES (2, N'C01-01-02', 3, N'固定数量', 3, N'人工拣料', 20, 1, N'R02', 5, 125, 2)
GO
INSERT [dbo].[MaterialCallPoint] ([ID], [MaterialCallCode], [MaterialId], [CallType], [DeductionCountor], [DeliverType], [SaveNumber], [DelayTime], [DeliverWay], [StationId], [WHCount], [StoreId]) VALUES (3, N'C01-01-03', 3, N'按BOM数量', 0, N'人工拣料', 30, 1, N'R02', 6, 24, 2)
GO
INSERT [dbo].[MaterialCallPoint] ([ID], [MaterialCallCode], [MaterialId], [CallType], [DeductionCountor], [DeliverType], [SaveNumber], [DelayTime], [DeliverWay], [StationId], [WHCount], [StoreId]) VALUES (4, N'C01-01-04', 3, N'按BOM数量', 0, N'人工拣料', 30, 1, N'R03', 6, 0, 2)
GO
SET IDENTITY_INSERT [dbo].[MaterialCallPoint] OFF
GO
SET IDENTITY_INSERT [dbo].[MaterialData] ON 

GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (1, N'FANUC_M00004', N'半轴（左）', N'装箱', 12, 900, N'江森', 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (2, N'FANUC_M00005', N'油箱', N'托盘', 1, 200, N'库尔', 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (3, N'FANUC_M00003', N'半轴（右）', N'装箱', 12, 900, N'江森', 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (4, N'A0001', N'油箱1', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (5, N'A0002', N'油箱2', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (6, N'A0003', N'油箱3', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (7, N'A0004', N'油箱4', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (8, N'B0001', N'油箱5', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (9, N'B0002', N'油箱6', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (10, N'C0001', N'油箱7', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (11, N'D0001', N'油箱8', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (12, N'E0001', N'油箱9', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (13, N'F0001', N'油箱10', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (14, N'G0001', N'油箱11', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (15, N'H0001', N'油箱12', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (16, N'I0001', N'油箱13', NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[MaterialData] ([ID], [MaterialDataNo], [MaterialDataName], [BoxType], [BoxTotalNo], [KG], [Supplier], [IsEnable]) VALUES (17, N'J0001', N'油箱14', NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[MaterialData] OFF
GO
SET IDENTITY_INSERT [dbo].[Menus] ON 

GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (1, N'生产数据管理', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (2, N'生产计划排产', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (3, N'订单管理', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (4, N'物料拉动', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (5, N'刀具管理', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (6, N'设备维护', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (7, N'库存WMS', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (8, N'ANDON', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (9, N'系统管理', N'#', 0)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (10, N'角色管理', N'/Views/UserPermission/Role.aspx', 9)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (11, N'用户管理', N'/Views/UserPermission/User.aspx', 9)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (12, N'用户操作日志', N'/Views/UserPermission/SystemLogs.aspx', 9)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (13, N'PLC交互日志', N'/Views/UserPermission/PLCLogs.aspx', 9)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (14, N'执行日志', N'/Views/UserPermission/ErrorLogs.aspx', 9)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (15, N'生产线管理', N'/Views/ProductionManagement/Line.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (16, N'产品管理', N'/Views/ProductionManagement/ProductionInfo.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (17, N'站点管理', N'/Views/ProductionManagement/StationSeach.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (19, N'PLC模板', N'/Views/ProductionManagement/PLCTemplateInfo.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (20, N'BOM管理', N'/Views/ProductionManagement/PBOM.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (21, N'工作日历', N'/Views/ProductionManagement/WorkCalendar.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (22, N'设备主数据', N'/Views/ProductionManagement/EquipmentData.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (23, N'设备故障提醒设置', N'/Views/ProductionManagement/FaultUserInfo.aspx', 1)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (24, N'ERP集成接口', N'/Views/ERP/ERPConfiguration.aspx', 2)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (25, N'生产计划及生产订单', N'/Views/ERP/ERPOrder.aspx', 2)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (26, N'订单查询', N'/Views/OrderManagement/EndProduct.aspx', 3)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (27, N'成品查询', N'/Views/OrderManagement/EndProductList.aspx', 3)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (28, N'零件追溯查询', N'/Views/OrderManagement/EndProductionTraceability.aspx', 3)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (29, N'物料落点管理', N'/Views/MaterialCall/MaterialCallPoint.aspx', 4)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (30, N'触发点管理', N'/Views/MaterialCall/MaterialCallPointSetWHCount.aspx', 4)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (31, N'叫料需求管理', N'/Views/MaterialCall/CallList.aspx', 4)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (32, N'捡料单管理', N'/Views/MaterialCall/PickList.aspx', 4)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (33, N'刀具主数据', N'/Views/Cuttor/CuttorInfo.aspx', 5)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (34, N'换刀提醒设置', N'/Views/Cuttor/CuttorAlarmConfiguration.aspx', 5)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (35, N'故障通知单', N'/Views/Fault/FaultNotice.aspx', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (36, N'故障通知单–执行人查看并执行', N'/Views/Fault/FaultNoticeRespone.aspx', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (37, N'日常维护管理', N'/Views/Fault/AMTicket.aspx', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (39, N'日常维护任务单–查看执行', N'/Views/Fault/AMTicketRespone.aspx', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (40, N'生产报表', N'#', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (41, N'Cycletime', N'#', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (42, N'站点状态报表', N'#', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (43, N'故障和人工干预报表', N'#', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (44, N'瓶颈分析', N'#', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (45, N'TOP10 故障', N'#', 6)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (46, N'仓储区域维护', N'/Views/WMS/Warehouse.aspx', 7)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (47, N'仓位维护', N'/Views/WMS/Store.aspx', 7)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (48, N'物料主数据维护', N'/Views/WMS/MaterialData.aspx', 7)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (49, N'转储单管理', N'/Views/WMS/ExchangStore.aspx', 7)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (50, N'物料库存查询', N'/Views/WMS/WMSSearch.aspx', 7)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (51, N'ANDON配置', N'/Views/Andon/Andon.aspx', 8)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (52, N'登录用户维护', N'/Views/UserPermission/UserChange.aspx', 9)
GO
INSERT [dbo].[Menus] ([ID], [MenuName], [MenuDesc], [ParentId]) VALUES (53, N'过程质量查询', N'/Views/OrderManagement/ProcessInfo.aspx', 3)
GO
SET IDENTITY_INSERT [dbo].[Menus] OFF
GO
SET IDENTITY_INSERT [dbo].[PBOM] ON 

GO
INSERT [dbo].[PBOM] ([ID], [ProductionId], [MaterialId], [MaterialCode], [UseCount]) VALUES (2, 15, 7, N'A0004', 2)
GO
INSERT [dbo].[PBOM] ([ID], [ProductionId], [MaterialId], [MaterialCode], [UseCount]) VALUES (3, 15, 17, N'J0001', 3)
GO
INSERT [dbo].[PBOM] ([ID], [ProductionId], [MaterialId], [MaterialCode], [UseCount]) VALUES (4, 16, 17, N'J0001', 2)
GO
INSERT [dbo].[PBOM] ([ID], [ProductionId], [MaterialId], [MaterialCode], [UseCount]) VALUES (5, 15, 7, N'A0004', 1)
GO
SET IDENTITY_INSERT [dbo].[PBOM] OFF
GO
SET IDENTITY_INSERT [dbo].[PCStationProcessSheet] ON 

GO
INSERT [dbo].[PCStationProcessSheet] ([PCStationId], [ProcessId], [ProcessName], [ProcessDesc], [ProcessType]) VALUES (5, 12, N'sheet', N'qq', N'装配')
GO
INSERT [dbo].[PCStationProcessSheet] ([PCStationId], [ProcessId], [ProcessName], [ProcessDesc], [ProcessType]) VALUES (5, 13, N'shhe', N'11', N'装配')
GO
INSERT [dbo].[PCStationProcessSheet] ([PCStationId], [ProcessId], [ProcessName], [ProcessDesc], [ProcessType]) VALUES (5, 16, N'sheet3', N'11', N'拧紧')
GO
INSERT [dbo].[PCStationProcessSheet] ([PCStationId], [ProcessId], [ProcessName], [ProcessDesc], [ProcessType]) VALUES (0, 1016, N'', N'', N'')
GO
INSERT [dbo].[PCStationProcessSheet] ([PCStationId], [ProcessId], [ProcessName], [ProcessDesc], [ProcessType]) VALUES (0, 1017, N'', N'', N'')
GO
INSERT [dbo].[PCStationProcessSheet] ([PCStationId], [ProcessId], [ProcessName], [ProcessDesc], [ProcessType]) VALUES (0, 1018, N'', N'', N'')
GO
INSERT [dbo].[PCStationProcessSheet] ([PCStationId], [ProcessId], [ProcessName], [ProcessDesc], [ProcessType]) VALUES (6, 1019, N'sheet1', N'sheet1 按住啊', N'装配')
GO
SET IDENTITY_INSERT [dbo].[PCStationProcessSheet] OFF
GO
SET IDENTITY_INSERT [dbo].[PCStationQuality] ON 

GO
INSERT [dbo].[PCStationQuality] ([PCStationId], [QualityId], [QualityDesc], [QualityStandard]) VALUES (5, 1, N'确认支撑是否安装', N'左倾45度角安装')
GO
INSERT [dbo].[PCStationQuality] ([PCStationId], [QualityId], [QualityDesc], [QualityStandard]) VALUES (5, 3, N'qq', N'11')
GO
SET IDENTITY_INSERT [dbo].[PCStationQuality] OFF
GO
SET IDENTITY_INSERT [dbo].[PCTraceability] ON 

GO
INSERT [dbo].[PCTraceability] ([PCStationId], [TraceabilityId], [TraceabilityDesc]) VALUES (5, 1, N'扫描天窗')
GO
SET IDENTITY_INSERT [dbo].[PCTraceability] OFF
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 15)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 16)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 17)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 18)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (2, 10)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (3, 10)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (3, 11)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (3, 12)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (3, 13)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 19)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 20)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 21)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 22)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 23)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 24)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 25)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 26)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 27)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 28)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 53)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 29)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 30)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 31)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 32)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 33)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 34)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 35)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 36)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 37)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 38)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 39)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 40)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 41)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 42)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 43)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 44)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 45)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 46)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 47)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 48)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 49)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 50)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 51)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 10)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 11)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 12)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 13)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 15)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 16)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 17)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 18)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 19)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 20)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 21)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 22)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 23)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 24)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (6, 25)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 14)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (1, 52)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 15)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 16)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 17)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 19)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 20)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 21)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 22)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 23)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 24)
GO
INSERT [dbo].[Permissions] ([RoleId], [MenuId]) VALUES (7, 25)
GO
SET IDENTITY_INSERT [dbo].[PickDetailList] ON 

GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (1, 1, 2)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (2, 1, 2)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (3, 2, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (4, 2, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (5, 3, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (6, 3, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (7, 4, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (8, 4, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (9, 5, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (10, 5, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (11, 6, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (12, 6, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (13, 7, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (14, 7, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (15, 8, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (16, 8, 2)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (17, 9, 1)
GO
INSERT [dbo].[PickDetailList] ([ID], [PickId], [CallId]) VALUES (18, 9, 2)
GO
SET IDENTITY_INSERT [dbo].[PickDetailList] OFF
GO
SET IDENTITY_INSERT [dbo].[PickList] ON 

GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (1, N'FANUC-C-P-00001', N'R02', CAST(N'2019-03-25 09:44:51.173' AS DateTime), NULL, N'系统管理员', NULL)
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (2, N'FANUC-C-P-00002', N'R02', CAST(N'2019-03-25 09:55:05.600' AS DateTime), NULL, N'系统管理员', NULL)
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (3, N'FANUC-C-P-00003', N'R02', CAST(N'2019-03-25 09:59:11.350' AS DateTime), NULL, N'系统管理员', NULL)
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (4, N'FANUC-C-P-00004', N'R02', CAST(N'2019-03-25 10:01:04.007' AS DateTime), NULL, N'系统管理员', NULL)
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (5, N'FANUC-C-P-00005', N'R02', CAST(N'2019-03-25 10:05:25.913' AS DateTime), NULL, N'系统管理员', NULL)
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (6, N'FANUC-C-P-00006', N'R02', CAST(N'2019-03-25 10:08:52.383' AS DateTime), NULL, N'系统管理员', NULL)
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (7, N'FANUC-C-P-00007', N'R02', CAST(N'2019-03-25 10:21:36.257' AS DateTime), NULL, N'系统管理员', NULL)
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (8, N'FANUC-C-P-00008', N'R02', CAST(N'2019-03-25 10:33:53.220' AS DateTime), NULL, N'系统管理员', N'/PickListPDF/Pick_20190325103403.pdf')
GO
INSERT [dbo].[PickList] ([ID], [PickCode], [DeliverWay], [CreateTime], [UpdateTime], [Creator], [PickPdfUrl]) VALUES (9, N'FANUC-C-P-00009', N'R02', CAST(N'2019-03-25 11:49:06.190' AS DateTime), NULL, N'系统管理员', N'/PickListPDF/Pick_20190325114915.pdf')
GO
SET IDENTITY_INSERT [dbo].[PickList] OFF
GO
SET IDENTITY_INSERT [dbo].[PLCAPInfo] ON 

GO
INSERT [dbo].[PLCAPInfo] ([PLCStationId], [PLCAPId], [PLCAPDBAddress], [APDataLength], [APDataDesc]) VALUES (6, 1, N'0', 12, N'qw')
GO
SET IDENTITY_INSERT [dbo].[PLCAPInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[PLCTemplateInfo] ON 

GO
INSERT [dbo].[PLCTemplateInfo] ([ID], [PLCTemplateName], [UpdateTime], [Updator]) VALUES (1, N'订单模板', CAST(N'2019-04-25 11:26:30.000' AS DateTime), N'系统管理员')
GO
INSERT [dbo].[PLCTemplateInfo] ([ID], [PLCTemplateName], [UpdateTime], [Updator]) VALUES (3, N'PLC模板2', CAST(N'2019-03-12 16:33:09.000' AS DateTime), N'系统管理员')
GO
SET IDENTITY_INSERT [dbo].[PLCTemplateInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[PLCTemplateInfoDetail] ON 

GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (1, 1, N'Order0Init', 9, N'Order0Init')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (3, 1, N'Order1Init', 10, N'Order1Init')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (4, 3, N'33', 10, N'33')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (5, 1, N'Order2RO', 0, N'Order2RO')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (6, 1, N'Order3StationCode', 0, N'Order3StationCode')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (7, 1, N'Order4No', 0, N'Order4No')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (8, 1, N'Order5ProductionSN', 0, N'Order5ProductionSN')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (9, 1, N'Order6LastOrderNo', 0, N'Order6LastOrderNo')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (10, 1, N'Order7Total', 0, N'Order7Total')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (11, 1, N'Order8Count', 0, N'Order8Count')
GO
INSERT [dbo].[PLCTemplateInfoDetail] ([ID], [PLCTemplateID], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (12, 1, N'Order9Error', 0, N'Order9Error')
GO
SET IDENTITY_INSERT [dbo].[PLCTemplateInfoDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[PLCTemplateOperationInfo] ON 

GO
INSERT [dbo].[PLCTemplateOperationInfo] ([PLCStationId], [PLCTemplateId], [ID], [PLCTrigger], [CommunicateType], [CheckAddress], [PLCDB], [ActionCode], [CommunicateName], [ReturnLength]) VALUES (6, 1, 1, N'Channel1.Device3', N'kepware', N'DB36.X9', N'DB2312.X8', N'UP', N'CMM', 10)
GO
INSERT [dbo].[PLCTemplateOperationInfo] ([PLCStationId], [PLCTemplateId], [ID], [PLCTrigger], [CommunicateType], [CheckAddress], [PLCDB], [ActionCode], [CommunicateName], [ReturnLength]) VALUES (7, 1, 2, N'Channel1.Device2', N'kepware', N'DB2316.X9', N'DB2316.X8', N'UP', N'CMM', 10)
GO
SET IDENTITY_INSERT [dbo].[PLCTemplateOperationInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[PLCUPInfo] ON 

GO
INSERT [dbo].[PLCUPInfo] ([PLCStationId], [PLCUPId], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (6, 1, N'1', 12, N'qwe')
GO
INSERT [dbo].[PLCUPInfo] ([PLCStationId], [PLCUPId], [PLCUPDBAddress], [UPDataLength], [UPDataDesc]) VALUES (6, 3, N'13', 12, N'TTTT')
GO
SET IDENTITY_INSERT [dbo].[PLCUPInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductDefectInfo] ON 

GO
INSERT [dbo].[ProductDefectInfo] ([ID], [ProductId], [ProductCode], [DefectCode], [DefectDesc], [StationName], [LastStatus], [LastUpdator], [UpdateTime]) VALUES (1, 1, N'0101', N'X-1
', N'拧紧
', N'C01001', N'OK', N'系统管理员', CAST(N'2019-03-04 12:23:00.000' AS DateTime))
GO
INSERT [dbo].[ProductDefectInfo] ([ID], [ProductId], [ProductCode], [DefectCode], [DefectDesc], [StationName], [LastStatus], [LastUpdator], [UpdateTime]) VALUES (2, 1, N'0101', N'X-1', N'拧紧
', N'C01001', N'1.56', NULL, CAST(N'2019-03-04 12:23:00.000' AS DateTime))
GO
INSERT [dbo].[ProductDefectInfo] ([ID], [ProductId], [ProductCode], [DefectCode], [DefectDesc], [StationName], [LastStatus], [LastUpdator], [UpdateTime]) VALUES (3, 1, N'0101', N'X-1', N'拧紧
', N'C01001', N'OK', NULL, CAST(N'2019-03-04 12:23:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ProductDefectInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductionInfo] ON 

GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (2, N'P20190302', N'气缸', N'P2019', N'P2019', 1, 10, 2, N'', N'13213213131', 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (3, N'X20180073', N'气缸1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (4, N'A20190010', N'气缸A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (5, N'B20190010', N'气缸B', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (6, N'C20190010', N'气缸C', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (7, N'D20190010', N'气缸D', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (8, N'E20190010', N'气缸E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (9, N'F20190010', N'气缸F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (10, N'G20190010', N'气缸G', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (11, N'H20190010', N'气缸H', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (12, N'I20190010', N'气缸I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (13, N'J20190010', N'气缸J', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (14, N'K20190010', N'气缸K', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (15, N'L20190010', N'气缸L', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[ProductionInfo] ([ID], [ProductionId], [ProductionName], [ProductionType], [ProductionSheet], [LineId], [Batch], [StoreId], [ProductionImg], [ProductionDesc], [IsEnable]) VALUES (16, N'M20190010', N'气缸M', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[ProductionInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductPLCTraceabilityInfo] ON 

GO
INSERT [dbo].[ProductPLCTraceabilityInfo] ([ID], [ProductId], [ProductCode], [PLCDataDesc], [PLCDataResult], [LastStatus], [Updator], [UpdateTime], [StationName], [PLCAPID]) VALUES (1, 1, N'0101', N'O-Read Piston code
', N'OK', NULL, NULL, CAST(N'2019-03-04 12:23:00.000' AS DateTime), N'C01001', NULL)
GO
INSERT [dbo].[ProductPLCTraceabilityInfo] ([ID], [ProductId], [ProductCode], [PLCDataDesc], [PLCDataResult], [LastStatus], [Updator], [UpdateTime], [StationName], [PLCAPID]) VALUES (2, 1, N'0101', N'O-Read Piston code', N'NOK', N'OK', N'系统管理员', CAST(N'2019-03-04 12:23:00.000' AS DateTime), N'C01001', NULL)
GO
INSERT [dbo].[ProductPLCTraceabilityInfo] ([ID], [ProductId], [ProductCode], [PLCDataDesc], [PLCDataResult], [LastStatus], [Updator], [UpdateTime], [StationName], [PLCAPID]) VALUES (3, 1, N'0101', N'O-Read Piston code', N'NOK', N'OK', N'系统管理员', CAST(N'2019-03-04 12:23:00.000' AS DateTime), N'C01001', NULL)
GO
SET IDENTITY_INSERT [dbo].[ProductPLCTraceabilityInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTraceabilityInfo] ON 

GO
INSERT [dbo].[ProductTraceabilityInfo] ([ID], [ProductId], [ProductCode], [StationName], [ParkSn], [TransitTime], [ItemID]) VALUES (1, 1, N'0101', N'C01001', N'384677383388992345', CAST(N'2019-03-04 12:23:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[ProductTraceabilityInfo] ([ID], [ProductId], [ProductCode], [StationName], [ParkSn], [TransitTime], [ItemID]) VALUES (2, 1, N'0101', N'C01001', N'384677383388992345', CAST(N'2019-03-04 12:23:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[ProductTraceabilityInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTransitInfo] ON 

GO
INSERT [dbo].[ProductTransitInfo] ([ID], [ProductId], [ProductCode], [StationName], [StationDesc], [StationType], [TransitTime], [QualityStatus]) VALUES (1, 1, N'0101', N'C01001', N'首工位', N'PC', CAST(N'2019-03-04 12:23:00.000' AS DateTime), N'OK')
GO
SET IDENTITY_INSERT [dbo].[ProductTransitInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[StationInfo] ON 

GO
INSERT [dbo].[StationInfo] ([ID], [StationCode], [StationName], [StationDesc], [StationType], [StationPosition], [StationAsset], [Team], [IP], [ProcessSheet], [IsEnable], [LineId], [LineName], [IsFirstStation]) VALUES (4, N'01004', N'C0102323', N'C0102323', N'PC', N'标准站点', NULL, N'01', N'', N'/ProcessSheet/20190313102216.pdf', 1, 1, NULL, 0)
GO
INSERT [dbo].[StationInfo] ([ID], [StationCode], [StationName], [StationDesc], [StationType], [StationPosition], [StationAsset], [Team], [IP], [ProcessSheet], [IsEnable], [LineId], [LineName], [IsFirstStation]) VALUES (5, N'01005', N'测试站点', N'测试站点', N'PC', N'标准站点', NULL, N'01', N'', N'/ProcessSheet/20190313101959.pdf', 1, 1, NULL, 0)
GO
INSERT [dbo].[StationInfo] ([ID], [StationCode], [StationName], [StationDesc], [StationType], [StationPosition], [StationAsset], [Team], [IP], [ProcessSheet], [IsEnable], [LineId], [LineName], [IsFirstStation]) VALUES (6, N'01006', N'PLC01', N'放PLC的地方', N'PLC', N'标准站点', NULL, N'01', N'10.27.163.10', NULL, 1, 1, NULL, 1)
GO
INSERT [dbo].[StationInfo] ([ID], [StationCode], [StationName], [StationDesc], [StationType], [StationPosition], [StationAsset], [Team], [IP], [ProcessSheet], [IsEnable], [LineId], [LineName], [IsFirstStation]) VALUES (7, N'04007', N'CP010', N'', N'PLC', N'标准站点', NULL, N'01', N'', NULL, 1, 4, NULL, 1)
GO
INSERT [dbo].[StationInfo] ([ID], [StationCode], [StationName], [StationDesc], [StationType], [StationPosition], [StationAsset], [Team], [IP], [ProcessSheet], [IsEnable], [LineId], [LineName], [IsFirstStation]) VALUES (8, N'04008', N'CP002', N'', N'PC', N'标准站点', NULL, N'01', N'', NULL, 1, 4, NULL, 0)
GO
INSERT [dbo].[StationInfo] ([ID], [StationCode], [StationName], [StationDesc], [StationType], [StationPosition], [StationAsset], [Team], [IP], [ProcessSheet], [IsEnable], [LineId], [LineName], [IsFirstStation]) VALUES (9, N'00009', N'CF001', N'', N'PC', N'返修站点', NULL, N'01', N'', NULL, 1, 4, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[StationInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Store] ON 

GO
INSERT [dbo].[Store] ([ID], [WarehouseId], [StoreNo], [StoreName], [PickArea], [KG], [MaxNo], [IsEnable]) VALUES (2, 3, N'FANUC_S00002', N'内饰仓位1', N'TL-01', 1499, 24, 1)
GO
INSERT [dbo].[Store] ([ID], [WarehouseId], [StoreNo], [StoreName], [PickArea], [KG], [MaxNo], [IsEnable]) VALUES (3, 3, N'FANUC_S00003', N'内饰仓位4', N'TL-04', 1500, 24, 1)
GO
SET IDENTITY_INSERT [dbo].[Store] OFF
GO
SET IDENTITY_INSERT [dbo].[SystemLogs] ON 

GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (7, CAST(N'2019-02-21 11:51:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (8, CAST(N'2019-02-21 11:56:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (9, CAST(N'2019-02-21 12:09:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (10, CAST(N'2019-02-21 12:29:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (11, CAST(N'2019-02-21 12:31:34.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (12, CAST(N'2019-02-21 12:35:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (13, CAST(N'2019-02-21 12:36:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (14, CAST(N'2019-02-21 12:36:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增角色成功:测试')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (15, CAST(N'2019-02-21 12:36:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (16, CAST(N'2019-02-21 13:36:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (17, CAST(N'2019-02-21 13:49:41.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (18, CAST(N'2019-02-21 13:56:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (19, CAST(N'2019-02-21 15:43:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (20, CAST(N'2019-02-21 16:28:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (21, CAST(N'2019-02-21 16:51:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (22, CAST(N'2019-02-21 16:56:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (23, CAST(N'2019-02-21 16:57:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (24, CAST(N'2019-02-21 17:05:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (25, CAST(N'2019-02-21 17:36:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (26, CAST(N'2019-02-21 17:37:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (27, CAST(N'2019-02-21 21:38:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (28, CAST(N'2019-02-21 21:39:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (29, CAST(N'2019-02-21 21:42:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (30, CAST(N'2019-02-21 21:44:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (31, CAST(N'2019-02-22 09:51:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (32, CAST(N'2019-02-22 09:51:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (33, CAST(N'2019-02-22 11:35:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (34, CAST(N'2019-02-22 11:39:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (35, CAST(N'2019-02-22 12:05:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (36, CAST(N'2019-02-22 12:10:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (37, CAST(N'2019-02-22 15:12:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (38, CAST(N'2019-02-22 15:21:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (39, CAST(N'2019-02-22 16:02:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (40, CAST(N'2019-02-22 16:03:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (41, CAST(N'2019-02-22 16:04:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (42, CAST(N'2019-02-22 16:04:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (43, CAST(N'2019-02-22 16:22:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (44, CAST(N'2019-02-22 16:23:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (45, CAST(N'2019-02-22 16:26:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (46, CAST(N'2019-02-22 16:27:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (47, CAST(N'2019-02-22 16:28:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (48, CAST(N'2019-02-22 17:14:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (49, CAST(N'2019-02-22 17:15:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (50, CAST(N'2019-02-22 17:15:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (51, CAST(N'2019-02-22 17:20:27.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (52, CAST(N'2019-02-22 17:22:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (53, CAST(N'2019-02-22 17:28:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (54, CAST(N'2019-02-22 17:30:34.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (55, CAST(N'2019-02-22 17:31:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (56, CAST(N'2019-02-22 22:18:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (57, CAST(N'2019-02-22 22:33:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (58, CAST(N'2019-02-22 22:34:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (59, CAST(N'2019-02-22 22:43:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (60, CAST(N'2019-02-23 09:12:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (61, CAST(N'2019-02-23 09:13:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (62, CAST(N'2019-02-23 14:49:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (63, CAST(N'2019-02-23 15:47:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (64, CAST(N'2019-02-23 16:01:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (65, CAST(N'2019-02-23 16:04:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (66, CAST(N'2019-02-23 16:24:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (67, CAST(N'2019-02-23 16:25:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (68, CAST(N'2019-02-23 16:50:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (69, CAST(N'2019-02-23 17:06:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (70, CAST(N'2019-02-23 17:09:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (71, CAST(N'2019-02-23 17:12:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (72, CAST(N'2019-02-23 17:21:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (73, CAST(N'2019-02-23 17:27:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (74, CAST(N'2019-02-23 21:21:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (75, CAST(N'2019-02-23 21:21:35.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (76, CAST(N'2019-02-23 21:22:59.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑角色成功:系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (77, CAST(N'2019-02-23 21:22:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (78, CAST(N'2019-02-23 21:23:27.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (79, CAST(N'2019-02-23 21:43:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (80, CAST(N'2019-02-23 21:43:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (81, CAST(N'2019-02-23 21:43:23.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑角色成功:系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (82, CAST(N'2019-02-23 21:43:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (83, CAST(N'2019-02-23 21:43:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (84, CAST(N'2019-02-23 21:44:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (85, CAST(N'2019-02-24 21:15:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (86, CAST(N'2019-02-24 21:54:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (87, CAST(N'2019-02-24 21:54:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (88, CAST(N'2019-02-24 22:04:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (89, CAST(N'2019-02-24 22:07:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (90, CAST(N'2019-02-24 22:09:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (91, CAST(N'2019-02-24 22:09:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (92, CAST(N'2019-02-24 22:10:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (93, CAST(N'2019-02-24 22:10:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (94, CAST(N'2019-02-24 22:10:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (95, CAST(N'2019-02-24 22:10:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (96, CAST(N'2019-02-24 22:11:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (97, CAST(N'2019-02-24 22:11:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (98, CAST(N'2019-02-24 22:30:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (99, CAST(N'2019-02-24 22:30:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (100, CAST(N'2019-02-24 22:32:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (101, CAST(N'2019-02-24 22:36:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (102, CAST(N'2019-02-24 22:39:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (103, CAST(N'2019-02-24 22:42:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (104, CAST(N'2019-02-24 22:44:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (105, CAST(N'2019-02-24 22:46:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (106, CAST(N'2019-02-24 22:46:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (107, CAST(N'2019-02-24 22:46:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (108, CAST(N'2019-02-24 22:47:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (109, CAST(N'2019-02-24 22:52:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (110, CAST(N'2019-02-24 22:52:35.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑角色成功:测试4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (111, CAST(N'2019-02-24 22:52:35.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (112, CAST(N'2019-02-24 22:52:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除角色成功:|5|4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (113, CAST(N'2019-02-24 22:52:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (114, CAST(N'2019-02-25 12:33:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (115, CAST(N'2019-02-25 12:33:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (116, CAST(N'2019-02-25 20:47:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (117, CAST(N'2019-02-25 21:00:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (118, CAST(N'2019-02-25 21:19:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (119, CAST(N'2019-02-25 21:25:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (120, CAST(N'2019-02-25 21:41:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (121, CAST(N'2019-02-25 21:59:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (122, CAST(N'2019-02-25 22:01:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (123, CAST(N'2019-02-25 22:03:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (124, CAST(N'2019-02-25 22:34:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (125, CAST(N'2019-02-25 22:38:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (126, CAST(N'2019-02-25 22:39:05.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (127, CAST(N'2019-02-25 22:39:56.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (128, CAST(N'2019-02-25 22:41:27.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (129, CAST(N'2019-02-25 22:41:54.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (130, CAST(N'2019-02-25 22:42:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (131, CAST(N'2019-02-25 22:43:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增用户成功:admin2/陈生')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (132, CAST(N'2019-02-25 22:43:36.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin2/陈生')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (133, CAST(N'2019-02-25 22:44:54.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin2/陈生生')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (134, CAST(N'2019-02-25 22:45:35.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin2/陈生生')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (135, CAST(N'2019-02-25 22:47:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin2/陈生生')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (136, CAST(N'2019-02-25 22:49:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (137, CAST(N'2019-02-25 22:49:24.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (138, CAST(N'2019-02-26 10:03:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (139, CAST(N'2019-02-26 10:12:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (140, CAST(N'2019-02-26 10:42:23.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin2/陈生生')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (141, CAST(N'2019-02-26 11:50:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (142, CAST(N'2019-02-26 11:51:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (143, CAST(N'2019-02-26 11:51:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑角色成功:系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (144, CAST(N'2019-02-26 11:51:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (145, CAST(N'2019-02-26 11:51:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (146, CAST(N'2019-02-26 11:58:27.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (147, CAST(N'2019-02-26 13:22:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (148, CAST(N'2019-02-26 13:46:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (149, CAST(N'2019-02-26 13:48:47.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑用户成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (150, CAST(N'2019-02-26 13:53:32.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (151, CAST(N'2019-02-26 13:56:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (152, CAST(N'2019-02-26 14:12:44.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (153, CAST(N'2019-02-26 14:47:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (154, CAST(N'2019-02-26 14:47:54.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (155, CAST(N'2019-02-26 14:51:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (156, CAST(N'2019-02-26 14:52:10.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (157, CAST(N'2019-02-26 15:41:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (158, CAST(N'2019-02-26 15:41:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (159, CAST(N'2019-02-26 16:01:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (160, CAST(N'2019-02-26 16:01:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (161, CAST(N'2019-02-26 16:20:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (162, CAST(N'2019-02-26 16:32:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (163, CAST(N'2019-02-26 17:00:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (164, CAST(N'2019-02-26 17:03:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (165, CAST(N'2019-02-26 17:06:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (166, CAST(N'2019-02-26 17:22:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (167, CAST(N'2019-02-26 17:24:25.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (168, CAST(N'2019-02-26 17:27:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (169, CAST(N'2019-02-26 17:29:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (170, CAST(N'2019-02-26 17:30:28.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (171, CAST(N'2019-02-26 17:30:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (172, CAST(N'2019-02-26 22:16:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (173, CAST(N'2019-02-26 22:16:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'重置密码成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (174, CAST(N'2019-02-26 22:18:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'重置密码成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (175, CAST(N'2019-02-26 22:18:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (176, CAST(N'2019-02-26 22:20:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增线体成功:/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (177, CAST(N'2019-02-26 22:22:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (178, CAST(N'2019-02-26 22:23:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00001/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (179, CAST(N'2019-02-26 22:25:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增线体成功:/FANUC-TL2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (180, CAST(N'2019-02-26 22:29:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (181, CAST(N'2019-02-26 22:29:52.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00002/FANUC-TL2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (182, CAST(N'2019-02-26 22:30:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00002/FANUC-TL2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (183, CAST(N'2019-02-26 22:30:47.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00001/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (184, CAST(N'2019-02-26 22:31:00.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00001/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (185, CAST(N'2019-02-26 22:32:40.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00001/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (186, CAST(N'2019-02-26 22:34:08.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00001/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (187, CAST(N'2019-02-26 22:35:17.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00001/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (188, CAST(N'2019-02-26 22:36:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除线体成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (189, CAST(N'2019-02-27 09:57:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (190, CAST(N'2019-02-27 09:57:48.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑线体成功:FANUC00001/FANUC-TL1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (191, CAST(N'2019-02-27 15:51:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (192, CAST(N'2019-02-27 15:54:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增仓储区域成功:FANUC_W00001/底盘区域')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (193, CAST(N'2019-02-27 15:55:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增仓储区域成功:FANUC_W00002/内饰区域')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (194, CAST(N'2019-02-27 15:56:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增仓储区域成功:FANUC_W00003/内饰区域')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (195, CAST(N'2019-02-27 15:58:37.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑仓储区域成功:FANUC_W00002/内饰区域2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (196, CAST(N'2019-02-27 15:58:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除仓储区域成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (197, CAST(N'2019-02-27 16:00:52.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑仓储区域成功:FANUC_W00001/底盘区域2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (198, CAST(N'2019-02-27 16:02:22.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑仓储区域成功:FANUC_W00001/底盘区域2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (199, CAST(N'2019-02-27 16:03:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (200, CAST(N'2019-02-27 16:06:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增仓位成功:FANUC_W00001/底盘2-01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (201, CAST(N'2019-02-27 16:26:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (202, CAST(N'2019-02-27 16:35:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (203, CAST(N'2019-02-27 16:37:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (204, CAST(N'2019-02-27 16:39:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增仓位成功:FANUC_W00002/内饰仓位1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (205, CAST(N'2019-02-27 16:39:17.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑仓位成功:FANUC_S00001/底盘2-01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (206, CAST(N'2019-02-27 16:39:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除仓位成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (207, CAST(N'2019-02-27 16:40:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增仓位成功:FANUC_W00003/内饰仓位4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (208, CAST(N'2019-02-27 21:49:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (209, CAST(N'2019-02-27 21:50:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (210, CAST(N'2019-02-27 22:50:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (211, CAST(N'2019-02-28 10:29:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (212, CAST(N'2019-02-28 10:48:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (213, CAST(N'2019-02-28 10:48:59.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (214, CAST(N'2019-02-28 10:49:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (215, CAST(N'2019-02-28 10:52:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (216, CAST(N'2019-02-28 10:54:03.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (217, CAST(N'2019-02-28 10:55:40.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (218, CAST(N'2019-02-28 10:56:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (219, CAST(N'2019-02-28 10:57:38.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (220, CAST(N'2019-02-28 10:58:23.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (221, CAST(N'2019-02-28 11:00:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (222, CAST(N'2019-02-28 11:01:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (223, CAST(N'2019-02-28 11:02:21.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (224, CAST(N'2019-02-28 11:10:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (225, CAST(N'2019-02-28 11:11:30.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑物料成功:FANUC_M00004/半轴（左）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (226, CAST(N'2019-02-28 11:22:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增物料成功:FANUC_M00004/油箱')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (227, CAST(N'2019-02-28 11:32:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (228, CAST(N'2019-02-28 11:40:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (229, CAST(N'2019-02-28 12:01:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增物料成功:FANUC_M00003/半轴（右）')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (230, CAST(N'2019-02-28 14:45:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (231, CAST(N'2019-02-28 15:12:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (232, CAST(N'2019-02-28 16:20:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (233, CAST(N'2019-02-28 16:30:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (234, CAST(N'2019-02-28 16:45:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (235, CAST(N'2019-02-28 17:24:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (236, CAST(N'2019-02-28 17:29:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (237, CAST(N'2019-02-28 17:30:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新库存成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (238, CAST(N'2019-02-28 17:35:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (239, CAST(N'2019-02-28 17:38:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (240, CAST(N'2019-02-28 17:38:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新库存成功:|6_10|5_0|4_0|3_0|2_0')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (241, CAST(N'2019-02-28 17:38:52.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新库存成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (242, CAST(N'2019-02-28 20:25:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (243, CAST(N'2019-02-28 20:25:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (244, CAST(N'2019-02-28 20:26:13.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新库存成功:|6_10|5_10|4_0|3_0|2_0')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (245, CAST(N'2019-02-28 20:26:18.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新库存成功:|6_10|5_10|4_12|3_0|2_0')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (246, CAST(N'2019-02-28 20:30:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (247, CAST(N'2019-02-28 20:30:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增用户成功:chenqin/陈秦')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (248, CAST(N'2019-02-28 20:31:03.000' AS DateTime), N'chenqin', N'陈秦', N'测试', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (249, CAST(N'2019-02-28 20:31:09.000' AS DateTime), N'chenqin', N'陈秦', N'测试', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (250, CAST(N'2019-02-28 20:31:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (251, CAST(N'2019-02-28 20:33:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑本人用户信息成功:admin/系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (252, CAST(N'2019-02-28 20:33:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (253, CAST(N'2019-02-28 20:38:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (254, CAST(N'2019-02-28 20:39:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (255, CAST(N'2019-02-28 20:41:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (256, CAST(N'2019-02-28 20:42:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (257, CAST(N'2019-02-28 20:49:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (258, CAST(N'2019-02-28 22:19:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (259, CAST(N'2019-02-28 22:23:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增Andon成功:FANUC_Andon00001/andon01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (260, CAST(N'2019-02-28 22:26:17.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑Andon成功:andon01/andon01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (261, CAST(N'2019-02-28 22:31:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (262, CAST(N'2019-02-28 22:31:29.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑Andon成功:andon01/andon01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (263, CAST(N'2019-02-28 22:31:41.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除Andon成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (264, CAST(N'2019-02-28 22:31:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增Andon成功:FANUC_Andon00001/andon02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (265, CAST(N'2019-02-28 22:32:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增Andon成功:FANUC_Andon00003/andon03')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (266, CAST(N'2019-03-01 16:19:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (267, CAST(N'2019-03-01 16:55:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增产品成功:P20190301/气门')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (268, CAST(N'2019-03-01 16:59:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑产品成功:P20190301/气门2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (269, CAST(N'2019-03-01 17:04:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增产品成功:P20190302/气缸')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (270, CAST(N'2019-03-01 17:04:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除产品成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (271, CAST(N'2019-03-01 17:09:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (272, CAST(N'2019-03-04 10:54:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (273, CAST(N'2019-03-04 11:21:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (274, CAST(N'2019-03-04 11:26:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增ERP接口基本信息成功；')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (275, CAST(N'2019-03-04 11:29:38.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑ERP接口基本信息成功；')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (276, CAST(N'2019-03-04 11:30:49.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑ERP接口基本信息成功；')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (277, CAST(N'2019-03-04 11:33:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑ERP接口基本信息成功；')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (278, CAST(N'2019-03-04 11:37:07.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑ERP接口基本信息成功；')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (279, CAST(N'2019-03-04 11:37:59.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑ERP接口基本信息成功；')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (280, CAST(N'2019-03-04 11:38:39.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新ERP接口字段配置成功:|1_1_12|2_0_0|3_0_0|4_0_0|5_0_0')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (281, CAST(N'2019-03-04 12:18:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (282, CAST(N'2019-03-04 21:19:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (283, CAST(N'2019-03-04 21:21:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (284, CAST(N'2019-03-04 21:34:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增ERP订单成功:P20190304/测试')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (285, CAST(N'2019-03-04 21:39:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (286, CAST(N'2019-03-04 21:48:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (287, CAST(N'2019-03-04 21:49:29.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑ERP订单成功:P20190304/测试')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (288, CAST(N'2019-03-04 21:55:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑ERP订单成功:P20190304/测试')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (289, CAST(N'2019-03-04 22:52:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (290, CAST(N'2019-03-04 22:55:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (291, CAST(N'2019-03-04 22:57:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (292, CAST(N'2019-03-04 22:57:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'分解ERP订单成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (293, CAST(N'2019-03-04 23:03:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (294, CAST(N'2019-03-05 09:25:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (295, CAST(N'2019-03-05 10:52:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (296, CAST(N'2019-03-05 12:08:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (297, CAST(N'2019-03-05 14:36:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (298, CAST(N'2019-03-05 14:36:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (299, CAST(N'2019-03-05 15:00:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (300, CAST(N'2019-03-05 15:00:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_00_1|2_01_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (301, CAST(N'2019-03-05 15:13:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'分解ERP订单成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (302, CAST(N'2019-03-05 15:13:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_00_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (303, CAST(N'2019-03-05 15:26:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单关闭成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (304, CAST(N'2019-03-05 15:48:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (305, CAST(N'2019-03-05 16:23:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (306, CAST(N'2019-03-05 16:59:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (307, CAST(N'2019-03-05 17:05:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_01_1|2_03_1|3_02_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (308, CAST(N'2019-03-05 17:05:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单下达成功:|1|2|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (309, CAST(N'2019-03-06 09:24:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (310, CAST(N'2019-03-06 09:25:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (311, CAST(N'2019-03-06 09:37:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_01_1|2_02_1|3_03_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (312, CAST(N'2019-03-06 09:37:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_01_1|2_03_1|3_02_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (313, CAST(N'2019-03-06 09:39:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_01_1|2_03_1|3_02_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (314, CAST(N'2019-03-06 13:51:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (315, CAST(N'2019-03-06 14:17:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (316, CAST(N'2019-03-06 14:23:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (317, CAST(N'2019-03-06 14:53:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (318, CAST(N'2019-03-06 14:56:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (319, CAST(N'2019-03-06 15:25:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (320, CAST(N'2019-03-06 15:45:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (321, CAST(N'2019-03-06 15:53:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (322, CAST(N'2019-03-06 15:58:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (323, CAST(N'2019-03-06 17:19:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (324, CAST(N'2019-03-06 21:23:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (325, CAST(N'2019-03-06 22:29:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (326, CAST(N'2019-03-06 22:45:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'PLC过程质量问题关闭成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (327, CAST(N'2019-03-06 22:48:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (328, CAST(N'2019-03-06 22:49:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'手工录入过程质量问题关闭成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (329, CAST(N'2019-03-07 10:04:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (330, CAST(N'2019-03-07 10:15:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (331, CAST(N'2019-03-07 10:15:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'PLC过程质量问题关闭成功:|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (332, CAST(N'2019-03-07 11:08:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (333, CAST(N'2019-03-07 11:10:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (334, CAST(N'2019-03-07 11:18:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (335, CAST(N'2019-03-07 11:41:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (336, CAST(N'2019-03-07 11:47:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (337, CAST(N'2019-03-07 11:48:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑角色成功:系统管理员')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (338, CAST(N'2019-03-07 11:48:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (339, CAST(N'2019-03-07 11:48:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (340, CAST(N'2019-03-07 12:12:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (341, CAST(N'2019-03-07 12:17:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (342, CAST(N'2019-03-07 13:08:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (343, CAST(N'2019-03-07 13:23:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (344, CAST(N'2019-03-07 13:35:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (345, CAST(N'2019-03-07 13:41:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (346, CAST(N'2019-03-07 16:47:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (347, CAST(N'2019-03-07 20:11:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (348, CAST(N'2019-03-07 20:13:35.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (349, CAST(N'2019-03-07 20:15:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (350, CAST(N'2019-03-07 20:20:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (351, CAST(N'2019-03-07 20:23:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (352, CAST(N'2019-03-07 20:32:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (353, CAST(N'2019-03-07 20:34:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (354, CAST(N'2019-03-07 20:39:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (355, CAST(N'2019-03-07 20:41:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (356, CAST(N'2019-03-07 20:43:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (357, CAST(N'2019-03-07 20:45:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (358, CAST(N'2019-03-07 20:47:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (359, CAST(N'2019-03-07 21:03:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (360, CAST(N'2019-03-07 21:04:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (361, CAST(N'2019-03-07 21:27:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (362, CAST(N'2019-03-07 21:38:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (363, CAST(N'2019-03-07 21:41:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (364, CAST(N'2019-03-07 22:01:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (365, CAST(N'2019-03-07 22:05:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (366, CAST(N'2019-03-07 22:12:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (367, CAST(N'2019-03-07 22:22:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (368, CAST(N'2019-03-07 22:26:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (369, CAST(N'2019-03-08 09:46:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (370, CAST(N'2019-03-08 09:55:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (371, CAST(N'2019-03-08 10:33:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (372, CAST(N'2019-03-08 10:38:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (373, CAST(N'2019-03-08 14:15:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (374, CAST(N'2019-03-08 14:27:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (375, CAST(N'2019-03-08 14:33:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (376, CAST(N'2019-03-08 14:50:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (377, CAST(N'2019-03-08 14:50:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (378, CAST(N'2019-03-08 15:37:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (379, CAST(N'2019-03-08 15:44:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (380, CAST(N'2019-03-08 16:46:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (381, CAST(N'2019-03-08 17:00:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (382, CAST(N'2019-03-08 17:30:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (383, CAST(N'2019-03-10 16:21:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (384, CAST(N'2019-03-10 16:43:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (385, CAST(N'2019-03-10 17:06:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (386, CAST(N'2019-03-10 17:15:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (387, CAST(N'2019-03-10 17:18:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (388, CAST(N'2019-03-10 18:38:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (389, CAST(N'2019-03-10 18:54:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (390, CAST(N'2019-03-10 21:31:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (391, CAST(N'2019-03-10 21:32:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (392, CAST(N'2019-03-11 10:02:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (393, CAST(N'2019-03-11 10:12:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (394, CAST(N'2019-03-11 10:13:39.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (395, CAST(N'2019-03-11 10:15:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (396, CAST(N'2019-03-11 10:16:05.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (397, CAST(N'2019-03-11 10:16:25.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (398, CAST(N'2019-03-11 10:31:25.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:%u6D4B%u8BD5%u7AD9%u70B9')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (399, CAST(N'2019-03-11 11:03:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (400, CAST(N'2019-03-11 11:10:35.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (401, CAST(N'2019-03-11 11:12:26.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (402, CAST(N'2019-03-11 11:54:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (403, CAST(N'2019-03-11 11:55:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (404, CAST(N'2019-03-11 11:55:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (405, CAST(N'2019-03-11 11:56:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (406, CAST(N'2019-03-11 11:56:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet2555')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (407, CAST(N'2019-03-11 11:58:55.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (408, CAST(N'2019-03-11 11:59:07.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:sheet255555')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (409, CAST(N'2019-03-11 11:59:50.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (410, CAST(N'2019-03-11 11:59:58.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:sheet25555533')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (411, CAST(N'2019-03-11 12:05:07.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (412, CAST(N'2019-03-11 12:05:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:shee4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (413, CAST(N'2019-03-11 12:12:14.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (414, CAST(N'2019-03-11 12:12:30.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:shee444')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (415, CAST(N'2019-03-11 12:12:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet5')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (416, CAST(N'2019-03-11 12:14:00.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (417, CAST(N'2019-03-11 12:14:13.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:sheet56')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (418, CAST(N'2019-03-11 12:14:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet6')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (419, CAST(N'2019-03-11 12:16:26.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (420, CAST(N'2019-03-11 12:17:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:sheet6')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (421, CAST(N'2019-03-11 12:17:14.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:sheet6')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (422, CAST(N'2019-03-11 12:28:37.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:sheet6')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (423, CAST(N'2019-03-11 12:30:18.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:sheet6')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (424, CAST(N'2019-03-11 12:31:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:qq')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (425, CAST(N'2019-03-11 12:34:53.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (426, CAST(N'2019-03-11 12:37:30.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (427, CAST(N'2019-03-11 12:37:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:xx')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (428, CAST(N'2019-03-11 12:40:20.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (429, CAST(N'2019-03-11 13:04:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:111')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (430, CAST(N'2019-03-11 13:06:21.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (431, CAST(N'2019-03-11 13:06:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (432, CAST(N'2019-03-11 13:12:26.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (433, CAST(N'2019-03-11 13:13:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (434, CAST(N'2019-03-11 13:14:44.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (435, CAST(N'2019-03-11 13:15:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:shhe')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (436, CAST(N'2019-03-11 13:18:18.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (437, CAST(N'2019-03-11 13:18:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:34')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (438, CAST(N'2019-03-11 13:21:46.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (439, CAST(N'2019-03-11 13:22:06.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (440, CAST(N'2019-03-11 13:22:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:34')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (441, CAST(N'2019-03-11 13:22:50.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:34')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (442, CAST(N'2019-03-11 13:23:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点工艺成功:34')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (443, CAST(N'2019-03-11 13:23:20.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (444, CAST(N'2019-03-11 13:24:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (445, CAST(N'2019-03-11 15:13:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (446, CAST(N'2019-03-11 15:13:31.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (447, CAST(N'2019-03-11 15:15:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (448, CAST(N'2019-03-11 15:17:14.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (449, CAST(N'2019-03-11 15:22:06.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (450, CAST(N'2019-03-11 15:38:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (451, CAST(N'2019-03-11 15:38:41.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (452, CAST(N'2019-03-11 15:39:46.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点过程质量信息成功:确认支撑是否安装')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (453, CAST(N'2019-03-11 15:41:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除站点工艺信息:15/34')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (454, CAST(N'2019-03-11 15:42:34.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除站点工艺信息:14/34')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (455, CAST(N'2019-03-11 15:43:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点过程质量信息成功:真的吗')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (456, CAST(N'2019-03-11 15:45:55.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (457, CAST(N'2019-03-11 15:47:28.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (458, CAST(N'2019-03-11 15:48:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除站点过程质量信息:2/真的吗')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (459, CAST(N'2019-03-11 16:13:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (460, CAST(N'2019-03-11 16:13:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (461, CAST(N'2019-03-11 16:14:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (462, CAST(N'2019-03-11 16:14:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点过程质量信息成功:qq')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (463, CAST(N'2019-03-11 16:50:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (464, CAST(N'2019-03-11 16:51:49.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (465, CAST(N'2019-03-11 16:58:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (466, CAST(N'2019-03-11 16:58:51.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (467, CAST(N'2019-03-11 16:59:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点零件追溯信息成功:扫描天窗')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (468, CAST(N'2019-03-11 17:00:16.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (469, CAST(N'2019-03-11 17:00:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点零件追溯信息成功:扫描天线基座')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (470, CAST(N'2019-03-11 17:00:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除站点零件追溯信息:2/扫描天线基座')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (471, CAST(N'2019-03-11 17:03:26.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (472, CAST(N'2019-03-11 17:13:08.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (473, CAST(N'2019-03-11 17:19:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (474, CAST(N'2019-03-11 17:19:33.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (475, CAST(N'2019-03-11 17:25:44.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (476, CAST(N'2019-03-11 17:28:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (477, CAST(N'2019-03-11 17:29:48.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (478, CAST(N'2019-03-12 15:17:27.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1459, CAST(N'2019-03-12 15:48:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1460, CAST(N'2019-03-12 15:51:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1461, CAST(N'2019-03-12 15:55:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1462, CAST(N'2019-03-12 15:57:01.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1463, CAST(N'2019-03-12 16:08:12.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1464, CAST(N'2019-03-12 16:08:16.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1465, CAST(N'2019-03-12 16:11:53.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1466, CAST(N'2019-03-12 16:12:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1467, CAST(N'2019-03-12 16:15:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1468, CAST(N'2019-03-12 16:18:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1469, CAST(N'2019-03-12 16:19:01.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1470, CAST(N'2019-03-12 16:19:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:去去去')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1471, CAST(N'2019-03-12 16:20:10.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板明细成功:去去去')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1472, CAST(N'2019-03-12 16:26:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板成功:qq')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1473, CAST(N'2019-03-12 16:26:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:qq')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1474, CAST(N'2019-03-12 16:29:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1475, CAST(N'2019-03-12 16:29:54.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1476, CAST(N'2019-03-12 16:30:00.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:qq')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1477, CAST(N'2019-03-12 16:30:13.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1478, CAST(N'2019-03-12 16:30:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:33')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1479, CAST(N'2019-03-12 16:33:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板成功:PLC模板2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1480, CAST(N'2019-03-12 16:33:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:33')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1481, CAST(N'2019-03-12 16:33:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除PLC模板成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1482, CAST(N'2019-03-12 16:42:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1483, CAST(N'2019-03-12 16:42:39.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1484, CAST(N'2019-03-12 16:44:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1485, CAST(N'2019-03-12 16:44:46.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1486, CAST(N'2019-03-12 22:44:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1487, CAST(N'2019-03-12 22:53:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1488, CAST(N'2019-03-12 22:54:56.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1489, CAST(N'2019-03-12 22:56:24.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1490, CAST(N'2019-03-12 22:57:21.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1491, CAST(N'2019-03-12 23:00:11.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1492, CAST(N'2019-03-12 23:05:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1493, CAST(N'2019-03-12 23:05:49.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1494, CAST(N'2019-03-12 23:09:11.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1495, CAST(N'2019-03-12 23:10:00.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1496, CAST(N'2019-03-12 23:11:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1497, CAST(N'2019-03-12 23:13:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1498, CAST(N'2019-03-12 23:15:29.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1499, CAST(N'2019-03-12 23:19:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1500, CAST(N'2019-03-12 23:20:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1501, CAST(N'2019-03-12 23:24:05.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1502, CAST(N'2019-03-12 23:24:23.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1503, CAST(N'2019-03-12 23:24:49.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1504, CAST(N'2019-03-12 23:26:27.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1505, CAST(N'2019-03-12 23:30:46.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1506, CAST(N'2019-03-12 23:30:49.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1507, CAST(N'2019-03-13 08:50:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1508, CAST(N'2019-03-13 08:51:18.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1509, CAST(N'2019-03-13 08:51:22.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1510, CAST(N'2019-03-13 08:51:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点PLCAP信息成功:qw')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1511, CAST(N'2019-03-13 08:52:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点PLCAP信息成功:qw')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1512, CAST(N'2019-03-13 08:52:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点PLCAP信息成功:we')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1513, CAST(N'2019-03-13 08:52:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除站点PLCAP信息:2/we')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1514, CAST(N'2019-03-13 08:54:12.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1515, CAST(N'2019-03-13 08:54:16.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1516, CAST(N'2019-03-13 08:57:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1517, CAST(N'2019-03-13 08:57:36.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1518, CAST(N'2019-03-13 08:57:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1519, CAST(N'2019-03-13 09:02:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1520, CAST(N'2019-03-13 09:02:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1521, CAST(N'2019-03-13 09:02:46.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1522, CAST(N'2019-03-13 09:03:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点PLCAP信息成功:qwe')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1523, CAST(N'2019-03-13 09:03:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点PLCAP信息成功:qwe')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1524, CAST(N'2019-03-13 09:03:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点PLCAP信息成功:EWWRW')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1525, CAST(N'2019-03-13 09:04:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除站点PLCAP信息:2/EWWRW')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1526, CAST(N'2019-03-13 09:04:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点PLCAP信息成功:TTTT')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1527, CAST(N'2019-03-13 09:04:54.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1528, CAST(N'2019-03-13 09:04:57.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1529, CAST(N'2019-03-13 09:07:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点工艺成功:sheet1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1530, CAST(N'2019-03-13 09:10:37.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1531, CAST(N'2019-03-13 09:10:45.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1532, CAST(N'2019-03-13 09:14:49.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1533, CAST(N'2019-03-13 09:16:17.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1534, CAST(N'2019-03-13 09:16:20.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1535, CAST(N'2019-03-13 09:18:14.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1536, CAST(N'2019-03-13 09:18:16.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1537, CAST(N'2019-03-13 09:51:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1538, CAST(N'2019-03-13 09:51:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1539, CAST(N'2019-03-13 10:01:07.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1540, CAST(N'2019-03-13 10:01:53.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1541, CAST(N'2019-03-13 10:02:40.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1542, CAST(N'2019-03-13 10:09:27.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1543, CAST(N'2019-03-13 10:12:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1544, CAST(N'2019-03-13 10:12:35.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1545, CAST(N'2019-03-13 10:15:46.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1546, CAST(N'2019-03-13 10:19:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1547, CAST(N'2019-03-13 10:19:47.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1548, CAST(N'2019-03-13 10:22:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:C0102323')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1549, CAST(N'2019-03-13 11:03:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1550, CAST(N'2019-03-13 11:03:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'设置站点状态成功:|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1551, CAST(N'2019-03-13 11:04:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'设置站点状态成功:|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1552, CAST(N'2019-03-13 11:04:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除产品成功:|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1553, CAST(N'2019-03-13 11:08:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1554, CAST(N'2019-03-13 11:08:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除站点成功:|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1555, CAST(N'2019-03-13 12:19:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1556, CAST(N'2019-03-13 13:36:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1557, CAST(N'2019-03-13 14:23:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1558, CAST(N'2019-03-13 14:42:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增BOM信息成功:15/FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1559, CAST(N'2019-03-13 14:49:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增BOM信息成功:15/A0004')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1560, CAST(N'2019-03-13 14:49:41.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增BOM信息成功:15/J0001')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1561, CAST(N'2019-03-13 14:49:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除BOM信息:1/FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1562, CAST(N'2019-03-13 14:50:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增BOM信息成功:16/J0001')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1563, CAST(N'2019-03-13 17:29:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1564, CAST(N'2019-03-13 17:29:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1565, CAST(N'2019-03-13 20:22:35.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1566, CAST(N'2019-03-13 20:22:41.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1567, CAST(N'2019-03-13 20:23:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1568, CAST(N'2019-03-13 20:31:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1569, CAST(N'2019-03-13 20:34:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1570, CAST(N'2019-03-13 20:44:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1571, CAST(N'2019-03-14 08:55:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1572, CAST(N'2019-03-14 09:17:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1573, CAST(N'2019-03-14 10:08:20.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1574, CAST(N'2019-03-14 10:12:27.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1575, CAST(N'2019-03-14 10:48:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1576, CAST(N'2019-03-14 11:06:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1577, CAST(N'2019-03-14 11:07:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1578, CAST(N'2019-03-14 12:02:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1579, CAST(N'2019-03-14 12:21:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1580, CAST(N'2019-03-14 12:23:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1581, CAST(N'2019-03-14 15:53:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1582, CAST(N'2019-03-14 16:00:07.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑设备成功:内饰线')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1583, CAST(N'2019-03-14 16:20:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增设备成功:C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1584, CAST(N'2019-03-14 16:22:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增故障代码信息成功:01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1585, CAST(N'2019-03-14 16:23:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增故障代码信息成功:02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1586, CAST(N'2019-03-14 16:25:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除故障代码信息:2/02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1587, CAST(N'2019-03-14 16:48:32.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑设备成功:C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1588, CAST(N'2019-03-14 16:56:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1589, CAST(N'2019-03-14 16:56:50.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑设备成功:C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1590, CAST(N'2019-03-14 16:58:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增设备成功:C02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1591, CAST(N'2019-03-14 17:02:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1592, CAST(N'2019-03-14 17:05:53.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑设备成功:C02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1593, CAST(N'2019-03-14 17:21:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1594, CAST(N'2019-03-14 17:34:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1595, CAST(N'2019-03-14 20:34:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1596, CAST(N'2019-03-14 20:41:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1597, CAST(N'2019-03-14 20:43:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增角色成功:测试5')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1598, CAST(N'2019-03-14 20:43:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1599, CAST(N'2019-03-14 20:49:57.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑角色成功:测试5')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1600, CAST(N'2019-03-14 20:49:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1601, CAST(N'2019-03-14 21:17:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1602, CAST(N'2019-03-14 22:09:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1603, CAST(N'2019-03-15 10:25:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1604, CAST(N'2019-03-15 10:31:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1605, CAST(N'2019-03-15 10:37:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除设备故障提醒设置成功:4/')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1606, CAST(N'2019-03-15 12:17:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1607, CAST(N'2019-03-15 13:50:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1608, CAST(N'2019-03-15 13:56:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1609, CAST(N'2019-03-15 14:01:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1610, CAST(N'2019-03-15 14:47:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1611, CAST(N'2019-03-15 14:49:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1612, CAST(N'2019-03-15 14:52:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1613, CAST(N'2019-03-15 14:54:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1614, CAST(N'2019-03-15 14:56:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置设备提醒成功:4/C02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1615, CAST(N'2019-03-15 14:56:34.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置设备提醒成功:4/C02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1616, CAST(N'2019-03-15 14:56:52.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置设备提醒成功:3/C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1617, CAST(N'2019-03-15 14:59:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置设备提醒成功:3/C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1618, CAST(N'2019-03-16 11:49:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1619, CAST(N'2019-03-16 11:50:13.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置设备提醒成功:3/C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1620, CAST(N'2019-03-16 11:50:33.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置设备提醒成功:3/C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1621, CAST(N'2019-03-16 11:55:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1622, CAST(N'2019-03-16 11:58:28.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1623, CAST(N'2019-03-16 11:58:46.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1624, CAST(N'2019-03-16 12:02:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1625, CAST(N'2019-03-16 12:03:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1626, CAST(N'2019-03-16 12:05:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1627, CAST(N'2019-03-16 12:08:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1628, CAST(N'2019-03-16 12:15:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1629, CAST(N'2019-03-16 12:55:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1630, CAST(N'2019-03-16 13:10:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1631, CAST(N'2019-03-16 13:10:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1632, CAST(N'2019-03-16 13:13:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1633, CAST(N'2019-03-16 13:19:25.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1634, CAST(N'2019-03-16 13:19:30.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1635, CAST(N'2019-03-16 13:22:12.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:测试站点')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1636, CAST(N'2019-03-16 13:23:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:PLC模板1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1637, CAST(N'2019-03-16 13:25:26.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑站点基本信息成功:PLC01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1638, CAST(N'2019-03-16 13:28:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增BOM信息成功:15/A0004')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1639, CAST(N'2019-03-16 13:48:52.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置设备提醒成功:3/C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1640, CAST(N'2019-03-16 14:07:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_01_1|2_02_1|3_03_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1641, CAST(N'2019-03-16 15:29:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1642, CAST(N'2019-03-17 21:15:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1643, CAST(N'2019-03-17 21:22:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1644, CAST(N'2019-03-17 21:48:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (1645, CAST(N'2019-03-17 22:03:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2618, CAST(N'2019-03-18 13:56:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2619, CAST(N'2019-03-18 14:03:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2620, CAST(N'2019-03-18 16:55:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2621, CAST(N'2019-03-18 17:03:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2622, CAST(N'2019-03-18 20:56:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2623, CAST(N'2019-03-18 21:07:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2624, CAST(N'2019-03-18 22:38:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2625, CAST(N'2019-03-18 22:49:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2626, CAST(N'2019-03-19 09:40:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2627, CAST(N'2019-03-19 09:48:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2628, CAST(N'2019-03-19 09:50:44.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2629, CAST(N'2019-03-19 09:50:50.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2630, CAST(N'2019-03-19 09:50:53.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2631, CAST(N'2019-03-19 09:50:54.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2632, CAST(N'2019-03-19 09:50:57.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2633, CAST(N'2019-03-19 09:51:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2634, CAST(N'2019-03-19 10:09:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2635, CAST(N'2019-03-19 10:23:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2636, CAST(N'2019-03-19 10:25:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2637, CAST(N'2019-03-19 13:26:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2638, CAST(N'2019-03-19 13:30:13.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2639, CAST(N'2019-03-19 13:42:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2640, CAST(N'2019-03-19 13:47:11.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2641, CAST(N'2019-03-19 13:47:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2642, CAST(N'2019-03-19 13:48:00.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2643, CAST(N'2019-03-19 13:48:25.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2644, CAST(N'2019-03-19 13:48:30.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2645, CAST(N'2019-03-19 13:53:43.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2646, CAST(N'2019-03-19 13:54:25.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2647, CAST(N'2019-03-19 13:54:41.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置工作日成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2648, CAST(N'2019-03-19 15:08:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2649, CAST(N'2019-03-19 15:18:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2650, CAST(N'2019-03-19 15:19:13.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置班次成功!')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2651, CAST(N'2019-03-19 15:26:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2652, CAST(N'2019-03-19 16:02:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2653, CAST(N'2019-03-19 16:31:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2654, CAST(N'2019-03-19 16:31:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增小休成功:01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2655, CAST(N'2019-03-19 16:32:08.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑小休成功:0101')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2656, CAST(N'2019-03-19 16:32:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除小休成功:1/0101')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2657, CAST(N'2019-03-19 16:35:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2658, CAST(N'2019-03-19 16:38:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2659, CAST(N'2019-03-19 16:54:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2660, CAST(N'2019-03-19 21:24:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2661, CAST(N'2019-03-20 12:02:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2662, CAST(N'2019-03-20 12:21:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2663, CAST(N'2019-03-20 14:02:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2664, CAST(N'2019-03-20 14:07:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2665, CAST(N'2019-03-20 15:29:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2666, CAST(N'2019-03-20 16:56:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2667, CAST(N'2019-03-20 17:16:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2668, CAST(N'2019-03-20 21:07:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2669, CAST(N'2019-03-20 21:27:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2670, CAST(N'2019-03-20 21:34:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2671, CAST(N'2019-03-20 21:34:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增转储单成功:FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2672, CAST(N'2019-03-20 22:08:21.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑转储单成功:FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2673, CAST(N'2019-03-20 22:09:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2674, CAST(N'2019-03-20 22:23:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2675, CAST(N'2019-03-20 22:26:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2676, CAST(N'2019-03-20 22:27:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'确认转储单成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2677, CAST(N'2019-03-20 22:27:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2678, CAST(N'2019-03-20 22:28:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'确认转储单成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2679, CAST(N'2019-03-20 22:31:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增转储单成功:FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2680, CAST(N'2019-03-20 22:34:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2681, CAST(N'2019-03-20 22:34:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'确认转储单成功:2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2682, CAST(N'2019-03-20 22:35:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2683, CAST(N'2019-03-20 22:36:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增转储单成功:FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2684, CAST(N'2019-03-20 22:39:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2685, CAST(N'2019-03-20 22:40:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2686, CAST(N'2019-03-20 22:40:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'确认转储单成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2687, CAST(N'2019-03-20 23:06:18.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑转储单成功:FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2688, CAST(N'2019-03-20 23:06:32.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑转储单成功:FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2689, CAST(N'2019-03-20 23:14:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2690, CAST(N'2019-03-20 23:19:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2691, CAST(N'2019-03-20 23:22:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2692, CAST(N'2019-03-20 23:39:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2693, CAST(N'2019-03-20 23:40:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增转储单成功:FANUC_M00003')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2694, CAST(N'2019-03-21 08:49:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2695, CAST(N'2019-03-21 15:24:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2696, CAST(N'2019-03-21 15:57:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2697, CAST(N'2019-03-21 16:04:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2698, CAST(N'2019-03-21 16:12:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2699, CAST(N'2019-03-21 16:15:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2700, CAST(N'2019-03-21 16:16:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增刀具成功:CUTX1-0001')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2701, CAST(N'2019-03-21 16:22:47.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新当前加工次数成功:|1_10')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2702, CAST(N'2019-03-21 16:37:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2703, CAST(N'2019-03-21 16:37:44.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑刀具成功:CUTX1-0001')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2704, CAST(N'2019-03-21 16:38:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增刀具成功:CUTX2-0001')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2705, CAST(N'2019-03-21 16:38:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除刀具成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2706, CAST(N'2019-03-21 16:40:03.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新当前加工次数成功:|1_100')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2707, CAST(N'2019-03-21 16:47:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2708, CAST(N'2019-03-21 16:48:46.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2709, CAST(N'2019-03-22 11:47:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2710, CAST(N'2019-03-22 11:57:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增零件落点成功:C01-01-01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2711, CAST(N'2019-03-22 12:04:31.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑零件落点成功:C01-01-01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2712, CAST(N'2019-03-22 12:17:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2713, CAST(N'2019-03-22 12:21:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增零件落点成功:C01-01-02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2714, CAST(N'2019-03-22 12:21:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除零件落点成功:|1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2715, CAST(N'2019-03-22 13:25:41.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2716, CAST(N'2019-03-22 13:26:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新线边库存数量成功:|2_100')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2717, CAST(N'2019-03-22 13:29:24.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新线边库存数量成功:|2_29')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2718, CAST(N'2019-03-22 13:29:32.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'更新线边库存数量成功:|2_29')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2719, CAST(N'2019-03-24 21:24:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2720, CAST(N'2019-03-24 21:27:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2721, CAST(N'2019-03-24 21:28:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2722, CAST(N'2019-03-24 21:32:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2723, CAST(N'2019-03-24 21:36:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2724, CAST(N'2019-03-24 21:47:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2725, CAST(N'2019-03-24 21:49:35.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2726, CAST(N'2019-03-24 21:51:17.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2727, CAST(N'2019-03-24 21:52:27.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2728, CAST(N'2019-03-24 21:53:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2729, CAST(N'2019-03-24 22:01:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2730, CAST(N'2019-03-24 22:05:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2731, CAST(N'2019-03-24 22:08:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2732, CAST(N'2019-03-24 22:18:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2733, CAST(N'2019-03-24 22:20:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2734, CAST(N'2019-03-24 22:26:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2735, CAST(N'2019-03-24 22:32:07.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2736, CAST(N'2019-03-24 22:33:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2737, CAST(N'2019-03-24 22:35:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2738, CAST(N'2019-03-24 22:43:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2739, CAST(N'2019-03-24 22:44:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2740, CAST(N'2019-03-24 22:49:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2741, CAST(N'2019-03-24 22:50:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2742, CAST(N'2019-03-24 22:52:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2743, CAST(N'2019-03-24 22:55:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2744, CAST(N'2019-03-24 23:08:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2745, CAST(N'2019-03-24 23:10:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2746, CAST(N'2019-03-24 23:12:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2747, CAST(N'2019-03-24 23:16:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2748, CAST(N'2019-03-24 23:17:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2749, CAST(N'2019-03-24 23:19:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2750, CAST(N'2019-03-24 23:20:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2751, CAST(N'2019-03-24 23:26:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2752, CAST(N'2019-03-24 23:27:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2753, CAST(N'2019-03-24 23:28:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2754, CAST(N'2019-03-24 23:31:46.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2755, CAST(N'2019-03-24 23:32:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2756, CAST(N'2019-03-25 09:33:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2757, CAST(N'2019-03-25 09:40:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增零件落点成功:C01-01-03')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2758, CAST(N'2019-03-25 09:58:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2759, CAST(N'2019-03-25 10:00:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2760, CAST(N'2019-03-25 10:01:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印拣料单成功:|1|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2761, CAST(N'2019-03-25 10:04:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2762, CAST(N'2019-03-25 10:06:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印拣料单成功:|1|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2763, CAST(N'2019-03-25 10:08:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印拣料单成功:|1|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2764, CAST(N'2019-03-25 10:18:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2765, CAST(N'2019-03-25 10:20:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2766, CAST(N'2019-03-25 10:22:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印拣料单成功:|1|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2767, CAST(N'2019-03-25 10:33:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2768, CAST(N'2019-03-25 10:34:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印拣料单成功:|1|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2769, CAST(N'2019-03-25 11:33:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2770, CAST(N'2019-03-25 11:37:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2771, CAST(N'2019-03-25 11:40:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2772, CAST(N'2019-03-25 11:43:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2773, CAST(N'2019-03-25 11:48:31.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2774, CAST(N'2019-03-25 11:49:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印拣料单成功:|1|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2775, CAST(N'2019-03-26 10:39:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2776, CAST(N'2019-03-26 10:40:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2777, CAST(N'2019-03-26 12:04:27.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2778, CAST(N'2019-03-26 12:08:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2779, CAST(N'2019-03-26 12:09:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增故障通知单成功:1号机器人挂了')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2780, CAST(N'2019-03-26 12:15:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2781, CAST(N'2019-03-26 12:33:41.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2782, CAST(N'2019-03-26 12:33:57.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑故障通知单成功:1号机器人挂了')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2783, CAST(N'2019-03-26 12:34:24.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑故障通知单成功:1号机器人挂了')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2784, CAST(N'2019-03-26 13:35:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2785, CAST(N'2019-03-26 13:36:03.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑故障通知单成功:1号机器人挂了')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2786, CAST(N'2019-03-26 16:33:46.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2787, CAST(N'2019-03-26 16:43:34.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2788, CAST(N'2019-03-26 17:00:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'查询角色权限！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2789, CAST(N'2019-03-26 17:34:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2790, CAST(N'2019-03-27 10:38:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2791, CAST(N'2019-03-28 12:29:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2792, CAST(N'2019-03-28 13:32:21.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2793, CAST(N'2019-03-28 16:34:58.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2794, CAST(N'2019-03-28 16:35:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增日常维护任务成功:维护1号机器人')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2795, CAST(N'2019-03-28 17:19:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2796, CAST(N'2019-03-28 17:19:29.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2797, CAST(N'2019-03-28 17:30:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2798, CAST(N'2019-03-28 17:32:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2799, CAST(N'2019-03-28 17:32:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2800, CAST(N'2019-03-28 20:57:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2801, CAST(N'2019-03-28 20:57:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2802, CAST(N'2019-03-28 20:58:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除维护设备信息:4/C02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2803, CAST(N'2019-03-28 20:58:40.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除维护设备信息:4/C02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2804, CAST(N'2019-03-28 20:58:42.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除维护设备信息:4/C02')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2805, CAST(N'2019-03-28 21:07:34.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2806, CAST(N'2019-03-28 21:09:02.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护设备信息成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2807, CAST(N'2019-03-28 21:21:56.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护设备信息成功:4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2808, CAST(N'2019-03-28 21:22:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2809, CAST(N'2019-03-28 21:22:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除维护设备信息:3/C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2810, CAST(N'2019-03-28 21:23:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除维护设备信息:2/C01')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2811, CAST(N'2019-03-28 21:27:16.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2812, CAST(N'2019-03-28 21:31:55.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除AM指导书成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2813, CAST(N'2019-03-28 21:35:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护任务提醒内容信息成功:不要忘记啊赶紧开搞')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2814, CAST(N'2019-03-28 21:35:21.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护任务提醒内容信息成功:不要忘记啊赶紧开搞2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2815, CAST(N'2019-03-28 21:39:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2816, CAST(N'2019-03-28 21:40:12.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护任务提醒内容信息成功:不要忘记啊赶紧开搞2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2817, CAST(N'2019-03-28 21:40:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护任务提醒内容信息成功:不要忘记啊赶紧开搞2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2818, CAST(N'2019-03-28 21:40:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除维护任务提醒内容信息成功:2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2819, CAST(N'2019-03-28 21:47:38.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增日常维护任务成功:2号机器人维护任务')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2820, CAST(N'2019-03-28 21:48:56.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2821, CAST(N'2019-03-28 21:52:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2822, CAST(N'2019-03-28 21:53:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增日常维护任务成功:3号机器人维护任务')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2823, CAST(N'2019-03-28 21:53:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2824, CAST(N'2019-03-28 21:53:44.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2825, CAST(N'2019-03-28 21:54:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护任务提醒内容信息成功:111111')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2826, CAST(N'2019-03-28 21:54:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'删除日常维护任务成功:|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2827, CAST(N'2019-03-28 21:59:53.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑日常维护任务成功:维护1号机器人')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2828, CAST(N'2019-03-28 22:00:01.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑日常维护任务成功:维护1号机器人')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2829, CAST(N'2019-03-28 22:01:12.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑日常维护任务成功:维护1号机器人')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2830, CAST(N'2019-03-28 22:02:24.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑日常维护任务成功:维护1号机器人')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2831, CAST(N'2019-03-28 22:04:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2832, CAST(N'2019-03-28 22:05:03.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑日常维护任务成功:维护1号机器人')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2833, CAST(N'2019-03-28 22:13:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2834, CAST(N'2019-03-28 22:13:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2835, CAST(N'2019-03-28 22:16:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2836, CAST(N'2019-03-28 22:18:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2837, CAST(N'2019-03-28 22:18:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2838, CAST(N'2019-03-29 11:59:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2839, CAST(N'2019-03-29 12:01:19.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护任务内容信息成功:开搞')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2840, CAST(N'2019-03-29 12:06:32.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护任务内容信息成功:开搞，完成')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2841, CAST(N'2019-03-29 15:37:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2842, CAST(N'2019-03-30 12:31:25.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2843, CAST(N'2019-03-30 12:34:34.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2844, CAST(N'2019-03-30 12:36:06.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2845, CAST(N'2019-03-30 12:38:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2846, CAST(N'2019-03-30 12:39:05.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2847, CAST(N'2019-03-30 12:39:24.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2848, CAST(N'2019-03-30 12:44:34.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2849, CAST(N'2019-03-30 12:50:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2850, CAST(N'2019-03-30 12:55:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2851, CAST(N'2019-03-30 12:59:29.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2852, CAST(N'2019-03-30 13:55:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2853, CAST(N'2019-03-30 14:01:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增日常维护任务成功:月度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2854, CAST(N'2019-03-30 14:01:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:4')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2855, CAST(N'2019-03-30 14:02:24.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2856, CAST(N'2019-03-30 14:03:08.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护任务提醒内容信息成功:月度提醒')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2857, CAST(N'2019-03-30 14:23:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2858, CAST(N'2019-03-30 15:05:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2859, CAST(N'2019-03-30 15:08:40.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2860, CAST(N'2019-03-30 15:13:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2861, CAST(N'2019-03-30 15:24:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2862, CAST(N'2019-03-30 15:28:35.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2863, CAST(N'2019-03-30 15:31:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2864, CAST(N'2019-03-30 15:31:18.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2865, CAST(N'2019-03-30 15:42:04.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2866, CAST(N'2019-03-30 15:46:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2867, CAST(N'2019-03-30 15:48:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2868, CAST(N'2019-03-30 15:50:55.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2869, CAST(N'2019-03-30 15:51:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增日常维护任务成功:年度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2870, CAST(N'2019-03-30 15:51:59.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:5')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2871, CAST(N'2019-03-30 15:52:09.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护设备信息成功:3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2872, CAST(N'2019-03-30 15:52:49.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增维护任务提醒内容信息成功:年度提醒')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2873, CAST(N'2019-03-30 16:18:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:5')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2874, CAST(N'2019-03-30 16:18:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'编辑任务维护单执行频率成功:5')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2875, CAST(N'2019-03-30 16:20:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2876, CAST(N'2019-03-30 16:24:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2877, CAST(N'2019-03-30 16:25:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2878, CAST(N'2019-03-30 16:26:12.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'开始执行维护任务成功:')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2879, CAST(N'2019-03-30 16:38:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2880, CAST(N'2019-03-30 16:45:12.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护任务内容信息成功:QQQQ')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2881, CAST(N'2019-03-30 16:45:30.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑维护任务内容信息成功:QQQQ')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2882, CAST(N'2019-03-30 22:56:53.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2883, CAST(N'2019-03-30 22:57:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印日常维护任务单成功:年度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2884, CAST(N'2019-03-30 23:00:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2885, CAST(N'2019-03-30 23:01:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印日常维护任务单成功:年度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2886, CAST(N'2019-03-30 23:03:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2887, CAST(N'2019-03-30 23:03:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印日常维护任务单成功:年度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2888, CAST(N'2019-03-30 23:03:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印日常维护任务单成功:年度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2889, CAST(N'2019-03-30 23:04:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印日常维护任务单成功:月度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2890, CAST(N'2019-03-30 23:07:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2891, CAST(N'2019-03-30 23:08:22.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2892, CAST(N'2019-03-30 23:08:35.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'打印日常维护任务单成功:月度维护计划')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2893, CAST(N'2019-03-30 23:23:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2894, CAST(N'2019-03-30 23:31:19.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2895, CAST(N'2019-03-30 23:35:36.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2896, CAST(N'2019-03-31 12:51:23.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2897, CAST(N'2019-03-31 13:35:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2898, CAST(N'2019-03-31 13:37:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2899, CAST(N'2019-03-31 13:40:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单下达成功:|1|2|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2900, CAST(N'2019-03-31 13:41:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单更新成功:|1_01_1|2_03_1|3_02_1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2901, CAST(N'2019-03-31 13:42:26.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'订单下达成功:|1|2|3')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2902, CAST(N'2019-04-01 12:03:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2903, CAST(N'2019-04-01 13:09:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2904, CAST(N'2019-04-01 13:10:56.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置换刀提醒成功:|4/|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2905, CAST(N'2019-04-01 13:17:10.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2906, CAST(N'2019-04-01 13:18:51.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2907, CAST(N'2019-04-01 13:19:22.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'设置换刀提醒成功:|5|4/|1|2')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2908, CAST(N'2019-04-01 21:46:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2909, CAST(N'2019-04-02 09:37:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2910, CAST(N'2019-04-02 09:46:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2911, CAST(N'2019-04-02 11:09:30.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2912, CAST(N'2019-04-02 11:16:39.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2913, CAST(N'2019-04-02 11:18:50.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'报废产品成功:0101')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (2914, CAST(N'2019-04-02 11:27:05.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3902, CAST(N'2019-04-09 10:19:03.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3903, CAST(N'2019-04-09 10:19:48.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增线体成功:/内饰线')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3904, CAST(N'2019-04-09 10:21:06.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3905, CAST(N'2019-04-09 10:21:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增线体成功:/底盘线')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3906, CAST(N'2019-04-09 10:35:45.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3907, CAST(N'2019-04-09 10:36:54.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点基本信息成功:CP010')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3908, CAST(N'2019-04-09 10:39:02.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3909, CAST(N'2019-04-09 10:40:01.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点基本信息成功:CP002')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3910, CAST(N'2019-04-09 10:41:12.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增站点基本信息成功:CF001')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3911, CAST(N'2019-04-09 10:48:14.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3912, CAST(N'2019-04-09 10:48:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增仓储区域成功:004/零件仓')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3913, CAST(N'2019-04-11 15:03:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3914, CAST(N'2019-04-11 15:03:48.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:订单模板')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3915, CAST(N'2019-04-11 15:04:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板明细成功:Order1Init')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3916, CAST(N'2019-04-11 15:05:08.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板明细成功:Order0Init')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3917, CAST(N'2019-04-11 15:05:43.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:Order2RO')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3918, CAST(N'2019-04-11 15:06:15.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:Order3StationCode')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3919, CAST(N'2019-04-11 15:06:37.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:Order4No')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3920, CAST(N'2019-04-11 15:07:00.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:Order5ProductionSN')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3921, CAST(N'2019-04-11 15:07:18.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:Order6LastOrderNo')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3922, CAST(N'2019-04-11 15:07:47.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:Order7Total')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3923, CAST(N'2019-04-11 15:08:13.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'新增PLC模板明细成功:Order8Count')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3924, CAST(N'2019-04-11 15:09:42.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3925, CAST(N'2019-04-11 15:10:09.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板信息成功:1')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3926, CAST(N'2019-04-12 16:26:28.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3927, CAST(N'2019-04-12 17:18:20.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3928, CAST(N'2019-04-13 08:12:52.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3929, CAST(N'2019-04-13 08:22:32.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3930, CAST(N'2019-04-13 09:41:33.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3931, CAST(N'2019-04-25 09:38:11.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3932, CAST(N'2019-04-25 11:25:57.000' AS DateTime), N'admin', N'系统管理员', N'系统管理员', N'登录系统！')
GO
INSERT [dbo].[SystemLogs] ([ID], [CreateTime], [UserId], [UserName], [RoleName], [OptionDesc]) VALUES (3933, CAST(N'2019-04-25 11:26:30.000' AS DateTime), N'1', N'系统管理员', N'系统管理员', N'编辑PLC模板成功:订单模板')
GO
SET IDENTITY_INSERT [dbo].[SystemLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[UserInfo] ON 

GO
INSERT [dbo].[UserInfo] ([ID], [UserId], [LastName], [FirstName], [RoleId], [Email], [PhoneNumber], [UserDesc], [UserImagic], [Password]) VALUES (1, N'admin', N'系统', N'管理员', 1, N'gyfvqt@126.com', N'13800138001xx', N'真的好吗！？好的好的qq', N'/UserImg/20190228203339.jpg', N'e10adc3949ba59abbe56e057f20f883e')
GO
INSERT [dbo].[UserInfo] ([ID], [UserId], [LastName], [FirstName], [RoleId], [Email], [PhoneNumber], [UserDesc], [UserImagic], [Password]) VALUES (2, N'admin2', N'陈', N'生生', 1, N'282828@qq.com', N'1380013809', N',q,d;:#44444', NULL, N'e10adc3949ba59abbe56e057f20f883e')
GO
INSERT [dbo].[UserInfo] ([ID], [UserId], [LastName], [FirstName], [RoleId], [Email], [PhoneNumber], [UserDesc], [UserImagic], [Password]) VALUES (3, N'chenqin', N'陈', N'秦', 3, N'', N'', N'', NULL, N'e10adc3949ba59abbe56e057f20f883e')
GO
SET IDENTITY_INSERT [dbo].[UserInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRole] ON 

GO
INSERT [dbo].[UserRole] ([ID], [RoleName], [RoleDesc]) VALUES (1, N'系统管理员', N'系统管理员')
GO
INSERT [dbo].[UserRole] ([ID], [RoleName], [RoleDesc]) VALUES (3, N'测试', N'测试')
GO
INSERT [dbo].[UserRole] ([ID], [RoleName], [RoleDesc]) VALUES (6, N'测试4', N'测试4')
GO
INSERT [dbo].[UserRole] ([ID], [RoleName], [RoleDesc]) VALUES (7, N'测试5', N'测试5')
GO
SET IDENTITY_INSERT [dbo].[UserRole] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse] ON 

GO
INSERT [dbo].[Warehouse] ([ID], [WarehouseNo], [WarehouseType], [WarehouseName]) VALUES (1, N'FANUC_W00001', N'原材料与零部件库', N'底盘区域2')
GO
INSERT [dbo].[Warehouse] ([ID], [WarehouseNo], [WarehouseType], [WarehouseName]) VALUES (3, N'FANUC_W00003', N'成品仓', N'内饰区域')
GO
INSERT [dbo].[Warehouse] ([ID], [WarehouseNo], [WarehouseType], [WarehouseName]) VALUES (4, N'004', N'原材料与零部件库', N'零件仓')
GO
SET IDENTITY_INSERT [dbo].[Warehouse] OFF
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-01' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-04' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-05' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-06' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-07' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-08' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-11' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-12' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-13' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-14' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-15' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-18' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-19' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-20' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-21' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-22' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-25' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-26' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-27' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-28' AS Date))
GO
INSERT [dbo].[WorkCalendar] ([WorkDate]) VALUES (CAST(N'2019-03-29' AS Date))
GO
INSERT [dbo].[WorkShift] ([ID], [BeginTime], [EndTime]) VALUES (N'01', N'07:30', N'16:30')
GO
INSERT [dbo].[WorkShift] ([ID], [BeginTime], [EndTime]) VALUES (N'02', N'17:00', N'02:00')
GO
INSERT [dbo].[WorkShift] ([ID], [BeginTime], [EndTime]) VALUES (N'03', N'02:30', N'07:00')
GO
USE [master]
GO
ALTER DATABASE [FANUCMES] SET  READ_WRITE 
GO
