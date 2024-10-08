USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getSanPhamByNhaCungCap]    Script Date: 25/09/2024 9:01:23 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[getSanPhamByNhaCungCap] (
	@NhaCungCap int=null
)
as
begin
select sp.SanPham,TenSanPham,size.MaSize,size.Size,
sptcdp.DonGia,dvt.TenDonViTinh,sp.DonViTinh,ncc.NhaCungCap,ncc.TenNhaCungCap ,
tcpd.TenTinhChatDongPhuc,tcpd.TinhChatDongPhuc
from
NS_DP_SanPham sp join NS_DP_SanPham_TinhChatDongPhuc sptcdp on sp.SanPham=sptcdp.SanPham
left join DM_DP_TinhChatDongPhuc tcpd on sptcdp.TinhChatDongPhuc = tcpd.TinhChatDongPhuc
join DM_DP_Size size on size.LoaiSanPham = sp.LoaiSanPham
join DM_DP_NhaCungCap ncc on ncc.NhaCungCap = sptcdp.NhaCungCap
join DM_DP_DonViTinh dvt on dvt.DonViTinh=sp.DonViTinh
where ncc.NhaCungCap=@NhaCungCap
order by sp.SanPham, MaSize asc
end
