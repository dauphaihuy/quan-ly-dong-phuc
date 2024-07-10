using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class NS_DP_PhieuNhapHang_ChiTietController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();

        // GET: NS_DP_PhieuNhapHang_ChiTiet
        public ActionResult Index()
        {
            return View();
        }

        // POST: NS_DP_PhieuNhapHang_ChiTiet/GetIdPhieuNhapHangChiTiet/5
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

        // GET: NS_DP_PhieuNhapHang_ChiTiet/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: NS_DP_PhieuNhapHang_ChiTiet/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: NS_DP_PhieuNhapHang_ChiTiet/Create
        [HttpPost]
        public ActionResult Create(string SanPham, string TinhChat, string Size, int SoLuong, int DonGia, string DonViTinh, string GhiChu)
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

        // GET: NS_DP_PhieuNhapHang_ChiTiet/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: NS_DP_PhieuNhapHang_ChiTiet/Edit/5
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

        // GET: NS_DP_PhieuNhapHang_ChiTiet/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: NS_DP_PhieuNhapHang_ChiTiet/Delete/5
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
