USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[NhapKho_getSoLuongDeXoa]    Script Date: 25/09/2024 9:04:12 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[NhapKho_getSoLuongDeXoa]
(
	 @XuatNhapKho int =null
)
as 
begin
	select NS_DP_XuatNhapKho.XuatNhapKho,
	NS_DP_XuatNhapKho.MaXuatNhapKho ,
	NS_DP_XuatNhapKho.IDPhieu,
	NS_DP_XuatNhapKho_ChiTiet.SanPham,
	NS_DP_XuatNhapKho_ChiTiet.Size,
	NS_DP_XuatNhapKho_ChiTiet.SoLuong
	from NS_DP_XuatNhapKho 
	left join NS_DP_XuatNhapKho_ChiTiet on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
	where NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho = @XuatNhapKho
end 
