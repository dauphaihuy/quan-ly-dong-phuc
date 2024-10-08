USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[getSize]    Script Date: 25/09/2024 9:01:38 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getSize]
AS
BEGIN
	SELECT S.*,
	LSP.TenLoaiSanPham,
	LSP.TenLoaiSanPham_EN,
	LSP.TenLoaiSanPham_JP
	FROM DM_DP_Size S
	LEFT JOIN DM_DP_LoaiSanPham LSP ON LSP.LoaiSanPham = S.LoaiSanPham
END