USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getTinhChatTuSanPham]    Script Date: 25/09/2024 9:01:53 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[getTinhChatTuSanPham](
	@sanPham int =null 
)
as 
begin
select tcdp.* from DM_DP_TinhChatDongPhuc tcdp join NS_DP_SanPham_TinhChatDongPhuc sptcdp 
on tcdp.TinhChatDongPhuc = sptcdp.TinhChatDongPhuc
join NS_DP_SanPham sp on sp.SanPham = sptcdp.SanPham
where sp.SanPham =@sanPham
end
