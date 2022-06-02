--Bài thực hành số 5 – Stored procedures

CREATE DATABASE LAB5
GO
USE LAB5
GO
--Bài 1: Viết stored-procedure:
--In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của bạn. Gợi ý:
--sử dụng UniKey để gõ Tiếng Việt 
--chuỗi unicode phải bắt đầu bởi N 
--dùng hàm cast 
CREATE PROCEDURE sp_xinChao @ten nvarchar(20)
AS
BEGIN
DECLARE @name nvarchar(13)
SET @name = @ten
PRINT 'XIN CHÀO :'+ CAST(@name AS nvarchar(11))
END
EXEC xinChao N'Thế Huy'
--==========================================================
--Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.
GO
CREATE PROCEDURE sp_sumSo @s1 int, @s2 int

AS
BEGIN
DECLARE @tg int
SET @tg = @s1 + @s2
PRINT N'Tổng là'+CAST(@tg AS nvarchar(11))
EXEC sp_sumSo 12,
--==========================================================
--Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
GO
CREATE PROC sp_tinhTongSoChan @soNguyen int
AS 
	BEGIN
	DECLARE @sum int, @i int
		SET @sum = 0
		SET @i = 1
			WHILE @i <= @soNguyen
	BEGIN 
			IF @i % 2 = 0
	BEGIN
		SET @sum = @sum + @i
	END
		SET @i = @i + 1
	END;
		PRINT N'TỔNG CÁC SỐ CHẴN ' + CAST(@sum  AS nvarchar);
	END;
EXEC sp_tinhTongSoChan 4
--==========================================================
--Nhập vào 2 số. In ra ước chung lớn nhất của chúng theo gợi ý dưới đây:
-- b1. Không mất tính tổng quát giả sử a <= A
-- b2. Nếu A chia hết cho a thì : (a,A) = a ngược lại : (a,A) = (A%a,a) hoặc (a,A) = (a,A-a)
-- b3. Lặp lại b1,b2 cho đến khi điều kiện trong b2 được thỏa
GO
CREATE PROC _UCLN @a int, @b int
AS 
	BEGIN  
		DECLARE @x int --- x là biến trung gian, lưu giá trị tạm thời
		IF @a>@b
		BEGIN 
			SELECT @x = @a , @a = @b ,@b = @x;
		END
		
		WHILE @b%@a != 0 --- kiểm tra điều kiện
		BEGIN
			SELECT @x= @a, @a=@b %@a,@b =@x;---thực hiện hoán đổi giá trị
 		END;
		PRINT N'ƯỚC CHUNG LỚN NHẤT CỦA 2 SỐ:'+cast(@a AS varchar); 
	END
 
-- Bài 2: Sử dụng cơ sở dữ liệu QLDA, Viết các Proc:
-- Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
--Sử dụng cơ sở dữ liệu QLDA

--Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
USE QLDA 
GO
CREATE PROC sp_maNhanVien @maNV int
AS
	BEGIN
	SELECT * FROM NHANVIEN
	WHERE MANV = @maNV --- điều kiện
	END
	EXEC sp_maNhanVien 002


-- Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó
CREATE PROC sp_maDeAn @maNV int
AS
	BEGIN
	SELECT COUNT(MANV) AS'SỐ LƯỢNG THAM GIA ĐỀ ÁN' FROM NHANVIEN-- đếm số lượng mã nv cần tìm
	INNER JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG --- join bảng để tìm mã đề án 
	INNER JOIN DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
	WHERE MADA = @maNV
	GROUP BY MADA
	END
	EXEC sp_maDeAn 10;

	SELECT * FROM DEAN
	SELECT *FROM NHANVIEN

-- Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham
--gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA
CREATE PROC sp_soLuongNhanVien @maDeAn int, @Ddiem_DA nvarchar(20)
AS
	BEGIN
		SELECT COUNT(MANV) AS'SỐ LƯỢNG NHÂN VIÊN THAM GIA ĐỀ ÁN: ' FROM NHANVIEN
		INNER JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG --- join bảng để kết nối dữ liệu 
		INNER JOIN DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
		WHERE MADA = @maDeAn AND DDIEM_DA = @Ddiem_DA --- điểm chung
		GROUP BY  MADA, DDIEM_DA
	END
	EXEC sp_soLuongNhanVien 30, N'Hà Nội'

-- Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là
--@Trphg và các nhân viên này không có thân nhân.
CREATE PROC sp_truongPhong @maTrP int
AS
	BEGIN
		SELECT  HONV, TENNV, TENPHG, NHANVIEN.MANV, THANNHAN.* FROM NHANVIEN
		INNER JOIN PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG
		LEFT OUTER JOIN THANNHAN ON NHANVIEN.MANV = THANNHAN.MA_NVIEN --- Trả về tất cả bản ghi từ bảng bên trái và bản ghi trùng với bảng bên phải
		WHERE THANNHAN.MA_NVIEN IS NULL AND TRPHG= @maTrP
	END
	EXEC sp_truongPhong 008
	SELECT MA_NQL,*  FROM NHANVIEN
-- Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có
-- mã @Mapb hay không
CREATE PROC sp_NV_PHG @maNV nvarchar(5), @maPHG int
AS
	BEGIN
	IF exists(SELECT * FROM NHANVIEN WHERE MANV = @maNV AND PHG= @maPHG) ---kiểm tra sự tồn tại
		print N'NHÂN VIÊN  Ở TRONG PHÒNG BAN NÀY!'
	ELSE
		PRINT N'NHÂN VIÊN KHÔNG CÓ Ở TRONG PHÒNG BAN NÀY!' 
	END
	EXEC sp_NV_PHG '007',5
	EXEC sp_NV_PHG '007',4
-- Bài 3: Sử dụng cơ sở dữ liệu QLDA, Viết các Proc

-- Thêm phòng ban có tên CNTT vào csdl QLDA, các giá trị được thêm vào dưới dạng
--tham số đầu vào, kiếm tra nếu trùng Maphg thì thông báo thêm thất bại.
CREATE PROC kiemTRa @maPHG int , @tenPHG nvarchar(15), @MaTP nvarchar(9), @ngayNhanChuc date
AS
	BEGIN
		if exists(Select * from PHONGBAN WHERE MAPHG = @maPHG)---kiểm tra sự tồn tại của mã phg
			PRINT N'THÊM DỮ LIỆU THẤT BẠI'
		ELSE
			BEGIN
				INSERT INTO PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)-- chèn thêm dữ liệu 
				VALUES(@maPHG, @tenPHG, @MaTP, @ngayNhanChuc)
				PRINT N'THÊM DỮ LIỆU THÀNH CÔNG'
			END
	END
	EXEC kiemTRa 2, N'CNTT', '008', '2021-10-22'
	SELECT * FROM PHONGBAN

-- Cập nhật phòng ban có tên CNTT thành phòng IT.
CREATE PROC CapNhap @maPHG int , @tenPHG nvarchar(15), @MaTP nvarchar(9), @ngayNhanChuc date
AS
	BEGIN
		if exists(Select * from PHONGBAN WHERE MAPHG = @maPHG)---- check xem có mã phòng trùng ko
			update PHONGBAN Set TENPHG = @tenPHG, TRPHG = @MaTP, NG_NHANCHUC = @ngayNhanChuc--- cập nhật giá trị cần thay đổi 
			WHERE MAPHG = @maPHG
		ELSE
			BEGIN
				INSERT INTO PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
				VALUES(@maPHG, @tenPHG, @MaTP, @ngayNhanChuc)
				PRINT N'THÊM DỮ LIỆU THÀNH CÔNG'
			END
	END
	EXEC CapNhap 7, N'IT', '007', '2001-11-26'
	SELECT * FROM PHONGBAN
-- Thêm một nhân viên vào bảng NhanVien, tất cả giá trị đều truyền dưới dạng tham số đầu
--vào với điều kiện:
-- nhân viên này trực thuộc phòng IT
-- Nhận @luong làm tham số đầu vào cho cột Luong, nếu @luong<25000 thì nhân
--viên này do nhân viên có mã 009 quản lý, ngươc lại do nhân viên có mã 005 quản lý
-- Nếu là nhân viên nam thi nhân viên phải nằm trong độ tuổi 18-65, nếu là nhân
--viên nữ thì độ tuổi phải từ 18-60.

SELECT *  FROM NHANVIEN
SELECT HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG FROM NHANVIEN

INSERT INTO NHANVIEN 
VALUES (N'Nguyễn', N'Thị', N'Hạnh', '010', '1999-12-12', N'Cầu Giấy,Hà Nội', N'Nữ', '123456789', '008', 6)

CREATE PROC Sp_nv @HONV nvarchar(15), @TENLOT nvarchar(15), @TENNV nvarchar(15), @MANV nvarchar(9), 
@NGSINH date, @DCHI nvarchar(30), @PHAI nvarchar(3), @LUONG float, @MA_NQL nvarchar(5), @PHG int 
AS 
BEGIN -- PROC
		DECLARE @tuoi int
		SET @tuoi = YEAR(GETDATE())- YEAR(@NGSINH)
		IF @PHG =  (SELECT MAPHG FROM PHONGBAN WHERE TENPHG = 'IT')
			BEGIN -- THUỘC PHÒNG IT
				IF @LUONG < 25000
				SET @MA_NQL = '008'
				ELSE SET @MA_NQL = '008'

				IF(@PHAI = 'Nam' and (@tuoi >= 18 and @tuoi <=65))
				or (@PHAI = N'Nữ' and (@tuoi >= 18 and @tuoi <=60))
					BEGIN --ĐỘ TUỔI LAO ĐỘNG
						INSERT INTO NHANVIEN(HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
						VALUES (@HONV, @TENLOT, @TENNV, @MANV, @NGSINH, @DCHI, @PHAI, @LUONG, @MA_NQL, @PHG)
					END --ĐỘ TUỔI LAO ĐỘNG
				ELSE
					PRINT N'KHÔNG THUỘC ĐỘ TUỔI LAO ĐỘNG'
			END -- THUỘC PHÒNG IT
		ELSE
			PRINT N'KHÔNG THUỘC PHÒNG IT'
END	-- PROC	
EXEC Sp_nv N'Nguyễn', N'Thị', N'Hạnh', '014', '2003-12-12', N'Cầu Giấy,Hà Nội', N'Nữ', '123456789', '008',6
SELECT * FROM PHONGBAN
SELECT * FROM NHANVIEN

