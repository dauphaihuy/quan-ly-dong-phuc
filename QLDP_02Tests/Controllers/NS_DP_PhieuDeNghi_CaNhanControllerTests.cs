using Microsoft.VisualStudio.TestTools.UnitTesting;
using QLDP_02.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLDP_02.Controllers.Tests
{
    [TestClass()]
    public class NS_DP_PhieuDeNghi_CaNhanControllerTests
    {
        [TestMethod()]
        public void getSanPhamChuaChonTest()
        {
            try
            {
                // Arrange
                var controller = new NS_DP_PhieuDeNghi_CaNhanController();

                // Act

                // Assert
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
                Assert.Fail($"Test failed: {ex.Message}");
            }
        }
    }
}