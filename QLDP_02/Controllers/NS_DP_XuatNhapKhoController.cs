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
        public int PhieuNhaphang { get; set; }
        public int SanPham { get; set; }
        public string TenSanPham { get; set; }
        public int Size { get; set; }
        public int SoLuong { get; set; }
        public int SoLuongDaNhap { get; set; }
        public int DonGia { get; set; }
        public int DonViTinh { get; set; }
        public string TenDonViTinh { get; set; }
        public int ThanhTien { get; set; }
        public string GhiChu { get; set; }
        public int MaSize { get; set; }
        public int TonKho { get; set; }
        public int SoLuongYeuCau { get; set; }
        public int TinhChatDongPhuc { get; set; }
        public int NhaCungCap { get; set; }
        public int ID { get; set; }
    }
    public class XoaPhieuNhapKho
    {
        public int XuatNhapKho { get; set; }
    }
    public class XuatKho_XoaSanPham 
    { 
        public int ID { get; set; }
        public int SanPham { get; set; }
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
            catch (Exception e)
            {
                return Json(new { success = false, err = e.Message });
            }
        }
        //xóa từng cái
        //public JsonResult NhapKho_XoaPhieuNhapKho(int XuatNhapKho)
        //{
        //    try
        //    {
        //        var xuatNhapKhoChiTiet = db.NS_DP_XuatNhapKho_ChiTiet.Where(x => x.XuatNhapKho == XuatNhapKho).ToList();
        //        var xuatNhapKho = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == XuatNhapKho).FirstOrDefault();
        //        var PhieuNhapHang = db.NS_DP_PhieuNhapHang.Where(x => x.PhieuNhapHang == xuatNhapKho.IDPhieu).FirstOrDefault();
        //        var phieuNhapHangChiTiet = db.NS_DP_PhieuNhapHang_ChiTiet.Where(x => x.PhieuNhapHang == xuatNhapKho.IDPhieu);
        //        foreach(var itemxnkChiTiet in xuatNhapKhoChiTiet)
        //        {
        //            foreach (var itemPhieuChiTiet in phieuNhapHangChiTiet)
        //            {
        //                if(itemxnkChiTiet.SanPham==itemPhieuChiTiet.SanPham 
        //                    && itemxnkChiTiet.Size == itemPhieuChiTiet.Size 
        //                    && itemxnkChiTiet.DonViTinh == itemPhieuChiTiet.DonViTinh)
        //                {
        //                    itemPhieuChiTiet.SoLuongDaNhap = itemPhieuChiTiet.SoLuongDaNhap - itemxnkChiTiet.SoLuong;
        //                    PhieuNhapHang.TongSLDaNhap = PhieuNhapHang.TongSLDaNhap - itemxnkChiTiet.SoLuong;
        //                    PhieuNhapHang.IsHoanThanh = false;
        //                }
        //            }
        //        }
        //        //db.NS_DP_XuatNhapKho_ChiTiet.RemoveRange(xuatNhapKhoChiTiet);
        //        xuatNhapKho.IsDel = true;
        //        xuatNhapKho.NgayXoa = DateTime.Now;
        //        db.SaveChanges();
        //        return Json(new { success = true , xuatNhapKhoChiTiet, xuatNhapKho, phieuNhapHangChiTiet });
        //    }catch(Exception e)
        //    {
        //        return Json(new { success = false, err = e.Message });
        //    }   
        //}
        public JsonResult NhapKho_GetDanhSachSanPhamNhapHang(int phieuNhapHang)
        {
            return Json(new { success = true });
        }
        // GET: NS_DP_XuatNhapKho/NhapKho
        public ActionResult NhapKho()
        {
            var SelectPhieuNhap = db.NhapKho_SelectPhieuNhapHang();
            var SelectKhoNhan = db.DM_DP_Kho;
            ViewBag.SelectPhieuNhap = new SelectList(SelectPhieuNhap, "PhieuNhapHang", "TenVaMaPhieu");
            ViewBag.SelectKhoNhan = new SelectList(SelectKhoNhan, "Kho", "TenKho");
            return View();
        }
        public ActionResult XuatKho()
        {
            return View();
        }
        public JsonResult getPhieuNhapHang()
        {
            try
            {
                var SelectPhieuNhap = db.NhapKho_SelectPhieuNhapHang();
                return Json(new { success = true, SelectPhieuNhap });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, err = ex.Message });
            }
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
                if (xuatNhapKho == 0)
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
                        NgayNhapXuat=DateTime.Now,  
                    };
                    db.NS_DP_XuatNhapKho.Add(xnkRow);
                    db.SaveChanges();
                    return Json(new { success = true, phieuXuatNhapKho = xnkRow });
                }
                if (xuatNhapKho != 0)
                {
                    var phieu = db.NS_DP_XuatNhapKho.Where(x => x.MaXuatNhapKho == maXuatNhapKho).FirstOrDefault();

                    return Json(new { success = true, phieuXuatNhapKho = phieu });
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
                var phieuXuatNhapKho = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == XuatNhapKho).FirstOrDefault();
                var dssp = db.NhapKho_HienThiSanPhamTheoPhieu(XuatNhapKho);
                return Json(new { success = true, phieuXuatNhapKho, dssp });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e.Message });
            }
        }
        public JsonResult NhapKho_XoaPhieuNhapKho(List<XoaPhieuNhapKho> ListPhieuCanXoa)
        {
            try
            {
                foreach (var item in ListPhieuCanXoa)
                {
                    var xuatNhapKhoChiTiet = db.NS_DP_XuatNhapKho_ChiTiet.Where(x => x.XuatNhapKho == item.XuatNhapKho).ToList();
                    var xuatNhapKho = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == item.XuatNhapKho).FirstOrDefault();
                    var PhieuNhapHang = db.NS_DP_PhieuNhapHang.Where(x => x.PhieuNhapHang == xuatNhapKho.IDPhieu).FirstOrDefault();
                    var phieuNhapHangChiTiet = db.NS_DP_PhieuNhapHang_ChiTiet.Where(x => x.PhieuNhapHang == xuatNhapKho.IDPhieu);
                    foreach (var itemxnkChiTiet in xuatNhapKhoChiTiet)
                    {
                        foreach (var itemPhieuChiTiet in phieuNhapHangChiTiet)
                        {
                            if (itemxnkChiTiet.SanPham == itemPhieuChiTiet.SanPham
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
                }
                return Json(new { success = true });
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
                    db.SaveChanges();
                    return Json(new { success = true, message = "cập nhật" });
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e.Message });
            }
        }
        //xuất kho
        public JsonResult XuatKho_RenderSelectPhieuDeNghiBoPhan()
        {
            try
            {
                var result = db.NS_DP_PhieuDeNghi.Where(x => x.IsDel == false && x.IsHoanThanh!=true);
                return Json(new { success = true, result });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_RenderSelectKho()
        {
            try
            {
                var result = db.DM_DP_Kho;
                return Json(new { success = true, result });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_RenderNhaCungCap()
        {
            try
            {
                var result = db.DM_DP_NhaCungCap.Where(x => x.IsDel != true);
                return Json(new { success = true, result });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_GetDanhSachSanPhamDeNghi(int phieuDeNghi, int nhaCungCap)
        {
            try
            {
                var item = db.XuatKho_GetSanPham(phieuDeNghi, nhaCungCap);
                return Json(new { success = true, item });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public static string RandomXuatKho(int length)
        {
            const string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            StringBuilder result = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < length; i++)
            {
                int index = random.Next(characters.Length);
                result.Append(characters[index]);
            }
            return "XK_" + result.ToString();
        }
        public JsonResult CapNhat_PhieuXuatKho(String MaXuatNhapKho, String GhiChu, int IDPhieu, 
            int Kho, String NgayNhapXuat, int XuatNhapKho)
        {
            try
            {
                if (XuatNhapKho == 0)
                {
                    NS_DP_XuatNhapKho xnkRow = new NS_DP_XuatNhapKho
                    {
                        MaXuatNhapKho = RandomXuatKho(5),
                        Kho = Kho,
                        LoaiPhieu = 2,
                        IDPhieu = IDPhieu,
                        GhiChu = GhiChu,
                        NgayTao = DateTime.Parse(NgayNhapXuat),
                        IsDel = false,
                        NguoiTao = 17,
                        NgayNhapXuat = DateTime.Now,
                        NguoiNhapXuat = 17,

                    };
                    db.NS_DP_XuatNhapKho.Add(xnkRow);
                    db.SaveChanges();
                    return Json(new { success = true, phieuXuatNhapKho = xnkRow });
                }
                if (XuatNhapKho != 0) { 
                    var phieu = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == XuatNhapKho).FirstOrDefault();
                    return Json(new { success = true, phieuXuatNhapKho = phieu });
                }
                return Json(new { success = true, });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });

            }
        }
        public JsonResult XuatKho_ChonSanPham(int XuatNhapKho, int IDPhieu, List<XuatKho_GetSanPham_Result> listChonSp)
        {
            try
            {
                var phieu = db.NS_DP_PhieuDeNghi.Where(x => x.PhieuDeNghi == IDPhieu).SingleOrDefault();
                var XuatNhapKhoChiTiet = db.NS_DP_XuatNhapKho_ChiTiet.Where(x => x.XuatNhapKho == XuatNhapKho).ToList();
                var xnk_ct_ns = db.NS_DP_XuatKho_ChiTiet_NhanSu.Where(x => x.XuatNhapKho == XuatNhapKho).ToList();
                foreach (var item in listChonSp)
                {
                    var existingItem = XuatNhapKhoChiTiet.FirstOrDefault(x => x.SanPham == item.SanPham && x.Size == item.Size && x.NhaCungCap == item.NhaCungCap);
                    if (existingItem != null)
                    {
                        existingItem.SoLuong -= item.SoLuong;
                        phieu.TongSLNhan += item.SoLuong;
                        existingItem.ThanhTien = -existingItem.SoLuong * existingItem.DonGia;

                        if (phieu.TongSLNhan == phieu.TongSLYeuCau)
                        {
                            phieu.IsHoanThanh = true;
                        }

                        var phieuDNChiTiet = db.NS_DP_PhieuDeNghi_ChiTiet.Where(x => x.PhieuDeNghi == IDPhieu && x.SanPham == item.SanPham && x.Size == item.Size);
                        foreach (var itemPhieuDNChiTiet in phieuDNChiTiet)
                        {
                            itemPhieuDNChiTiet.SoLuongDaNhan += item.SoLuong;
                        }
                    }
                    else
                    {
                        NS_DP_XuatNhapKho_ChiTiet ct = new NS_DP_XuatNhapKho_ChiTiet
                        {
                            XuatNhapKho = XuatNhapKho,
                            SanPham = item.SanPham,
                            Size = item.Size,
                            SoLuong = -item.SoLuong,
                            DonGia = item.DonGia,
                            ThanhTien = item.SoLuong * item.DonGia,
                            TinhChatDongPhuc = item.TinhChatDongPhuc,
                            NhaCungCap = item.NhaCungCap,
                            DonViTinh = item.DonViTinh
                        };
                        phieu.TongSLNhan += item.SoLuong;
                        if (phieu.TongSLNhan == phieu.TongSLYeuCau)
                        {
                            phieu.IsHoanThanh = true;
                        }
                        var phieuDNChiTiet = db.NS_DP_PhieuDeNghi_ChiTiet.Where(x => x.PhieuDeNghi == IDPhieu && x.SanPham == item.SanPham && x.Size == item.Size);
                        foreach (var itemPhieuDNChiTiet in phieuDNChiTiet)
                        {
                            itemPhieuDNChiTiet.SoLuongDaNhan += item.SoLuong;
                        }
                        db.NS_DP_XuatNhapKho_ChiTiet.Add(ct);
                        //NS_DP_XuatKho_ChiTiet_NhanSu
                        
                    }
                    var xk_ct_ns_exit = db.NS_DP_XuatKho_ChiTiet_NhanSu.Where(x => x.XuatNhapKho == XuatNhapKho
                        && x.SanPham == item.SanPham && x.Size==item.Size && x.DonViTinh == item.DonViTinh && x.NhaCungCap == item.NhaCungCap).FirstOrDefault();
                    if (xk_ct_ns_exit != null)
                    {
                        xk_ct_ns_exit.SoLuong = xk_ct_ns_exit.SoLuong + -item.SoLuong;
                        xk_ct_ns_exit.ThanhTien = -xk_ct_ns_exit.SoLuong * xk_ct_ns_exit.DonGia;
                    }
                    else
                    {
                        NS_DP_XuatKho_ChiTiet_NhanSu xk_ct_ns = new NS_DP_XuatKho_ChiTiet_NhanSu
                        {
                            XuatNhapKho = XuatNhapKho,
                            SanPham = item.SanPham,
                            Size = item.Size,
                            SoLuong = -item.SoLuong,
                            DonViTinh = item.DonViTinh,
                            DonGia = item.DonGia,
                            ThanhTien = item.SoLuong * item.DonGia,
                            TinhChatDongPhuc = item.TinhChatDongPhuc,
                            NhaCungCap = item.NhaCungCap,
                            NhanSu = item.NhanSu,
                            NguoiDoiTra = null,
                            NgayDoiTra = null
                        };
                        db.NS_DP_XuatKho_ChiTiet_NhanSu.Add(xk_ct_ns);
                    }
                }
                db.SaveChanges();
                return Json(new { success = true, XuatNhapKho, IDPhieu, listChonSp });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_getAllPhieuXuatKho()
        {
            try
            {
                var allPhieuXuatKho = db.XuatKho_getAllPhieuXuatKho();
                return Json(new { success = true, allPhieuXuatKho },JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_GetDanhSachSanPhamDaChon(int XuatNhapKho,int IDPhieu)
        {
            try
            {
                var xuatKho = db.XuatKho_getAllPhieuXuatKho()
                    .Where(x => x.XuatNhapKho == XuatNhapKho)
                    .SingleOrDefault();
                var dssp = db.XuatKho_GetSanPhamByPhieu(XuatNhapKho, IDPhieu);
                var phieuBP = db.NS_DP_PhieuDeNghi.Where(x => x.PhieuDeNghi == IDPhieu).SingleOrDefault();
                return Json(new { success = true, xuatKho , dssp, phieuBP });
            }
            catch(Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_CapNhatSanPham(int XuatNhapKho,String GhiChu, List<XuatKho_GetSanPhamByPhieu_Result> listsp)
        {
            try
            {
                var phieu = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == XuatNhapKho).SingleOrDefault();
                phieu.GhiChu = GhiChu;
                foreach(var item in listsp)
                {
                    var NS_DP_XuatNhapKho_ChiTiet_item = db.NS_DP_XuatNhapKho_ChiTiet.Where(x => x.XuatNhapKho == XuatNhapKho && x.ID == item.ID).SingleOrDefault();
                    NS_DP_XuatNhapKho_ChiTiet_item.GhiChu=item.GhiChu;
                }
                db.SaveChanges();
                return Json(new { success = true, XuatNhapKho, phieu.IDPhieu });
            }
            catch(Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_XoaSanPham(int XuatNhapKho, List<XuatKho_XoaSanPham> listXoa)
        {
            try
            {
                return Json(new { success = true,});
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_GetChiTietCapPhat(int XuatNhapKho)
        {
            try
            {
                var item = db.XuatKho_GetDanhSachCapPhatNhanSu(XuatNhapKho);
                return Json(new { success = true, item });
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
        public JsonResult XuatKho_DoiTraCapPhat(int XuatNhapKho, List<XuatKho_GetDanhSachCapPhatNhanSu_Result> listsp)
        {
            try
            {
                var xnk = db.NS_DP_XuatNhapKho.Where(x => x.XuatNhapKho == XuatNhapKho).SingleOrDefault();
                foreach (var item in listsp)
                {
                    var xk_ct_ns = db.NS_DP_XuatKho_ChiTiet_NhanSu.Where(x=>x.ID == item.ID).SingleOrDefault();
                    xk_ct_ns.Size = item.Size;
                    xk_ct_ns.NguoiDoiTra = 17;
                    xk_ct_ns.NgayDoiTra = DateTime.Now;
                    var xk_ct = db.NS_DP_XuatNhapKho_ChiTiet.Where(x=>x.XuatNhapKho == XuatNhapKho
                    && x.SanPham == item.SanPham 
                    && x.NhaCungCap == item.NhaCungCap
                    && x.TinhChatDongPhuc == item.TinhChatDongPhuc
                    ).SingleOrDefault();
                    xk_ct.Size = item.Size;
                    var phieuCaNhan = db.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Where(x=>x.PhieuDeNghi_CaNhan == xnk.IDPhieu 
                    && x.SanPham == item.SanPham && x.TinhChatDongPhuc == item.TinhChatDongPhuc
                    && x.NhanSu == item.NhanSu).SingleOrDefault();
                    phieuCaNhan.Size = item.Size;
                    // phieu bo phan
                    var phieuBP_CT = db.NS_DP_PhieuDeNghi_ChiTiet.
                        Where(x=>x.PhieuDeNghi == phieuCaNhan.PhieuDeNghi_CaNhan && x.SanPham == item.SanPham && x.TinhChatDongPhuc == item.TinhChatDongPhuc).SingleOrDefault();
                    phieuBP_CT.Size = item.Size;    
                }
                db.SaveChanges();   
                return Json(new { success = true, XuatNhapKho , xnk.IDPhieu});
            }
            catch (Exception e)
            {
                return Json(new { success = false, err = e });
            }
        }
    }

}