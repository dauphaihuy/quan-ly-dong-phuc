USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[XuatKho_getAllPhieuXuatKho]    Script Date: 25/09/2024 9:07:57 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[XuatKho_getAllPhieuXuatKho]
AS   

   SET NOCOUNT ON;
   SELECT 
  ROW_NUMBER() OVER (ORDER BY NS_DP_XuatNhapKho.XuatNhapKho) AS stt,
  HoTenNguoiXuat = dbo.NS_NhanSu.HoDem +' '+NS_NhanSu.Ten,
  XuatNhapKho,
  Kho,
  LoaiPhieu,
  IDPhieu,
  NguoiTao,
  NS_DP_XuatNhapKho.NgayTao,
  NS_DP_XuatNhapKho.IsDel,
  NS_DP_XuatNhapKho.NguoiNhapXuat,
  NS_DP_XuatNhapKho.NgayNhapXuat,
  NS_DP_XuatNhapKho.GhiChu,
  MaXuatNhapKho
FROM dbo.NS_DP_XuatNhapKho
LEFT JOIN dbo.NS_NhanSu ON NS_NhanSu.NhanSu = NS_DP_XuatNhapKho.NguoiTao
WHERE LoaiPhieu = 2 AND NS_DP_XuatNhapKho.IsDel!=1
