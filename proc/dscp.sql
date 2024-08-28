alter proc BC_DSCapPhat
as
begin
select 
-sum(SoLuong) soLuong
,NS_DP_XuatKho_ChiTiet_NhanSu.SanPham 
,NS_DP_XuatKho_ChiTiet_NhanSu.Size
,CONVERT(date,NgayNhapXuat) AS date_only 
, NS_DP_XuatKho_ChiTiet_NhanSu.NhanSu
, NS_DP_XuatKho_ChiTiet_NhanSu.TinhChatDongPhuc
, DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc
,NS_DP_XuatKho_ChiTiet_NhanSu.NhaCungCap
,DM_DP_NhaCungCap.TenNhaCungCap
,NS_DP_SanPham.TenSanPham
,NS_NhanSu.HoDem+' '+NS_NhanSu.Ten as hoTen
,DM_DP_Size.MaSize
from NS_DP_XuatKho_ChiTiet_NhanSu
join dbo.NS_DP_XuatNhapKho on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatKho_ChiTiet_NhanSu.XuatNhapKho
LEFT JOIN dbo.NS_DP_SanPham on NS_DP_SanPham.SanPham = NS_DP_XuatKho_ChiTiet_NhanSu.SanPham
LEFT JOIN dbo.DM_DP_Size on DM_DP_Size.Size = NS_DP_XuatKho_ChiTiet_NhanSu.Size
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc on DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_XuatKho_ChiTiet_NhanSu.TinhChatDongPhuc
LEFT JOIN dbo.DM_DP_NhaCungCap on DM_DP_NhaCungCap.NhaCungCap = NS_DP_XuatKho_ChiTiet_NhanSu.NhaCungCap
LEFT JOIN dbo.NS_NhanSu on NS_NhanSu.NhanSu = NS_DP_XuatKho_ChiTiet_NhanSu.NhanSu
group by NS_DP_XuatKho_ChiTiet_NhanSu.SanPham 
	,NS_DP_XuatKho_ChiTiet_NhanSu.Size
	,CONVERT(date,NS_DP_XuatNhapKho.NgayNhapXuat)
	, NS_DP_XuatKho_ChiTiet_NhanSu.NhanSu
	, NS_DP_XuatKho_ChiTiet_NhanSu.TinhChatDongPhuc
,NS_DP_XuatKho_ChiTiet_NhanSu.NhaCungCap
,DM_DP_NhaCungCap.TenNhaCungCap
,NS_DP_SanPham.TenSanPham
,NS_NhanSu.HoDem+' '+NS_NhanSu.Ten
,DM_DP_Size.MaSize
, DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc
order by date_only
end 
go
exec BC_DSCapPhat