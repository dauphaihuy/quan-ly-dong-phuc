select * from [NS_DP_PhieuDeNghi_CaNhan]
select * from [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet]
delete from [NS_DP_PhieuDeNghi_CaNhan]
where PhieuDeNghi_CaNhan = 11
select * from [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet]
exec [getDanhSachSanPham]
select * from DM_DP_LyDoCapPhat
USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getDanhSachSanPham]    Script Date: 13/04/2024 9:22:25 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[getDanhSachSanPham]
AS
BEGIN
	SELECT s.*, L.TenLoaiSanPham, D.TenDonViTinh, G.TenGioiTinh, NS_DP_SanPham_LienKet.TenSanPhamLK
	FROM NS_DP_SanPham S 
		LEFT JOIN DM_DP_LoaiSanPham L ON S.LoaiSanPham = L.LoaiSanPham
		LEFT JOIN DM_DP_DonViTinh D ON D.DonViTinh = S.DonViTinh
		LEFT JOIN NS_DP_GioiTinh G ON G.GioiTinh = S.GioiTinh
		LEFT JOIN (select SanPham, TenSanPham TenSanPhamLK from NS_DP_SanPham) NS_DP_SanPham_LienKet on NS_DP_SanPham_LienKet.SanPham = S.SanPhamLienKet
END
update [NS_DP_PhieuDeNghi_CaNhan]
set IsHoanThanh=0
where PhieuDeNghi_CaNhan in(12,13,14)

select * from NS_NhanSu
select * from [dbo].[DM_DP_TinhChatDongPhuc]

CREATE PROCEDURE procedure_name
AS
sql_statement
GO;
SELECT        NS_DP_PhieuDeNghi_CaNhan.NguoiDeNghi, NS_NhanSu.NhanSu, DM_DP_LyDoCapPhat.TenLyDoCapPhat, DM_DP_LyDoCapPhat.LyDoCapPhat, NS_DP_PhieuDeNghi_CaNhan.TrangThaiDuyet, 
                         NS_DP_PhieuDeNghi_CaNhan.NgayTao, NS_DP_PhieuDeNghi_CaNhan.NguoiTao, NS_DP_PhieuDeNghi_CaNhan.NgayDeNghi, NS_NhanSu.Ten, NS_NhanSu.HoDem
FROM            NS_DP_PhieuDeNghi_CaNhan CROSS JOIN
                         NS_NhanSu CROSS JOIN
                         DM_DP_LyDoCapPhat

select * from [dbo].[DM_DP_LyDoCapPhat]

drop procedure getPhieuDeNghiCaNhan
drop procedure getSanPhamYeuCau



select * from DM_DP_TinhChatDongPhuc
select * from NS_DP_SanPham_TinhChatDongPhuc
select * from NS_DP_PhieuDeNghi_CaNhan
select * from NS_DP_PhieuDeNghi_CaNhan_ChiTiet

delete from NS_DP_PhieuDeNghi_CaNhan
where NguoiDeNghi in (1)
select * from NS_NhanSu

select * from NS_QuocTich




select * from NS_NhanSu


SELECT ROW_NUMBER() OVER (ORDER BY NS_DP_SanPham.LoaiSanPham,NS_DP_SanPham.TenSanPham) AS STT,
			   NS_DP_SanPham.SanPham,
			   CASE WHEN @NgonNgu = 'vi' THEN (CASE WHEN SPLK.TenSanPham IS NULL THEN NS_DP_SanPham.TenSanPham ELSE NS_DP_SanPham.TenSanPham + ' - ' + SPLK.TenSanPham END)
					WHEN @NgonNgu = 'en' THEN (CASE WHEN SPLK.TenSanPham_EN IS NULL THEN NS_DP_SanPham.TenSanPham_EN ELSE NS_DP_SanPham.TenSanPham_EN + ' - ' + SPLK.TenSanPham_EN END)
					WHEN @NgonNgu = 'jp' THEN (CASE WHEN SPLK.TenSanPham_JP IS NULL THEN NS_DP_SanPham.TenSanPham_JP ELSE NS_DP_SanPham.TenSanPham_JP + ' - ' + SPLK.TenSanPham_JP END) END TenSanPham,
			   @NhanSu NhanSu,
			   1 SoLuong,
			   NS_DP_SanPham.LoaiSanPham,
			   TenLoaiSanPham,
			   DM_DonViTinh.DonViTinh,
			   TenDonViTinh,
			   CASE WHEN IsCoSize = 1 THEN 0 ELSE - 1 END Size,
			   ISNULL(NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc,0) TinhChatDongPhuc,
			   IsCoSize
		FROM dbo.NS_DP_SanPham
			INNER JOIN dbo.DM_DP_LoaiSanPham ON DM_DP_LoaiSanPham.LoaiSanPham = NS_DP_SanPham.LoaiSanPham
			LEFT JOIN dbo.DM_DonViTinh ON DM_DonViTinh.DonViTinh = NS_DP_SanPham.DonViTinh
			LEFT JOIN (SELECT SanPham, TenSanPham, TenSanPham_EN, TenSanPham_JP FROM dbo.NS_DP_SanPham) SPLK ON SPLK.SanPham = NS_DP_SanPham.SanPhamLienKet
			LEFT JOIN (SELECT SanPham, TinhChatDongPhuc FROM dbo.NS_DP_SanPham_TinhChatDongPhuc WHERE TinhChatDongPhuc = 2 AND NhaCungCap = 1) NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.SanPham = NS_DP_SanPham.SanPham
			LEFT JOIN (SELECT NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham, SUM(SoLuong) SoLuongDaChon
						FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
							INNER JOIN dbo.NS_DP_SanPham ON NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
						WHERE PhieuDeNghi_CaNhan = @ID
						GROUP BY NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham
					  ) SanPhamDaChon ON SanPhamDaChon.SanPham = NS_DP_SanPham.SanPham
		WHERE ISNULL(NS_DP_SanPham.IsDel,0) = 0 AND (GioiTinh IS NULL OR GioiTinh = ISNULL(@GioiTinh,0))
			  AND (NS_DP_SanPham.LoaiSanPham <> 1 AND (SanPhamLienKet > 0 OR ISNULL(SanPhamLienKet,0) = 0))
			  AND 2 = CASE WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) IN (1,3,5) AND ISNULL(SanPhamDaChon.SoLuongDaChon,0) < 3 THEN 2
						 WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) NOT IN (1,3,5) AND SanPhamDaChon.SanPham IS NULL THEN 2
						 ELSE 0
						 END
		ORDER BY IsCoSize DESC

--procedure xóa sản phẩm 
--int maPhieu,int nguoiDeNghi,int lyDoCapPhat
alter procedure updateLyDoCapPhat(
	@maPhieu nvarchar(50) =null,
	@nguoiDeNghi int=null,
	@idLyDoCapPhat int=null
)
AS
BEGIN
	update [dbo].[NS_DP_PhieuDeNghi_CaNhan]
	set LyDoCapPhat =@idLyDoCapPhat
	where MaPhieuDeNghi_CaNhan =@maPhieu and NguoiDeNghi=@nguoiDeNghi
end
go

drop proc updateLyDoCapPhat
select * 
from [dbo].[NS_DP_PhieuDeNghi_CaNhan] phieuCaNhan
where MaPhieuDeNghi_CaNhan =17 and NguoiDeNghi=8
select * from [NS_DP_PhieuDeNghi_CaNhan]
exec updateLyDoCapPhat 17 ,8, 3

INSERT INTO DM_DP_Size
--(MaSize, LoaiSanPham, NguoiTao, IsDel)
--VALUES
--(35, 6, 1, 0),
--(36, 6, 1, 0),
--(37, 6, 1, 0),
--(38, 6, 1, 0),
--(39, 6, 1, 0),
--(40, 6, 1, 0),
--(41, 6, 1, 0),
--(42, 6, 1, 0),
--(43, 6, 1, 0),
--(44, 6, 1, 0);
--INSERT INTO DM_DP_Size
--(MaSize, LoaiSanPham, NguoiTao, IsDel)
--VALUES
--('44-NC', 10, 1, 0),
--('45-NC', 10, 1, 0)
select * from DM_DP_Size
select * from [dbo].[DM_DP_LoaiSanPham]
select * from NS_DP_SanPham

select * from NS_DP_SanPham_TinhChatDongPhuc

select * from NS_DP_SanPham
select * from NS_DP_SanPham_TinhChatDongPhuc
select * from DM_DP_TinhChatDongPhuc
--get tính chất theo mã sp
select * from 
NS_DP_SanPham sp 
join NS_DP_SanPham_TinhChatDongPhuc spTinhChatDp on sp.SanPham = spTinhChatDp.SanPham
join DM_DP_TinhChatDongPhuc tcdp on tcdp.TinhChatDongPhuc=spTinhChatDp.TinhChatDongPhuc

--getSanPhamConLaiNguoiDungChuaChon
--lấy ra sản phẩm mà người ta chưa chọn
--phieuDeNghiCaNhan
--NhanVienMoi
--NhanSu 
--GioiTinh
create alter procedure getSanPhamConLaiChuaChon(
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
GO

exec getSanPhamConLaiChuaChon 'ICPM2' ,10

select * from NS_DP_PhieuDeNghi_CaNhan
select *
from 
[dbo].[NS_DP_PhieuDeNghi_CaNhan] phieuCaNhan 
left join [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet] phieuCaNhanChiTiet on phieuCaNhan.PhieuDeNghi_CaNhan= phieuCaNhanChiTiet.PhieuDeNghi_CaNhan
left join NS_NhanSu ns on phieuCaNhan.NguoiDeNghi= ns.NhanSu
left join DM_DP_LyDoCapPhat lyDoCap on lyDoCap.LyDoCapPhat= phieuCaNhan.LyDoCapPhat
left join NS_DP_SanPham sanPham on phieuCaNhanChiTiet.SanPham = sanPham.SanPham  
left join DM_DP_TinhChatDongPhuc tinhChat on tinhChat.TinhChatDongPhuc= phieuCaNhanChiTiet.TinhChatDongPhuc
left join DM_DP_Size size on size.Size =phieuCaNhanChiTiet.Size
where phieuCaNhan.PhieuDeNghi_CaNhan =39 and NguoiDeNghi =8 and sanPham.GioiTinh in ((select GioiTinh from NS_NhanSu where NhanSu =8) ,2)

select * from NS_DP_PhieuDeNghi_CaNhan

--11/07
--insert thêm dữ liệu
select *
from NS_DP_PhieuDeNghi_CaNhan pdn 
left join NS_DP_PhieuDeNghi_CaNhan_ChiTiet phieuChiTiet on pdn.PhieuDeNghi_CaNhan= phieuChiTiet.PhieuDeNghi_CaNhan
where MaPhieuDeNghi_CaNhan ='ULIB7'
PhieuDeNghi_CaNhan,MaPhieuDeNghi_CaNhan,NguoiDeNghi,NgayDeNghi,NguoiTao,NgayTao,IsDel,IsHoanThanh,PhieuDeNghi_CaNhan,SanPham,Size,SoLuong,TinhChatDongPhuc

select * from NS_DP_PhieuDeNghi_CaNhan_ChiTiet

select PhieuDeNghi_CaNhan from NS_DP_PhieuDeNghi_CaNhan
Where MaPhieuDeNghi_CaNhan ='ULIB7'
--themSanPhamConLaiNguoiDungChuChon
create procedure themSanPhamConLaiNguoiDungChuChon(
	@PhieuDeNghi_CaNhan int = null,
	@SanPham int = null ,
	@Size int = null,
	@SoLuong int = null,
	@TinhChatDongPhuc int = null
)
AS
BEGIN
	insert into NS_DP_PhieuDeNghi_CaNhan_ChiTiet(PhieuDeNghi_CaNhan,SanPham,Size,SoLuong,TinhChatDongPhuc)
	values (@PhieuDeNghi_CaNhan,@SanPham,@Size,@SoLuong,@TinhChatDongPhuc)
END
GO

SELECT ROW_NUMBER() OVER (ORDER BY NS_DP_SanPham.LoaiSanPham,NS_DP_SanPham.TenSanPham) AS STT,
			   NS_DP_SanPham.SanPham,
			   CASE WHEN @NgonNgu = 'vi' THEN (CASE WHEN SPLK.TenSanPham IS NULL THEN NS_DP_SanPham.TenSanPham ELSE NS_DP_SanPham.TenSanPham + ' - ' + SPLK.TenSanPham END)
					WHEN @NgonNgu = 'en' THEN (CASE WHEN SPLK.TenSanPham_EN IS NULL THEN NS_DP_SanPham.TenSanPham_EN ELSE NS_DP_SanPham.TenSanPham_EN + ' - ' + SPLK.TenSanPham_EN END)
					WHEN @NgonNgu = 'jp' THEN (CASE WHEN SPLK.TenSanPham_JP IS NULL THEN NS_DP_SanPham.TenSanPham_JP ELSE NS_DP_SanPham.TenSanPham_JP + ' - ' + SPLK.TenSanPham_JP END) END TenSanPham,
			   @NhanSu NhanSu,
			   1 SoLuong,
			   NS_DP_SanPham.LoaiSanPham,
			   TenLoaiSanPham,
			   DM_DonViTinh.DonViTinh,
			   TenDonViTinh,
			   CASE WHEN IsCoSize = 1 THEN 0 ELSE - 1 END Size,
			   ISNULL(NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc,0) TinhChatDongPhuc,
			   IsCoSize
		FROM dbo.NS_DP_SanPham
			INNER JOIN dbo.DM_DP_LoaiSanPham ON DM_DP_LoaiSanPham.LoaiSanPham = NS_DP_SanPham.LoaiSanPham
			LEFT JOIN dbo.DM_DonViTinh ON DM_DonViTinh.DonViTinh = NS_DP_SanPham.DonViTinh
			LEFT JOIN (SELECT SanPham, TenSanPham, TenSanPham_EN, TenSanPham_JP FROM dbo.NS_DP_SanPham) SPLK ON SPLK.SanPham = NS_DP_SanPham.SanPhamLienKet
			LEFT JOIN (SELECT SanPham, TinhChatDongPhuc FROM dbo.NS_DP_SanPham_TinhChatDongPhuc WHERE TinhChatDongPhuc = 2 AND NhaCungCap = 1) NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.SanPham = NS_DP_SanPham.SanPham
			LEFT JOIN (SELECT NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham, SUM(SoLuong) SoLuongDaChon
						FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
							INNER JOIN dbo.NS_DP_SanPham ON NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
						WHERE PhieuDeNghi_CaNhan = @ID
						GROUP BY NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham, LoaiSanPham
					  ) SanPhamDaChon ON SanPhamDaChon.SanPham = NS_DP_SanPham.SanPham
		WHERE ISNULL(NS_DP_SanPham.IsDel,0) = 0 AND (GioiTinh IS NULL OR GioiTinh = ISNULL(@GioiTinh,0))
			  AND (NS_DP_SanPham.LoaiSanPham <> 1 AND (SanPhamLienKet > 0 OR ISNULL(SanPhamLienKet,0) = 0))
			  AND 2 = CASE WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) IN (1,3,5) AND ISNULL(SanPhamDaChon.SoLuongDaChon,0) < 3 THEN 2
						 WHEN ISNULL(SanPhamDaChon.LoaiSanPham,0) NOT IN (1,3,5) AND SanPhamDaChon.SanPham IS NULL THEN 2
						 ELSE 0
						 END
		ORDER BY IsCoSize DESC

create procedure getsize
as begin
select distinct MaSize from [dbo].[DM_DP_Size]
end go

select * from DM_DP_Size
select * from DM_DP_LoaiSanPham
select * from DM_DP_TinhChatDongPhuc
select * from DM_DP_Size
select * from NS_DP_SanPham
select * from DM_DP_TinhChatDongPhuc
select * from NS_DP_SanPham

select GioiTinh from NS_NhanSu
select * from NS_NhanSu
--select size theo san phẩm
select*from DM_DP_Size
Select *from NS_DP_SanPham_TinhChatDongPhuc

select * from NS_DP_PhieuDeNghi_CaNhan


select * from NS_DP_PhieuDeNghi_CaNhan_ChiTiet where PhieuDeNghi_CaNhan = 47

select * from NS_DP_SanPham_TinhChatDongPhuc where TinhChatDongPhuc=1
select * from NS_DP_SanPham where SanPham=1
select * from DM_DP_LoaiSanPham 
where LoaiSanPham=1

create procedure getSizeFromSanPham(
	@masp int = NULL
)
as
begin 
select distinct size.*  from 
DM_DP_Size size join DM_DP_LoaiSanPham loaisp on size.LoaiSanPham = loaisp.LoaiSanPham
join NS_DP_SanPham sp on sp.LoaiSanPham = loaisp.LoaiSanPham
where sp.SanPham =@masp
end
go

drop proc getSizeFromSanPham

create proc updatessss
as 
begin
select * from NS_DP_SanPham
end
go
exec getSizeFromSanPham 2

drop procedure updatessss
select * from NS_DP_SanPham where SanPham =5
select * distinct from DM_DP_Size
select * from DM_DP_LoaiSanPham
select * from NS_DP_PhieuDeNghi_CaNhan
SELECT GETDATE();

-- lấy size từ sản phẩm
select * from DM_DP_Size
--
select * from NS_DP_SanPham

alter procedure getTinhChatTuSanPham(
	@sanPham int =null 
)
as 
begin
select tcdp.* from DM_DP_TinhChatDongPhuc tcdp join NS_DP_SanPham_TinhChatDongPhuc sptcdp 
on tcdp.TinhChatDongPhuc = sptcdp.TinhChatDongPhuc
join NS_DP_SanPham sp on sp.SanPham = sptcdp.SanPham
where sp.SanPham =@sanPham
end
go

exec getTinhChatTuSanPham 3
select * from NS_DP_SanPham_TinhChatDongPhuc
select * from NS_NhanSu
select * from NS_DP_XuatNhapKho
select * from [dbo].[NS_DP_XuatNhapKho_ChiTiet]
select * from[dbo].[NS_DP_PhieuNhapHang]
select * from NS_DP_PhieuNhapHang_ChiTiet
exec [dbo].[getXuatNhapKho]
select * from NS_DP_PhieuNhapHang pnh join NS_DP_PhieuNhapHang_ChiTiet pnhct on pnh.PhieuNhapHang = pnhct.PhieuNhapHang

alter procedure selectOptionGetPhieuNhap
as
begin
select MaVaTenPhieu=MaPhieuNhapHang+' - '+TenPhieuNhapHang,* from NS_DP_PhieuNhapHang
where IsDel !=1 and IsHoanThanh !=1
end 
go
select * from DM_DP_NhaCungCap
--GetDanhSachSanPhamNhapHang
	select distinct * from 
	NS_DP_PhieuNhapHang pnh left join NS_DP_PhieuNhapHang_ChiTiet pnhct 
	on pnh.PhieuNhapHang = pnhct.PhieuNhapHang
	join NS_DP_SanPham sp on sp.SanPham = pnhct.SanPham
	join NS_DP_SanPham_TinhChatDongPhuc sptc on sp.SanPham = sptc.SanPham
	join DM_DP_TinhChatDongPhuc tcdp on sptc.TinhChatDongPhuc = tcdp.TinhChatDongPhuc
	join DM_DP_Size size on size.LoaiSanPham = sp.LoaiSanPham
where pnhct = 17
select * from NS_DP_PhieuNhapHang
select * from NS_DP_XuatNhapKho
select * from NS_DP_XuatNhapKho_ChiTiet
select * from NS_DP_SanPham
select * from DM_DP_Size
select * from NS_DP_SanPham_TinhChatDongPhuc
select * from NS_DP_SanPham
select * from DM_DP_TinhChatDongPhuc
select * from DM_DP_DonViTinh
exec getPhieuNhapHang
-- lấy sản phẩm từ nhà cung cấp

alter procedure getSanPhamByNhaCungCap (
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
where ncc.NhaCungCap=1
order by sp.SanPham asc, MaSize asc
end
go
Select * from DM_DP_Size
exec getSanPhamByNhaCungCap 1


select * from NS_DP_PhieuNhapHang 
select * from NS_DP_PhieuNhapHang_ChiTiet

-- lấy sản phẩm tất cả sản phẩm đã chọn 

select *
from NS_DP_PhieuNhapHang_ChiTiet pnhct join NS_DP_SanPham sp on pnhct.SanPham = sp.SanPham
join DM_DP_DonViTinh dvt on pnhct.DonViTinh = dvt.DonViTinh
exec [dbo].[getPhieuNhapHang]

select sum(SoLuong) from NS_DP_PhieuNhapHang_ChiTiet
where PhieuNhapHang = 3

select * from NS_DP_SanPham_TinhChatDongPhuc

alter procedure PhieuNhap_GetSanhSachSanPham
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
go
exec  PhieuNhap_GetSanhSachSanPham

TRUNCATE TABLE NS_DP_PhieuNhapHang
select * from NS_DP_PhieuNhapHang
--23/07/2024
select * from NS_DP_PhieuNhapHang
create procedure NhapKho_SelectPhieuNhapHang
as
begin
select PhieuNhapHang, TenVaMaPhieu= MaPhieuNhapHang +' - '+TenPhieuNhapHang,IsDel,IsHoanThanh from NS_DP_PhieuNhapHang
where IsDel !=1 and IsHoanThanh !=1
end 
go
create procedure NhapKho_SelectKhoNhan
as
begin
select * from DM_DP_Kho
where IsDel !=1 
end 
go
--
drop proc NhapKho_ChonPhieuNhapHan
create procedure NhapKho_ChonPhieuNhapHan
as
begin
select * from NS_DP_PhieuNhapHang pnh 
join DM_DP_Kho kho
on pnh.KhoNhan = kho.Kho
end
go

--
SELECT ROW_NUMBER() OVER(ORDER BY NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc, MaSize, GioiTinh, NS_DP_SanPham.SanPham) AS STT,
	   NS_DP_XuatNhapKho_ChiTiet.ID,
	   NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang,
	   NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho,
	   NS_DP_XuatNhapKho_ChiTiet.SanPham,
	   TenSanPham,
	   NS_DP_XuatNhapKho_ChiTiet.Size,
	   NS_DP_XuatNhapKho_ChiTiet.SoLuong,
	   SoLuongDaNhap,
	   NS_DP_XuatNhapKho_ChiTiet.DonGia,
	   NS_DP_XuatNhapKho_ChiTiet.DonViTinh,
	   TenDonViTinh,
	   NS_DP_XuatNhapKho_ChiTiet.ThanhTien,
	   NS_DP_XuatNhapKho_ChiTiet.GhiChu,
	   MaSize,
	   NS_DP_SanPham.LoaiSanPham,
	   ISNULL(TonKho.TonKho,0) TonKho, --ISNULL(expression, replacement_value)
	   NS_DP_PhieuNhapHang_ChiTiet.SoLuong SoLuongYeuCau,
	   ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0) TinhChatDongPhuc,
	   NS_DP_XuatNhapKho_ChiTiet.NhaCungCap,
	   ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0) TinhChatDongPhuc1
FROM dbo.NS_DP_XuatNhapKho_ChiTiet
	INNER JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
	INNER JOIN dbo.NS_DP_SanPham ON NS_DP_SanPham.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham
	LEFT JOIN dbo.DM_DP_DonViTinh ON DM_DP_DonViTinh.DonViTinh = NS_DP_XuatNhapKho_ChiTiet.DonViTinh
	LEFT JOIN dbo.DM_DP_Size ON DM_DP_Size.Size = NS_DP_XuatNhapKho_ChiTiet.Size
	LEFT JOIN dbo.NS_DP_PhieuNhapHang ON PhieuNhapHang = IDPhieu
	LEFT JOIN dbo.NS_DP_PhieuNhapHang_ChiTiet ON NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang = NS_DP_PhieuNhapHang.PhieuNhapHang 
											 AND NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham 
											 AND NS_DP_PhieuNhapHang_ChiTiet.Size = NS_DP_XuatNhapKho_ChiTiet.Size
											 AND ISNULL(NS_DP_PhieuNhapHang_ChiTiet.TinhChatDongPhuc,0) = ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0)

	LEFT JOIN (SELECT SanPham,Size, Kho, ISNULL(TinhChatDongPhuc,0) TinhChatDongPhuc, SUM(SoLuong) TonKho, NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
				FROM dbo.NS_DP_XuatNhapKho_ChiTiet
					INNER JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
				WHERE ISNULL(NS_DP_XuatNhapKho.IsDel,0) = 0
				GROUP BY SanPham,Size,Kho,ISNULL(TinhChatDongPhuc,0),NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
				) TonKho ON TonKho.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham 
					AND TonKho.Size = NS_DP_XuatNhapKho_ChiTiet.Size 
					AND TonKho.Kho = NS_DP_XuatNhapKho.Kho
					AND ISNULL(TonKho.TinhChatDongPhuc,0) = ISNULL(NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,0)
					AND TonKho.NhaCungCap = NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
WHERE 1 = 1 AND LoaiPhieu = 1 AND ISNULL(NS_DP_XuatNhapKho.IsDel,0) = 0


--thay đổi selecct phieu nhap hang
alter proc NhapKho_ChangeSelectPhieuNhap(
@maPhieu int =null)
as
begin
select 
	ROW_NUMBER() over (order by NS_DP_PhieuNhapHang.PhieuNhapHang) stt,
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
		group by SanPham, Size
				) TonKho 
	on NS_DP_PhieuNhapHang_ChiTiet.SanPham = TonKho.SanPham and TonKho.Size = NS_DP_PhieuNhapHang_ChiTiet.Size
where NS_DP_PhieuNhapHang.PhieuNhapHang = @maPhieu
end
go

--
select sum(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,SanPham,Size 
		from NS_DP_XuatNhapKho_ChiTiet 
		group by SanPham, Size
--
select *  
from NS_DP_XuatNhapKho 
		join NS_DP_XuatNhapKho_ChiTiet on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho


exec NhapKho_ChangeSelectPhieuNhap 4
select * from DM_DP_Kho
select * from NS_DP_PhieuNhapHang
alter proc NhapKho_getAllDanhSachNhapHang
as
begin
	select distinct ROW_NUMBER() OVER(ORDER BY NS_DP_XuatNhapKho.XuatNhapKho) 
	stt,
	NS_DP_XuatNhapKho.*,
	DM_DP_Kho.TenKho,
	DM_DP_NhaCungCap.TenNhaCungCap from NS_DP_XuatNhapKho
	left join DM_DP_NhaCungCap on NS_DP_XuatNhapKho.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
	left join DM_DP_Kho on NS_DP_XuatNhapKho.Kho = DM_DP_Kho.Kho
	WHERE NS_DP_XuatNhapKho.IsDel !=1
end 
go
select * from DM_DP_NhaCungCap
select * from NS_DP_XuatNhapKho_ChiTiet
exec NhapKho_getAllDanhSachNhapHang
select * from NS_DP_PhieuNhapHang_ChiTiet
where PhieuNhapHang = 2 and SanPham =6 and Size=14

select * from NS_DP_XuatNhapKho
where 1=1
order by XuatNhapKho

delete from NS_DP_XuatNhapKho where XuatNhapKho between 50 and 62
select * from NS_DP_XuatNhapKho_ChiTiet
Select * from NS_DP_SanPham
update table NS_DP_XuatNhapKho_ChiTiet
set SanPham = @sanPham
	Size =@Size
	SoLuong= @SoLuong
	DonViTinh = @DonViTinh
	GhiChu = @GhiChu
	DonGia = @DonGia
	ThanhTien = @SoLuong * @DonGia
	TinhChatDongPhuc = @TinhChatDongPhuc
	NhaCungCap = @NhaCungCap

select * from NS_DP_XuatNhapKho
order by XuatNhapKho
select * from NS_DP_XuatNhapKho_ChiTiet
exec getSanPhamByNhaCungCap 2

exec NhapKho_ChangeSelectPhieuNhap 4
--26/7
exec getSanPhamByNhaCungCap 2
select * from NS_DP_PhieuNhapHang
order by XuatNhapKho
select * from NS_DP_XuatNhapKho_ChiTiet
-- xóa phiếu
select * from NS_DP_XuatNhapKho 
	left join NS_DP_XuatNhapKho_ChiTiet on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
create procedure NhapKho_getSoLuongDeXoa
(
	 @XuatNhapKho int =null
)
as 
begin
	select NS_DP_XuatNhapKho.XuatNhapKho,
	NS_DP_XuatNhapKho.MaXuatNhapKho ,
	NS_DP_XuatNhapKho.IDPhieu,
	NS_DP_XuatNhapKho_ChiTiet.SanPham,
	NS_DP_XuatNhapKho_ChiTiet.Size,
	NS_DP_XuatNhapKho_ChiTiet.SoLuong
	from NS_DP_XuatNhapKho 
	left join NS_DP_XuatNhapKho_ChiTiet on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
	where NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho = @XuatNhapKho
end 
go
exec NhapKho_getAllDanhSachNhapHang
select * from NS_DP_XuatNhapKho
select
select * from NS_DP_PhieuNhapHang_ChiTiet
where PhieuNhapHang = 18

select * from NS_DP_PhieuNhapHang
where PhieuNhapHang = 18
 
--cập nhật lại phiếu
select * from NS_DP_PhieuNhapHang
select * from NS_DP_PhieuNhapHang_ChiTiet
--cập nhật lại theo phieu nhap hang- sản phẩm- size
--
select NS_DP_XuatNhapKho.*,
	NS_DP_XuatNhapKho_ChiTiet.ID,
	NS_DP_XuatNhapKho_ChiTiet.SanPham,
	NS_DP_XuatNhapKho_ChiTiet.Size
	from NS_DP_XuatNhapKho
left join NS_DP_XuatNhapKho_ChiTiet on NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
order by NS_DP_XuatNhapKho.XuatNhapKho
where 

--
delete from NS_DP_XuatNhapKho where XuatNhapKho between 10 and 76
select * from NS_DP_XuatNhapKho_ChiTiet
order by XuatNhapKho
select * from NS_DP_PhieuNhapHang
select * from NS_DP_XuatNhapKho
order by XuatNhapKho

select * 
from NS_DP_XuatNhapKho_ChiTiet
left join NS_DP_SanPham on NS_DP_SanPham.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham
where XuatNhapKho =99
order by XuatNhapKho

select * 
from NS_DP_XuatNhapKho_ChiTiet
where XuatNhapKho =99

create proc NhapKho_HienThiSanPhamTheoPhieu (
@PhieuNhap int =null)
as
begin
select 
	ROW_NUMBER() over (order by NS_DP_PhieuNhapHang.PhieuNhapHang) stt,
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
where NS_DP_PhieuNhapHang.PhieuNhapHang = @PhieuNhap
end 
go

ALTER PROC NhapKho_HienThiSanPhamTheoPhieu
(@XuatNhapKho int = NULL)
AS
BEGIN
    SELECT ROW_NUMBER() OVER (ORDER BY NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho) stt,
           NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho,
           DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
           NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc,
           NS_DP_XuatNhapKho_ChiTiet.Size,
           DM_DP_Size.MaSize,
           NS_DP_PhieuNhapHang_ChiTiet.SoLuong AS SoLuongYeuCau,
           NS_DP_XuatNhapKho_ChiTiet.SoLuong AS SoLuong,
           NS_DP_PhieuNhapHang_ChiTiet.SoLuongDaNhap,
           NS_DP_PhieuNhapHang.TongSLDaNhap,
           NS_DP_XuatNhapKho_ChiTiet.DonGia,
           NS_DP_XuatNhapKho_ChiTiet.ThanhTien,
           DM_DP_DonViTinh.DonViTinh,
           DM_DP_DonViTinh.TenDonViTinh,
           NS_DP_XuatNhapKho_ChiTiet.NhaCungCap,
           TenNhaCungCap,
           TonKho.TonKho,
           NS_DP_XuatNhapKho_ChiTiet.GhiChu,
           NS_DP_SanPham.SanPham,
           NS_DP_SanPham.TenSanPham,
           NS_DP_XuatNhapKho.TyGia
    FROM NS_DP_XuatNhapKho_ChiTiet
        JOIN NS_DP_XuatNhapKho
            ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
        LEFT JOIN DM_DP_TinhChatDongPhuc
            ON NS_DP_XuatNhapKho_ChiTiet.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
        JOIN DM_DP_Size
            ON NS_DP_XuatNhapKho_ChiTiet.Size = DM_DP_Size.Size
        JOIN DM_DP_DonViTinh
            ON NS_DP_XuatNhapKho_ChiTiet.DonViTinh = DM_DP_DonViTinh.DonViTinh
        JOIN DM_DP_NhaCungCap
            ON NS_DP_XuatNhapKho_ChiTiet.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
        JOIN NS_DP_SanPham
            ON NS_DP_XuatNhapKho_ChiTiet.SanPham = NS_DP_SanPham.SanPham
        JOIN NS_DP_PhieuNhapHang
            ON NS_DP_PhieuNhapHang.PhieuNhapHang = NS_DP_XuatNhapKho.IDPhieu
        JOIN NS_DP_PhieuNhapHang_ChiTiet
            ON NS_DP_PhieuNhapHang_ChiTiet.PhieuNhapHang = NS_DP_PhieuNhapHang.PhieuNhapHang
               AND NS_DP_PhieuNhapHang_ChiTiet.Size = NS_DP_XuatNhapKho_ChiTiet.Size
               AND NS_DP_PhieuNhapHang_ChiTiet.SanPham = NS_DP_XuatNhapKho_ChiTiet.SanPham
        LEFT JOIN
        (
            SELECT SUM(NS_DP_XuatNhapKho_ChiTiet.SoLuong) TonKho,
                   SanPham,
                   Size
            FROM NS_DP_XuatNhapKho_ChiTiet
			JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
			WHERE dbo.NS_DP_XuatNhapKho.IsDel !=1
            GROUP BY SanPham,
                     Size
        ) TonKho
            ON NS_DP_XuatNhapKho_ChiTiet.SanPham = TonKho.SanPham
               AND TonKho.Size = NS_DP_XuatNhapKho_ChiTiet.Size
    WHERE NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho = @XuatNhapKho ;
END;
GO
EXEC NhapKho_HienThiSanPhamTheoPhieu 5
SELECT* FROM dbo.NS_DP_XuatNhapKho
ORDER BY XuatNhapKho

SELECT * FROM dbo.NS_DP_XuatNhapKho
SELECT * FROM dbo.NS_DP_XuatNhapKho_ChiTiet
SELECT * FROM dbo.NS_DP_PhieuNhapHang
SELECT * FROM dbo.NS_DP_PhieuNhapHang_ChiTiet

TRUNCATE TABLE NS_DP_PhieuNhapHang
TRUNCATE TABLE NS_DP_PhieuNhapHang_ChiTiet
TRUNCATE TABLE dbo.NS_DP_XuatNhapKho
TRUNCATE TABLE dbo.NS_DP_XuatNhapKho_ChiTiet
EXEC NhapKho_HienThiSanPhamTheoPhieu 3

--
TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_CaNhan
TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan

SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan
JOIN dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.PhieuDeNghi_CaNhan = NS_DP_PhieuDeNghi_CaNhan.PhieuDeNghi_CaNhan
JOIN dbo.NS_DP_SanPham ON dbo.NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc
JOIN dbo.NS_NhanSu ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu = NS_NhanSu.NhanSu
WHERE NS_DP_PhieuDeNghi_CaNhan.IsDel !=1

alter PROC DPBP_HienThiSanPham
AS 
BEGIN 
SELECT
	dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham,
	TenSanPham,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu,
	TenNhanSu=MaNhanSu+' - '+NS_NhanSu.HoDem+' '+ NS_NhanSu.Ten,
	SoLuong,
	DM_DP_LoaiSanPham.LoaiSanPham,
	DM_DP_LoaiSanPham.TenLoaiSanPham,
	DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.DonViTinh,
	DM_DP_DonViTinh.TenDonViTinh,
	dbo.NS_DP_PhieuDeNghi_CaNhan.LyDoCapPhat,
	dbo.DM_DP_LyDoCapPhat.TenLyDoCapPhat,
	NS_DP_PhieuDeNghi_CaNhan.PhieuDeNghi_CaNhan,
	dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.ID,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.TinhChatDongPhuc,
	MaPhieuDeNghi_CaNhan,
	NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Size ,
	dbo.DM_DP_Size.MaSize,
	NS_DP_PhieuDeNghi_CaNhan.TrangThaiDuyet
FROM dbo.NS_DP_PhieuDeNghi_CaNhan
JOIN dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.PhieuDeNghi_CaNhan = NS_DP_PhieuDeNghi_CaNhan.PhieuDeNghi_CaNhan
JOIN dbo.NS_DP_SanPham ON dbo.NS_DP_SanPham.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.SanPham = NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham AND NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc=NS_DP_PhieuDeNghi_CaNhan_ChiTiet.TinhChatDongPhuc
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON DM_DP_TinhChatDongPhuc.TinhChatDongPhuc = NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc
JOIN dbo.NS_NhanSu ON NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu = NS_NhanSu.NhanSu
JOIN DM_DP_LoaiSanPham on DM_DP_LoaiSanPham.LoaiSanPham = NS_DP_SanPham.LoaiSanPham
LEFT JOIN dbo.DM_DP_DonViTinh ON DM_DP_DonViTinh.DonViTinh = NS_DP_SanPham.DonViTinh
JOIN dbo.DM_DP_Size ON DM_DP_Size.Size = dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Size
JOIN dbo.DM_DP_LyDoCapPhat ON NS_DP_PhieuDeNghi_CaNhan.LyDoCapPhat = DM_DP_LyDoCapPhat.LyDoCapPhat
WHERE 1=1
		AND NS_DP_PhieuDeNghi_CaNhan.IsDel !=1 
		AND dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.IsDaChon!=1
ORDER BY NS_DP_PhieuDeNghi_CaNhan_ChiTiet.NhanSu, NS_DP_PhieuDeNghi_CaNhan_ChiTiet.SanPham
END
GO 
SELECT * FROM dbo.DM_DP_TrangThaiDuyet
SELECT * FROM NS_DP_PhieuDeNghi_CaNhan
SELECT * FROM  NS_DP_PhieuDeNghi_CaNhan_ChiTiet
EXEC DPBP_HienThiSanPham
WHERE PhieuDeNghi_CaNhan =2

SELECT * FROM dbo.NS_DP_PhieuDeNghi_ChiTiet
SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan

TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_CaNhan
TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi_ChiTiet
TRUNCATE TABLE dbo.NS_DP_PhieuDeNghi
SELECT * FROM dbo.DM_DP_TrangThaiDuyet
SELECT * FROM dbo.NS_DP_PhieuDeNghi_ChiTiet

EXEC DPBP_GetAllPhieuDeNghi
SELECT * FROM NS_DP_PhieuDeNghi_CaNhan_ChiTiet WHERE IsDaChon !=1
SELECT * FROM dbo.NS_DP_PhieuDeNghi_CaNhan_ChiTiet
SELECT * FROM dbo.NS_DP_PhieuDeNghi_ChiTiet
SELECT * FROM dbo.DM_DP_TrangThaiDuyet
INSERT INTO dbo.DM_DP_TrangThaiDuyet
(
    TenTrangThaiDuyet,
    IsDel,
    NguoiNhap,
    IPNhap,
    NgayNhap,
    MayNhap,
    NguoiSua,
    IPSua,
    NgaySua,
    MaySua,
    NguoiXoa,
    IPXoa,
    NgayXoa,
    MayXoa
)
VALUES
(   N'',  -- TenTrangThaiDuyet - nvarchar(100)
    NULL, -- IsDel - bit
    NULL, -- NguoiNhap - int
    NULL, -- IPNhap - nvarchar(50)
    NULL, -- NgayNhap - datetime
    NULL, -- MayNhap - nvarchar(50)
    NULL, -- NguoiSua - int
    NULL, -- IPSua - nvarchar(50)
    NULL, -- NgaySua - datetime
    NULL, -- MaySua - nvarchar(50)
    NULL, -- NguoiXoa - int
    NULL, -- IPXoa - nvarchar(50)
    NULL, -- NgayXoa - datetime
    NULL  -- MayXoa - nvarchar(50)
    )

	TRUNCATE TABLEih