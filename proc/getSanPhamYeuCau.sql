USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getSanPhamYeuCau]    Script Date: 25/09/2024 9:01:33 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[getSanPhamYeuCau] 
as 
select phieuCaNhan.PhieuDeNghi_CaNhan,size.Size,ns.NhanSu,size.MaSize,SanPham.SanPham,phieuCaNhanChiTiet.TinhChatDongPhuc,sanPham.TenSanPham,tinhChat.TenTinhChatDongPhuc,phieuCaNhanChiTiet.SoLuong
from 
[dbo].[NS_DP_PhieuDeNghi_CaNhan] phieuCaNhan 
left join [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet] phieuCaNhanChiTiet on phieuCaNhan.PhieuDeNghi_CaNhan= phieuCaNhanChiTiet.PhieuDeNghi_CaNhan
left join NS_NhanSu ns on phieuCaNhan.NguoiDeNghi= ns.NhanSu
left join DM_DP_LyDoCapPhat lyDoCap on lyDoCap.LyDoCapPhat= phieuCaNhan.LyDoCapPhat
left join NS_DP_SanPham sanPham on phieuCaNhanChiTiet.SanPham = sanPham.SanPham  
left join DM_DP_TinhChatDongPhuc tinhChat on tinhChat.TinhChatDongPhuc= phieuCaNhanChiTiet.TinhChatDongPhuc
left join DM_DP_Size size on size.Size =phieuCaNhanChiTiet.Size