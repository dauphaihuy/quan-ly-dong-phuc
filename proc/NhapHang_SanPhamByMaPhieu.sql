USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[NhapHang_SanPhamByMaPhieu]    Script Date: 25/09/2024 9:03:52 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[NhapHang_SanPhamByMaPhieu]
(
	@phieu INT = NULL
)
AS
begin
SELECT 
	ROW_NUMBER() OVER (ORDER BY PhieuNhapHang) stt,
	NS_DP_PhieuNhapHang_ChiTiet.ID,
	PhieuNhapHang,
	NS_DP_PhieuNhapHang_ChiTiet.SanPham,
	TenSanPham,
	DM_DP_TinhChatDongPhuc.TinhChatDongPhuc,
	TenTinhChatDongPhuc,
	NS_DP_PhieuNhapHang_ChiTiet.Size,
	MaSize,
	SoLuong,
	NS_DP_PhieuNhapHang_ChiTiet.DonGia,
	ThanhTien,
	SoLuongDaNhap,
	SLConLai = SoLuong- SoLuongDaNhap,
	NS_DP_PhieuNhapHang_ChiTiet.DonViTinh,
	TenDonViTinh,
	GhiChu
FROM dbo.NS_DP_PhieuNhapHang_ChiTiet
JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_SanPham.SanPham
JOIN dbo.DM_DP_Size ON DM_DP_Size.Size = NS_DP_PhieuNhapHang_ChiTiet.Size
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc
JOIN dbo.DM_DP_DonViTinh ON NS_DP_PhieuNhapHang_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
WHERE PhieuNhapHang =@phieu
END
