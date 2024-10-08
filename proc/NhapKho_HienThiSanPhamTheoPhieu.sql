USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[NhapKho_HienThiSanPhamTheoPhieu]    Script Date: 25/09/2024 9:04:18 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[NhapKho_HienThiSanPhamTheoPhieu]
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
           NS_DP_XuatNhapKho.TyGia,
		    dbo.NS_DP_PhieuNhapHang_ChiTiet.ID
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
