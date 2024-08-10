using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class NS_DP_PhieuDeNghiBoPhanController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();
        // GET: NS_DP_PhieuDeNghiBoPhan
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult DeNghiBP_GetDanhSachSanPhamDaChon(int PhieuDeNghi)
        {
            try
            {
                if (PhieuDeNghi == 0)
                {
                    return Json(new { success = true, item = new object[] { } });
                }
                else
                {
                    var phieuDeNghi = db.getPhieuDeNghi(PhieuDeNghi).SingleOrDefault();
                    var DanhSachSanPham = db.DPBP_GetSanPhamByPhieu(PhieuDeNghi);
                    return Json(new { success = true, phieuDeNghi, DanhSachSanPham });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        public JsonResult CapNhat_PhieuDeNghiBoPhan(string MaPhieuDeNghi, string TenNguoiDeNghi,
            int? TongSLYeuCau,int? TongSLNhan, string ghiChu,int PhieuDeNghi)
        {
            try
            {
                if (PhieuDeNghi == 0)
                {
                    NS_DP_PhieuDeNghi pdn = new NS_DP_PhieuDeNghi
                    {
                        MaPhieuDeNghi = RandomMaPhieu(6),
                        NguoiDeNghi = 17,
                        NgayDeNghi = DateTime.Now,
                        LoaiPhieu = 1,
                        GhiChu = ghiChu,
                        NguoiTao = 1,
                        NgayTao = DateTime.Now,
                        IsDel = false,
                        TrangThai=2,
                        TongSLNhan=0,
                        IsXuatKho=false,
                        IsHoanThanh=false,
                        TongSLYeuCau=0
                        
                    };
                    db.NS_DP_PhieuDeNghi.Add(pdn);
                    db.SaveChanges();
                    return Json(new { success = true, item = pdn });
                }
                var item = db.NS_DP_PhieuDeNghi.Where(x => x.PhieuDeNghi == PhieuDeNghi).SingleOrDefault();
                return Json(new { success = true, item });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        public JsonResult DeNghiBP_GetDanhSachSanPhamChuaChon(int PhieuDeNghi)
        {
            try
            {
                if (PhieuDeNghi == 0)
                {
                    var DanhSachSanPham = db.DPBP_HienThiSanPham();
                    return Json(new { success = true, DanhSachSanPham });
                }
                else
                {
                    //var DanhSachSanPham = db.DPBP_HienThiSanPhamChuaChon(PhieuDeNghi);
                    var DanhSachSanPham = db.DPBP_HienThiSanPham();
                    return Json(new { success = true, DanhSachSanPham });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
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
            return "BP_" + result.ToString();
        }
        //hiển thị tất cả phiếu
        public JsonResult getAllPhieu()
        {
            try
            {
                var listPhieu = db.DPBP_GetAllPhieuDeNghi();
                return Json(new { success = true, listPhieu });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        // thêm vs sửa
        public JsonResult DeNghiBP_ChonSanPham(int PhieuDeNghi,List<SanPhamChon> SanPhamChon)
        {
            try
            {
                var phieu = db.NS_DP_PhieuDeNghi.Where(x => x.PhieuDeNghi == PhieuDeNghi).FirstOrDefault();
                var soLuong = 0;
                foreach (var item in SanPhamChon)
                {
                    var phieuCaNhanct = db.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Where(x=>x.PhieuDeNghi_CaNhan == item.PhieuDeNghi_CaNhan);
                    foreach (var p in phieuCaNhanct)
                    {
                        var phieuCaNhan = db.NS_DP_PhieuDeNghi_CaNhan.Where(x => x.PhieuDeNghi_CaNhan == p.PhieuDeNghi_CaNhan).FirstOrDefault();
                        phieuCaNhan.TrangThaiDuyet = 4;
                        soLuong+= p.SoLuong;
                        NS_DP_PhieuDeNghi_ChiTiet pdnct = new NS_DP_PhieuDeNghi_ChiTiet
                        {
                            PhieuDeNghi = PhieuDeNghi,
                            NhanSu = p.NhanSu,
                            SanPham = p.SanPham,
                            Size = p.Size,
                            SoLuong = p.SoLuong,
                            LyDoCapPhat = phieuCaNhan.LyDoCapPhat,
                            GhiChu = p.GhiChu,
                            DonViTinh = p.DonViTinh,
                            SoLuongDaNhan = p.SoLuongDaNhan,
                            PhieuDeNghi_CaNhan_ChiTiet = p.PhieuDeNghi_CaNhan,
                            TinhChatDongPhuc = p.TinhChatDongPhuc,
                            TrangThaiDuyet = 2,
                        };
                        p.IsDaChon= true;
                        db.NS_DP_PhieuDeNghi_ChiTiet.Add(pdnct);
                    }
                }
                phieu.TongSLYeuCau= soLuong+ phieu.TongSLYeuCau;
                db.SaveChanges();
                return Json(new { success = true, PhieuDeNghi });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        public JsonResult DeNghiBP_TuChoiPhieuDeNghi(List<TuChoiPhieu> DanhSachSanPham,string LyDoTuChoi)
        {
            try
            {
                foreach(var item in DanhSachSanPham)
                {
                    var phieuCaNhan = db.NS_DP_PhieuDeNghi_CaNhan.Where(x => x.PhieuDeNghi_CaNhan == item.PhieuDeNghi_CaNhan).SingleOrDefault();
                    phieuCaNhan.TrangThaiDuyet = 3;
                    phieuCaNhan.LyDoTuChoi = LyDoTuChoi;
                    phieuCaNhan.NgayDuyet = DateTime.Now;
                    phieuCaNhan.NguoiDuyet = 1;
                    db.SaveChanges();
                }
                return Json(new { success = true });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
        }
        
        //xóa
        public JsonResult DeNghiBP_XoaSanPham(List<XoaSanPham> DanhSachSanPham)
        {
            try
            {
                foreach(var item in DanhSachSanPham)
                {
                    var phieuDeNghiCaNhanChiTiet = db.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Where(x => x.PhieuDeNghi_CaNhan == item.PhieuDeNghi_CaNhan_ChiTiet);
                    foreach (var p in phieuDeNghiCaNhanChiTiet)
                    {
                            p.IsDaChon = false;
                    }
                    var PhieuDeNghiChiTiet = db.NS_DP_PhieuDeNghi_ChiTiet.Where(x => x.PhieuDeNghi_CaNhan_ChiTiet == item.PhieuDeNghi_CaNhan_ChiTiet);
                    foreach (var p in PhieuDeNghiChiTiet)
                    {
                        var phieuDeNghi = db.NS_DP_PhieuDeNghi.Where(x => x.PhieuDeNghi == p.PhieuDeNghi).SingleOrDefault();
                        phieuDeNghi.TongSLYeuCau = phieuDeNghi.TongSLYeuCau - p.SoLuong;
                    }
                    db.NS_DP_PhieuDeNghi_ChiTiet.RemoveRange(PhieuDeNghiChiTiet);
                }
                db.SaveChanges();
                return Json(new { success = true , DanhSachSanPham });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
        }
        public JsonResult DeNghiBP_XoaPhieuPham(List<XoaPhieu> DanhSachPhieu)
        {
            try
            {
                foreach (var item in DanhSachPhieu)
                {
                    var phieu = db.NS_DP_PhieuDeNghi.Where(x => x.PhieuDeNghi == item.PhieuDeNghi).SingleOrDefault();
                    phieu.IsDel = true;
                    db.SaveChanges();
                }
                return Json(new { success = true, DanhSachPhieu });
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
        }
    }
    public class XoaSanPham
    {
        public int PhieuDeNghi_CaNhan_ChiTiet { get; set; }
    }
    public class XoaPhieu
    {
        public int PhieuDeNghi { get; set; }
    }
    public class TuChoiPhieu
    {
        public int PhieuDeNghi_CaNhan { get; set; }
    }
    public class SanPhamChon
    {
        public int NhanSu { get; set; }
        public int PhieuDeNghi_CaNhan { get; set; }
    }
}