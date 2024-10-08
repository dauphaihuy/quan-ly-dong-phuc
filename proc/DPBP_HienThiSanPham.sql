USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[DPBP_HienThiSanPham]    Script Date: 25/09/2024 8:55:56 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[DPBP_HienThiSanPham]
AS 
BEGIN 
SELECT
	dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham,
	TenSanPham,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu,
	TenNhanSu=MaNhanSu+' - '+NS_NhanSu.HoDem+' '+ NS_NhanSu.Ten,
	SoLuong,
	DM_DP_LoaiSanPham.LoaiSanPham,
	DM_DP_LoaiSanPham.TenLoaiSanPham,
	DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.DonViTinh,
	DM_DP_DonViTinh.TenDonViTinh,
	dbo.NS_DP_PhieuDeNghi_CaNhan.LyDoCapPhat,
	dbo.DM_DP_LyDoCapPhat.TenLyDoCapPhat,
	NS_DP_PhieuDeNghi_CaNhan.PhieuDeNghi_CaNhan,
	dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.ID,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.TinhChatDongPhuc,
	MaPhieuDeNghi_CaNhan,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Size ,
	dbo.DM_DP_Size.MaSize
FROM dbo.NS_DP_PhieuDeNghi_CaNhan
JOIN dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.PhieuDeNghi_CaNhan = NS_DP_PhieuDeNghi_CaNhan.PhieuDeNghi_CaNhan
JOIN dbo.NS_DP_SanPham ON dbo.NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.TinhChatDongPhuc
JOIN dbo.NS_NhanSu ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu = NS_NhanSu.NhanSu
JOIN DM_DP_LoaiSanPham on DM_DP_LoaiSanPham.LoaiSanPham = NS_DP_SanPham.LoaiSanPham
LEFT JOIN dbo.DM_DP_DonViTinh ON DM_DP_DonViTinh.DonViTinh = NS_DP_SanPham.DonViTinh
JOIN dbo.DM_DP_Size ON DM_DP_Size.Size = dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Size
JOIN dbo.DM_DP_LyDoCapPhat ON NS_DP_PhieuDeNghi_CaNhan.LyDoCapPhat = DM_DP_LyDoCapPhat.LyDoCapPhat
WHERE 1=1
		AND NS_DP_PhieuDeNghi_CaNhan.IsDel !=1 
		AND dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.IsDaChon!=1
		AND NS_DP_PhieuDeNghi_CaNhan.TrangThaiDuyet !=3
ORDER BY NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu, NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
END