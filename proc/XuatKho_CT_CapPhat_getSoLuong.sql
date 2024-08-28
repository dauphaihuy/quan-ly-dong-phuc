
create proc XuatKho_CT_CapPhat_getSoLuong
(
	@SanPham int,
	@NhaCC int,
	@Size int,
	@TCDP int
)
as
begin
SELECT sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) soLuong
		,NS_DP_XuatNhapKho_ChiTiet.SanPham
		,NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
		,NS_DP_XuatNhapKho_ChiTiet.Size
		,NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc from dbo.NS_DP_XuatNhapKho_ChiTiet
LEFT JOIN NS_DP_XuatNhapKho on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
where LoaiPhieu =1 and 
					NS_DP_XuatNhapKho_ChiTiet.SanPham=@SanPham
					and NS_DP_XuatNhapKho_ChiTiet.NhaCungCap= @NhaCC
					and NS_DP_XuatNhapKho_ChiTiet.Size=@Size
					and NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc=@TCDP
group by NS_DP_XuatNhapKho_ChiTiet.SanPham
		,NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
		,NS_DP_XuatNhapKho_ChiTiet.Size 
		,NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc
end 
go