using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class DM_DP_SizeController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();

        // GET: DM_DP_Size
        public ActionResult Index()
        {
            ViewBag.LoaiSanPham = new SelectList(db.DM_DP_LoaiSanPham, "LoaiSanPham", "TenLoaiSanPham");

            return View(db.getSize()
                            .Where(sp => sp.IsDel == false)
                            .OrderBy(m => m.LoaiSanPham)
                            .ThenBy(s => s.STTSize)
                            .GroupBy(l => l.LoaiSanPham)
                            .SelectMany(group => group)
                            .ToList());
        }

        [HttpPost]
        public ActionResult Index(int Size)
        {
            try
            {
                getSize_Result s = db.getSize().First(sz => sz.Size == Size);

                if (s != null)
                {
                    return Json(s, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { success = false, message = "Xác nhận sửa không thành công." });
                }
            }
            catch
            {
                return Json(new { success = false, message = "Xác nhận sửa không thành công." });
            }
        }

        // POST: DM_DP_Size/Create
        [HttpPost]
        public ActionResult Create(string MaSize, string LoaiSanPham)
        {
            try
            {
                // TODO: Add insert logic here
                if (MaSize == "")
                    return Json(new { success = false, message = "Xác nhận thêm không thành công." });


				DM_DP_Size s = new DM_DP_Size();
				if (s != null)
                {

                    s.MaSize = MaSize;
                    s.LoaiSanPham = int.Parse(LoaiSanPham);
                    
                    s.NguoiTao = 1;
                    s.NgayTao = DateTime.Now;
                    s.IsDel = false;

                    db.DM_DP_Size.Add(s);
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
                return Json(new { success = false, message = "Xác nhận sửa không thành công." });
            }
        }

        // POST: DM_DP_Size/Edit/5
        [HttpPost]
        public ActionResult Edit(int Size, string MaSize, string LoaiSanPham)
        {
            try
            {
                // TODO: Add update logic here
                DM_DP_Size s = db.DM_DP_Size.First(sz => sz.Size == Size);

                if (s != null)
                {
                    if (MaSize == "")
                        return Json(new { success = false, message = "Xác nhận sửa không thành công." });

                    s.MaSize = MaSize;
                    s.LoaiSanPham = int.Parse(LoaiSanPham);
                    
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
                return Json(new { success = false, message = "Xác nhận sửa không thành công." });
            }
        }

        // POST: DM_DP_Size/Delete/5
        [HttpPost]
        public ActionResult Delete(int Size)
        {
            try
            {
                // TODO: Add delete logic here
                DM_DP_Size s = db.DM_DP_Size.First(sz => sz.Size == Size);

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
                return Json(new { success = false, message = "Xác nhận xóa không thành công." });
            }
        }
    }
}
