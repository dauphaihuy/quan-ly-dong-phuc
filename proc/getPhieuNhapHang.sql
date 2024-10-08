USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getPhieuNhapHang]    Script Date: 25/09/2024 9:00:09 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getPhieuNhapHang]
AS
BEGIN
	SELECT PNH.*, 
		NS.HoDem, 
		NS.Ten, 
		NCC.TenNhaCungCap,
		PNH_CT.ID,
		PNH_CT.SoLuong,
		PNH_CT.DonGia,
		PNH_CT.ThanhTien,
		PNH_CT.SoLuongDaNhap,
		PNH_CT.GhiChu AS GhiChuChiTiet,
		SP.TenSanPham,
		TC_DP.TenTinhChatDongPhuc,
		S.MaSize,
		DVT.TenDonViTinh
		
	FROM NS_DP_PhieuNhapHang PNH
	LEFT JOIN NS_NhanSu NS ON NS.NhanSu = PNH.NguoiDatHang
	LEFT JOIN DM_DP_NhaCungCap NCC ON NCC.NhaCungCap = PNH.NhaCungCap
	LEFT JOIN NS_DP_PhieuNhapHang_ChiTiet PNH_CT ON PNH_CT.PhieuNhapHang = PNH.PhieuNhapHang
	LEFT JOIN DM_DP_TinhChatDongPhuc TCDP ON TCDP.TinhChatDongPhuc = PNH_CT.TinhChatDongPhuc
	LEFT JOIN NS_DP_SanPham SP ON SP.SanPham = PNH_CT.SanPham
	LEFT JOIN DM_DP_TinhChatDongPhuc TC_DP ON TC_DP.TinhChatDongPhuc = PNH_CT.TinhChatDongPhuc
	LEFT JOIN DM_DP_Size S ON S.Size = PNH_CT.Size
	LEFT JOIN DM_DP_DonViTinh DVT ON DVT.DonViTinh = PNH_CT.DonViTinh
END