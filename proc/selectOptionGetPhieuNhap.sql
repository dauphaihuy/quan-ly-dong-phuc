USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[selectOptionGetPhieuNhap]    Script Date: 25/09/2024 9:04:34 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[selectOptionGetPhieuNhap]
as
begin
select MaVaTenPhieu=MaPhieuNhapHang+' - '+TenPhieuNhapHang,* from NS_DP_PhieuNhapHang
where IsDel !=1 and IsHoanThanh !=1
end 
