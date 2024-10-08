USE [DB_QLDP]
GO
/****** Object:  StoredProcedure [dbo].[updateLyDoCapPhat]    Script Date: 25/09/2024 9:07:46 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[updateLyDoCapPhat](
	@maPhieu nvarchar(50) =null,
	@nguoiDeNghi int=null,
	@idLyDoCapPhat int=null
)
AS
BEGIN
	update [dbo].[NS_DP_PhieuDeNghi_CaNhan]
	set LyDoCapPhat =@idLyDoCapPhat
	where MaPhieuDeNghi_CaNhan =@maPhieu and NguoiDeNghi=@nguoiDeNghi
end
