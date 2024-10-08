USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[NhapKho_getAllDanhSachNhapHang]    Script Date: 25/09/2024 9:04:02 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[NhapKho_getAllDanhSachNhapHang]
as
begin
	select distinct ROW_NUMBER() OVER(ORDER BY NS_DP_XuatNhapKho.XuatNhapKho) 
	stt,
	NS_DP_XuatNhapKho.*,
	DM_DP_Kho.TenKho,
	DM_DP_NhaCungCap.TenNhaCungCap from NS_DP_XuatNhapKho
	left join DM_DP_NhaCungCap on NS_DP_XuatNhapKho.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
	left join DM_DP_Kho on NS_DP_XuatNhapKho.Kho = DM_DP_Kho.Kho
	WHERE NS_DP_XuatNhapKho.IsDel !=1 AND
    LoaiPhieu =1
end 
