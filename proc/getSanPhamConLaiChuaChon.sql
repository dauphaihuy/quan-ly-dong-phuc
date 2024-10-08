USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getSanPhamConLaiChuaChon]    Script Date: 25/09/2024 9:01:28 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER procedure [dbo].[getSanPhamConLaiChuaChon](
	@MaPhieuDeNghi_CaNhan nvarchar(50) = NULL,
	@NguoiDeNghi int = NULL
)
AS
BEGIN
	select * from NS_DP_SanPham 
	where SanPham not in (
		select sanPham.SanPham
		from 
		[dbo].[NS_DP_PhieuDeNghi_CaNhan] phieuCaNhan 
		left join [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet] phieuCaNhanChiTiet on phieuCaNhan.PhieuDeNghi_CaNhan= phieuCaNhanChiTiet.PhieuDeNghi_CaNhan
		left join NS_NhanSu ns on phieuCaNhan.NguoiDeNghi= ns.NhanSu
		left join DM_DP_LyDoCapPhat lyDoCap on lyDoCap.LyDoCapPhat= phieuCaNhan.LyDoCapPhat
		left join NS_DP_SanPham sanPham on phieuCaNhanChiTiet.SanPham = sanPham.SanPham  
		left join DM_DP_TinhChatDongPhuc tinhChat on tinhChat.TinhChatDongPhuc= phieuCaNhanChiTiet.TinhChatDongPhuc
		left join DM_DP_Size size on size.Size =phieuCaNhanChiTiet.Size
		where phieuCaNhan.MaPhieuDeNghi_CaNhan =@MaPhieuDeNghi_CaNhan 
		and NguoiDeNghi = @NguoiDeNghi
		and sanPham.IsDel !=1
	)and IsDel!=1 and GioiTinh in ((select GioiTinh from NS_NhanSu where NhanSu = @NguoiDeNghi), 2)
END
