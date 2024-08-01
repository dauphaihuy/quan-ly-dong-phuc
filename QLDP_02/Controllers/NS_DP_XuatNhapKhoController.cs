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
        public int STT { get; set; }
        public int PhieuNhaphang {get;set; }
        public int SanPham { get; set; }
        public string TenSanPham { get; set; }
        public int Size { get; set; }
        public int SoLuong { get; set; }
        public int SoLuongDaNhap { get; set; }
        public int DonGia { get; set; }
        public int DonViTinh  { get; set; }
        public string TenDonViTinh { get; set; }
        public int ThanhTien { get; set; }
        public string GhiChu { get; set; }
        public int MaSize { get; set; }
        public int TonKho { get; set; }
        public int SoLuongYeuCau { get; set; }
        public int TinhChatDongPhuc { get; set; }
        public int NhaCungCap { get; set; }
    }
    public class NS_DP_XuatNhapKhoController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();
        public JsonResult getAllDanhSachNhapHang()
        {
            try
            {
                var result = db.NhapKho_getAllDanhSachNhapHang();
                return Json(new { success = true, item = result });
            }
            catch(Exception e)
            {
                return Json(new{ success = false, err = e.Message });
            }
        }
        public JsonResult NhapKho_XoaPhieuNhapKho(int XuatNhapKho)
        {
            try
            {
                var xuatNhapKhoChiTiet = db.NS_DP_XuatNhapKho_ChiTiet.Where(x => x.XuatNhapKho == XuatNhapKho).ToList();
                var xuatNhapKho = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == XuatNhapKho).FirstOrDefault();
                var PhieuNhapHang = db.NS_DP_PhieuNhapHang.Where(x => x.PhieuNhapHang == xuatNhapKho.IDPhieu).FirstOrDefault();
                var phieuNhapHangChiTiet = db.NS_DP_PhieuNhapHang_ChiTiet.Where(x => x.PhieuNhapHang == xuatNhapKho.IDPhieu);
                foreach(var itemxnkChiTiet in xuatNhapKhoChiTiet)
                {
                    foreach (var itemPhieuChiTiet in phieuNhapHangChiTiet)
                    {
                        if(itemxnkChiTiet.SanPham==itemPhieuChiTiet.SanPham 
                            && itemxnkChiTiet.Size == itemPhieuChiTiet.Size 
                            && itemxnkChiTiet.DonViTinh == itemPhieuChiTiet.DonViTinh)
                        {
                            itemPhieuChiTiet.SoLuongDaNhap = itemPhieuChiTiet.SoLuongDaNhap - itemxnkChiTiet.SoLuong;
                            PhieuNhapHang.TongSLDaNhap = PhieuNhapHang.TongSLDaNhap - itemxnkChiTiet.SoLuong;
                            PhieuNhapHang.IsHoanThanh = false;
                        }
                    }
                }
                //db.NS_DP_XuatNhapKho_ChiTiet.RemoveRange(xuatNhapKhoChiTiet);
                xuatNhapKho.IsDel = true;
                xuatNhapKho.NgayXoa = DateTime.Now;
                db.SaveChanges();
                return Json(new { success = true , xuatNhapKhoChiTiet, xuatNhapKho, phieuNhapHangChiTiet });
            }catch(Exception e)
            {
                return Json(new { success = false, err = e.Message });
            }   
        }
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
                if (xuatNhapKho != 0)
                {
                    var phieu = db.NS_DP_XuatNhapKho.Where(x => x.MaXuatNhapKho == maXuatNhapKho).FirstOrDefault();
                    
                    return Json(new { success = true , phieuXuatNhapKho  = phieu });
                }
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, err = ex.Message });
            }
        }
        public JsonResult NhapKho_HienSanPhamTheoPhieu(int XuatNhapKho)
        {
            try
            {
                var phieuXuatNhapKho = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho==XuatNhapKho).FirstOrDefault();
                var dssp = db.NhapKho_HienThiSanPhamTheoPhieu(XuatNhapKho);
                return Json(new { success = true, phieuXuatNhapKho, dssp });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e.Message });
            }
        }
        public JsonResult NhapKho_ThemSanPham(int XuatNhapKho, List<XuatNhapKhoChiTiet> danhSachSanPhamNhapKho)
        {
            try
            {
                var ktraTonTai = db.NS_DP_XuatNhapKho_ChiTiet.Where(x => x.XuatNhapKho == XuatNhapKho).Count();
                //ktra phiếu đã tồn tại ch
                if (ktraTonTai == 0)
                {
                    foreach (var item in danhSachSanPhamNhapKho)
                    {
                        var capnhatphieuNhapChiTiet = db.NS_DP_PhieuNhapHang_ChiTiet.Where(x => x.PhieuNhapHang == item.PhieuNhaphang && x.SanPham == item.SanPham && x.Size == item.MaSize).FirstOrDefault();
                        var phieuNhapHang = db.NS_DP_PhieuNhapHang.Where(x => x.PhieuNhapHang == item.PhieuNhaphang).FirstOrDefault();
                        if (item.SoLuong > capnhatphieuNhapChiTiet.SoLuong || item.SoLuong + capnhatphieuNhapChiTiet.SoLuongDaNhap > item.SoLuongYeuCau)
                        {
                            return Json(new { success = false, message = "số lượng nhập lớn hơn số lượng yêu cầu" });
                        }
                        else
                        {
                            capnhatphieuNhapChiTiet.SoLuongDaNhap = item.SoLuong + capnhatphieuNhapChiTiet.SoLuongDaNhap;
                            phieuNhapHang.TongSLDaNhap = item.SoLuong + phieuNhapHang.TongSLDaNhap;
                            phieuNhapHang.NhaCungCap = item.NhaCungCap;
                            if (phieuNhapHang.TongSLMua == phieuNhapHang.TongSLDaNhap)
                            {
                                phieuNhapHang.IsHoanThanh = true;
                            }
                            var xnk = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == XuatNhapKho).FirstOrDefault();
                            xnk.NhaCungCap = item.NhaCungCap;
                            NS_DP_XuatNhapKho_ChiTiet xnkct = new NS_DP_XuatNhapKho_ChiTiet
                            {
                                XuatNhapKho = XuatNhapKho,
                                SanPham = item.SanPham,
                                Size = item.MaSize,
                                SoLuong = item.SoLuong,
                                DonViTinh = item.DonViTinh,
                                GhiChu = item.GhiChu,
                                DonGia = item.DonGia,
                                ThanhTien = item.ThanhTien,
                                TinhChatDongPhuc = item.TinhChatDongPhuc,
                                NhaCungCap = item.NhaCungCap
                            };
                            db.NS_DP_XuatNhapKho_ChiTiet.Add(xnkct);
                            db.SaveChanges();

                        }
                    }
                    return Json(new { success = true, danhSachSanPhamNhapKho });
                }
                else
                {
                    return Json(new { success = true, message="cập nhật" });
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e.Message });
            }
        }

    }
}
