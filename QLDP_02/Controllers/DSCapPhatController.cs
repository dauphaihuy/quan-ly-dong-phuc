using QLDP_02.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLDP_02.Controllers
{
    public class DSCapPhatController : Controller
    {
        private DB_QLDPEntities db = new DB_QLDPEntities();
        // GET: DSCapPhat
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult BC_DSCapPhat()
        {
            try
            {
                var item = db.BC_DSCapPhat();
                return Json(new { success = false, item });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
    }
}