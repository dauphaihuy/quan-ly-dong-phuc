USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getSizeFromSanPham]    Script Date: 25/09/2024 9:01:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[getSizeFromSanPham](
	@masp int = NULL
)
as
begin 
select distinct size.*  from 
DM_DP_Size size join DM_DP_LoaiSanPham loaisp on size.LoaiSanPham = loaisp.LoaiSanPham
join NS_DP_SanPham sp on sp.LoaiSanPham = loaisp.LoaiSanPham
where sp.SanPham =@masp
end