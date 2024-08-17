using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class BC_TonKhoController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();
        // GET: BC_TonKho
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult getBaoCaoTK(string thang, string nam, int ncc)
        {
            try
            {
                var item = db.GetBaoCaoTonKho(thang, nam, ncc);
                return Json(new { success = true,item });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
    }
}