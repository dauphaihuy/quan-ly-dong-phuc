USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[DPBP_GetAllPhieuDeNghi]    Script Date: 25/09/2024 8:55:22 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[DPBP_GetAllPhieuDeNghi]
AS
BEGIN
	SELECT 
	IsHoanThanh,
	ROW_NUMBER() OVER (ORDER BY MaPhieuDeNghi) stt,
	MaPhieuDeNghi,
	PhieuDeNghi,
	TenNhanSu =NS_NhanSu.HoDem+' '+ NS_NhanSu.Ten,
	MaNhanSu,
	NgayDeNghi,
	NS_DP_PhieuDeNghi.GhiChu,
	TongSLYeuCau,
	NS_DP_PhieuDeNghi.TongSLNhan,
	NguoiDuyet1,
	NgayDuyet1,
	LyDoTuChoi,
	TrangThaiDuyet,
	DM_DP_TrangThaiDuyet.TenTrangThaiDuyet,
	DM_DP_TrangThaiDuyet.IsDel
	FROM 
	dbo.NS_DP_PhieuDeNghi 
	LEFT JOIN dbo.NS_NhanSu ON NS_DP_PhieuDeNghi.NguoiDeNghi = NS_NhanSu.NhanSu
	LEFT JOIN dbo.DM_DP_TrangThaiDuyet ON NS_DP_PhieuDeNghi.TrangThai = DM_DP_TrangThaiDuyet.TrangThaiDuyet
	WHERE NS_DP_PhieuDeNghi.IsDel != 1
END