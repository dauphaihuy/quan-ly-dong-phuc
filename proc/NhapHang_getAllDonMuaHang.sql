USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[NhapHang_getAllDonMuaHang]    Script Date: 25/09/2024 9:02:03 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[NhapHang_getAllDonMuaHang]
AS
begin
SELECT 
	ROW_NUMBER() OVER (ORDER BY PhieuNhapHang) stt,
	PhieuNhapHang,
	TenPhieuNhapHang,
	MaPhieuNhapHang,
	NgayDatHang,
	Hoten = NS_NhanSu.HoDem+' '+NS_NhanSu.Ten,
	NS_DP_PhieuNhapHang.NhaCungCap,
	TenNhaCungCap,
	TongSLMua,
	TongSLDaNhap,
	TongThanhToan,
	IsHoanThanh,
	NS_DP_PhieuNhapHang.GhiChu
FROM 
dbo.NS_DP_PhieuNhapHang 
LEFT JOIN dbo.NS_NhanSu ON dbo.NS_DP_PhieuNhapHang.NguoiDatHang = dbo.NS_NhanSu.NhanSu
LEFT JOIN dbo.DM_DP_NhaCungCap ON DM_DP_NhaCungCap.NhaCungCap = NS_DP_PhieuNhapHang.NhaCungCap
WHERE NS_DP_PhieuNhapHang.IsDel !=1
END 
