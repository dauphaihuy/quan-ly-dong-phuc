USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getDanhSachSanPham]    Script Date: 25/09/2024 8:59:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getDanhSachSanPham]
AS
BEGIN
	SELECT s.*, L.TenLoaiSanPham, D.TenDonViTinh, G.TenGioiTinh, NS_DP_SanPham_LienKet.TenSanPhamLK
	FROM NS_DP_SanPham S 
		LEFT JOIN DM_DP_LoaiSanPham L ON S.LoaiSanPham = L.LoaiSanPham
		LEFT JOIN DM_DP_DonViTinh D ON D.DonViTinh = S.DonViTinh
		LEFT JOIN NS_DP_GioiTinh G ON G.GioiTinh = S.GioiTinh
		LEFT JOIN (select SanPham, TenSanPham TenSanPhamLK from NS_DP_SanPham) NS_DP_SanPham_LienKet on NS_DP_SanPham_LienKet.SanPham = S.SanPhamLienKet
END