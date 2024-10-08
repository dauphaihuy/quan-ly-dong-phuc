USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[DPBP_GetSanPhamByPhieu]    Script Date: 25/09/2024 8:55:44 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[DPBP_GetSanPhamByPhieu]
(@Phieu int= NULL)
AS
BEGIN
    SELECT 
	ROW_NUMBER() OVER (ORDER BY PhieuDeNghi) stt,
	NS_DP_PhieuDeNghi_ChiTiet.ID,
	NS_DP_PhieuDeNghi_ChiTiet.NhanSu,
	PhieuDeNghi,
	TenNs =MaNhanSu+' - '+ dbo.NS_NhanSu.HoDem+' '+dbo.NS_NhanSu.Ten,
	NS_DP_PhieuDeNghi_ChiTiet.SanPham,
	TenSanPham,
	TenTinhChatDongPhuc,
	MaSize,
	SoLuong,
	TenLyDoCapPhat,
	NS_DP_PhieuDeNghi_ChiTiet.TrangThaiDuyet,
	TenTrangThaiDuyet,
	LyDoTuChoi,
	PhieuDeNghi_CaNhan_ChiTiet
FROM 
dbo.NS_DP_PhieuDeNghi_ChiTiet
JOIN dbo.NS_NhanSu ON NS_DP_PhieuDeNghi_ChiTiet.NhanSu = dbo.NS_NhanSu.NhanSu
JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = dbo.NS_DP_SanPham.SanPham
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
JOIN dbo.DM_DP_Size ON DM_DP_Size.Size = dbo.NS_DP_PhieuDeNghi_ChiTiet.Size
JOIN dbo.DM_DP_LyDoCapPhat ON dbo.NS_DP_PhieuDeNghi_ChiTiet.LyDoCapPhat = DM_DP_LyDoCapPhat.LyDoCapPhat
JOIN dbo.DM_DP_TrangThaiDuyet ON NS_DP_PhieuDeNghi_ChiTiet.TrangThaiDuyet = dbo.DM_DP_TrangThaiDuyet.TrangThaiDuyet
WHERE PhieuDeNghi = @Phieu
END