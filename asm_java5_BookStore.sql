USE [master]
GO
/****** Object:  Database [asm]    Script Date: 6/11/2024 10:33:04 PM ******/
CREATE DATABASE [asm]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'asm', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\asm.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'asm_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\asm_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [asm] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [asm].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [asm] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [asm] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [asm] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [asm] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [asm] SET ARITHABORT OFF 
GO
ALTER DATABASE [asm] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [asm] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [asm] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [asm] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [asm] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [asm] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [asm] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [asm] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [asm] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [asm] SET  DISABLE_BROKER 
GO
ALTER DATABASE [asm] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [asm] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [asm] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [asm] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [asm] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [asm] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [asm] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [asm] SET RECOVERY FULL 
GO
ALTER DATABASE [asm] SET  MULTI_USER 
GO
ALTER DATABASE [asm] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [asm] SET DB_CHAINING OFF 
GO
ALTER DATABASE [asm] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [asm] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [asm] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [asm] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'asm', N'ON'
GO
ALTER DATABASE [asm] SET QUERY_STORE = ON
GO
ALTER DATABASE [asm] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [asm]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bill](
	[BillID] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Fullname] [nvarchar](50) NULL,
	[phone_number] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[order_date] [date] NULL,
	[Address] [nvarchar](255) NULL,
	[payment_method] [nvarchar](50) NULL,
	[total] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Subtotal] [float] NOT NULL,
	[Total] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[name_category] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[favorite_products]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[favorite_products](
	[username] [varchar](50) NOT NULL,
	[ProductID] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[Text] [nvarchar](255) NULL,
	[DateFeed] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[password_reset_token]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[password_reset_token](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[expiry_date] [datetime2](6) NOT NULL,
	[token] [varchar](255) NOT NULL,
	[username] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryID] [bigint] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Author] [nvarchar](150) NOT NULL,
	[Year] [varchar](50) NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Image] [nvarchar](225) NOT NULL,
	[Infor] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromotionID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Discount] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PromotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/11/2024 10:33:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[username] [varchar](50) NOT NULL,
	[password] [nvarchar](60) NULL,
	[fullname] [nvarchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[ngaysinh] [date] NULL,
	[gender] [varchar](50) NULL,
	[phone_number] [varchar](20) NOT NULL,
	[image] [varchar](225) NULL,
	[admin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (2, N'truong', N'Phạm Xuân Trường', N'0358423817', N'truong21122004@gmail.com', CAST(N'2024-01-10' AS Date), N'tiền gian', N'on', 140000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (3, N'truong', N'Phạm Xuân Trường', N'0358423817', N'truong21122004@gmail.com', CAST(N'2024-01-17' AS Date), N'Mặt sau Số 26 Đường 494', N'on', 170000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (4, N'truong', N'Phạm Xuân Trường', N'0358423817', N'truong21122004@gmail.com', CAST(N'2024-02-10' AS Date), N'Mặt sau Số 26 Đường 494', N'on', 320000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (5, N'truong', N'Phạm Xuân Trường', N'0358423817', N'truong21122004@gmail.com', CAST(N'2024-03-10' AS Date), N'tiền giang', N'on', 120000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (6, N'truong', N'Phạm Xuân Trường', N'0358423817', N'truong21122004@gmail.com', CAST(N'2024-05-10' AS Date), N'Mặt sau Số 26 Đường 494', N'on', 115000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (7, N'truong', N'Phạm Xuân Trường', N'0358423817', N'truong21122004@gmail.com', CAST(N'2024-06-10' AS Date), N'g', N'on', 110000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (8, N'truong1', N'Phạm Xuân Trường 3', N'0358423812', N'pxt2018zz@gmail.com', CAST(N'2024-06-10' AS Date), N'Mặt sau Số 26 Đường 494', N'on', 230000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (11, N'truong1', N'Phạm Xuân Trường 3', N'0358423812', N'pxt2018zz@gmail.com', CAST(N'2024-06-11' AS Date), N'kim sơn 2', N'on', 140000)
INSERT [dbo].[Bill] ([BillID], [Username], [Fullname], [phone_number], [Email], [order_date], [Address], [payment_method], [total]) VALUES (12, N'truong1', N'Phạm Xuân Trường 3', N'0358423812', N'pxt2018zz@gmail.com', CAST(N'2024-06-11' AS Date), N'tiền giang', N'on', 150000)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([CartID], [Username], [ProductID], [Quantity], [Subtotal], [Total]) VALUES (5, N'admin2', 84, 1, 0, 110000)
INSERT [dbo].[Cart] ([CartID], [Username], [ProductID], [Quantity], [Subtotal], [Total]) VALUES (6, N'admin2', 25, 2, 0, 230000)
INSERT [dbo].[Cart] ([CartID], [Username], [ProductID], [Quantity], [Subtotal], [Total]) VALUES (7, N'admin2', 2, 1, 0, 120000)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (1, N'Văn học')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (2, N'Trinh thám')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (3, N'Kinh dị')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (4, N'Khoa học ')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (5, N'Sức khỏe ')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (6, N'Lịch Sửc ')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (7, N'Kinh doanh ')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (8, N'Truyện tranh ')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (9, N'Truyện ngắn')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (13, N'Tiểu thuyểt')
INSERT [dbo].[Categories] ([CategoryID], [name_category]) VALUES (14, N'Anime')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[password_reset_token] ON 

INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (1, CAST(N'2024-06-07T19:11:08.1219660' AS DateTime2), N'4176330d-7e5e-47f1-b374-5961b50cddf9', N'trong')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (2, CAST(N'2024-06-07T19:25:07.1841800' AS DateTime2), N'ac19745c-e5a5-49d6-b07b-15d49bb86cc3', N'user7')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (5, CAST(N'2024-06-07T19:31:34.3169140' AS DateTime2), N'0ca87701-5ba8-465c-ac45-483999202c53', N'truongps')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (8, CAST(N'2024-06-07T19:36:19.2661500' AS DateTime2), N'a1784de7-a919-441d-8082-55129591530a', N'hihi')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (9, CAST(N'2024-06-07T19:43:28.2085840' AS DateTime2), N'4fa37aeb-45d1-4575-80a0-9c4c12554501', N'admin1')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (10, CAST(N'2024-06-07T19:50:37.0493040' AS DateTime2), N'5252431e-8fae-47bd-a7b8-1b9c30f3cb67', N'truong')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (13, CAST(N'2024-06-07T19:57:41.2270940' AS DateTime2), N'b55f02f6-34cc-40b7-96e0-518c9b92e4b0', N'admin7')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (16, CAST(N'2024-06-07T20:11:43.2637700' AS DateTime2), N'5f675296-a4b3-4b35-8892-0852b3ca71f4', N'user6')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (18, CAST(N'2024-06-09T15:30:55.5639320' AS DateTime2), N'fdb55d93-7917-4d2a-ac17-14c8611bedb9', N'admin')
INSERT [dbo].[password_reset_token] ([id], [expiry_date], [token], [username]) VALUES (22, CAST(N'2024-06-11T23:31:01.4696600' AS DateTime2), N'8c34e0a5-8849-4ead-9b97-c4a9cb925ed7', N'truong1')
SET IDENTITY_INSERT [dbo].[password_reset_token] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (1, 1, N'To Kill a Mockingbird', N'Harper Lee', N'1960', 170000, 10, N'/imgProduct/UserCase.jpg', N'Một câu chuyện về sự bất công chủng tộc và mất mát tuổi thơ ở miền Nam nước Mỹ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (2, 1, N'1984 Book', N'George Orwell', N'1949', 120000, 10, N'/imgProduct/1984_2.jpg', N'Tác phẩm viễn tưởng chính trị phản ánh xã hội toàn trị và sự kiểm soát của chính phủ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (3, 1, N'The Great Gatsby', N'F. Scott Fitzgerald', N'1925', 130000, 10, N'/imgProduct/TheGreatGatsby2.jpg', N'Một câu chuyện về giấc mơ Mỹ và sự đổ vỡ của nó.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (4, 1, N'Pride and Prejudice', N'Jane Austen', N'1813', 110000, 10, N'/imgProduct/PrideAndPrejudice.jpg', N'Một tiểu thuyết lãng mạn kinh điển về tình yêu và những sai lầm của con người.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (5, 1, N'One Hundred Years of Solitude', N'Gabriel García Márquez', N'1967', 160000, 10, N'/imgProduct/OneHundredYearsofSolitude.jpg', N'Một câu chuyện sử thi về gia đình Buendía qua nhiều thế hệ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (6, 1, N'Crime and Punishment', N'Fyodor Dostoevsky', N'1866', 140000, 10, N'/imgProduct/CrimeandPunishment.jpg', N'Một tiểu thuyết tâm lý về tội ác và sự hối hận.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (7, 1, N'The Catcher in the Rye', N'J.D. Salinger', N'1951', 115000, 10, N'/imgProduct/TheCatcherintheRye.jpg', N'Câu chuyện về cuộc phiêu lưu của một thiếu niên trong thành phố New York.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (8, 1, N'War and Peace', N'Leo Tolstoy', N'1869', 170000, 10, N'/imgProduct/WarandPeace.jpg', N'Một tiểu thuyết lịch sử về các gia đình quý tộc Nga trong thời kỳ chiến tranh Napoleon.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (9, 1, N'The Brothers Karamazov', N'Fyodor Dostoevsky', N'1880', 150000, 10, N'/imgProduct/TheBrothersKaramazov.jpg', N'Một tiểu thuyết triết học về tình yêu, niềm tin và sự phản bội trong một gia đình Nga.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (10, 1, N'Moby-Dick', N'Herman Melville', N'1851', 125000, 10, N'/imgProduct/MobyDick.jpg', N'Một cuộc phiêu lưu trên biển với con cá voi trắng khổng lồ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (11, 2, N'The Girl with the Dragon Tattoo', N'Stieg Larsson', N'2005', 135000, 10, N'/imgProduct/TheGirlwiththeDragonTattoo.jpg', N'Một câu chuyện trinh thám về một nhà báo và một hacker nữ tài năng.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (12, 2, N'Gone Girl', N'Gillian Flynn', N'2012', 140000, 10, N'/imgProduct/GoneGirl.jpg', N'Một câu chuyện bí ẩn về sự biến mất của một người vợ và những bí mật đen tối.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (13, 2, N'The Da Vinci Code', N'Dan Brown', N'2003', 150000, 10, N'/imgProduct/TheDaVinciCode.jpg', N'Một câu chuyện về cuộc truy tìm những bí ẩn ẩn giấu trong các tác phẩm nghệ thuật.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (14, 2, N'The Hound of the Baskervilles', N'Arthur Conan Doyle', N'1902', 110000, 10, N'/imgProduct/TheHoundoftheBaskervilles.jpg', N'Một vụ án kỳ bí về con chó ma và một gia tộc bị nguyền rủa.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (15, 2, N'And Then There Were None', N'Agatha Christie', N'1939', 120000, 10, N'/imgProduct/AndThenThereWereNone.jpg', N'Một câu chuyện về mười người lạ bị mắc kẹt trên một hòn đảo và bị giết dần bởi một kẻ bí ẩn.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (16, 2, N'The Silent Patient', N'Alex Michaelides', N'2019', 130000, 10, N'/imgProduct/TheSilentPatient.jpg', N'Một bệnh nhân tâm thần bí ẩn và cuộc điều tra của một nhà tâm lý học.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (17, 2, N'In the Woods', N'Tana French', N'2007', 140000, 10, N'/imgProduct/IntheWoods.jpg', N'Một vụ án về sự mất tích bí ẩn của hai đứa trẻ trong rừng.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (18, 2, N'The Reversal', N'Michael Connelly', N'2010', 150000, 10, N'/imgProduct/TheReversal.jpg', N'Một câu chuyện về cuộc tái thẩm một vụ án giết người và những bí mật ẩn giấu.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (19, 2, N'The Big Sleep', N'Raymond Chandler', N'1939', 115000, 10, N'/imgProduct/TheBigSleep.jpg', N'Một thám tử tư bị kéo vào một mạng lưới tội ác phức tạp.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (20, 2, N'Sharp Objects', N'Gillian Flynn', N'2006', 130000, 10, N'/imgProduct/SharpObjects.jpg', N'Một nhà báo trở về quê nhà để điều tra vụ giết người và đối mặt với quá khứ của mình.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (21, 3, N'The Shining', N'Stephen King', N'1977', 150000, 10, N'/imgProduct/TheShining.jpg', N'Một gia đình đến sống trong một khách sạn ma ám và gặp phải những hiện tượng kỳ bí.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (22, 3, N'Dracula', N'Bram Stoker', N'1897', 120000, 10, N'/imgProduct/Dracula.jpg', N'Câu chuyện về bá tước ma cà rồng Dracula và cuộc chiến đấu chống lại hắn.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (23, 3, N'It', N'Stephen King', N'1986', 180000, 10, N'/imgProduct/It.jpg', N'Một nhóm bạn trẻ đối mặt với một thực thể tà ác dưới hình dạng chú hề.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (24, 3, N'The Haunting of Hill House', N'Shirley Jackson', N'1959', 130000, 10, N'/imgProduct/TheHauntingofHillHouse.jpg', N'Một câu chuyện về một nhóm người nghiên cứu một ngôi nhà ma ám.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (25, 3, N'Frankenstein', N'Mary Shelley', N'1818', 115000, 10, N'/imgProduct/Frankenstein.jpg', N'Một nhà khoa học tạo ra một sinh vật sống và đối mặt với hậu quả khủng khiếp.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (26, 3, N'Pet Sematary', N'Stephen King', N'1983', 140000, 10, N'/imgProduct/PetSematary.jpg', N'Một gia đình chuyển đến gần một nghĩa địa thú cưng và phát hiện ra những điều kinh hoàng.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (27, 3, N'The Exorcist', N'William Peter Blatty', N'1971', 150000, 10, N'/imgProduct/TheExorcist.jpg', N'Một cô bé bị ám bởi một thực thể tà ác và cuộc chiến đấu của mẹ cô với nó.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (28, 3, N'The Silence of the Lambs', N'Thomas Harris', N'1988', 135000, 10, N'/imgProduct/TheSilenceoftheLambs.jpg', N'Một đặc vụ FBI trẻ tuổi tìm kiếm sự giúp đỡ của một kẻ giết người hàng loạt để bắt một kẻ giết người khác.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (29, 3, N'Bird Box', N'Josh Malerman', N'2014', 120000, 10, N'/imgProduct/BirdBox.jpg', N'Một phụ nữ và hai đứa con phải di chuyển trong thế giới bị tàn phá bởi những sinh vật khiến con người tự sát.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (30, 3, N'The Amityville Horror', N'Jay Anson', N'1977', 130000, 10, N'/imgProduct/TheAmityvilleHorror.jpg', N'Câu chuyện dựa trên sự kiện có thật về một ngôi nhà bị ám ở Amityville.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (31, 4, N'A Brief History of Time', N'Stephen Hawking', N'1988', 160000, 10, N'/imgProduct/ABriefHistoryofTime.jpg', N'Một cuốn sách giải thích về các khái niệm vật lý học và vũ trụ học cho người đọc phổ thông.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (32, 4, N'The Selfish Gene', N'Richard Dawkins', N'1976', 150000, 10, N'/imgProduct/TheSelfishGene.jpg', N'Một lý thuyết về sự tiến hóa và di truyền học từ góc nhìn của các gen.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (33, 4, N'The Origin of Species', N'Charles Darwin', N'1859', 140000, 10, N'/imgProduct/TheOriginofSpecies.jpg', N'Cuốn sách nền tảng về lý thuyết tiến hóa thông qua chọn lọc tự nhiên.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (34, 4, N'Cosmos', N'Carl Sagan', N'1980', 170000, 10, N'/imgProduct/Cosmos.jpg', N'Một cuốn sách giải thích về vũ trụ và các hiện tượng thiên văn học.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (35, 4, N'The Elegant Universe', N'Brian Greene', N'1999', 160000, 10, N'/imgProduct/TheElegantUniverse.jpg', N'Một cuốn sách về lý thuyết dây và cấu trúc của vũ trụ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (36, 4, N'Astrophysics for People in a Hurry', N'Neil deGrasse Tyson', N'2017', 140000, 10, N'/imgProduct/AstrophysicsforPeopleinaHurry.jpg', N'Một cuốn sách giới thiệu về thiên văn học cho người đọc phổ thông.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (37, 4, N'The Immortal Life of Henrietta Lacks', N'Rebecca Skloot', N'2010', 150000, 10, N'/imgProduct/TheImmortalLifeofHenriettaLacks.jpg', N'Câu chuyện về tế bào HeLa và tác động của nó lên y học hiện đại.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (38, 4, N'Sapiens: A Brief History of Humankind', N'Yuval Noah Harari', N'2011', 170000, 10, N'/imgProduct/SapiensABriefHistoryofHumankind.jpg', N'Một cuốn sách về lịch sử loài người từ thời tiền sử đến hiện đại.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (39, 4, N'The Gene: An Intimate History', N'Siddhartha Mukherjee', N'2016', 160000, 10, N'/imgProduct/TheGeneAnIntimateHistory.jpg', N'Một cuốn sách về lịch sử và tương lai của gen học.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (40, 4, N'The Sixth Extinction', N'Elizabeth Kolbert', N'2014', 150000, 10, N'/imgProduct/TheSixthExtinction.jpg', N'Một cuốn sách về các đợt tuyệt chủng trong lịch sử và hiện tại.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (41, 5, N'The Power of Habit', N'Charles Duhigg', N'2012', 140000, 1, N'/imgProduct/ThePowerofHabit.jpg', N'Một cuốn sách về cách thức hình thành thói quen và làm thế nào để thay đổi chúng.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (42, 5, N'How Not to Die', N'Michael Greger', N'2015', 150000, 1, N'/imgProduct/HowNottoDie.jpg', N'Một cuốn sách về cách ăn uống và lối sống để phòng tránh bệnh tật.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (43, 5, N'The Whole30', N'Melissa Hartwig', N'2015', 160000, 1, N'/imgProduct/TheWhole30.jpg', N'Một chương trình dinh dưỡng kéo dài 30 ngày giúp cải thiện sức khỏe.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (44, 5, N'Why We Sleep', N'Matthew Walker', N'2017', 150000, 1, N'/imgProduct/WhyWeSleep.jpg', N'Một cuốn sách về tầm quan trọng của giấc ngủ và cách cải thiện chất lượng giấc ngủ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (46, 5, N'You Are a Badass', N'Jen Sincero', N'2013', 140000, 1, N'/imgProduct/YouAreaBadass.jpg', N'Một cuốn sách tự lực giúp bạn thay đổi tư duy và cuộc sống của mình.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (47, 5, N'The Subtle Art of Not Giving a F*ck', N'Mark Manson', N'2016', 150000, 1, N'/imgProduct/TheSubtleArtofNotGivingaFuck.jpg', N'Một cuốn sách về cách sống thực tế và tìm kiếm hạnh phúc.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (48, 5, N'Mindfulness in Plain English', N'Bhante Henepola Gunaratana', N'1994', 130000, 1, N'/imgProduct/MindfulnessinPlainEnglish.jpg', N'Một cuốn sách hướng dẫn về thiền và sự tỉnh thức.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (49, 5, N'Atomic Habits', N'James Clear', N'2018', 160000, 1, N'/imgProduct/AtomicHabits.jpg', N'Một cuốn sách về cách xây dựng thói quen tốt và phá vỡ thói quen xấu.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (50, 5, N'The Happiness Project', N'Gretchen Rubin', N'2009', 150000, 1, N'/imgProduct/TheHappinessProject.jpg', N'Một cuốn sách về hành trình tìm kiếm hạnh phúc qua các thí nghiệm cá nhân.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (51, 6, N'Guns, Germs, and Steel', N'Jared Diamond', N'1997', 180000, 1, N'/imgProduct/GunsGermsandSteel.jpg', N'Một cuốn sách giải thích tại sao một số xã hội phát triển hơn những xã hội khác.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (52, 6, N'A Peoples History of the United States', N'Howard Zinn', N'1980', 160000, 1, N'/imgProduct/APeoplesHistoryoftheUnitedStates.jpg', N'Một cuốn sách về lịch sử Hoa Kỳ từ góc nhìn của những người bị áp bức.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (53, 6, N'The Diary of a Young Girl', N'Anne Frank', N'1947', 140000, 1, N'/imgProduct/TheDiaryofaYoungGirl.jpg', N'Nhật ký của Anne Frank, một cô bé Do Thái trong thời kỳ Đức Quốc xã chiếm đóng.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (54, 6, N'The Wright Brothers', N'David McCullough', N'2015', 170000, 1, N'/imgProduct/TheWrightBrothers.jpg', N'Câu chuyện về hai anh em nhà Wright và sự phát minh ra máy bay.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (55, 6, N'Team of Rivals', N'Doris Kearns Goodwin', N'2005', 180000, 1, N'/imgProduct/TeamofRivals.jpg', N'Một cuốn sách về cuộc đời của Abraham Lincoln và các cộng sự của ông.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (56, 6, N'The Silk Roads', N'Peter Frankopan', N'2015', 160000, 1, N'/imgProduct/TheSilkRoads.jpg', N'Một cuốn sách về con đường tơ lụa và ảnh hưởng của nó lên lịch sử thế giới.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (57, 6, N'The Rise and Fall of the Third Reich', N'William L. Shirer', N'1960', 200000, 1, N'/imgProduct/TheRiseandFalloftheThirdReich.jpg', N'Một cuốn sách về sự thăng trầm của Đế chế thứ Ba Đức Quốc xã.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (58, 6, N'1776', N'David McCullough', N'2005', 170000, 1, N'/imgProduct/1776.jpg', N'Một cuốn sách về cuộc Cách mạng Mỹ và năm 1776.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (59, 6, N'Genghis Khan and the Making of the Modern World', N'Jack Weatherford', N'2004', 160000, 1, N'/imgProduct/GenghisKhanandtheMakingoftheMoernWorld.jpg', N'Một cuốn sách về cuộc đời và sự ảnh hưởng của Thành Cát Tư Hãn.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (60, 6, N'Sapiens: A Brief History of Humankind', N'Yuval Noah Harari', N'2011', 170000, 1, N'/imgProduct/SapiensABriefHistoryofHumankind.jpg', N'Một cuốn sách về lịch sử loài người từ thời tiền sử đến hiện đại.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (61, 7, N'Rich Dad Poor Dad', N'Robert T. Kiyosaki', N'1997', 150000, 1, N'/imgProduct/RichDadPoorDad.jpg', N'Một cuốn sách về quản lý tài chính cá nhân và đầu tư.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (62, 7, N'The Lean Startup', N'Eric Ries', N'2011', 160000, 1, N'/imgProduct/TheLeanStartup.jpg', N'Một cuốn sách về phương pháp khởi nghiệp tinh gọn và hiệu quả.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (63, 7, N'Think and Grow Rich', N'Napoleon Hill', N'1937', 140000, 1, N'/imgProduct/ThinkandGrowRich.jpg', N'Một cuốn sách về tư duy làm giàu và các nguyên tắc thành công.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (64, 7, N'The Intelligent Investor', N'Benjamin Graham', N'1949', 170000, 1, N'/imgProduct/TheIntelligentInvestor.jpg', N'Một cuốn sách kinh điển về đầu tư chứng khoán và quản lý tài chính.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (65, 7, N'Good to Great', N'Jim Collins', N'2001', 160000, 1, N'/imgProduct/GoodtoGreat.jpg', N'Một cuốn sách về những yếu tố giúp các công ty vượt trội.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (66, 7, N'The 7 Habits of Highly Effective People', N'Stephen R. Covey', N'1989', 150000, 1, N'/imgProduct/The7HabitsofHighlyEffectivePeople.jpg', N'Một cuốn sách về các thói quen của những người thành công.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (67, 7, N'Zero to One', N'Peter Thiel', N'2014', 140000, 1, N'/imgProduct/ZerotoOne.jpg', N'Một cuốn sách về cách thức tạo ra các công ty đổi mới và thành công.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (68, 7, N'Outliers', N'Malcolm Gladwell', N'2008', 160000, 1, N'/imgProduct/Outliers.jpg', N'Một cuốn sách về những yếu tố tạo nên sự thành công phi thường.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (69, 7, N'The Innovators Dilemma', N'Clayton M. Christensen', N'1997', 150000, 1, N'/imgProduct/TheInnovatorsDilemma.jpg', N'Một cuốn sách về sự đổi mới và lý do tại sao các công ty lớn thường thất bại.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (70, 7, N'Shoe Dog', N'Phil Knight', N'2016', 170000, 1, N'/imgProduct/ShoeDog.jpg', N'Một cuốn sách hồi ký của nhà sáng lập Nike về hành trình khởi nghiệp và xây dựng thương hiệu.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (71, 8, N'Watchmen', N'Alan Moore', N'1986', 180000, 100, N'/imgProduct/Watchmen.jpg', N'Một cuốn tiểu thuyết đồ họa về những siêu anh hùng và những vấn đề đạo đức.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (72, 8, N'Maus', N'Art Spiegelman', N'1991', 170000, 100, N'/imgProduct/Maus.jpg', N'Một cuốn tiểu thuyết đồ họa về Holocaust và di sản của nó.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (73, 8, N'Persepolis', N'Marjane Satrapi', N'2000', 160000, 100, N'/imgProduct/Persepolis.jpg', N'Một cuốn hồi ký đồ họa về tuổi thơ của tác giả tại Iran.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (74, 8, N'Batman: The Killing Joke', N'Alan Moore', N'1988', 150000, 100, N'/imgProduct/BatmanTheKillingJoke.jpg', N'Một câu chuyện về Batman và kẻ thù Joker của anh.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (75, 8, N'The Sandman', N'Neil Gaiman', N'1989', 180000, 100, N'/imgProduct/TheSandman.jpg', N'Một cuốn tiểu thuyết đồ họa về Dream, một trong bảy Endless.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (76, 8, N'V for Vendetta', N'Alan Moore', N'1988', 170000, 100, N'/imgProduct/VforVendetta.jpg', N'Một câu chuyện về cuộc nổi dậy chống lại chế độ toàn trị tại Anh.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (77, 8, N'Saga', N'Brian K. Vaughan', N'2012', 160000, 100, N'/imgProduct/Saga.jpg', N'Một câu chuyện về một gia đình chạy trốn trong bối cảnh chiến tranh giữa các hành tinh.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (78, 8, N'Y: The Last Man', N'Brian K. Vaughan', N'2002', 160000, 100, N'/imgProduct/YTheLastMan.jpg', N'Một câu chuyện về người đàn ông cuối cùng còn sống sót trên Trái Đất.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (79, 8, N'Bone', N'Jeff Smith', N'1991', 150000, 100, N'/imgProduct/Bone.jpg', N'Một câu chuyện phiêu lưu của ba anh em Bone ở một thế giới kỳ lạ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (80, 8, N'Scott Pilgrim', N'Bryan Lee O''Malley', N'2004', 140000, 100, N'/imgProduct/ScottPilgrim.jpg', N'Một câu chuyện về cuộc sống và tình yêu của Scott Pilgrim, một chàng trai trẻ tuổi ở Toronto.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (81, 9, N'Dubliners', N'James Joyce', N'1914', 120000, 10, N'/imgProduct/Dubliners.jpg', N'Một tuyển tập các truyện ngắn về cuộc sống ở Dublin, Ireland.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (82, 9, N'The Complete Stories', N'Flannery O''Connor', N'1971', 150000, 10, N'/imgProduct/TheCompleteStories.jpg', N'Một tuyển tập các truyện ngắn của Flannery O''Connor về miền Nam nước Mỹ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (83, 9, N'Tenth of December', N'George Saunders', N'2013', 130000, 10, N'/imgProduct/TenthofDecember.jpg', N'Một tuyển tập các truyện ngắn phản ánh những khía cạnh khác nhau của xã hội Mỹ hiện đại.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (84, 9, N'Nine Stories', N'J.D. Salinger', N'1953', 110000, 10, N'/imgProduct/NineStories.jpg', N'Một tuyển tập các truyện ngắn của J.D. Salinger, tác giả của The Catcher in the Rye.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (85, 9, N'Interpreter of Maladies', N'Jhumpa Lahiri', N'1999', 140000, 10, N'/imgProduct/InterpreterofMaladies.jpg', N'Một tuyển tập các truyện ngắn về cuộc sống của người Ấn Độ tại Mỹ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (86, 9, N'Men Without Women', N'Haruki Murakami', N'2014', 150000, 10, N'/imgProduct/MenWithoutWomen.jpg', N'Một tuyển tập các truyện ngắn về những người đàn ông cô đơn và tình yêu của họ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (87, 9, N'Jesus'' Son', N'Denis Johnson', N'1992', 130000, 10, N'/imgProduct/JesusSon.jpg', N'Một tuyển tập các truyện ngắn về cuộc sống của những người nghiện ma túy và vô gia cư.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (88, 9, N'The Things They Carried', N'Tim O''Brien', N'1990', 140000, 10, N'/imgProduct/TheThingsTheyCarried.jpg', N'Một tuyển tập các truyện ngắn về cuộc chiến tranh Việt Nam và những ảnh hưởng của nó lên các binh sĩ.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (89, 9, N'What We Talk About When We Talk About Love', N'Raymond Carver', N'1981', 120000, 10, N'/imgProduct/WhatWeTalkAboutWhenWeTalkAboutBooks.jpg', N'Một tuyển tập các truyện ngắn về tình yêu và sự cô đơn.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (90, 9, N'The Collected Stories of Amy Hempel', N'Amy Hempel', N'2006', 150000, 10, N'/imgProduct/TheCollectedStoriesofAmyHempel.jpg', N'Một tuyển tập các truyện ngắn về cuộc sống và cảm xúc của con người.')
INSERT [dbo].[Product] ([ProductID], [CategoryID], [Name], [Author], [Year], [Price], [Quantity], [Image], [Infor]) VALUES (104, 8, N'Sách Sách', N'Alex Xanhdow', N'2024', 123222, 12, N'/imgProduct/TheGreatGatsby2.jpg', N'khong co mo ta ')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[Users] ([username], [password], [fullname], [email], [ngaysinh], [gender], [phone_number], [image], [admin]) VALUES (N'admin2', N'$2a$10$fYFeLE9I9AEF0Aapv0uez.QE28ZZlt4RGb.NKA639DWA/KgeWi0CG', N'bánh Cuốn', N'admin2@gmail.com', CAST(N'2009-07-12' AS Date), N'admin', N'0971789475', N'/imgProduct/doraemon.jpg', 1)
INSERT [dbo].[Users] ([username], [password], [fullname], [email], [ngaysinh], [gender], [phone_number], [image], [admin]) VALUES (N'truong', N'$2a$10$3e4f4xFD1Du.ioykArgwg.BzfYVyGEke.Vkm9mk.yE.mKPiSX/0Zq', N'Phạm Xuân Trường', N'truong21122004@gmail.com', CAST(N'2004-12-21' AS Date), N'male', N'0358423814', NULL, NULL)
INSERT [dbo].[Users] ([username], [password], [fullname], [email], [ngaysinh], [gender], [phone_number], [image], [admin]) VALUES (N'truong1', N'$2a$10$Kdr76wSU8fPPrFNgsRyHGuj1gJvb5.3fcKGnW3sOTXbmfGmuKdxxC', N'Phạm Xuân Trường 3', N'pxt2018zz@gmail.com', CAST(N'2000-09-23' AS Date), N'male', N'0358423812', NULL, 1)
INSERT [dbo].[Users] ([username], [password], [fullname], [email], [ngaysinh], [gender], [phone_number], [image], [admin]) VALUES (N'truong2', N'$2a$10$NPk/WwnNh5ccWnb3Dpbn1OCWhnJzFDxs981y751vrcUzSloHFij82', N'Bún bò', N'bbb@gmail.com', CAST(N'2007-12-21' AS Date), N'female', N'035842356', NULL, 1)
INSERT [dbo].[Users] ([username], [password], [fullname], [email], [ngaysinh], [gender], [phone_number], [image], [admin]) VALUES (N'truong3', N'$2a$10$DhicQKWBCQrIsCfUKZ5yHuMu/BHk9t7cuTkvtylbcfoiFCJ/852P.', N'Lê Người Già', N'nguoigia@gmail.com', CAST(N'2006-02-01' AS Date), N'user', N'0358423811', N'/imgProduct/TheGreatGatsby2.jpg', 1)
INSERT [dbo].[Users] ([username], [password], [fullname], [email], [ngaysinh], [gender], [phone_number], [image], [admin]) VALUES (N'truong4', N'$2a$10$KmXreLwpM6./fLddPDgTpefcfeTcOmmbdU0Kd.rDEk5ojw0/8CES.', N'NGười sắt', N'nguoisat@gmail.com', CAST(N'2002-12-21' AS Date), N'user', N'0971789763', N'/imgProduct/1984_2.jpg', 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UKg0guo4k8krgpwuagos61oc06j]    Script Date: 6/11/2024 10:33:04 PM ******/
ALTER TABLE [dbo].[password_reset_token] ADD  CONSTRAINT [UKg0guo4k8krgpwuagos61oc06j] UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UKh48jl6npn50roaejnmu8yr48l]    Script Date: 6/11/2024 10:33:04 PM ******/
ALTER TABLE [dbo].[password_reset_token] ADD  CONSTRAINT [UKh48jl6npn50roaejnmu8yr48l] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Users] FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Users]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK8hnkuypxm7rivjgvuj6cdbbs6] FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK8hnkuypxm7rivjgvuj6cdbbs6]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FKbbm1p4bmt0wlt8fqwcdqnrxy3] FOREIGN KEY([Username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FKbbm1p4bmt0wlt8fqwcdqnrxy3]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FKkh5di77cfr01hq05rbcogspec] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FKkh5di77cfr01hq05rbcogspec]
GO
ALTER TABLE [dbo].[favorite_products]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[favorite_products]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
USE [master]
GO
ALTER DATABASE [asm] SET  READ_WRITE 
GO
