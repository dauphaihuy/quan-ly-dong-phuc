USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[NhapKho_GetSelectPhieuNhapHang]    Script Date: 25/09/2024 9:04:08 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[NhapKho_GetSelectPhieuNhapHang]
as
begin
select PhieuNhapHang, TenVaMaPhieu= MaPhieuNhapHang +' - '+TenPhieuNhapHang,IsDel,IsHoanThanh from NS_DP_PhieuNhapHang
where IsDel !=1 and IsHoanThanh !=1
end 
