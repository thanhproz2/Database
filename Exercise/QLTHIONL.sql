USE [QLTHI]
GO
/****** Object:  Table [dbo].[CauHoi]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CauHoi](
	[MaCauHoi] [nchar](10) NOT NULL,
	[NoiDung] [nvarchar](50) NULL,
	[Diem] [float] NULL,
	[DoKho] [nchar](10) NULL,
	[MaDe] [nchar](10) NULL,
 CONSTRAINT [PK_CauHoi] PRIMARY KEY CLUSTERED 
(
	[MaCauHoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaChucVu] [nchar](10) NOT NULL,
	[TenChucVu] [nvarchar](50) NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[MaChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DapAN]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DapAN](
	[MaDA] [nchar](10) NOT NULL,
	[MaCauHoi] [nchar](10) NOT NULL,
	[Noidung_DA] [nvarchar](50) NULL,
	[TrangThaiDapAn] [nvarchar](50) NULL,
 CONSTRAINT [PK_DapAN_1] PRIMARY KEY CLUSTERED 
(
	[MaDA] ASC,
	[MaCauHoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daptest]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daptest](
	[mda] [int] NOT NULL,
	[noidung] [nchar](10) NULL,
	[tinhtrang] [nchar](10) NULL,
 CONSTRAINT [PK_daptest] PRIMARY KEY CLUSTERED 
(
	[mda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[De]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[De](
	[MaDe] [nchar](10) NOT NULL,
	[MaND] [nchar](10) NULL,
	[ThoiGianLamBai] [time](7) NULL,
	[SoLuongCauHoi] [int] NULL,
	[NgayRaDe] [datetime] NULL,
	[TrangThai] [nchar](10) NULL,
	[MaMH] [nchar](10) NULL,
 CONSTRAINT [PK_De_1] PRIMARY KEY CLUSTERED 
(
	[MaDe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Diem]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diem](
	[MaTS] [nchar](10) NOT NULL,
	[Diem] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KetQua]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KetQua](
	[MaTS] [nchar](10) NOT NULL,
	[MaMH] [nchar](10) NOT NULL,
	[LanThi] [int] NULL,
	[TongDiem] [datetime] NULL,
 CONSTRAINT [PK_KetQua] PRIMARY KEY CLUSTERED 
(
	[MaTS] ASC,
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KetQuaTungCau]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KetQuaTungCau](
	[MaND] [nchar](10) NOT NULL,
	[MaCauHoi] [nchar](10) NOT NULL,
	[CauTraLoiNguoiDung] [nchar](10) NULL,
 CONSTRAINT [PK_KetQuaTungCau] PRIMARY KEY CLUSTERED 
(
	[MaND] ASC,
	[MaCauHoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [nchar](10) NOT NULL,
	[TenKhoa] [nvarchar](50) NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[MaMon] [nchar](10) NOT NULL,
	[TenMon] [nvarchar](50) NULL,
 CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED 
(
	[MaMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 6/28/2017 4:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[MaND] [nchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[SDT] [int] NULL,
	[MaChucVu] [nchar](10) NULL,
	[MaKhoa] [nchar](10) NULL,
	[user] [nchar](10) NULL,
	[pass] [nchar](10) NULL,
 CONSTRAINT [PK_GiaoVien] PRIMARY KEY CLUSTERED 
(
	[MaND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[daptest] ([mda], [noidung], [tinhtrang]) VALUES (1, N'2         ', N'3         ')
INSERT [dbo].[daptest] ([mda], [noidung], [tinhtrang]) VALUES (2, N'2         ', N'2         ')
INSERT [dbo].[daptest] ([mda], [noidung], [tinhtrang]) VALUES (3, N'3         ', N'34        ')
INSERT [dbo].[daptest] ([mda], [noidung], [tinhtrang]) VALUES (12, N'3         ', N'4         ')
INSERT [dbo].[daptest] ([mda], [noidung], [tinhtrang]) VALUES (65, N'65        ', N'541       ')
INSERT [dbo].[KetQuaTungCau] ([MaND], [MaCauHoi], [CauTraLoiNguoiDung]) VALUES (N'1         ', N'65        ', N'1212      ')
INSERT [dbo].[KetQuaTungCau] ([MaND], [MaCauHoi], [CauTraLoiNguoiDung]) VALUES (N'2         ', N'65        ', N'1212      ')
INSERT [dbo].[KetQuaTungCau] ([MaND], [MaCauHoi], [CauTraLoiNguoiDung]) VALUES (N'3         ', N'65        ', N'1212      ')
ALTER TABLE [dbo].[CauHoi]  WITH CHECK ADD  CONSTRAINT [FK_CauHoi_De] FOREIGN KEY([MaDe])
REFERENCES [dbo].[De] ([MaDe])
GO
ALTER TABLE [dbo].[CauHoi] CHECK CONSTRAINT [FK_CauHoi_De]
GO
ALTER TABLE [dbo].[DapAN]  WITH CHECK ADD  CONSTRAINT [FK_DapAN_CauHoi] FOREIGN KEY([MaCauHoi])
REFERENCES [dbo].[CauHoi] ([MaCauHoi])
GO
ALTER TABLE [dbo].[DapAN] CHECK CONSTRAINT [FK_DapAN_CauHoi]
GO
ALTER TABLE [dbo].[De]  WITH CHECK ADD  CONSTRAINT [FK_De_GiaoVien] FOREIGN KEY([MaND])
REFERENCES [dbo].[NguoiDung] ([MaND])
GO
ALTER TABLE [dbo].[De] CHECK CONSTRAINT [FK_De_GiaoVien]
GO
ALTER TABLE [dbo].[De]  WITH CHECK ADD  CONSTRAINT [FK_De_MonHoc] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MonHoc] ([MaMon])
GO
ALTER TABLE [dbo].[De] CHECK CONSTRAINT [FK_De_MonHoc]
GO
ALTER TABLE [dbo].[KetQua]  WITH CHECK ADD  CONSTRAINT [FK_KetQua_NguoiDung] FOREIGN KEY([MaTS])
REFERENCES [dbo].[NguoiDung] ([MaND])
GO
ALTER TABLE [dbo].[KetQua] CHECK CONSTRAINT [FK_KetQua_NguoiDung]
GO
ALTER TABLE [dbo].[KetQua]  WITH CHECK ADD  CONSTRAINT [FK_LanThi_MonHoc] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MonHoc] ([MaMon])
GO
ALTER TABLE [dbo].[KetQua] CHECK CONSTRAINT [FK_LanThi_MonHoc]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_ChucVu] FOREIGN KEY([MaChucVu])
REFERENCES [dbo].[ChucVu] ([MaChucVu])
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_GiaoVien_ChucVu]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_GiaoVien_Khoa]
GO
