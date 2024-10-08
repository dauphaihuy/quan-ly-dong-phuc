﻿using Microsoft.Ajax.Utilities;
using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;

namespace QLDP_02.Controllers
{
    public class NS_DP_PhieuNhapHangController : Controller
    {
        public class Product
        {
           public int soLuong { get; set; }
           public int donGia { get; set; }
           public int SanPham { get; set; }
           public int Size { get; set; }
           public int TinhChat { get; set; }
           public int NhaCungCap { get; set; }
           public int DonViTinh { get; set; }

        }
        public class DeleteProduct
        {
            public int ID { get; set; }
        }
        public class DeletePhieu
        {
            public int PhieuNhapHang { get; set; }

        }
        private DB_QLDPEntities db = new DB_QLDPEntities();
        public static string GenerateRandomString(int length)
        {
            string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            StringBuilder sb = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < length; i++)
            {
                sb.Append(chars[random.Next(chars.Length)]);
            }
            return "PN_"+sb.ToString();
        }
        public JsonResult DeletePhieuNhap(List<DeletePhieu> listPhieu)
        {
            try
            {
                foreach (var item in listPhieu)
                {
                    var phieu = db.NS_DP_PhieuNhapHang.Where(pr => pr.PhieuNhapHang == item.PhieuNhapHang).FirstOrDefault();
                    if (phieu.IsHoanThanh == true)
                    {
                        return Json(new { success = false });
                    }
                    phieu.IsDel = true;
                }
                db.SaveChanges();
                return Json(new { success = true, listPhieu });
            }catch(Exception e)
            {
                return Json(new { message = e });
            }
        }
        public JsonResult ChonSpPhieuNhap(List<Product> SelectedRows,string MaPhieuNhap,string TenPhieuNhap,string GhiChu,int KhoNhan)
        {
            try
            {
                if (MaPhieuNhap == "")
                {
                    if (TenPhieuNhap == "" || TenPhieuNhap == null)
                    {
                        return Json(new { success = false, message = "Tên phiếu không được để trống" });
                    }
                    if (SelectedRows.Count == 0)
                    {
                        return Json(new { error = false, message = "Chưa chọn sản phẩm" });
                    }
                    string MaPhieuNhapMoi = GenerateRandomString(6);

                    NS_DP_PhieuNhapHang p = new NS_DP_PhieuNhapHang
                    {
                        MaPhieuNhapHang = MaPhieuNhapMoi,
                        TenPhieuNhapHang = TenPhieuNhap,
                        NgayDatHang = DateTime.Now,
                        KhoNhan = KhoNhan,
                        NhaCungCap = SelectedRows[0].NhaCungCap,
                        GhiChu = GhiChu,
                        NguoiDatHang = 1,
                        NguoiTao = 1,
                        NgayTao = DateTime.Now,
                        IsDel = false,
                        IsHoanThanh = false,
                        TongSLDaNhap = 0
                    };
                    db.NS_DP_PhieuNhapHang.Add(p);
                    db.SaveChanges();
                    var PhieuNhap = db.NS_DP_PhieuNhapHang.Where(pr => pr.MaPhieuNhapHang == MaPhieuNhapMoi).Select(pr => pr.PhieuNhapHang).FirstOrDefault();
                    var maPhieu = db.NS_DP_PhieuNhapHang.Where(pr => pr.MaPhieuNhapHang == MaPhieuNhapMoi).Select(pr => pr.PhieuNhapHang).FirstOrDefault();
                    int tongSLMua = 0;
                    int tongThanhToan = 0;
                    foreach (var item in SelectedRows)
                    {
                        tongSLMua += item.soLuong;
                        tongThanhToan += item.soLuong * item.donGia;
                        NS_DP_PhieuNhapHang_ChiTiet c = new NS_DP_PhieuNhapHang_ChiTiet
                        {
                            PhieuNhapHang = PhieuNhap,
                            SanPham = item.SanPham,
                            Size = item.Size,
                            TinhChatDongPhuc = item.TinhChat,
                            SoLuong = item.soLuong,
                            DonGia = item.donGia,
                            DonViTinh = item.DonViTinh,
                            ThanhTien = item.soLuong * item.donGia,
                            SoLuongDaNhap = 0,
                            GhiChu = GhiChu
                        };
                        db.NS_DP_PhieuNhapHang_ChiTiet.Add(c);
                        db.SaveChanges();
                    }
                    p.TongSLMua = tongSLMua;
                    p.TongThanhToan = tongThanhToan;
                    db.SaveChanges();
                    return Json(new { success = true, selectedProduct = SelectedRows, PhieuNhap = maPhieu, TenPhieu = TenPhieuNhap, GhiChu, KhoNhan,item=p, PhieuNhapHang = p, MaPhieuNhap = p.MaPhieuNhapHang });
                }
                else
                {
                    bool isProductExists = false;
                    var item = db.NS_DP_PhieuNhapHang.Where(x => x.MaPhieuNhapHang == MaPhieuNhap).SingleOrDefault();
                    var dssp = db.NS_DP_PhieuNhapHang_ChiTiet.Where(x => x.PhieuNhapHang == item.PhieuNhapHang);
                    foreach (var sp in SelectedRows)
                    {
                        isProductExists = false;
                        foreach (var spTonTai in dssp)
                        {
                            if (sp.SanPham == spTonTai.SanPham && sp.Size == spTonTai.Size)
                            {
                                spTonTai.SoLuong = spTonTai.SoLuong + sp.soLuong;
                                item.TongSLMua = item.TongSLMua + sp.soLuong;
                                isProductExists = true;
                                break;
                            }
                        }
                        if (!isProductExists)
                        {
                            NS_DP_PhieuNhapHang_ChiTiet c = new NS_DP_PhieuNhapHang_ChiTiet
                            {
                                PhieuNhapHang = item.PhieuNhapHang,
                                SanPham = sp.SanPham,
                                Size = sp.Size,
                                TinhChatDongPhuc = sp.TinhChat,
                                SoLuong = sp.soLuong,
                                DonGia = sp.donGia,
                                DonViTinh = sp.DonViTinh,
                                ThanhTien = sp.soLuong * sp.donGia,
                                SoLuongDaNhap = 0,
                                GhiChu = GhiChu
                            };
                            item.TongSLMua = item.TongSLMua + sp.soLuong;
                            db.NS_DP_PhieuNhapHang_ChiTiet.Add(c);
                        }
                    }
                    db.SaveChanges();
                    return Json(new { success = true, item , dssp });
                }
            }
            catch (Exception ex)
            {
                return Json(new { message = ex });
            }
        }
        public JsonResult PhieuNhap_XoaSanPham(int PhieuNhapHang, List<DeleteProduct> danhSachXoa)
        {
            try
            {
                var phieuNhapHang = db.NS_DP_PhieuNhapHang.Where(x => x.PhieuNhapHang == PhieuNhapHang).SingleOrDefault();
                foreach (var item in danhSachXoa)
                {
                    var sp = db.NS_DP_PhieuNhapHang_ChiTiet.Where(x => x.ID == item.ID && x.PhieuNhapHang==PhieuNhapHang).SingleOrDefault();
                    phieuNhapHang.TongSLMua = phieuNhapHang.TongSLMua-sp.SoLuong;
                    db.NS_DP_PhieuNhapHang_ChiTiet.Remove(sp);
                }
                db.SaveChanges();
                return Json(new { success = true, danhSachXoa });
            }
            catch (Exception ex)
            {
                return Json(new { message = ex });
            }
        }
        public JsonResult PhieuNhap_GetSanPhamByPhieuNhap(int MaPhieu)
        {
            try
            {
                if (MaPhieu == 0)
                {
                    return Json(new { success = false });
                }
                else
                {
                    var item = db.PhieuNhap_GetSanhSachSanPham().Where(sp=>sp.PhieuNhapHang == MaPhieu);
                    return Json(new { success = true, item });
                }
            }
            catch (Exception ex)
            {
                return Json(new { message = ex });
            }
        }
        // đây
        public JsonResult renderTableDonMuaHang()
        {
            try
            {
                var item = db.NhapHang_getAllDonMuaHang();
                return Json(new { success = true, item });
            }
            catch (Exception ex)
            {
                return Json(new { message = ex });
            }
        }
        public JsonResult SelectDonMuaHang(int DonMuaHang)
        {
            try
            {
                var item = db.NhapHang_getDonHangByMaPhieu(DonMuaHang).SingleOrDefault();
                var dsSanPham = db.NhapHang_SanPhamByMaPhieu(DonMuaHang);
                return Json(new { success = true, item, dsSanPham });
            }
            catch (Exception ex)
            {
                return Json(new { message = ex });
            }
        }
        // GET: NS_DP_PhieuNhapHang
        public ActionResult Index()
        {
            var nhacc = db.DM_DP_NhaCungCap.Where(ncc => ncc.IsDel != true);

            ViewBag.KhoNhan = new SelectList(db.DM_DP_Kho, "Kho", "TenKho");
            ViewBag.NhaCungCap = new SelectList(nhacc, "NhaCungCap", "TenNhaCungCap");
                
            // Modal Thêm Phiếu nhập hàng chi tiết
            ViewBag.TenSanPham = new SelectList(db.NS_DP_SanPham, "SanPham", "TenSanPham");
            ViewBag.TinhChatDongPhuc = new SelectList(db.DM_DP_TinhChatDongPhuc, "TinhChatDongPhuc", "TenTinhChatDongPhuc");
            ViewBag.Size = new SelectList(db.DM_DP_Size, "Size", "MaSize");
            ViewBag.DonViTinh = new SelectList(db.DM_DP_DonViTinh, "DonViTinh", "TenDonViTinh");

            return View();
        }
        //thêm mới
        public JsonResult NhapHang_GetDanhSachSanPhamChuaChon(int NhaCungCap)
        {
            try
            {
                if (NhaCungCap == 0)
                {
                    return Json(new { success = false});
                }
                else
                {
                    var item = db.getSanPhamByNhaCungCap(NhaCungCap);
                    return Json(new { success = true, item = item });
                }
            }
            catch (Exception ex)
            {
                return Json(new { message = ex });
            }
        }
        //cập nhật sản phẩm
        public JsonResult NhapHang_GetDanhSachSanPhamDaChon(int PhieuNhapHang)
        {
            try
            {
                return Json(new { success=true, PhieuNhapHang });
            }
            catch(Exception ex)
            {
                return Json(new { message=ex});
            }
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
