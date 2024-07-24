using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class XuatNhapKhoChiTiet
    {
        int STT { get; set; }
        int PhieuNhaphang {get;set; }
        int SanPham { get; set; }
        string TenSanPham { get; set; }
        int Size { get; set; }
        int SoLuong { get; set; }
        int SoLuongDaNhap { get; set; }
        int DonGia { get; set; }
        int DonViTinh  { get; set; }
        string TenDonViTinh { get; set; }
        int ThanhTien { get; set; }
        string GhiChu { get; set; }
        int MaSize { get; set; }
        int TonKho { get; set; }
        int SoLuongYeuCau { get; set; }
        int TinhChatDongPhuc { get; set; }
        int NhaCungCap { get; set; }
    }
    public class NS_DP_XuatNhapKhoController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();

        public JsonResult NhapKho_GetDanhSachSanPhamNhapHang(int phieuNhapHang)
        {
            return Json(new { success = true });
        }
        // GET: NS_DP_XuatNhapKho/NhapKho
        public ActionResult NhapKho()
        {
            var SelectPhieuNhap = db.NhapKho_SelectPhieuNhapHang().Where(phieu => phieu.IsDel != true && phieu.IsHoanThanh != true);
            var SelectKhoNhan = db.DM_DP_Kho;
            ViewBag.SelectPhieuNhap = new SelectList(SelectPhieuNhap, "PhieuNhapHang", "TenVaMaPhieu");
            ViewBag.SelectKhoNhan = new SelectList(SelectKhoNhan, "Kho", "TenKho");
            return View();
        }
        public JsonResult NhapKho_ChonPhieuNhapHan(int? maPhieuNhap)
        {
            try
            {
                if (maPhieuNhap == null)
                {
                    Json(new { success = true, item = new object[] { } });
                }
                var result = db.NhapKho_ChangeSelectPhieuNhap(maPhieuNhap);
                return Json(new { success = true, item = result });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, err = ex.Message });
            }
        }
        public static string RandomMaPhieu(int length)
        {
            const string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            StringBuilder result = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < length; i++)
            {
                int index = random.Next(characters.Length);
                result.Append(characters[index]);
            }
            return "NK_" + result.ToString();
        }
        public JsonResult CapNhat_PhieuNhapKho(string maXuatNhapKho, string ghiChu, int phieuNhapHang, int khoNhan, string ngayNhap, decimal tyGia, int xuatNhapKho)
        {
            try
            {   // thêm mới
                if(xuatNhapKho == 0)
                {
                    NS_DP_XuatNhapKho xnkRow = new NS_DP_XuatNhapKho
                    {
                        MaXuatNhapKho = RandomMaPhieu(5),
                        Kho = khoNhan,
                        LoaiPhieu = 1,
                        IDPhieu = phieuNhapHang,
                        GhiChu = ghiChu,
                        NgayTao = DateTime.Parse(ngayNhap),
                        IsDel = false,
                        TyGia = tyGia,
                    };
                    db.NS_DP_XuatNhapKho.Add(xnkRow);
                    db.SaveChanges();
                    return Json(new { success = true , phieuXuatNhapKho= xnkRow });
                }
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, err = ex.Message });
            }
        }
    }
}
