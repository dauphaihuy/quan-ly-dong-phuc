USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getSanhSachSanPham]    Script Date: 25/09/2024 9:01:18 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[getSanhSachSanPham]
as 
begin
select DISTINCT * from NS_DP_PhieuNhapHang pnh 
	left join NS_DP_PhieuNhapHang_ChiTiet pnhct
	on pnh.PhieuNhapHang = pnhct.PhieuNhapHang
	left join NS_DP_SanPham sp on pnhct.SanPham = sp.SanPham
	left join DM_DP_TinhChatDongPhuc tcdp on tcdp.TinhChatDongPhuc = pnhct.TinhChatDongPhuc
end 
