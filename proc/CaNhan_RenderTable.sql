USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[CaNhan_RenderTable]    Script Date: 25/09/2024 8:55:12 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[CaNhan_RenderTable]
AS
BEGIN 
SELECT 
	PhieuDeNghi_CaNhan,
	IsHoanThanh,
	ROW_NUMBER() OVER (ORDER BY PhieuDeNghi_CaNhan) stt,
	HoTenNguoiDeNghi = HoDem+' '+Ten,
	MaPhieuDeNghi_CaNhan,
	NgayDeNghi,
	IsNhanVienMoi,
	TenLyDoCapPhat,
	NguoiDuyet,
	NS_DP_PhieuDeNghi_CaNhan.TrangThaiDuyet,
	NS_DP_PhieuDeNghi_CaNhan.IsDel,
	TenTrangThaiDuyet
FROM dbo.NS_DP_PhieuDeNghi_CaNhan
LEFT JOIN dbo.DM_DP_LyDoCapPhat ON NS_DP_PhieuDeNghi_CaNhan.LyDoCapPhat = DM_DP_LyDoCapPhat.LyDoCapPhat
LEFT JOIN dbo.NS_NhanSu ON NS_DP_PhieuDeNghi_CaNhan.NguoiDeNghi = NhanSu
LEFT JOIN dbo.DM_DP_TrangThaiDuyet ON NS_DP_PhieuDeNghi_CaNhan.TrangThaiDuyet = dbo.DM_DP_TrangThaiDuyet.TrangThaiDuyet
WHERE NS_DP_PhieuDeNghi_CaNhan.IsDel !=1
END 
