using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class NS_DP_SanPhamController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();

        // GET: NS_DP_SanPham
        public ActionResult Index()
        {
            ViewBag.LoaiSanPham = new SelectList(db.DM_DP_LoaiSanPham, "LoaiSanPham", "TenLoaiSanPham");
            ViewBag.DonViTinh = new SelectList(db.DM_DP_DonViTinh, "DonViTinh", "TenDonViTinh");
            ViewBag.GioiTinh = new SelectList(db.NS_DP_GioiTinh, "GioiTinh", "TenGioiTinh");
            ViewBag.SanPhamLienKet = new SelectList(db.NS_DP_SanPham, "SanPham", "TenSanPham");

            //ViewBag.SanPham = db.NS_DP_SanPham.FirstOrDefault(s => s.SanPham.Equals(id)).TenSanPham.ToString();

            return View(db.getDanhSachSanPham().Where(sp => sp.IsDel == false).ToList());
        }

        [HttpPost]
        public ActionResult Index(int SanPham)
        {
            try
            {
                getDanhSachSanPham_Result s1 = db.getDanhSachSanPham().First(sp => sp.SanPham == SanPham);

                if (s1 != null)
                {
                    return Json(s1, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận sửa không thành công." });
                }
                //ViewBag.SanPham = db.NS_DP_SanPham.FirstOrDefault(s => s.SanPham.Equals(id)).TenSanPham.ToString();
            }
            catch
            {
                return View();
            }
        }

        // POST: NS_DP_SanPham/GetNameProduct/5
        //public ActionResult GetNameProduct(int SanPham)
        //{
        //    try
        //    {
        //        NS_DP_SanPham s = db.NS_DP_SanPham.First(sp => sp.SanPham == SanPham);

        //        if (s != null)
        //        {
        //            return Json(s, JsonRequestBehavior.AllowGet);
        //        }
        //        else
        //        {
        //            return Json(new { success = false, message = "Xác nhận xoá không thành công." });
        //        }
        //    }
        //    catch
        //    {
        //        return View();
        //    }
        //}

        // GET: NS_DP_SanPham/Create
        public ActionResult Create()
        {   
            return View();
        }

        // POST: NS_DP_SanPham/Create
        [HttpPost]
        public ActionResult Create(string TenSanPham, string LoaiSanPham, string DonViTinh, string SanPhamLienKet, string GioiTinh, string QuyCachDoi)
        {
            try
            {
                // TODO: Add insert logic here
                if (TenSanPham == "")
                    return Json(new { success = false, message = "Xác nhận sửa không thành công." });

                NS_DP_SanPham s = new NS_DP_SanPham();

                if (s != null)
                {
                    s.TenSanPham = TenSanPham;
                    s.LoaiSanPham = int.Parse(LoaiSanPham);
                    s.DonViTinh = int.Parse(DonViTinh);

                    if (SanPhamLienKet != "")
                        s.SanPhamLienKet = int.Parse(SanPhamLienKet);
                    else
                        s.SanPhamLienKet = null;

                    if (GioiTinh != "")
                        s.GioiTinh = int.Parse(GioiTinh);
                    else
                        s.GioiTinh = null;

                    s.QuyCachDoi = QuyCachDoi;
                    s.NguoiTao = 1;
                    s.NgayTao = DateTime.Now;
                    s.IsDel = false;

                    db.NS_DP_SanPham.Add(s);
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

        // GET: NS_DP_SanPham/Edit/5
        //public ActionResult Edit(int id)
        //{
        //    return View();
        //}

        // POST: NS_DP_SanPham/Edit/5
        [HttpPost]
        public ActionResult Edit(int SanPham, string TenSanPham, string LoaiSanPham, string DonViTinh, string SanPhamLienKet, string GioiTinh, string QuyCachDoi)
        {
            try
            {
                // TODO: Add update logic here
                NS_DP_SanPham s = db.NS_DP_SanPham.First(sp => sp.SanPham == SanPham);

                if (s != null)
                {
                    if (TenSanPham == "")
                        return Json(new { success = false, message = "Xác nhận sửa không thành công." });

                    s.TenSanPham = TenSanPham;
                    s.LoaiSanPham = int.Parse(LoaiSanPham);
                    s.DonViTinh = int.Parse(DonViTinh);

                    if (SanPhamLienKet != "")
                        s.SanPhamLienKet = int.Parse(SanPhamLienKet);
                    else
                        s.SanPhamLienKet = null;

                    if (GioiTinh != "")
                        s.GioiTinh = int.Parse(GioiTinh);
                    else
                        s.GioiTinh = null;

                    s.QuyCachDoi = QuyCachDoi;
                    s.NguoiSua = 2;
                    s.NgaySua = DateTime.Now;
                    s.IsDel = false;

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

        // POST: NS_DP_SanPham/Delete/5
        [HttpPost]
        public ActionResult Delete(int SanPham)
        {
            try
            {
                // TODO: Add delete logic here
                NS_DP_SanPham s = db.NS_DP_SanPham.First(sp => sp.SanPham == SanPham);

                if (s != null)
                {
                    s.IsDel = true;
                    s.NguoiXoa = 3;
                    s.NgayXoa = DateTime.Now;
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
