USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getPhieuDeNghi]    Script Date: 25/09/2024 8:59:58 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC
[dbo].[getPhieuDeNghi](@PhieuDeNghi int= NULL)
AS
BEGIN 
SELECT 
PhieuDeNghi,
MaPhieuDeNghi,
NgayDeNghi,
TenNguoiDeNghi =HoDem+' '+Ten,
TongSLYeuCau,
TongSLNhan,
NS_DP_PhieuDeNghi.GhiChu
FROM dbo.NS_DP_PhieuDeNghi
LEFT JOIN dbo.NS_NhanSu ON NS_NhanSu.NhanSu = NS_DP_PhieuDeNghi.NguoiDeNghi
WHERE NS_DP_PhieuDeNghi.PhieuDeNghi = @PhieuDeNghi
END
