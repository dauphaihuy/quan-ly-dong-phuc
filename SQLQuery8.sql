
alter PROC GetBaoCaoTonKho
	@Thang VARCHAR(5) = null,
	@Nam VARCHAR(5) = NULL,
	@NCC INT =null
AS
SET NOCOUNT ON 
BEGIN 
	DECLARE  @Ngay DATE = @Nam+'-'+@Thang+'-01'
SELECT 
	ROW_NUMBER() OVER (ORDER BY NS_DP_PhieuDeNghi_CaNhan_ChiTiet.ID) AS stt,
	NS_DP_SanPham.TenSanPham,
	ISNULL(DM_DP_TinhChatDongPhuc.TenTinhChatDongPhuc,'') TenTinhChatDongPhuc,
	DM_DP_LoaiSanPham.TenLoaiSanPham,
	DM_DP_Size.MaSize,
	DM_DP_DonViTinh.TenDonViTinh,
	ISNULL(tonDauKi.tonDauKi,0) tonDauKi,
	ISNULL(ntk.ntk,0) nhaptrongki,
	ISNULL(xtk.xtk,0) xuatrongki,
	toncuoi =ISNULL(tonDauKi.tonDauKi,0)+ ISNULL(ntk.ntk,0)- ISNULL(xtk.xtk,0),
	@Ngay ngay
	--ton dk = tondk+ntk-xtk
	
FROM dbo.NS_DP_SanPham 
LEFT JOIN dbo.NS_DP_SanPham_TinhChatDongPhuc ON NS_DP_SanPham.SanPham = NS_DP_SanPham_TinhChatDongPhuc.SanPham 
LEFT JOIN dbo.DM_DP_NhaCungCap ON NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = DM_DP_NhaCungCap.NhaCungCap
LEFT JOIN dbo.DM_DP_TinhChatDongPhuc ON NS_DP_SanPham_TinhChatDongPhuc.TinhChatDongPhuc = DM_DP_TinhChatDongPhuc.TinhChatDongPhuc
LEFT JOIN dbo.DM_DP_LoaiSanPham ON NS_DP_SanPham.LoaiSanPham = DM_DP_LoaiSanPham.LoaiSanPham
LEFT JOIN dbo.DM_DP_Size ON DM_DP_LoaiSanPham.LoaiSanPham = DM_DP_Size.LoaiSanPham
LEFT JOIN dbo.DM_DP_DonViTinh ON NS_DP_SanPham.DonViTinh = DM_DP_DonViTinh.DonViTinh
--tồn đầu kì
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
--nhập trong kì
LEFT JOIN (
		SELECT SUM(NS_DP_XuatNhapKho_ChiTiet.SoLuong) ntk, 
			NS_DP_XuatNhapKho_ChiTiet.Size, 
			NS_DP_XuatNhapKho_ChiTiet.SanPham,
			NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
		FROM dbo.NS_DP_XuatNhapKho_ChiTiet
		LEFT JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
		WHERE MONTH(NS_DP_XuatNhapKho.NgayNhapXuat) = MONTH(@Ngay) AND Year(NS_DP_XuatNhapKho.NgayNhapXuat) = year(@Ngay)
			AND NS_DP_XuatNhapKho.LoaiPhieu=1
		GROUP BY NS_DP_XuatNhapKho_ChiTiet.SanPham , 
			NS_DP_XuatNhapKho_ChiTiet.Size, 
			NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
) ntk ON ntk.SanPham = NS_DP_SanPham.SanPham --nhập trong kì
				AND ntk.Size = DM_DP_Size.Size
				AND ntk.NhaCungCap = NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap
-- xuất trong kì			
LEFT JOIN (
		SELECT -SUM(NS_DP_XuatNhapKho_ChiTiet.SoLuong) xtk, 
			NS_DP_XuatNhapKho_ChiTiet.Size, 
			NS_DP_XuatNhapKho_ChiTiet.SanPham,
			NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
		FROM dbo.NS_DP_XuatNhapKho_ChiTiet
		LEFT JOIN dbo.NS_DP_XuatNhapKho ON NS_DP_XuatNhapKho.XuatNhapKho = NS_DP_XuatNhapKho_ChiTiet.XuatNhapKho
		WHERE MONTH(NS_DP_XuatNhapKho.NgayNhapXuat) = MONTH(@Ngay) AND Year(NS_DP_XuatNhapKho.NgayNhapXuat) = year(@Ngay)
			AND NS_DP_XuatNhapKho.LoaiPhieu=2
		GROUP BY NS_DP_XuatNhapKho_ChiTiet.SanPham , 
			NS_DP_XuatNhapKho_ChiTiet.Size, 
			NS_DP_XuatNhapKho_ChiTiet.NhaCungCap
) xtk ON xtk.SanPham = NS_DP_SanPham.SanPham --nhập trong kì
				AND xtk.Size = DM_DP_Size.Size
				AND xtk.NhaCungCap = NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap
WHERE NS_DP_SanPham_TinhChatDongPhuc.NhaCungCap = @Ncc
end
GO 

EXEC GetBaoCaoTonKho @Thang = 8, @Nam = 2024 ,@NCC = 2