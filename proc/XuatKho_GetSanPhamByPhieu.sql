USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[XuatKho_GetSanPhamByPhieu]    Script Date: 28/08/2024 6:59:23 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[XuatKho_GetSanPhamByPhieu]
(
	@xuatnhapkho int = NULL,
    @idPhieu int = NULL
)
AS
BEGIN
	SELECT DISTINCT
	ROW_NUMBER() OVER (ORDER BY NS_DP_XuatNhapKho_ChiTiet.ID) AS stt,
	NS_DP_XuatNhapKho_ChiTiet.ID,
	NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho,
	NS_DP_XuatNhapKho_ChiTiet.SanPham,
	TenSanPham,
	NS_DP_XuatNhapKho_ChiTiet.Size,
	dbo.DM_DP_Size.MaSize,
	Slyc = NS_DP_PhieuDeNghi_ChiTiet.SoLuong,
	slx.slDaXuat,
	NS_DP_XuatNhapKho_ChiTiet.DonViTinh,
	DM_DP_DonViTinh.TenDonViTinh,
	TenTinhChatDongPhuc,
	tonKho.TonKho,
	NS_DP_XuatNhapKho_ChiTiet.GhiChu,
	DM_DP_NhaCungCap.TenNhaCungCap,
	NS_DP_XuatNhapKho_ChiTiet.SoLuong
	FROM dbo.NS_DP_XuatNhapKho_ChiTiet
	LEFT JOIN dbo.NS_DP_SanPham ON NS_DP_XuatNhapKho_ChiTiet.SanPham = NS_DP_SanPham.SanPham
	LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
	LEFT JOIN dbo.DM_DP_Size ON NS_DP_XuatNhapKho_ChiTiet.Size = DM_DP_Size.Size
	LEFT JOIN dbo.DM_DP_NhaCungCap ON NS_DP_XuatNhapKho_ChiTiet.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
	LEFT JOIN dbo.DM_DP_DonViTinh ON DM_DP_DonViTinh.DonViTinh = NS_DP_XuatNhapKho_ChiTiet.DonViTinh
	LEFT JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho = NS_DP_XuatNhapKho.XuatNhapKho
	LEFT JOIN NS_DP_PhieuDeNghi_ChiTiet ON  NS_DP_XuatNhapKho.IDPhieu = NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi
		AND NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham AND
        NS_DP_PhieuDeNghi_ChiTiet.Size = NS_DP_XuatNhapKho_ChiTiet.Size
	LEFT JOIN (
			SELECT -SUM(SoLuong) slDaXuat,SanPham, Size FROM NS_DP_XuatNhapKho_ChiTiet 
		JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
		WHERE IDPhieu =@idPhieu AND LoaiPhieu =2 
		GROUP BY SanPham, Size
	) slx ON slx.SanPham =NS_DP_XuatNhapKho_ChiTiet.SanPham AND slx.Size = NS_DP_XuatNhapKho_ChiTiet.Size 
	LEFT JOIN (
	select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size ,NhaCungCap
		from NS_DP_XuatNhapKho_ChiTiet 
		group by SanPham, Size ,NhaCungCap) tonKho ON tonKho.SanPham = NS_DP_PhieuDeNghi_ChiTiet.SanPham 
			AND tonKho.Size = NS_DP_PhieuDeNghi_ChiTiet.Size AND tonkho.NhaCungCap = NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
	WHERE NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho=@xuatnhapkho AND LoaiPhieu=2
END
