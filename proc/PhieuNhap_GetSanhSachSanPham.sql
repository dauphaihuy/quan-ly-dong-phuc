USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[PhieuNhap_GetSanhSachSanPham]    Script Date: 25/09/2024 9:04:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[PhieuNhap_GetSanhSachSanPham]
as 
begin
select pnhct.*,sp.TenSanPham,tcdp.TenTinhChatDongPhuc, size.MaSize, dvt.TenDonViTinh,
SoLuongConLai = pnhct.SoLuong - SoLuongDaNhap 
from NS_DP_PhieuNhapHang pnh 
	left join NS_DP_PhieuNhapHang_ChiTiet pnhct
	on pnh.PhieuNhapHang = pnhct.PhieuNhapHang
	left join NS_DP_SanPham sp on pnhct.SanPham = sp.SanPham
	left join DM_DP_TinhChatDongPhuc tcdp on tcdp.TinhChatDongPhuc = pnhct.TinhChatDongPhuc
	left join DM_DP_Size size on size.Size = pnhct.Size
	left join DM_DP_DonViTinh dvt on pnhct.DonViTinh = dvt.DonViTinh
where IsHoanThanh !=1
end 
