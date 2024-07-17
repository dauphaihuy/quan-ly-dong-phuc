select * from [NS_DP_PhieuDeNghi_CaNhan]
select * from [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet]
delete from [NS_DP_PhieuDeNghi_CaNhan]
where PhieuDeNghi_CaNhan = 11
select * from [dbo].[NS_DP_PhieuDeNghi_CaNhan_ChiTiet]
exec [getDanhSachSanPham]
select * from DM_DP_LyDoCapPhat

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
select * from[dbo].[NS_DP_PhieuNhapHang]
select * from NS_DP_PhieuNhapHang_ChiTiet
exec [dbo].[getXuatNhapKho]
select * from NS_DP_PhieuNhapHang pnh join NS_DP_PhieuNhapHang_ChiTiet pnhct on pnh.PhieuNhapHang = pnhct.PhieuNhapHang
