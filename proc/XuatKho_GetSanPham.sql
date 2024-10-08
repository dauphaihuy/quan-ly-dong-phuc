USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[XuatKho_GetSanPham]    Script Date: 28/08/2024 6:59:45 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[XuatKho_GetSanPham]
(
	@PhieuDeNghi INT ,
	@NhaCungCap INT 
)
AS
BEGIN
SET NOCOUNT ON
	SELECT 
ROW_NUMBER() OVER (ORDER BY NS_DP_PhieuDeNghi_ChiTiet.ID) stt,
	ISNULL(o.TonKho,0) AS tonKho,
	NS_DP_PhieuDeNghi_ChiTiet.ID,
	NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi,
	NS_DP_PhieuDeNghi_ChiTiet.SanPham,
	TenTinhChatDongPhuc,
	DM_DP_Size.MaSize,
	SoLuongDaNhan,
	SoLuong,
	TenDonViTinh,
	DM_DP_DonViTinh.DonViTinh,
	NS_DP_PhieuDeNghi_ChiTiet.Size,
	NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc,
	NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap,
	dbo.DM_DP_NhaCungCap.TenNhaCungCap,
	NS_DP_SanPham.TenSanPham,
	DonGia,
	NS_DP_PhieuDeNghi_ChiTiet.NhanSu
	FROM dbo.NS_DP_PhieuDeNghi_ChiTiet 
LEFT JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham.SanPham
LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc 
ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham 
and NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
LEFT JOIN dbo.DM_DP_Size ON dbo.NS_DP_PhieuDeNghi_ChiTiet.Size = DM_DP_Size.Size
LEFT JOIN NS_DP_PhieuDeNghi ON NS_DP_PhieuDeNghi.PhieuDeNghi = NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi
LEFT JOIN dbo.DM_DP_DonViTinh ON NS_DP_PhieuDeNghi_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
LEFT JOIN (select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size ,NhaCungCap
		from NS_DP_XuatNhapKho_ChiTiet 
		group by SanPham, Size ,NhaCungCap )o ON  o.SanPham=NS_DP_PhieuDeNghi_ChiTiet.SanPham AND
												o.Size = NS_DP_PhieuDeNghi_ChiTiet.Size AND
                                                NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = o.NhaCungCap
LEFT JOIN dbo.DM_DP_NhaCungCap ON NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = dbo.DM_DP_NhaCungCap.NhaCungCap
WHERE NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = @NhaCungCap AND NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi=@PhieuDeNghi
AND NS_DP_PhieuDeNghi_ChiTiet.SoLuong != NS_DP_PhieuDeNghi_ChiTiet.SoLuongDaNhan
END
