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
                        
                    };
                    db.NS_DP_PhieuDeNghi.Add(pdn);
                    db.SaveChanges();
                    return Json(new { success = true, item = pdn });
                }

                return Json(new { success = true });
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
                        db.NS_DP_PhieuDeNghi_ChiTiet.Add(pdnct);
                    }
                }
                phieu.TongSLYeuCau= soLuong;
                db.SaveChanges();
                return Json(new { success = true  });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        //xóa
        public JsonResult DeNghiBP_XoaSanPham(int ID)
        {
            try
            {
                var item = db.NS_DP_PhieuDeNghi_ChiTiet.Where(x => x.ID == ID).SingleOrDefault();
                var phieuDeNghi = db.NS_DP_PhieuDeNghi.Where(x => x.PhieuDeNghi == item.PhieuDeNghi).SingleOrDefault();
                phieuDeNghi.TongSLYeuCau -= item.SoLuong;
                db.NS_DP_PhieuDeNghi_ChiTiet.Remove(item);
                db.SaveChanges();
                return Json(new { success = true ,item});
            }
            catch (Exception e)
            {
                return Json(new { success = false, message = e.Message });
            }
        }
    }
    public class SanPhamChon
    {
        public int NhanSu { get; set; }
        public int PhieuDeNghi_CaNhan { get; set; }
    }
}