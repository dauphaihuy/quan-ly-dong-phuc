USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getXuatNhapKho]    Script Date: 25/09/2024 9:01:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getXuatNhapKho]
AS
BEGIN
	SELECT XNK.*,
	K.TenKho,
	NS.HoDem,
	NS.Ten,
	NCC.TenNhaCungCap
	FROM NS_DP_XuatNhapKho XNK
	LEFT JOIN NS_DP_PhieuNhapHang PNH ON PNH.MaPhieuNhapHang = XNK.MaXuatNhapKho
	LEFT JOIN DM_DP_Kho K ON K.Kho = XNK.Kho
	LEFT JOIN NS_NhanSu NS ON NS.NhanSu = XNK.NguoiNhapXuat
	LEFT JOIN DM_DP_NhaCungCap NCC ON NCC.NhaCungCap = XNK.NhaCungCap
END