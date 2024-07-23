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

        public JsonResult NhapKho_GetDanhSachSanPhamNhapHang(int phieuNhapHang)
        {
            return Json(new { success=true });
        }
        // GET: NS_DP_XuatNhapKho/NhapKho
        public ActionResult NhapKho()
        {
            var SelectPhieuNhap = db.NhapKho_SelectPhieuNhapHang().Where(phieu => phieu.IsDel != true);
            var SelectKhoNhan = db.DM_DP_Kho;
            ViewBag.SelectPhieuNhap = new SelectList(SelectPhieuNhap, "PhieuNhapHang", "TenVaMaPhieu");
            ViewBag.SelectKhoNhan = new SelectList(SelectKhoNhan, "Kho", "TenKho");
            return View();
        }
        public JsonResult NhapKho_ChonPhieuNhapHan(int PhieuNhap)
        {
            try
            {
                //var result = db.().Where(phieu => phieu.PhieuNhapHang == PhieuNhap);
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, err = ex.Message });
            }
        }
    }
}
