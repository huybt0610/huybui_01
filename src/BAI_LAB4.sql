/*bai 1:Sử dụng cơ sở dữ liệu QLDA. Thực hiện các câu truy vấn sau, sử dụng
if…else và case
 Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là
TenNV, cột thứ 2 nhận giá trị
- “TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong
phòng mà nhân viên đó đang làm việc.
 -“KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương
trong phòng mà nhân viên đó đang làm việc.
*/
--1.
USE QLDA
DECLARE @THONGKE TABLE(MAPB INT,LUONGTB FLOAT)
INSERT INTO @THONGKE
SELECT PHG,AVG(LUONG) FROM NHANVIEN
GROUP BY PHG
SELECT * FROM @THONGKE
SELECT TENNV,PHG,LUONG,LUONGTB,TINHTRANG=CASE WHEN LUONG >LUONGTB THEN N'KHÔNG TĂNG'
ELSE N'TĂNG LƯƠNG'
END
FROM NHANVIEN A
JOIN @THONGKE B
ON A.PHG=B.MAPB
/*
 Viết chương trình phân loại nhân viên dựa vào mức lương.
- Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì xếp loại “nhanvien”, ngược lại xếp loại “truongphong”
*/
--2.
SELECT IIF(LUONG>30000,N'TRƯỞNG PHÒNG', N'NHÂN VIÊN') AS N'CHỨC VỤ', 
HONV, TENLOT, TENNV, LUONG FROM  NHANVIEN
/*
 .Viết chương trình hiển thị TenNV như hình bên dưới, tùy vào cột phái của nhân viên
*/
--3
SELECT TENNV =  CASE PHAI
	WHEN N'NAM' THEN 'MR. '+[TENNV]
	WHEN N'NỮ' THEN 'MS. '+[TENNV]
	END
	FROM DBO.NHANVIEN
	/*
Viết chương trình tính thuế mà nhân viên phải đóng theo công thức:
o 0<luong<25000 thì đóng 10% tiền lương
o 25000<luong<30000 thì đóng 12% tiền lương
o 30000<luong<40000 thì đóng 15% tiền lương
o 40000<luong<50000 thì đóng 20% tiền lương
o Luong>50000 đóng 25% tiền lương
*/
--4
SELECT HONV, TENLOT, TENNV, LUONG, N'THUẾ' = CASE
	WHEN LUONG < 25000 THEN LUONG*0.1
	WHEN LUONG > 25000 AND LUONG < 30000 THEN LUONG*0.12
	WHEN LUONG > 30000 AND LUONG < 40000 THEN LUONG*0.15
	WHEN LUONG > 40000 AND LUONG < 50000 THEN LUONG*0.2
	ELSE LUONG*0.25
	END
FROM NHANVIEN;
--Bài 2: 
--Sử dụng cơ sở dữ liệu QLDA. Thực hiện các câu truy vấn sau, sử dụng vòng
--lặp
--a.Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
DECLARE @I  INT , @DEM INT
SET @I=2
SET @DEM = (SELECT COUNT(MANV) FROM NHANVIEN)
WHILE(@I<@DEM)
BEGIN 
SELECT HONV,TENLOT,TENNV,MANV 
FROM NHANVIEN
WHERE CAST(MANV AS INT ) = @I 
SET @I = @I+2
END
--=============================================
--b.Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng
--không tính nhân viên có MaNV là 4.
DECLARE @I INT , @DEM INT
SET @I=2
SET @DEM = (SELECT COUNT(MANV) FROM NHANVIEN)
WHILE(@I<@DEM)
BEGIN 
IF(@I=4)
BEGIN
	SET @I=@I+2
	CONTINUE
END
SELECT HONV,TENLOT,TENNV,MANV 
FROM NHANVIEN
WHERE CAST(MANV AS INT ) = @I 
SET @I = @I+2
END
--=============================================
--Bài 3:Quản lý lỗi chương trình   
--a.Thực hiện chèn thêm một dòng dữ liệu vào bảng PhongBan bằng try catch
BEGIN TRY 
	INSERT INTO  PHONGBAN VALUE('Van Hoc',9,'019','2019-05-25')
	PRINT N'Chèn thành công'
END TRY
BEGIN CATCH 
 PRINT N'Chèn không thành công' +CONVERT (VARCHAR,ERROR_NUMBER(),1) +'.'+ ERROR_MESSAGE()
 END CATCH
 --=============================================
-- b.Viết chương trình khai báo biến @chia, thực hiện phép chia @chia cho số 0 và dùng
--RAISERROR để thông báo lỗi

BEGIN TRY
		DECLARE @A INT =5 , @B INT = 0, @KQ  INT;
		SET @KQ = @A/@B
END TRY
BEGIN CATCH 
	DECLARE @ERRORMESSAGE NVARCHAR(1000),
			@ERRORSEVERITY INT,
			@ERRORSTATE INT
	SELECT @ERRORMESSAGE=ERROR_MESSAGE(),
			@ERRORSEVERITY = ERROR_SEVERITY(),
			@ERRORSTATE =ERROR_STATE()
	RAISERROR(@ERRORMESSAGE,@ERRORSEVERITY,@ERRORSTATE)
END CATCH


