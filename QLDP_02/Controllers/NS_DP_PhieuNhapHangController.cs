using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class NS_DP_PhieuNhapHangController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();

        // GET: NS_DP_PhieuNhapHang
        public ActionResult Index()
        {
            // Modal Thêm Phiếu nhập hàng
            ViewBag.KhoNhan = new SelectList(db.DM_DP_Kho, "Kho", "TenKho");
            ViewBag.NhaCungCap = new SelectList(db.DM_DP_NhaCungCap, "NhaCungCap", "TenNhaCungCap");

            // Modal Thêm Phiếu nhập hàng chi tiết
            ViewBag.TenSanPham = new SelectList(db.NS_DP_SanPham, "SanPham", "TenSanPham");
            ViewBag.TinhChatDongPhuc = new SelectList(db.DM_DP_TinhChatDongPhuc, "TinhChatDongPhuc", "TenTinhChatDongPhuc");
            ViewBag.Size = new SelectList(db.DM_DP_Size, "Size", "MaSize");
            ViewBag.DonViTinh = new SelectList(db.DM_DP_DonViTinh, "DonViTinh", "TenDonViTinh");

            return View(db.getPhieuNhapHang()
                .Where(p => p.IsDel == false)
                .GroupBy(p => p.PhieuNhapHang)
                .Select(g => g.First())
                .OrderByDescending(p => p.PhieuNhapHang)
                .ToList());
        }

        // GET: NS_DP_PhieuNhapHang/GetThemMoiPhieuNhapHang/
        public ActionResult GetThemMoiPhieuNhapHang()
        {
            try
            {
                int IdPhieuNhapHangCuoi = db.NS_DP_PhieuNhapHang
                            .OrderByDescending(item => item.PhieuNhapHang)
                            .Select(item => item.PhieuNhapHang)
                            .FirstOrDefault();

                int IdPhieuNhapHangThemMoi = IdPhieuNhapHangCuoi + 1;

                if (IdPhieuNhapHangThemMoi != 0)
                {
                    var listPNHChiTiet = db.getPhieuNhapHang()
                                                .Where(p => p.PhieuNhapHang == IdPhieuNhapHangThemMoi)
                                                .OrderBy(item => item.PhieuNhapHang)
                                                .ToList();

                    ViewBag.ListPNHChiTiet = listPNHChiTiet;
                    return Json(listPNHChiTiet, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận xóa không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }

        // POST: NS_DP_PhieuNhapHang/SuaPhieuNhapHang/
        public ActionResult SuaPhieuNhapHang(int PhieuNhapHang)
        {
            try
            {
                var checkPhieuNhapHang = db.NS_DP_PhieuNhapHang.FirstOrDefault(p => p.PhieuNhapHang == PhieuNhapHang);
                
                if (checkPhieuNhapHang != null)
                {
                    int IdPhieuNhapHang = checkPhieuNhapHang.PhieuNhapHang;

                    var listPNHChiTiet = db.getPhieuNhapHang()
                                                .Where(p => p.PhieuNhapHang == IdPhieuNhapHang)
                                                .OrderBy(item => item.PhieuNhapHang)
                                                .ToList();

                    ViewBag.ListPNHChiTiet = listPNHChiTiet;
                    return Json(listPNHChiTiet, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận xóa không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }

        // POST: NS_DP_PhieuNhapHang/GetIdPhieuNhapHang/
        [HttpPost]
        public ActionResult GetIdPhieuNhapHang(int PhieuNhapHang)
        {
            try
            {
                NS_DP_PhieuNhapHang s = db.NS_DP_PhieuNhapHang.First(sp => sp.PhieuNhapHang == PhieuNhapHang);

                if (s != null)
                {
                    return Json(s, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận xoá không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }

        [HttpPost]
        public ActionResult GetIdPhieuNhapHangChiTiet(int PhieuNhapHangChiTiet)
        {
            try
            {
                NS_DP_PhieuNhapHang_ChiTiet c = db.NS_DP_PhieuNhapHang_ChiTiet.FirstOrDefault(ct => ct.ID == PhieuNhapHangChiTiet);

                if (c != null)
                {
                    return Json(c, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận xoá không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }

        [HttpPost]
        public ActionResult GetNamePhieuNhapHangChiTiet(int PhieuNhapHangChiTiet)
        {
            try
            {
                getPhieuNhapHang_Result c = db.getPhieuNhapHang().FirstOrDefault(ct => ct.ID == PhieuNhapHangChiTiet);

                if (c != null)
                {
                    return Json(c, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận xoá không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }

        // POST: NS_DP_PhieuNhapHang/CreateChiTiet
        [HttpPost]
        public ActionResult CreateChiTiet(string SanPham, string TinhChat, string Size, int SoLuong, int DonGia, string DonViTinh, string GhiChu)
        {
            try
            {
                // TODO: Add insert logic here
                NS_DP_PhieuNhapHang_ChiTiet n = new NS_DP_PhieuNhapHang_ChiTiet();

                int IdPhieuNhapHangCuoi = db.NS_DP_PhieuNhapHang
                            .OrderByDescending(item => item.PhieuNhapHang)
                            .Select(item => item.PhieuNhapHang)
                            .FirstOrDefault();
                n.PhieuNhapHang = IdPhieuNhapHangCuoi + 1;

                n.SanPham = int.Parse(SanPham);

                if (TinhChat == "")
                    n.TinhChatDongPhuc = null;
                else
                    n.TinhChatDongPhuc = int.Parse(TinhChat);

                if (Size == "")
                    n.Size = null;
                else
                    n.Size = int.Parse(Size);

                n.SoLuong = SoLuong;
                n.DonGia = DonGia;
                n.DonViTinh = int.Parse(DonViTinh);
                n.GhiChu = GhiChu;

                n.ThanhTien = SoLuong * DonGia;
                n.SoLuongDaNhap = 0;

                db.NS_DP_PhieuNhapHang_ChiTiet.Add(n);
                db.SaveChanges();

                return Json(new { success = true });
            }
            catch
            {
                return View();
            }
        }

        // POST: NS_DP_PhieuNhapHang/ThemMoiSuaChiTiet
        [HttpPost]
        public ActionResult ThemMoiSuaChiTiet(int PhieuNhapHang, string SanPham, string TinhChat, string Size, int SoLuong, int DonGia, string DonViTinh, string GhiChu)
        {
            try
            {
                // TODO: Add insert logic here
                NS_DP_PhieuNhapHang_ChiTiet n = new NS_DP_PhieuNhapHang_ChiTiet();

                n.PhieuNhapHang = PhieuNhapHang;
                n.SanPham = int.Parse(SanPham);

                if (TinhChat == "")
                    n.TinhChatDongPhuc = null;
                else
                    n.TinhChatDongPhuc = int.Parse(TinhChat);

                if (Size == "")
                    n.Size = null;
                else
                    n.Size = int.Parse(Size);

                n.SoLuong = SoLuong;
                n.DonGia = DonGia;
                n.DonViTinh = int.Parse(DonViTinh);
                n.GhiChu = GhiChu;

                n.ThanhTien = SoLuong * DonGia;
                n.SoLuongDaNhap = 0;

                db.NS_DP_PhieuNhapHang_ChiTiet.Add(n);
                db.SaveChanges();

                return Json(new { success = true });
            }
            catch
            {
                return View();
            }
        }

        // POST: NS_DP_PhieuNhapHang/EditChiTiet
        [HttpPost]
        public ActionResult EditChiTiet(int ID, string SanPham, string TinhChat, string Size, int SoLuong, int DonGia, string DonViTinh, string GhiChu)
        {
            try
            {
                NS_DP_PhieuNhapHang_ChiTiet c = db.NS_DP_PhieuNhapHang_ChiTiet.First(ct => ct.ID == ID);

                if (c != null)
                {
                    c.SanPham = int.Parse(SanPham);

                    if (TinhChat == "")
                        c.TinhChatDongPhuc = null;
                    else
                        c.TinhChatDongPhuc = int.Parse(TinhChat);

                    if (Size == "")
                        c.Size = null;
                    else
                        c.Size = int.Parse(Size);

                    c.SoLuong = SoLuong;
                    c.DonGia = DonGia;
                    c.DonViTinh = int.Parse(DonViTinh);
                    c.ThanhTien = SoLuong * DonGia;
                    c.GhiChu = GhiChu;

                    db.SaveChanges();

                    var listPNHChiTiet = db.getPhieuNhapHang()
                                                    .Where(p => p.PhieuNhapHang == c.PhieuNhapHang)
                                                    .OrderBy(item => item.PhieuNhapHang)
                                                    .ToList();

                    ViewBag.ListPNHChiTiet = listPNHChiTiet;
                    return Json(listPNHChiTiet, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận sửa không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }

        [HttpPost]
        public ActionResult DeleteChiTiet(int ID)
        {
            try
            {
                NS_DP_PhieuNhapHang_ChiTiet c = db.NS_DP_PhieuNhapHang_ChiTiet.First(ct => ct.ID == ID);

                if (c != null)
                {
                    int PhieuNhapHang = db.NS_DP_PhieuNhapHang
                                                .Where(p => p.PhieuNhapHang == c.PhieuNhapHang)
                                                .Select(p => p.PhieuNhapHang)
                                                .FirstOrDefault();

                    db.NS_DP_PhieuNhapHang_ChiTiet.Remove(c);

                    db.SaveChanges();

                    var listPNHChiTiet = db.getPhieuNhapHang()
                                                    .Where(p => p.PhieuNhapHang == PhieuNhapHang)
                                                    .OrderBy(item => item.PhieuNhapHang)
                                                    .ToList();

                    ViewBag.ListPNHChiTiet = listPNHChiTiet;

                    return Json(listPNHChiTiet, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận xóa không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }



















        // GET: NS_DP_PhieuNhapHang/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: NS_DP_PhieuNhapHang/Create
        //public ActionResult Create()
        //{
        //    int IdPhieuNhapHang = db.NS_DP_PhieuNhapHang
        //                    .OrderByDescending(item => item.PhieuNhapHang)
        //                    .Select(item => item.PhieuNhapHang)
        //                    .FirstOrDefault();

        //    if (IdPhieuNhapHang != 0)
        //    {
        //        return Json(new { success = true });
        //    }
        //    else
        //    {
        //        return Json(new { success = false, message = "Xác nhận thêm không thành công." });
        //    }
        //}

        // POST: NS_DP_PhieuNhapHang/Create
        [HttpPost]
        public ActionResult Create(string MaPhieuNhapHang, string TenPhieuNhapHang, DateTime NgayDatHang, string NhaCungCap, string KhoNhan, string GhiChu)
        {
            try
            {
                // TODO: Add insert logic here
                NS_DP_PhieuNhapHang ck_pnh = db.NS_DP_PhieuNhapHang.FirstOrDefault(c => c.MaPhieuNhapHang.Equals(MaPhieuNhapHang));
                
                

                if (ck_pnh == null)
                {
                    NS_DP_PhieuNhapHang p = new NS_DP_PhieuNhapHang();

                    p.MaPhieuNhapHang = MaPhieuNhapHang;
                    p.TenPhieuNhapHang = TenPhieuNhapHang;
                    p.NgayDatHang = NgayDatHang;
                    p.KhoNhan = int.Parse(KhoNhan);
                    p.NhaCungCap = int.Parse(NhaCungCap);
                    p.GhiChu = GhiChu;

                    p.NguoiDatHang = 2;
                    p.NguoiTao = 2;
                    p.NgayTao = DateTime.Now;
                    p.IsDel = false;

                    db.NS_DP_PhieuNhapHang.Add(p);
                    db.SaveChanges();

                    return Json(new { success = true, PhieuNhapHang = p.PhieuNhapHang });
                }
                else
                    return Json(new { success = false, message = "Xác nhận thêm không thành công." });

            }
            catch
            {
                return Json(new { success = false, message = "Xác nhận thêm không thành công." });
            }
        }

        // GET: NS_DP_PhieuNhapHang/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: NS_DP_PhieuNhapHang/Edit/5
        [HttpPost]
        public ActionResult Edit(int PhieuNhapHang, string MaPhieuNhapHang, string TenPhieuNhapHang, DateTime NgayDatHang, string NhaCungCap, string KhoNhan, string GhiChu)
        {
            try
            {
                // TODO: Add update logic here
                NS_DP_PhieuNhapHang p = db.NS_DP_PhieuNhapHang.First(pnh => pnh.PhieuNhapHang == PhieuNhapHang);

                if (p != null)
                {
                    if (MaPhieuNhapHang == "" || TenPhieuNhapHang == "")
                        return Json(new { success = false, message = "Xác nhận sửa không thành công." });

                    p.MaPhieuNhapHang = MaPhieuNhapHang;
                    p.TenPhieuNhapHang = TenPhieuNhapHang;
                    p.NgayDatHang = NgayDatHang;
                    p.KhoNhan = int.Parse(KhoNhan);
                    p.NhaCungCap = int.Parse(NhaCungCap);
                    p.GhiChu = GhiChu;
                    p.NguoiDatHang = 1;
                    p.NguoiSua = 1;
                    p.NgaySua = DateTime.Now;
                    p.IsDel = false;                   

                    db.SaveChanges();
                    return Json(new { success = true });
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận sửa không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }

        // POST: NS_DP_PhieuNhapHang/Delete/5
        [HttpPost]
        public ActionResult Delete(int PhieuNhapHang)
        {
            try
            {
                // TODO: Add delete logic here
                NS_DP_PhieuNhapHang p = db.NS_DP_PhieuNhapHang.First(pnh => pnh.PhieuNhapHang == PhieuNhapHang);

                if (p != null)
                {
                    p.IsDel = true;
                    p.NguoiXoa = 3;
                    p.NgayXoa =DateTime.Now;

                    db.SaveChanges();
                    return Json(new { success = true });
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận xóa không thành công." });
                }
            }
            catch
            {
                return View();
            }
        }
    }
}
