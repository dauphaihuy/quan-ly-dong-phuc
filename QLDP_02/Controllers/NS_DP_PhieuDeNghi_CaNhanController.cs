using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Management;
using System.Web.ModelBinding;
using System.Web.Mvc;
using QLDP_02.Models;

namespace QLDP_02.Controllers
{
    public class NS_DP_PhieuDeNghi_CaNhanController : Controller
    {
		private DB_QLDPEntities db = new DB_QLDPEntities();
		// GET: NS_DP_PhieuDeNghi_CaNhan
		public ActionResult Index()
        {
			
			ViewBag.LyDoCapPhat = new SelectList(db.DM_DP_LyDoCapPhat, "LyDoCapPhat", "TenLyDoCapPhat");
			ViewBag.NguoiDeNghi = new SelectList(db.NS_NhanSu,"NhanSu", "Ten");
			ViewBag.SanPham = new SelectList(db.NS_DP_SanPham, "SanPham", "TenSanPham");
            var sizes = db.DM_DP_Size
                 .Select(s => new { Size = s.Size, MaSize = s.MaSize })  // Select Size and MaSize
                 .Distinct()
                 .ToList();

            ViewData["Size"] = new SelectList(sizes, "Size", "MaSize");  // Create SelectList with MaSize as value and Size as text
            ViewBag.TinhChat = new SelectList(db.DM_DP_TinhChatDongPhuc, "TinhChatDongPhuc", "TenTinhChatDongPhuc");
			return View(db.getPhieuDeNghiCaNhan().Where(phieu => phieu.IsDel == false));
        }
        //random tạo mã phiếu
        public string GenerateRandomMaPhieuDeNghi_CaNhan(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            string randomString = new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
            return randomString;
        }
		[HttpPost]
		public ActionResult ChonSanPham(List<SelectedProduct> selectedRows,string idNguoiDeNghi,string lyDoCapPhat,string maPhieu,int PhieuDeNghi)
		{
			if(selectedRows.Count==0|| idNguoiDeNghi==""|| lyDoCapPhat == "")
			{
				return Json(new { success = false, err = "input = null" });
			}
			try {
				if (maPhieu == "")
				{
				NS_DP_PhieuDeNghi_CaNhan nS_DP_PhieuDeNghi_CaNhan = new NS_DP_PhieuDeNghi_CaNhan
					{
						MaPhieuDeNghi_CaNhan = GenerateRandomMaPhieuDeNghi_CaNhan(5),
						NguoiDeNghi = int.Parse(idNguoiDeNghi),
						NgayDeNghi = DateTime.Now,
						NguoiTao=1,
						NgayTao=DateTime.Now,
						LyDoCapPhat=int.Parse(lyDoCapPhat),
						IsHoanThanh=false,
						IsDel=false
					};
					db.NS_DP_PhieuDeNghi_CaNhan.Add(nS_DP_PhieuDeNghi_CaNhan);
					db.SaveChanges();
					foreach (var item in selectedRows)
					{
						NS_DP_PhieuDeNghi_CaNhan_ChiTiet nS_DP_PhieuDeNghi_CaNhan_ChiTiet = new NS_DP_PhieuDeNghi_CaNhan_ChiTiet
						{
							PhieuDeNghi_CaNhan = nS_DP_PhieuDeNghi_CaNhan.PhieuDeNghi_CaNhan,
							SanPham = item.SanPham,
							Size = int.Parse(item.Size),
							SoLuong = item.SoLuong,
							TinhChatDongPhuc = int.Parse(item.TinhChat),

						};
						db.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Add(nS_DP_PhieuDeNghi_CaNhan_ChiTiet);
						db.SaveChanges();
					}
					return Json(new {success=true});
				}
				else
				{
                    foreach (var item in selectedRows)
                    {
						db.themSanPhamConLaiNguoiDungChuChon(PhieuDeNghi,item.SanPham, int.Parse(item.Size), item.SoLuong, int.Parse(item.TinhChat));
					}
                    return Json(new { success = true,data= selectedRows });
                }
				
			}
			catch(Exception e)
			{
				return Json(new { success = false,err=e });
			}
        }
		public JsonResult ChonPhieuDeNghi(string id)
		{
			try
			{
                var sanPham = db.getSanPhamYeuCau()
					.Where(x => x.PhieuDeNghi_CaNhan == int.Parse(id))
					.ToList();
				var phieu = db.getPhieuDeNghiCaNhan()
					 .FirstOrDefault(x => x.IsDel != true && x.PhieuDeNghi_CaNhan == int.Parse(id));
				return Json(new { success =true, phieu= phieu, data = sanPham });
			}
			catch (Exception ex)
            {
                return Json(new { success = false, error = ex.Message });
            }
		}
		public JsonResult getSanPhamChuaChon(string maPhieu,int idNguoiDeNghi)
		{
			try
			{
				if (maPhieu == "")
				{
					var dssp = db.getDanhSachSanPhamTheoGioiTinhNhanSu(idNguoiDeNghi).Where(sp => sp.IsDel == false).ToList();
                    return Json(new { success = true ,data= dssp });
                }
				else
				{
                    var dssp = db.getDanhSachSanPhamTheoGioiTinhNhanSu(idNguoiDeNghi).Where(sp => sp.IsDel == false).ToList();
                    return Json(new { success = true, data = dssp });
                }
			}catch (Exception ex)
            {
                return Json(new { success = false, error = ex.Message });
            }
        }
		public JsonResult getSanPhamConLaiNguoiDungChuaChon(string MaPhieuDeNghiCaNhan, int idNguoiDeNghi)
		{
			try
			{
				if (MaPhieuDeNghiCaNhan == "")
				{
                    return Json(new { success = false });
                }
				else
				{
					var dssp = db.getSanPhamConLaiChuaChon(MaPhieuDeNghiCaNhan, idNguoiDeNghi).Where(sp => sp.IsDel == false).ToList();
					return Json(new { success = true, data = dssp });
				}
            }
			catch (Exception ex)
			{
				return Json(new { success = false, error = ex.Message });
			}
		}
		public JsonResult CapNhat_PhieuDeNghiCaNhan(string maPhieu, int nguoiDeNghi, int idLyDoCapPhat)
		{
			try
			{
				if (maPhieu=="")
				{
                    return Json(new { success = false, message = "Các tham số đầu vào không hợp lệ." }, JsonRequestBehavior.AllowGet);
                }
				var excute = db.updateLyDoCapPhat(maPhieu, nguoiDeNghi, idLyDoCapPhat);
                return Json(new { success = true,data= excute });
			}
			catch(Exception ex)
			{
                return Json(new { success = true ,data=ex.Message});
            }
		}
        //xóa sản phẩm
        public JsonResult XoaSanPham(int idPhieu, int idSanPham)
        {
            try
            {
                var item = db.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.FirstOrDefault(s => s.PhieuDeNghi_CaNhan == idPhieu && s.SanPham == idSanPham);
                db.NS_DP_PhieuDeNghi_CaNhan_ChiTiet.Remove(item);
                db.SaveChanges();
                return Json(new { success = true, item = item });
            }
            catch
            {
                return Json(new { success = false });
            }
        }
		public JsonResult XoaPhieuDeNghi(int PhieuDeNghiCaNhan)
		{
			try
			{
				var item = db.NS_DP_PhieuDeNghi_CaNhan.FirstOrDefault(s => s.PhieuDeNghi_CaNhan == PhieuDeNghiCaNhan);
				item.IsDel = true;
				db.SaveChanges();
				return Json(new { success = true, item = item });
			}
			catch { return Json(new { success = false }); }
		}
		//public JsonResult getSizeFromSanPham(int idSanPham)
		//{
		//	try
		//	{
		//		db.upda
		//	}
		//	catch { return Json(new { success = false }); }
		//}
	}
    }
	
	public class SelectedProduct
	{
		public int SanPham { get; set; }
		public string TinhChat { get; set; }
		public string Size { get; set; }
		public int SoLuong { get; set; }
	}

