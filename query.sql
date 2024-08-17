--USE master
--GO
--/****** Object:  StoredProcedure [dbo].[getDanhSachSanPham]    Script Date: 13/04/2024 9:22:25 SA ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--create PROCEDURE [dbo].[getDanhSachSanPham]
--AS
--BEGIN
--	SELECT s.*, L.TenLoaiSanPham, D.TenDonViTinh, G.TenGioiTinh, NS_DP_SanPham_LienKet.TenSanPhamLK
--	FROM NS_DP_SanPham S 
--		LEFT JOIN DM_DP_LoaiSanPham L ON S.LoaiSanPham = L.LoaiSanPham
--		LEFT JOIN DM_DP_DonViTinh D ON D.DonViTinh = S.DonViTinh
--		LEFT JOIN NS_DP_GioiTinh G ON G.GioiTinh = S.GioiTinh
--		LEFT JOIN (select SanPham, TenSanPham TenSanPhamLK from NS_DP_SanPham) NS_DP_SanPham_LienKet on NS_DP_SanPham_LienKet.SanPham = S.SanPhamLienKet
--END
--update [NS_DP_PhieuDeNghi_CaNhan]
--set IsHoanThanh=0
--where PhieuDeNghi_CaNhan in(12,13,14)

--select * from NS_NhanSu
--select * from [dbo].[DM_DP_TinhChatDongPhuc]

--CREATE PROCEDURE procedure_name
--AS
--sql_statement
--GO;
--SELECT        NS_DP_PhieuDeNghi_CaNhan.NguoiDeNghi, NS_NhanSu.NhanSu, DM_DP_LyDoCapPhat.TenLyDoCapPhat, DM_DP_LyDoCapPhat.LyDoCapPhat, NS_DP_PhieuDeNghi_CaNhan.TrangThaiDuyet, 
--                         NS_DP_PhieuDeNghi_CaNhan.NgayTao, NS_DP_PhieuDeNghi_CaNhan.NguoiTao, NS_DP_PhieuDeNghi_CaNhan.NgayDeNghi, NS_NhanSu.Ten, NS_NhanSu.HoDem
--FROM            NS_DP_PhieuDeNghi_CaNhan CROSS JOIN
--                         NS_NhanSu CROSS JOIN
--                         DM_DP_LyDoCapPhat

--where NguoiDeNghi in (1)
--select * from NS_NhanSu

--select * from NS_QuocTich




--select * from NS_NhanSu


--SELECT ROW_NUMBER() OVER (ORDER BY NS_DP_SanPham.LoaiSanPham,NS_DP_SanPham.TenSanPham) AS STT,
--			   NS_DP_SanPham.SanPham,
--			   CASE WHEN @NgonNgu = 'vi' THEN (CASE WHEN SPLK.TenSanPham IS NULL THEN NS_DP_SanPham.TenSanPham ELSE NS_DP_SanPham.TenSanPham + ' - ' + SPLK.TenSanPham END)
--					WHEN @NgonNgu = 'en' THEN (CASE WHEN SPLK.TenSanPham_EN IS NULL THEN NS_DP_SanPham.TenSanPham_EN ELSE NS_DP_SanPham.TenSanPham_EN + ' - ' + SPLK.TenSanPham_EN END)
--					WHEN @NgonNgu = 'jp' THEN (CASE WHEN SPLK.TenSanPham_JP IS NULL THEN NS_DP_SanPham.TenSanPham_JP ELSE NS_DP_SanPham.TenSanPham_JP + ' - ' + SPLK.TenSanPham_JP END) END TenSanPham,
--			   @NhanSu NhanSu,
--			   1 SoLuong,
--			   NS_DP_SanPham.LoaiSanPham,
--			   TenLoaiSanPham,
--			   DM_DonViTinh.DonViTinh,
--			   TenDonViTinh,
--			   CASE WHEN IsCoSize = 1 THEN 0 ELSE - 1 END Size,
--			   ISNULL(NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc,0) TinhChatDongPhuc,
--			   IsCoSize
--		FROM dbo.NS_DP_SanPham
--			INNER JOIN dbo.DM_DP_LoaiSanPham ON DM_DP_LoaiSanPham.LoaiSanPham = NS_DP_SanPham.LoaiSanPham
--			LEFT JOIN dbo.DM_DonViTinh ON DM_DonViTinh.DonViTinh = NS_DP_SanPham.DonViTinh
--			LEFT JOIN (SELECT SanPham, TenSanPham, TenSanPham_EN, TenSanPham_JP FROM dbo.NS_DP_SanPham) SPLK ON SPLK.SanPham = NS_DP_SanPham.SanPhamLienKet
--			LEFT JOIN (SELECT SanPham, TinhChatDongPhuc FROM dbo.NS_DP_SanPham_TinhChatDongPhuc WHERE TinhChatDongPhuc = 2 AND NhaCungCap = 1) NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.SanPham = NS_DP_SanPham.SanPham
--			LEFT JOIN (SELECT NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham, SUM(SoLuong) SoLuongDaChon
--						FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
--							INNER JOIN dbo.NS_DP_SanPham ON NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
--						WHERE PhieuDeNghi_CaNhan = @ID
--						GROUP BY NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham
--					  ) SanPhamDaChon ON SanPhamDaChon.SanPham = NS_DP_SanPham.SanPham
--		WHERE ISNULL(NS_DP_SanPham.IsDel,0) = 0 AND (GioiTinh IS NULL OR GioiTinh = ISNULL(@GioiTinh,0))
--			  AND (NS_DP_SanPham.LoaiSanPham <> 1 AND (SanPhamLienKet > 0 OR ISNULL(SanPhamLienKet,0) = 0))
--			  AND 2 = CASE WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) IN (1,3,5) AND ISNULL(SanPhamDaChon.SoLuongDaChon,0) < 3 THEN 2
--						 WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) NOT IN (1,3,5) AND SanPhamDaChon.SanPham IS NULL THEN 2
--						 ELSE 0
--						 END
--		ORDER BY IsCoSize DESC

----procedure xóa sản phẩm 
----int maPhieu,int nguoiDeNghi,int lyDoCapPhat


--drop proc updateLyDoCapPhat
--select * 
--from [dbo].[NS_DP_PhieuDeNghi_CaNhan] phieuCaNhan
--where MaPhieuDeNghi_CaNhan =17 and NguoiDeNghi=8
--select * from [NS_DP_PhieuDeNghi_CaNhan]
--exec updateLyDoCapPhat 17 ,8, 3

--INSERT INTO DM_DP_Size
----(MaSize, LoaiSanPham, NguoiTao, IsDel)
----VALUES
----(35, 6, 1, 0),
----(36, 6, 1, 0),
----(37, 6, 1, 0),
----(38, 6, 1, 0),
----(39, 6, 1, 0),
----(40, 6, 1, 0),
----(41, 6, 1, 0),
----(42, 6, 1, 0),
----(43, 6, 1, 0),
----(44, 6, 1, 0);
----INSERT INTO DM_DP_Size
----(MaSize, LoaiSanPham, NguoiTao, IsDel)
----VALUES
----('44-NC', 10, 1, 0),
----('45-NC', 10, 1, 0)

----get tính chất theo mã sp
--select * from 
--NS_DP_SanPham sp 
--join NS_DP_SanPham_TinhChatDongPhuc spTinhChatDp on sp.SanPham = spTinhChatDp.SanPham
--join DM_DP_TinhChatDongPhuc tcdp on tcdp.TinhChatDongPhuc=spTinhChatDp.TinhChatDongPhuc

----getSanPhamConLaiNguoiDungChuaChon
----lấy ra sản phẩm mà người ta chưa chọn
----phieuDeNghiCaNhan
----NhanVienMoi
----NhanSu 
----GioiTinh
--create  procedure getSanPhamConLaiChuaChon(
--	@MaPhieuDeNghi_CaNhan nvarchar(50) = NULL,
--	@NguoiDeNghi int = NULL
--)
--AS
--BEGIN
--	select * from NS_DP_SanPham 
--	where SanPham not in (
--		select sanPham.SanPham
--		from 
--		[dbo].[NS_DP_PhieuDeNghi_CaNhan] phieuCaNhan 
--		left join [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet] phieuCaNhanChiTiet on phieuCaNhan.PhieuDeNghi_CaNhan= phieuCaNhanChiTiet.PhieuDeNghi_CaNhan
--		left join NS_NhanSu ns on phieuCaNhan.NguoiDeNghi= ns.NhanSu
--		left join DM_DP_LyDoCapPhat lyDoCap on lyDoCap.LyDoCapPhat= phieuCaNhan.LyDoCapPhat
--		left join NS_DP_SanPham sanPham on phieuCaNhanChiTiet.SanPham = sanPham.SanPham  
--		left join DM_DP_TinhChatDongPhuc tinhChat on tinhChat.TinhChatDongPhuc= phieuCaNhanChiTiet.TinhChatDongPhuc
--		left join DM_DP_Size size on size.Size =phieuCaNhanChiTiet.Size
--		where phieuCaNhan.MaPhieuDeNghi_CaNhan =@MaPhieuDeNghi_CaNhan 
--		and NguoiDeNghi = @NguoiDeNghi
--		and sanPham.IsDel !=1
--	)and IsDel!=1 and GioiTinh in ((select GioiTinh from NS_NhanSu where NhanSu = @NguoiDeNghi), 2)
--END
--GO

--exec getSanPhamConLaiChuaChon 'ICPM2' ,10

--select * from NS_DP_PhieuDeNghi_CaNhan
--select *
--from 
--[dbo].[NS_DP_PhieuDeNghi_CaNhan] phieuCaNhan 
--left join [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet] phieuCaNhanChiTiet on phieuCaNhan.PhieuDeNghi_CaNhan= phieuCaNhanChiTiet.PhieuDeNghi_CaNhan
--left join NS_NhanSu ns on phieuCaNhan.NguoiDeNghi= ns.NhanSu
--left join DM_DP_LyDoCapPhat lyDoCap on lyDoCap.LyDoCapPhat= phieuCaNhan.LyDoCapPhat
--left join NS_DP_SanPham sanPham on phieuCaNhanChiTiet.SanPham = sanPham.SanPham  
--left join DM_DP_TinhChatDongPhuc tinhChat on tinhChat.TinhChatDongPhuc= phieuCaNhanChiTiet.TinhChatDongPhuc
--left join DM_DP_Size size on size.Size =phieuCaNhanChiTiet.Size
--where phieuCaNhan.PhieuDeNghi_CaNhan =39 and NguoiDeNghi =8 and sanPham.GioiTinh in ((select GioiTinh from NS_NhanSu where NhanSu =8) ,2)

--select * from NS_DP_PhieuDeNghi_CaNhan

----11/07
----insert thêm dữ liệu
--select *
--from NS_DP_PhieuDeNghi_CaNhan pdn 
--left join NS_DP_PhieuDeNghi_CaNhan_ChiTiet phieuChiTiet on pdn.PhieuDeNghi_CaNhan= phieuChiTiet.PhieuDeNghi_CaNhan
--where MaPhieuDeNghi_CaNhan ='ULIB7'
--PhieuDeNghi_CaNhan,MaPhieuDeNghi_CaNhan,NguoiDeNghi,NgayDeNghi,NguoiTao,NgayTao,IsDel,IsHoanThanh,PhieuDeNghi_CaNhan,SanPham,Size,SoLuong,TinhChatDongPhuc

--select * from NS_DP_PhieuDeNghi_CaNhan_ChiTiet

--select PhieuDeNghi_CaNhan from NS_DP_PhieuDeNghi_CaNhan
--Where MaPhieuDeNghi_CaNhan ='ULIB7'
----themSanPhamConLaiNguoiDungChuChon
--create procedure themSanPhamConLaiNguoiDungChuChon(
--	@PhieuDeNghi_CaNhan int = null,
--	@SanPham int = null ,
--	@Size int = null,
--	@SoLuong int = null,
--	@TinhChatDongPhuc int = null
--)
--AS
--BEGIN
--	insert into NS_DP_PhieuDeNghi_CaNhan_ChiTiet(PhieuDeNghi_CaNhan,SanPham,Size,SoLuong,TinhChatDongPhuc)
--	values (@PhieuDeNghi_CaNhan,@SanPham,@Size,@SoLuong,@TinhChatDongPhuc)
--END
--GO

--SELECT ROW_NUMBER() OVER (ORDER BY NS_DP_SanPham.LoaiSanPham,NS_DP_SanPham.TenSanPham) AS STT,
--			   NS_DP_SanPham.SanPham,
--			   CASE WHEN @NgonNgu = 'vi' THEN (CASE WHEN SPLK.TenSanPham IS NULL THEN NS_DP_SanPham.TenSanPham ELSE NS_DP_SanPham.TenSanPham + ' - ' + SPLK.TenSanPham END)
--					WHEN @NgonNgu = 'en' THEN (CASE WHEN SPLK.TenSanPham_EN IS NULL THEN NS_DP_SanPham.TenSanPham_EN ELSE NS_DP_SanPham.TenSanPham_EN + ' - ' + SPLK.TenSanPham_EN END)
--					WHEN @NgonNgu = 'jp' THEN (CASE WHEN SPLK.TenSanPham_JP IS NULL THEN NS_DP_SanPham.TenSanPham_JP ELSE NS_DP_SanPham.TenSanPham_JP + ' - ' + SPLK.TenSanPham_JP END) END TenSanPham,
--			   @NhanSu NhanSu,
--			   1 SoLuong,
--			   NS_DP_SanPham.LoaiSanPham,
--			   TenLoaiSanPham,
--			   DM_DonViTinh.DonViTinh,
--			   TenDonViTinh,
--			   CASE WHEN IsCoSize = 1 THEN 0 ELSE - 1 END Size,
--			   ISNULL(NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc,0) TinhChatDongPhuc,
--			   IsCoSize
--		FROM dbo.NS_DP_SanPham
--			INNER JOIN dbo.DM_DP_LoaiSanPham ON DM_DP_LoaiSanPham.LoaiSanPham = NS_DP_SanPham.LoaiSanPham
--			LEFT JOIN dbo.DM_DonViTinh ON DM_DonViTinh.DonViTinh = NS_DP_SanPham.DonViTinh
--			LEFT JOIN (SELECT SanPham, TenSanPham, TenSanPham_EN, TenSanPham_JP FROM dbo.NS_DP_SanPham) SPLK ON SPLK.SanPham = NS_DP_SanPham.SanPhamLienKet
--			LEFT JOIN (SELECT SanPham, TinhChatDongPhuc FROM dbo.NS_DP_SanPham_TinhChatDongPhuc WHERE TinhChatDongPhuc = 2 AND NhaCungCap = 1) NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.SanPham = NS_DP_SanPham.SanPham
--			LEFT JOIN (SELECT NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham, SUM(SoLuong) SoLuongDaChon
--						FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
--							INNER JOIN dbo.NS_DP_SanPham ON NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
--						WHERE PhieuDeNghi_CaNhan = @ID
--						GROUP BY NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham
--					  ) SanPhamDaChon ON SanPhamDaChon.SanPham = NS_DP_SanPham.SanPham
--		WHERE ISNULL(NS_DP_SanPham.IsDel,0) = 0 AND (GioiTinh IS NULL OR GioiTinh = ISNULL(@GioiTinh,0))
--			  AND (NS_DP_SanPham.LoaiSanPham <> 1 AND (SanPhamLienKet > 0 OR ISNULL(SanPhamLienKet,0) = 0))
--			  AND 2 = CASE WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) IN (1,3,5) AND ISNULL(SanPhamDaChon.SoLuongDaChon,0) < 3 THEN 2
--						 WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) NOT IN (1,3,5) AND SanPhamDaChon.SanPham IS NULL THEN 2
--						 ELSE 0
--						 END
--		ORDER BY IsCoSize DESC

--create procedure getsize
--as begin
--select distinct MaSize from [dbo].[DM_DP_Size]
--end go


--select GioiTinh from NS_NhanSu
--select * from NS_NhanSu
----select size theo san phẩm
--select*from DM_DP_Size
--Select *from NS_DP_SanPham_TinhChatDongPhuc

--select * from NS_DP_PhieuDeNghi_CaNhan


--select * from NS_DP_PhieuDeNghi_CaNhan_ChiTiet where PhieuDeNghi_CaNhan = 47

--select * from NS_DP_SanPham_TinhChatDongPhuc where TinhChatDongPhuc=1
--select * from NS_DP_SanPham where SanPham=1
--select * from DM_DP_LoaiSanPham 
--where LoaiSanPham=1

--create procedure getSizeFromSanPham(
--	@masp int = NULL
--)
--as
--begin 
--select distinct size.*  from 
--DM_DP_Size size join DM_DP_LoaiSanPham loaisp on size.LoaiSanPham = loaisp.LoaiSanPham
--join NS_DP_SanPham sp on sp.LoaiSanPham = loaisp.LoaiSanPham
--where sp.SanPham =@masp
--end
--go

--drop proc getSizeFromSanPham

--create proc updatessss
--as 
--begin
--select * from NS_DP_SanPham
--end
--go
--exec getSizeFromSanPham 2

--drop procedure updatessss
--select * from NS_DP_SanPham where SanPham =5
--select * distinct from DM_DP_Size
--select * from DM_DP_LoaiSanPham
--select * from NS_DP_PhieuDeNghi_CaNhan
--SELECT GETDATE();

---- lấy size từ sản phẩm
--select * from DM_DP_Size
----
--select * from NS_DP_SanPham

-- procedure getTinhChatTuSanPham(
--	@sanPham int =null 
--)
--as 
--begin
--select tcdp.* from DM_DP_TinhChatDongPhuc tcdp join NS_DP_SanPham_TinhChatDongPhuc sptcdp 
--on tcdp.TinhChatDongPhuc = sptcdp.TinhChatDongPhuc
--join NS_DP_SanPham sp on sp.SanPham = sptcdp.SanPham
--where sp.SanPham =@sanPham
--end
--go
-- procedure selectOptionGetPhieuNhap
--as
--begin
--select MaVaTenPhieu=MaPhieuNhapHang+' - '+TenPhieuNhapHang,* from NS_DP_PhieuNhapHang
--where IsDel !=1 and IsHoanThanh !=1
--end 
--go
--select * from DM_DP_NhaCungCap
----GetDanhSachSanPhamNhapHang
--	select distinct * from 
--	NS_DP_PhieuNhapHang pnh left join NS_DP_PhieuNhapHang_ChiTiet pnhct 
--	on pnh.PhieuNhapHang = pnhct.PhieuNhapHang
--	join NS_DP_SanPham sp on sp.SanPham = pnhct.SanPham
--	join NS_DP_SanPham_TinhChatDongPhuc sptc on sp.SanPham = sptc.SanPham
--	join DM_DP_TinhChatDongPhuc tcdp on sptc.TinhChatDongPhuc = tcdp.TinhChatDongPhuc
--	join DM_DP_Size size on size.LoaiSanPham = sp.LoaiSanPham
--where pnhct = 17
--select * from NS_DP_PhieuNhapHang
--select * from NS_DP_XuatNhapKho
--select * from NS_DP_XuatNhapKho_ChiTiet
--select * from NS_DP_SanPham
--select * from DM_DP_Size
--select * from NS_DP_SanPham_TinhChatDongPhuc
--select * from NS_DP_SanPham
--select * from DM_DP_TinhChatDongPhuc
--select * from DM_DP_DonViTinh
--exec getPhieuNhapHang
---- lấy sản phẩm từ nhà cung cấp

--CREATE procedure getSanPhamByNhaCungCap (
--	@NhaCungCap int=null
--)
--as
--begin
--select sp.SanPham,TenSanPham,size.MaSize,size.Size,
--sptcdp.DonGia,dvt.TenDonViTinh,sp.DonViTinh,ncc.NhaCungCap,ncc.TenNhaCungCap ,
--tcpd.TenTinhChatDongPhuc,tcpd.TinhChatDongPhuc
--from
--NS_DP_SanPham sp join NS_DP_SanPham_TinhChatDongPhuc sptcdp on sp.SanPham=sptcdp.SanPham
--left join DM_DP_TinhChatDongPhuc tcpd on sptcdp.TinhChatDongPhuc = tcpd.TinhChatDongPhuc
--join DM_DP_Size size on size.LoaiSanPham = sp.LoaiSanPham
--join DM_DP_NhaCungCap ncc on ncc.NhaCungCap = sptcdp.NhaCungCap
--join DM_DP_DonViTinh dvt on dvt.DonViTinh=sp.DonViTinh
--where ncc.NhaCungCap=1
--order by sp.SanPham asc, MaSize asc
--end
--go
--Select * from DM_DP_Size
--exec getSanPhamByNhaCungCap 1


--select * from NS_DP_PhieuNhapHang 
--select * from NS_DP_PhieuNhapHang_ChiTiet

---- lấy sản phẩm tất cả sản phẩm đã chọn 

--select *
--from NS_DP_PhieuNhapHang_ChiTiet pnhct join NS_DP_SanPham sp on pnhct.SanPham = sp.SanPham
--join DM_DP_DonViTinh dvt on pnhct.DonViTinh = dvt.DonViTinh
--exec [dbo].[getPhieuNhapHang]

--select sum(SoLuong) from NS_DP_PhieuNhapHang_ChiTiet
--where PhieuNhapHang = 3


--create procedure PhieuNhap_GetSanhSachSanPham
--as 
--begin
--select pnhct.*,sp.TenSanPham,tcdp.TenTinhChatDongPhuc, size.MaSize, dvt.TenDonViTinh,
--SoLuongConLai = pnhct.SoLuong - SoLuongDaNhap 
--from NS_DP_PhieuNhapHang pnh 
--	left join NS_DP_PhieuNhapHang_ChiTiet pnhct
--	on pnh.PhieuNhapHang = pnhct.PhieuNhapHang
--	left join NS_DP_SanPham sp on pnhct.SanPham = sp.SanPham
--	left join DM_DP_TinhChatDongPhuc tcdp on tcdp.TinhChatDongPhuc = pnhct.TinhChatDongPhuc
--	left join DM_DP_Size size on size.Size = pnhct.Size
--	left join DM_DP_DonViTinh dvt on pnhct.DonViTinh = dvt.DonViTinh
--where IsHoanThanh !=1
--end 
--go
--exec  PhieuNhap_GetSanhSachSanPham

----
--SELECT ROW_NUMBER() OVER(ORDER BY NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc, MaSize, GioiTinh, NS_DP_SanPham.SanPham) AS STT,
--	   NS_DP_XuatNhapKho_ChiTiet.ID,
--	   NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang,
--	   NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho,
--	   NS_DP_XuatNhapKho_ChiTiet.SanPham,
--	   TenSanPham,
--	   NS_DP_XuatNhapKho_ChiTiet.Size,
--	   NS_DP_XuatNhapKho_ChiTiet.SoLuong,
--	   SoLuongDaNhap,
--	   NS_DP_XuatNhapKho_ChiTiet.DonGia,
--	   NS_DP_XuatNhapKho_ChiTiet.DonViTinh,
--	   TenDonViTinh,
--	   NS_DP_XuatNhapKho_ChiTiet.ThanhTien,
--	   NS_DP_XuatNhapKho_ChiTiet.GhiChu,
--	   MaSize,
--	   NS_DP_SanPham.LoaiSanPham,
--	   ISNULL(TonKho.TonKho,0) TonKho, --ISNULL(expression, replacement_value)
--	   NS_DP_PhieuNhapHang_ChiTiet.SoLuong SoLuongYeuCau,
--	   ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0) TinhChatDongPhuc,
--	   NS_DP_XuatNhapKho_ChiTiet.NhaCungCap,
--	   ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0) TinhChatDongPhuc1
--FROM dbo.NS_DP_XuatNhapKho_ChiTiet
--	INNER JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
--	INNER JOIN dbo.NS_DP_SanPham ON NS_DP_SanPham.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham
--	LEFT JOIN dbo.DM_DP_DonViTinh ON DM_DP_DonViTinh.DonViTinh = NS_DP_XuatNhapKho_ChiTiet.DonViTinh
--	LEFT JOIN dbo.DM_DP_Size ON DM_DP_Size.Size = NS_DP_XuatNhapKho_ChiTiet.Size
--	LEFT JOIN dbo.NS_DP_PhieuNhapHang ON PhieuNhapHang = IDPhieu
--	LEFT JOIN dbo.NS_DP_PhieuNhapHang_ChiTiet ON NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang = NS_DP_PhieuNhapHang.PhieuNhapHang 
--											 AND NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham 
--											 AND NS_DP_PhieuNhapHang_ChiTiet.Size = NS_DP_XuatNhapKho_ChiTiet.Size
--											 AND ISNULL(NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc,0) = ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0)

--	LEFT JOIN (SELECT SanPham,Size, Kho, ISNULL(TinhChatDongPhuc,0) TinhChatDongPhuc, SUM(SoLuong) TonKho, NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
--				FROM dbo.NS_DP_XuatNhapKho_ChiTiet
--					INNER JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
--				WHERE ISNULL(NS_DP_XuatNhapKho.IsDel,0) = 0
--				GROUP BY SanPham,Size,Kho,ISNULL(TinhChatDongPhuc,0),NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
--				) TonKho ON TonKho.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham 
--					AND TonKho.Size = NS_DP_XuatNhapKho_ChiTiet.Size 
--					AND TonKho.Kho = NS_DP_XuatNhapKho.Kho
--					AND ISNULL(TonKho.TinhChatDongPhuc,0) = ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0)
--					AND TonKho.NhaCungCap = NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
--WHERE 1 = 1 AND LoaiPhieu = 1 AND ISNULL(NS_DP_XuatNhapKho.IsDel,0) = 0


----thay đổi selecct phieu nhap hang
--create proc NhapKho_ChangeSelectPhieuNhap(
--@maPhieu int =null)
--as
--begin
--select 
--	ROW_NUMBER() over (order by NS_DP_PhieuNhapHang.PhieuNhapHang) stt,
--	NS_DP_PhieuNhapHang.PhieuNhapHang,
--	MaPhieuNhapHang, 
--	TenPhieuNhapHang,
--	DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
--	NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc,
--	NS_DP_PhieuNhapHang_ChiTiet.Size,
--	DM_DP_Size.MaSize,
--	SoLuong as SoLuongYeuCau,
--	SoLuongDaNhap,
--	DonGia,
--	ThanhTien,
--	DM_DP_DonViTinh.DonViTinh,
--	DM_DP_DonViTinh.TenDonViTinh,
--	NS_DP_PhieuNhapHang.NhaCungCap,
--	TenNhaCungCap,
--	TonKho.TonKho,
--	NS_DP_PhieuNhapHang_ChiTiet.GhiChu,
--	NS_DP_SanPham.SanPham,
--	NS_DP_SanPham.TenSanPham,
--	Kho,
--	DM_DP_Kho.TenKho
--from NS_DP_PhieuNhapHang join NS_DP_PhieuNhapHang_ChiTiet
--	on NS_DP_PhieuNhapHang.PhieuNhapHang = NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang
--	left join DM_DP_TinhChatDongPhuc on NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
--	join DM_DP_Size on NS_DP_PhieuNhapHang_ChiTiet.Size = DM_DP_Size.Size
--	join DM_DP_DonViTinh on NS_DP_PhieuNhapHang_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
--	join DM_DP_NhaCungCap on NS_DP_PhieuNhapHang.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
--	join NS_DP_SanPham on NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--	join DM_DP_Kho on DM_DP_Kho.Kho = NS_DP_PhieuNhapHang.KhoNhan
--	left join (
--		select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size 
--		from NS_DP_XuatNhapKho_ChiTiet 
--		group by SanPham, Size
--				) TonKho 
--	on NS_DP_PhieuNhapHang_ChiTiet.SanPham = TonKho.SanPham and TonKho.Size = NS_DP_PhieuNhapHang_ChiTiet.Size
--where NS_DP_PhieuNhapHang.PhieuNhapHang = @maPhieu
--end
--go

----
--select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size 
--		from NS_DP_XuatNhapKho_ChiTiet 
--		group by SanPham, Size
----
--select *  
--from NS_DP_XuatNhapKho 
--		join NS_DP_XuatNhapKho_ChiTiet on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho


--exec NhapKho_ChangeSelectPhieuNhap 4
--select * from DM_DP_Kho
--select * from NS_DP_PhieuNhapHang
--create proc NhapKho_getAllDanhSachNhapHang
--as
--begin
--	select distinct ROW_NUMBER() OVER(ORDER BY NS_DP_XuatNhapKho.XuatNhapKho) 
--	stt,
--	NS_DP_XuatNhapKho.*,
--	DM_DP_Kho.TenKho,
--	DM_DP_NhaCungCap.TenNhaCungCap from NS_DP_XuatNhapKho
--	left join DM_DP_NhaCungCap on NS_DP_XuatNhapKho.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
--	left join DM_DP_Kho on NS_DP_XuatNhapKho.Kho = DM_DP_Kho.Kho
--	WHERE NS_DP_XuatNhapKho.IsDel !=1
--end 
--go
--select * from DM_DP_NhaCungCap
--select * from NS_DP_XuatNhapKho_ChiTiet
--exec NhapKho_getAllDanhSachNhapHang
--select * from NS_DP_PhieuNhapHang_ChiTiet
--where PhieuNhapHang = 2 and SanPham =6 and Size=14

--select * from NS_DP_XuatNhapKho
--where 1=1
--order by XuatNhapKho

--select * from NS_DP_XuatNhapKho_ChiTiet
--Select * from NS_DP_SanPham


--select * from NS_DP_XuatNhapKho
--order by XuatNhapKho
--select * from NS_DP_XuatNhapKho_ChiTiet
--exec getSanPhamByNhaCungCap 2

--exec NhapKho_ChangeSelectPhieuNhap 4
----26/7
--exec getSanPhamByNhaCungCap 2
--select * from NS_DP_PhieuNhapHang
--order by XuatNhapKho
--select * from NS_DP_XuatNhapKho_ChiTiet
---- xóa phiếu
--select * from NS_DP_XuatNhapKho 
--	left join NS_DP_XuatNhapKho_ChiTiet on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho

--create proc NhapKho_HienThiSanPhamTheoPhieu (
--@PhieuNhap int =null)
--as
--begin
--select 
--	ROW_NUMBER() over (order by NS_DP_PhieuNhapHang.PhieuNhapHang) stt,
--	NS_DP_PhieuNhapHang.PhieuNhapHang,
--	MaPhieuNhapHang, 
--	TenPhieuNhapHang,
--	DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
--	NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc,
--	NS_DP_PhieuNhapHang_ChiTiet.Size,
--	DM_DP_Size.MaSize,
--	SoLuong as SoLuongYeuCau,
--	SoLuongDaNhap,
--	DonGia,
--	ThanhTien,
--	DM_DP_DonViTinh.DonViTinh,
--	DM_DP_DonViTinh.TenDonViTinh,
--	NS_DP_PhieuNhapHang.NhaCungCap,
--	TenNhaCungCap,
--	TonKho.TonKho,
--	NS_DP_PhieuNhapHang_ChiTiet.GhiChu,
--	NS_DP_SanPham.SanPham,
--	NS_DP_SanPham.TenSanPham,
--	Kho,
--	DM_DP_Kho.TenKho
--from NS_DP_PhieuNhapHang join NS_DP_PhieuNhapHang_ChiTiet
--	on NS_DP_PhieuNhapHang.PhieuNhapHang = NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang
--	left join DM_DP_TinhChatDongPhuc on NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
--	join DM_DP_Size on NS_DP_PhieuNhapHang_ChiTiet.Size = DM_DP_Size.Size
--	join DM_DP_DonViTinh on NS_DP_PhieuNhapHang_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
--	join DM_DP_NhaCungCap on NS_DP_PhieuNhapHang.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
--	join NS_DP_SanPham on NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--	join DM_DP_Kho on DM_DP_Kho.Kho = NS_DP_PhieuNhapHang.KhoNhan
--	left join (
--		select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size 
--		from NS_DP_XuatNhapKho_ChiTiet 
--		JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
--		WHERE dbo.NS_DP_XuatNhapKho.IsDel !=1
--		group by SanPham, Size
--		) TonKho 
--	on NS_DP_PhieuNhapHang_ChiTiet.SanPham = TonKho.SanPham and TonKho.Size = NS_DP_PhieuNhapHang_ChiTiet.Size
--where NS_DP_PhieuNhapHang.PhieuNhapHang = @PhieuNhap
--end 
--go

--create PROC NhapKho_HienThiSanPhamTheoPhieu
--(@XuatNhapKho int = NULL)
--AS
--BEGIN
--    SELECT ROW_NUMBER() OVER (ORDER BY NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho) stt,
--           NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho,
--           DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
--           NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,
--           NS_DP_XuatNhapKho_ChiTiet.Size,
--           DM_DP_Size.MaSize,
--           NS_DP_PhieuNhapHang_ChiTiet.SoLuong AS SoLuongYeuCau,
--           NS_DP_XuatNhapKho_ChiTiet.SoLuong AS SoLuong,
--           NS_DP_PhieuNhapHang_ChiTiet.SoLuongDaNhap,
--           NS_DP_PhieuNhapHang.TongSLDaNhap,
--           NS_DP_XuatNhapKho_ChiTiet.DonGia,
--           NS_DP_XuatNhapKho_ChiTiet.ThanhTien,
--           DM_DP_DonViTinh.DonViTinh,
--           DM_DP_DonViTinh.TenDonViTinh,
--           NS_DP_XuatNhapKho_ChiTiet.NhaCungCap,
--           TenNhaCungCap,
--           TonKho.TonKho,
--           NS_DP_XuatNhapKho_ChiTiet.GhiChu,
--           NS_DP_SanPham.SanPham,
--           NS_DP_SanPham.TenSanPham,
--           NS_DP_XuatNhapKho.TyGia
--    FROM NS_DP_XuatNhapKho_ChiTiet
--        JOIN NS_DP_XuatNhapKho
--            ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
--        LEFT JOIN DM_DP_TinhChatDongPhuc
--            ON NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
--        JOIN DM_DP_Size
--            ON NS_DP_XuatNhapKho_ChiTiet.Size = DM_DP_Size.Size
--        JOIN DM_DP_DonViTinh
--            ON NS_DP_XuatNhapKho_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
--        JOIN DM_DP_NhaCungCap
--            ON NS_DP_XuatNhapKho_ChiTiet.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
--        JOIN NS_DP_SanPham
--            ON NS_DP_XuatNhapKho_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--        JOIN NS_DP_PhieuNhapHang
--            ON NS_DP_PhieuNhapHang.PhieuNhapHang = NS_DP_XuatNhapKho.IDPhieu
--        JOIN NS_DP_PhieuNhapHang_ChiTiet
--            ON NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang = NS_DP_PhieuNhapHang.PhieuNhapHang
--               AND NS_DP_PhieuNhapHang_ChiTiet.Size = NS_DP_XuatNhapKho_ChiTiet.Size
--               AND NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham
--        LEFT JOIN
--        (
--            SELECT SUM(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,
--                   SanPham,
--                   Size
--            FROM NS_DP_XuatNhapKho_ChiTiet
--			JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
--			WHERE dbo.NS_DP_XuatNhapKho.IsDel !=1
--            GROUP BY SanPham,
--                     Size
--        ) TonKho
--            ON NS_DP_XuatNhapKho_ChiTiet.SanPham = TonKho.SanPham
--               AND TonKho.Size = NS_DP_XuatNhapKho_ChiTiet.Size
--    WHERE NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho = @XuatNhapKho ;
--END;
--GO
--EXEC NhapKho_HienThiSanPhamTheoPhieu 5
--SELECT* FROM dbo.NS_DP_XuatNhapKho
--ORDER BY XuatNhapKho

--SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
--SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan

--SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan
--JOIN dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
--ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.PhieuDeNghi_CaNhan = NS_DP_PhieuDeNghi_CaNhan.PhieuDeNghi_CaNhan
--JOIN dbo.NS_DP_SanPham ON dbo.NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
--JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
--JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc
--JOIN dbo.NS_NhanSu ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu = NS_NhanSu.NhanSu
--WHERE NS_DP_PhieuDeNghi_CaNhan.IsDel !=1

--SELECT * FROM NS_DP_PhieuDeNghi_CaNhan
--SELECT * FROM NS_DP_PhieuDeNghi_CaNhan WHERE PhieuDeNghi_CaNhan=3

--create PROC NhapHang_getAllDonMuaHang
--AS
--begin
--SELECT 
--	ROW_NUMBER() OVER (ORDER BY PhieuNhapHang) stt,
--	PhieuNhapHang,
--	TenPhieuNhapHang,
--	MaPhieuNhapHang,
--	NgayDatHang,
--	Hoten = NS_NhanSu.HoDem+' '+NS_NhanSu.Ten,
--	NS_DP_PhieuNhapHang.NhaCungCap,
--	TenNhaCungCap,
--	TongSLMua,
--	TongSLDaNhap,
--	TongThanhToan,
--	IsHoanThanh,
--	NS_DP_PhieuNhapHang.GhiChu
--FROM 
--dbo.NS_DP_PhieuNhapHang 
--LEFT JOIN dbo.NS_NhanSu ON dbo.NS_DP_PhieuNhapHang.NguoiDatHang = dbo.NS_NhanSu.NhanSu
--LEFT JOIN dbo.DM_DP_NhaCungCap ON DM_DP_NhaCungCap.NhaCungCap = NS_DP_PhieuNhapHang.NhaCungCap
--WHERE DM_DP_NhaCungCap.IsDel !=1
--END 
--GO

--CREATE PROC NhapHang_getDonHangByMaPhieu
--(
--	@phieu INT = NULL
--)
--AS
--begin
--SELECT 
--	ROW_NUMBER() OVER (ORDER BY PhieuNhapHang) stt,
--	PhieuNhapHang,
--	KhoNhan,
--	TenPhieuNhapHang,
--	MaPhieuNhapHang,
--	NgayDatHang,
--	Hoten = NS_NhanSu.HoDem+' '+NS_NhanSu.Ten,
--	NS_DP_PhieuNhapHang.NhaCungCap,
--	TenNhaCungCap,
--	TongSLMua,
--	TongSLDaNhap,
--	TongThanhToan,
--	IsHoanThanh,
--	NS_DP_PhieuNhapHang.GhiChu
--FROM 
--dbo.NS_DP_PhieuNhapHang 
--LEFT JOIN dbo.NS_NhanSu ON dbo.NS_DP_PhieuNhapHang.NguoiDatHang = dbo.NS_NhanSu.NhanSu
--LEFT JOIN dbo.DM_DP_NhaCungCap ON DM_DP_NhaCungCap.NhaCungCap = NS_DP_PhieuNhapHang.NhaCungCap
--WHERE 1=1 
--AND DM_DP_NhaCungCap.IsDel !=1
--AND PhieuNhapHang = @phieu
--END 
--GO

--SELECT * FROM  dbo.NS_DP_PhieuNhapHang_ChiTiet

--create PROC NhapHang_SanPhamByMaPhieu
--(
--	@phieu INT = NULL
--)
--AS
--begin
--SELECT 
--	ROW_NUMBER() OVER (ORDER BY PhieuNhapHang) stt,
--	NS_DP_PhieuNhapHang_ChiTiet.ID,
--	PhieuNhapHang,
--	NS_DP_PhieuNhapHang_ChiTiet.SanPham,
--	TenSanPham,
--	DM_DP_TinhChatDongPhuc.TinhChatDongPhuc,
--	TenTinhChatDongPhuc,
--	NS_DP_PhieuNhapHang_ChiTiet.Size,
--	MaSize,
--	SoLuong,
--	NS_DP_PhieuNhapHang_ChiTiet.DonGia,
--	ThanhTien,
--	SoLuongDaNhap,
--	SLConLai = SoLuong- SoLuongDaNhap,
--	NS_DP_PhieuNhapHang_ChiTiet.DonViTinh,
--	TenDonViTinh,
--	GhiChu
--FROM dbo.NS_DP_PhieuNhapHang_ChiTiet
--JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--JOIN dbo.DM_DP_Size ON DM_DP_Size.Size = NS_DP_PhieuNhapHang_ChiTiet.Size
--LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham AND NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc
--LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
--JOIN dbo.DM_DP_DonViTinh ON NS_DP_PhieuNhapHang_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
--WHERE PhieuNhapHang = @phieu 
--END
--GO 

--select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size 
--		from NS_DP_XuatNhapKho_ChiTiet 
--		group by SanPham, Size

--SELECT * FROM dbo.NS_DP_PhieuDeNghi

--SELECT 
--	*
--	FROM dbo.NS_DP_PhieuDeNghi_ChiTiet 
--LEFT JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc 
--ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham 
--	AND NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc = NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc
--JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
--JOIN dbo.DM_DP_Size ON dbo.NS_DP_PhieuDeNghi_ChiTiet.Size = DM_DP_Size.Size
--JOIN dbo.DM_DP_NhaCungCap ON NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap

----SET QUOTED_IDENTIFIER ON|OFF
----SET ANSI_NULLS ON|OFF

--create PROCEDURE XuatKho_GetSanPham
--(
--	@NhaCungCap int NULL,
--	@PhieuDeNghi int NULL
--	)
--AS
--	SELECT 
--ROW_NUMBER() OVER (ORDER BY NS_DP_PhieuDeNghi_ChiTiet.ID) stt,
--	ISNULL(o.TonKho,0) AS tonKho,
--	NS_DP_PhieuDeNghi_ChiTiet.ID,
--	NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi,
--	NS_DP_PhieuDeNghi_ChiTiet.SanPham,
--	DM_DP_Size.Size,
--	TenTinhChatDongPhuc,
--	DM_DP_Size.MaSize,
--	SoLuongYeuCau = SoLuong,
--	SoLuongDaNhan,
--	soLuongDaXuat = SoLuong-SoLuongDaNhan,SoLuong,
--	TenDonViTinh,
--	NS_DP_PhieuDeNghi_ChiTiet.Size,
--	NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc,
--	NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap,
--	dbo.DM_DP_NhaCungCap.TenNhaCungCap,
--	TenSanPham
	
--	FROM dbo.NS_DP_PhieuDeNghi_ChiTiet 
--LEFT JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc 
--ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham 
--and NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
--LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
--LEFT JOIN dbo.DM_DP_Size ON dbo.NS_DP_PhieuDeNghi_ChiTiet.Size = DM_DP_Size.Size
--LEFT JOIN NS_DP_PhieuDeNghi ON NS_DP_PhieuDeNghi.PhieuDeNghi = NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi
--LEFT JOIN dbo.DM_DP_DonViTinh ON NS_DP_PhieuDeNghi_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
--LEFT JOIN (select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size ,NhaCungCap
--		from NS_DP_XuatNhapKho_ChiTiet 
--		group by SanPham, Size ,NhaCungCap )o ON  o.SanPham=NS_DP_PhieuDeNghi_ChiTiet.SanPham AND
--												o.Size = NS_DP_PhieuDeNghi_ChiTiet.Size AND
--                                                NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = o.NhaCungCap
--LEFT JOIN dbo.DM_DP_NhaCungCap ON NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = dbo.DM_DP_NhaCungCap.NhaCungCap
--WHERE NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = @NhaCungCap AND NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi=@PhieuDeNghi
--GO


--SELECT 
--ROW_NUMBER() OVER (ORDER BY NS_DP_PhieuDeNghi_ChiTiet.ID) stt,
--	ISNULL(o.TonKho,0) AS tonKho,
--	NS_DP_PhieuDeNghi_ChiTiet.ID,
--	NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi,
--	NS_DP_PhieuDeNghi_ChiTiet.SanPham,
--	DM_DP_Size.Size,
--	TenTinhChatDongPhuc,
--	DM_DP_Size.MaSize,
--	SoLuongYeuCau = SoLuong,
--	SoLuongDaNhan,
--	soLuongDaXuat = SoLuong-SoLuongDaNhan,SoLuong,
--	TenDonViTinh,
--	NS_DP_PhieuDeNghi_ChiTiet.Size,
--	NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc,
--	NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap,
--	dbo.DM_DP_NhaCungCap.TenNhaCungCap,
--	TenSanPham
	
--	FROM dbo.NS_DP_PhieuDeNghi_ChiTiet 
--LEFT JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc 
--ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham 
--and NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
--LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
--LEFT JOIN dbo.DM_DP_Size ON dbo.NS_DP_PhieuDeNghi_ChiTiet.Size = DM_DP_Size.Size
--LEFT JOIN NS_DP_PhieuDeNghi ON NS_DP_PhieuDeNghi.PhieuDeNghi = NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi
--LEFT JOIN dbo.DM_DP_DonViTinh ON NS_DP_PhieuDeNghi_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
--LEFT JOIN (select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size ,NhaCungCap
--		from NS_DP_XuatNhapKho_ChiTiet 
--		group by SanPham, Size ,NhaCungCap )o ON  o.SanPham=NS_DP_PhieuDeNghi_ChiTiet.SanPham AND
--												o.Size = NS_DP_PhieuDeNghi_ChiTiet.Size AND
--                                                NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = o.NhaCungCap
--LEFT JOIN dbo.DM_DP_NhaCungCap ON NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = dbo.DM_DP_NhaCungCap.NhaCungCap
----SET QUOTED_IDENTIFIER ON|OFF
----SET ANSI_NULLS ON|OFF

--	SELECT 
--ROW_NUMBER() OVER (ORDER BY NS_DP_PhieuDeNghi_ChiTiet.ID) stt,
--	ISNULL(o.TonKho,0) AS tonKho,
--	NS_DP_PhieuDeNghi_ChiTiet.ID,
--	NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi,
--	NS_DP_PhieuDeNghi_ChiTiet.SanPham,
--	DM_DP_Size.Size
--	TenSanPham,
--	TenTinhChatDongPhuc,
--	DM_DP_Size.MaSize,
--	SoLuongYeuCau = SoLuong,
--	SoLuongDaNhan,
--	soLuongDaXuat = SoLuong-SoLuongDaNhan,SoLuong,
--	TenDonViTinh,
--	NS_DP_PhieuDeNghi_ChiTiet.Size,
--	NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc,
--	NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap,
--	dbo.DM_DP_NhaCungCap.TenNhaCungCap
	
--	FROM dbo.NS_DP_PhieuDeNghi_ChiTiet 
--LEFT JOIN dbo.NS_DP_SanPham ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham.SanPham
--LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc 
--ON NS_DP_PhieuDeNghi_ChiTiet.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham 
--and NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
--LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc
--LEFT JOIN dbo.DM_DP_Size ON dbo.NS_DP_PhieuDeNghi_ChiTiet.Size = DM_DP_Size.Size
--LEFT JOIN NS_DP_PhieuDeNghi ON NS_DP_PhieuDeNghi.PhieuDeNghi = NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi
--LEFT JOIN dbo.DM_DP_DonViTinh ON NS_DP_PhieuDeNghi_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
--LEFT JOIN (select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size ,NhaCungCap
--		from NS_DP_XuatNhapKho_ChiTiet 
--		group by SanPham, Size ,NhaCungCap )o ON  o.SanPham=NS_DP_PhieuDeNghi_ChiTiet.SanPham AND
--												o.Size = NS_DP_PhieuDeNghi_ChiTiet.Size AND
--                                                NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = o.NhaCungCap
--LEFT JOIN dbo.DM_DP_NhaCungCap ON NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = dbo.DM_DP_NhaCungCap.NhaCungCap
--WHERE NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap =2

--SELECT CURRENT_USER;
--ROW_NUMBER() OVER (ORDER BY NS_DP_PhieuDeNghi_ChiTiet.ID) stt,
--	ISNULL(o.TonKho,0) AS tonKho,
--	NS_DP_PhieuDeNghi_ChiTiet.ID,
--	NS_DP_PhieuDeNghi_ChiTiet.PhieuDeNghi,
--	NS_DP_PhieuDeNghi_ChiTiet.SanPham,
--	DM_DP_Size.Size
--	TenSanPham,
--	TenTinhChatDongPhuc,
--	DM_DP_Size.MaSize,
--	SoLuongYeuCau = SoLuong,
--	SoLuongDaNhan,
--	soLuongDaXuat = SoLuong-SoLuongDaNhan,SoLuong,
--	TenDonViTinh,
--	NS_DP_PhieuDeNghi_ChiTiet.Size,
--	NS_DP_PhieuDeNghi_ChiTiet.TinhChatDongPhuc,
--	NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap,
--	o.TonKho
	

--SELECT * FROM dbo.NS_DP_SanPham
--SELECT * FROM dbo.NS_DP_SanPham_TinhChatDongPhuc

--SELECT * FROM DM_DP_NhaCungCap
----TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi
----TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_ChiTiet
----TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_CaNhan
----TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
--SELECT * FROM NS_DP_PhieuDeNghi
--SELECT * FROM dbo.NS_DP_PhieuDeNghi_ChiTiet
--SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan
--SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
--EXEC XuatKho_GetSanPham 1,1
----SET QUOTED_IDENTIFIER ON|OFF
----SET ANSI_NULLS ON|OFF
----GO
--create PROCEDURE XuatKho_getAllPhieuXuatKho
--AS   

--   SET NOCOUNT ON;
--   SELECT 
--  ROW_NUMBER() OVER (ORDER BY NS_DP_XuatNhapKho.XuatNhapKho) AS stt,
--  HoTenNguoiXuat = dbo.NS_NhanSu.HoDem +' '+NS_NhanSu.Ten,
--  XuatNhapKho,
--  Kho,
--  LoaiPhieu,
--  IDPhieu,
--  NguoiTao,
--  NS_DP_XuatNhapKho.NgayTao,
--  NS_DP_XuatNhapKho.IsDel,
--  NS_DP_XuatNhapKho.NguoiNhapXuat,
--  NS_DP_XuatNhapKho.NgayNhapXuat,
--  NS_DP_XuatNhapKho.GhiChu,
--  MaXuatNhapKho
--FROM dbo.NS_DP_XuatNhapKho
--LEFT JOIN dbo.NS_NhanSu ON NS_NhanSu.NhanSu = NS_DP_XuatNhapKho.NguoiTao
--WHERE LoaiPhieu = 2 AND NS_DP_XuatNhapKho.IsDel!=1
--GO
--EXEC XuatKho_getAllPhieuXuatKho
--SELECT * FROM dbo.NS_DP_XuatNhapKho ORDER BY XuatNhapKho WHERE loai
--SELECT * FROM dbo.NS_DP_XuatNhapKho_ChiTiet WHERE XuatNhapKho =23
--SELECT * FROM dbo.NS_DP_SanPham_TinhChatDongPhuc
--SELECT * FROM dbo.DM_DP_LoaiSanPham

--SELECT * FROM dbo.DM_DP_DonViTinh
--SELECT * FROM dbo.NS_DP_SanPham
create PROC GetBaoCaoTonKho
	@Thang VARCHAR(5) = null,
	@Nam VARCHAR(5) = NULL,
	@NCC INT =null
AS
BEGIN 
	DECLARE  @Ngay DATE = @Nam+'-'+@Thang+'-01'
SELECT 
	NS_DP_SanPham.TenSanPham,
	DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
	DM_DP_LoaiSanPham.TenLoaiSanPham,
	DM_DP_Size.MaSize,
	DM_DP_DonViTinh.TenDonViTinh,
	ISNULL(tonDauKi.tonDauKi,0) tonDauKi,
	@Ngay ngay
FROM dbo.NS_DP_SanPham 
LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham 
LEFT JOIN dbo.DM_DP_NhaCungCap ON NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
LEFT JOIN dbo.DM_DP_LoaiSanPham ON NS_DP_SanPham.LoaiSanPham = DM_DP_LoaiSanPham.LoaiSanPham
LEFT JOIN dbo.DM_DP_Size ON DM_DP_LoaiSanPham.LoaiSanPham = DM_DP_Size.LoaiSanPham
LEFT JOIN dbo.DM_DP_DonViTinh ON NS_DP_SanPham.DonViTinh = DM_DP_DonViTinh.DonViTinh
LEFT JOIN (
		SELECT SUM(NS_DP_XuatNhapKho_ChiTiet.SoLuong) tonDauKi, 
			NS_DP_XuatNhapKho_ChiTiet.Size, 
			NS_DP_XuatNhapKho_ChiTiet.SanPham,
			NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
		FROM dbo.NS_DP_XuatNhapKho_ChiTiet
		LEFT JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
		WHERE NS_DP_XuatNhapKho.NgayNhapXuat < @Ngay
		GROUP BY NS_DP_XuatNhapKho_ChiTiet.SanPham , 
		NS_DP_XuatNhapKho_ChiTiet.Size, 
		NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
) tonDauKi ON tonDauKi.SanPham = NS_DP_SanPham.SanPham
				AND tonDauKi.Size = DM_DP_Size.Size
				AND tonDauKi.NhaCungCap = NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap
WHERE NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap=@NCC
END
GO 
EXEC GetBaoCaoTonKho 9, 2024 ,1