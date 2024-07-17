using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class NS_DP_XuatNhapKhoController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();

        // GET: NS_DP_XuatNhapKho
        public ActionResult Index()
        {
            return View();

        }
        public ActionResult GetDataTable() { 
            var danhSachNhapKho = db.getXuatNhapKho().ToList();
            return Json(new { data = danhSachNhapKho },JsonRequestBehavior.AllowGet);
        
        }
        //
        public JsonResult NhapKho_GetDanhSachSanPhamNhapHang(int phieuNhapHang)
        {
            return Json(new { success=true });
        }
        // GET: NS_DP_XuatNhapKho/NhapKho
        public ActionResult NhapKho()
        {
            var phieuNhapHangSelect = db.NS_DP_PhieuNhapHang.Where(h=>h.IsDel!=true).ToList();

            ViewBag.PhieuNhapHang = new SelectList(phieuNhapHangSelect, "PhieuNhapHang", "MaPhieuNhapHang");
            ViewBag.Kho = new SelectList(db.DM_DP_Kho, "Kho", "TenKho");
            ViewBag.NhanSu = new SelectList(db.NS_NhanSu, "NhanSu", "TenNhanSu");
            ViewBag.NhaCungCap = new SelectList(db.DM_DP_NhaCungCap, "NhaCungCap", "TenNhaCungCap");

            return View(db.getXuatNhapKho().Where(sp => sp.IsDel == false).ToList());
        }

        // GET: NS_DP_XuatNhapKho/NhapKho
        public ActionResult XuatKho()
        {
            ViewBag.PhieuNhapHang = new SelectList(db.NS_DP_PhieuNhapHang, "PhieuNhapHang", "MaPhieuNhapHang");
            ViewBag.Kho = new SelectList(db.DM_DP_Kho, "Kho", "TenKho");
            ViewBag.NhanSu = new SelectList(db.NS_NhanSu, "NhanSu", "TenNhanSu");

            //ViewBag.NhaCungCap = new SelectList(db.DM_DP_NhaCungCap, "NhaCungCap", "TenNhaCungCap");
            ViewBag.LoaiSanPham = new SelectList(db.DM_DP_LoaiSanPham, "LoaiSanPham", "TenLoaiSanPham");    
            ViewBag.DonViTinh = new SelectList(db.DM_DP_DonViTinh, "DonViTinh", "TenDonViTinh");
            ViewBag.GioiTinh = new SelectList(db.NS_DP_GioiTinh, "GioiTinh", "TenGioiTinh");
            ViewBag.SanPhamLienKet = new SelectList(db.NS_DP_SanPham, "SanPhamLienKet", "SanPhamLienKet");
            return View(db.getXuatNhapKho().Where(sp => sp.IsDel == false).ToList());
        }

        // GET: NS_DP_XuatNhapKho/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: NS_DP_XuatNhapKho/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: NS_DP_XuatNhapKho/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: NS_DP_XuatNhapKho/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: NS_DP_XuatNhapKho/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: NS_DP_XuatNhapKho/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: NS_DP_XuatNhapKho/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
