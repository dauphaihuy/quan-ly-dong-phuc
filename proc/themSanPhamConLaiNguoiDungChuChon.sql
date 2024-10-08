USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[themSanPhamConLaiNguoiDungChuChon]    Script Date: 25/09/2024 9:07:40 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[themSanPhamConLaiNguoiDungChuChon](
	@PhieuDeNghi_CaNhan int = null,
	@SanPham int = null ,
	@Size int = null,
	@SoLuong int = null,
	@TinhChatDongPhuc int = null
)
AS
BEGIN
	insert into NS_DP_PhieuDeNghi_CaNhan_ChiTiet(PhieuDeNghi_CaNhan,SanPham,Size,SoLuong,TinhChatDongPhuc)
	values (@PhieuDeNghi_CaNhan,@SanPham,@Size,@SoLuong,@TinhChatDongPhuc)
END
