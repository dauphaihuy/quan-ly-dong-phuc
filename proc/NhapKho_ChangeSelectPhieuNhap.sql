USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[NhapKho_ChangeSelectPhieuNhap]    Script Date: 25/09/2024 9:03:57 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[NhapKho_ChangeSelectPhieuNhap](
@maPhieu int =null)
as
begin
select 
	ROW_NUMBER() over (order by NS_DP_PhieuNhapHang.PhieuNhapHang) stt,
	NS_DP_PhieuNhapHang_ChiTiet.ID,
	NS_DP_PhieuNhapHang.PhieuNhapHang,
	MaPhieuNhapHang, 
	TenPhieuNhapHang,
	DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
	NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc,
	NS_DP_PhieuNhapHang_ChiTiet.Size,
	DM_DP_Size.MaSize,
	SoLuong as SoLuongYeuCau,
	SoLuongDaNhap,
	DonGia,
	ThanhTien,
	DM_DP_DonViTinh.DonViTinh,
	DM_DP_DonViTinh.TenDonViTinh,
	NS_DP_PhieuNhapHang.NhaCungCap,
	TenNhaCungCap,
	TonKho.TonKho,
	NS_DP_PhieuNhapHang_ChiTiet.GhiChu,
	NS_DP_SanPham.SanPham,
	NS_DP_SanPham.TenSanPham,
	Kho,
	DM_DP_Kho.TenKho
from NS_DP_PhieuNhapHang join NS_DP_PhieuNhapHang_ChiTiet
	on NS_DP_PhieuNhapHang.PhieuNhapHang = NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang
	left join DM_DP_TinhChatDongPhuc on NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
	join DM_DP_Size on NS_DP_PhieuNhapHang_ChiTiet.Size = DM_DP_Size.Size
	join DM_DP_DonViTinh on NS_DP_PhieuNhapHang_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
	join DM_DP_NhaCungCap on NS_DP_PhieuNhapHang.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
	join NS_DP_SanPham on NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_SanPham.SanPham
	join DM_DP_Kho on DM_DP_Kho.Kho = NS_DP_PhieuNhapHang.KhoNhan
	left join (
		select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size 
		from NS_DP_XuatNhapKho_ChiTiet 
		JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
		WHERE dbo.NS_DP_XuatNhapKho.IsDel !=1
		group by SanPham, Size
				) TonKho 
	on NS_DP_PhieuNhapHang_ChiTiet.SanPham = TonKho.SanPham and TonKho.Size = NS_DP_PhieuNhapHang_ChiTiet.Size
where NS_DP_PhieuNhapHang.PhieuNhapHang = @maPhieu
END