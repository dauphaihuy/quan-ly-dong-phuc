USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getPhieuDeNghiCaNhan]    Script Date: 25/09/2024 9:00:03 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[getPhieuDeNghiCaNhan]
as
select pdnCaNhan.PhieuDeNghi_CaNhan, pdnCaNhan.MaPhieuDeNghi_CaNhan,MaNguoiDeNghi=NguoiDeNghi,lyDoCap.LyDoCapPhat,NguoiDeNghi=NhanSu.HoDem+' '+nhanSu.Ten,pdnCaNhan.IsHoanThanh,pdnCaNhan.NgayDeNghi,lydo=lyDoCap.TenLyDoCapPhat,TrangThaiDuyet,pdnCaNhan.IsDel
from [NS_DP_PhieuDeNghi_CaNhan] pdnCaNhan left join [dbo].[NS_NhanSu] nhanSu on pdnCaNhan.NguoiDeNghi=nhanSu.NhanSu
	 left join [dbo].[DM_DP_LyDoCapPhat] lyDoCap on pdnCaNhan.LyDoCapPhat=lyDoCap.LyDoCapPhat
