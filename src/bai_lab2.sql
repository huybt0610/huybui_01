
--BÀI THỰC HÀNH LAB02-COM2034 LỚP IT17320 - BL1-SU2022

/*
1. Liệt kê các kiểu dữ liệu trong SQL Server
	=> Sinh viên trình bày ngay trên file này
1. Bảng NHANVIEN
TÊN THUỘC TÍNH			DIỄN GIẢI			KIỂU DỮ LIỆU			GHI CHÚ
	HONV					...				NVARCHAR(15)				CHUỖI
	TENLOT					...				NVARCHAR(15)				CHUỖI
	TENNV					...				NVARCHAR(15)				CHUỖI
	MANV,MA_NVIEN			...				NVARCHAR(9)					CHUỖI
	NGSINH					...				DATETIME					THỜI GIAN
	DCHI					...				NVARCHAR(30)				CHUỖI
	PHAI					...				NVARCHAR(3)					CHUỖI
	LUONG					...				FLOAT						SỐ THỰC
	MA_NQL					...				NVARCHAR(9)					CHUỖI
	TENPHG					...				NVARCHAR(15)				CHUỖI
	PHG,MAPHG				...				INT							SỐ NGUYÊN
	TRPHG					...				NVARCHAR(9)					CHUỖI
	NG_NHANCHUC				...				DATETIME					THỜI GIAN
	TENTIN					...				NVARCHAR(15)				CHUỖI
	QUANHE					...				NVARCHAR(15)				CHUỖI
	MADA,SODA				...				INT							SỐ NGUYÊN
	TENDA					...				NVARCHAR(15)				CHUỖI
	DDIEM_DA				...				NVARCHAR(15)				CHUỖI
	PHONG					...				INT							SỐ NGUYÊN
	THOIGIAN				...				FLOAT						SỐ THỰC
	STT						...				INT							SỐ NGUYÊN
	TEN_CONG_VIEC			...				NVARCHAR(50)				CHUỖI
	--BẢNG PHÒNG BAN
	TENPHG					...				NVARCHAR(15)				CHUỖI
	MAPHG					...				INT							SỐ NGUYÊN
	TRPHG					...				INT							SỐ NGUYÊN
	NG_NHANCHUC				...				DATETIME					THỜI GIAN
	--BẢNG THÂN NHÂN
	MA_NVIEN				...				INT							SỐ NGUYÊN
	TENTN					...				NVARCHAR(15)				CHUỖI
	PHAI					...				NVARCHAR(3)					CHUỖI
	NGSINH					...				DATETIME					THỜI GIAN
	QUANHE					...				NVARCHAR(15)				CHUỖI
	--BẢNG ĐỀ ÁN
	TENDA					...				NVARCHAR(15)				CHUỖI
	MADA					...				INT							SỐ NGUYÊN	
	DDIEM_DA				...				NVARCHAR(15)				CHUỖI
	PHONG					...				INT							SỐ NGUYÊN
	--BẢNG ĐỊA ĐIỂM_PHG
	MAPHG					...				INT							SỐ NGUYÊN
	DIADIEM					...				NVARCHAR(15)				CHUỖI
	--BẢNG PHÂN CÔNG
	 MA_NVIEN				...				INT							SỐ NGUYÊN
	 MADA					...				INT							SỐ NGUYÊN
	 STT					...				INT							SỐ NGUYÊN
	 THOIGIAN				...				FLOAT						SỐ THỰC
	 --BẢNG CÔNG VIỆC
	 MADA					...				INT							SỐ NGUYÊN
	 STT					...				INT							SỐ NGUYÊN
	 TEN_CONG_VIEC			...				NVARCHAR(20)				CHUỖI
2. BẢNG PHONGBAN

2. Tạo cơ sở dữ liệu bằng tool và bằng lệnh
	a. Tạo CSDL QLDA_LAB02
	b. Tạo các bảng cho CSDL: DEAN, PHONGBAN, DIADIEM_PHG, NHANVIEN, THANNHAN, CONGVIEC, PHANCONG
	c. Mô tả thuộc tính, kiểu dữ liệu và miền giá trị của các bảng
	d. Thực hiện nhập dữ liệu vào các bảng (lấy dữ liệu từ CSDL QLDA)
	e. Thực hiện ràng buộc khóa ngoại cho CSDL vừa tạo


	*/
	---TẠO CSDL
CREATE DATABASE QLDA_LAB02
----TẠO BẢNG
------BẢNG NHÂN VIÊN
IF OBJECT_ID('NHANVIEN') IS NOT NULL
    DROP TABLE NHANVIEN
GO
CREATE TABLE NHANVIEN
(
    HONV nvarchar(15) NOT NULL,
	TENLOT nvarchar(15) NOT NULL,
	TENNV nvarchar(15) NOT NULL,
	MANV nvarchar(9) NOT NULL PRIMARY KEY,
	NGSINH datetime NOT NULL,
	DCHI nvarchar(30) NOT NULL,
	PHAI nvarchar(3) NOT NULL,
	LUONG float NOT NULL,
	MA_NQL nvarchar(9) NULL,
	PHG int NULL,
)
------BẢNG PHÒNG BAN
IF OBJECT_ID('PHONGBAN') IS NOT NULL
    DROP TABLE PHONGBAN
GO
CREATE TABLE PHONGBAN
(
    TENPHG nvarchar(15) NOT NULL,
	MAPHG int NOT NULL PRIMARY KEY,
	TRPHG nvarchar(9) NULL,
	NG_NHANCHUC date NOT NULL,
)
------BẢNG CÔNG VIỆC
IF OBJECT_ID('CONGVIEC') IS NOT NULL
    DROP TABLE CONGVIEC
GO
CREATE TABLE CONGVIEC
(
    MADA int NOT NULL,	
	STT int NOT NULL PRIMARY KEY,
	TEN_CONG_VIEC NVARCHAR	(50) NOT NULL,
	FOREIGN KEY(MADA) REFERENCES DEAN(MADA)
 
)
------BẢNG ĐỀ ÁN
IF OBJECT_ID('DEAN') IS NOT NULL
    DROP TABLE DEAN
GO
CREATE TABLE DEAN
(
    TENDEAN nvarchar(15) NOT NULL,
	MADA int NOT NULL PRIMARY KEY,	
	DDIEM_DA nvarchar(15) NOT NULL,
	PHONG int NULL,
)
------BẢNG ĐỊA ĐIỂM PHÒNG BAN
IF OBJECT_ID('DIADIEM_PHG') IS NOT NULL
    DROP TABLE DIADIEM_PHG
GO
CREATE TABLE DIADIEM_PHG
(
    MAPHG int NOT NULL,
	DIADIEM nvarchar(15) NOT NULL  PRIMARY KEY,
	FOREIGN KEY(MAPHG) REFERENCES PHONGBAN(MAPHG)
)

------BẢNG PHÂN CÔNG
IF OBJECT_ID('PHANCONG') IS NOT NULL
    DROP TABLE PHANCONG
GO
CREATE TABLE PHANCONG
(
    MA_NVIEN nvarchar(9) NOT NULL ,
	MADA int NOT NULL,
	STT int NOT NULL PRIMARY KEY,
	THOIGIAN float NOT NULL,
	FOREIGN KEY(MA_NVIEN) REFERENCES dbo.NHANVIEN(MANV),
	FOREIGN KEY(MADA) REFERENCES dbo.DEAN(MADA),

)

------BẢNG THÂN NHÂN
IF OBJECT_ID('THANNHAN') IS NOT NULL
    DROP TABLE THANNHAN
GO
CREATE TABLE THANNHAN
(
    MA_NVIEN nvarchar(9) NOT NULL ,
	TENTN nvarchar(15) NOT NULL PRIMARY KEY,
	PHAI nvarchar(3) NOT NULL,
	NGSINH date NOT NULL,
	QUANHE nvarchar(15) NOT NULL,
	FOREIGN KEY(MA_NVIEN) REFERENCES dbo.NHANVIEN(MANV),

)

--TRUY VẤN

--KHAI BÁO BIẾN VÔ HƯỚNG
		DECLARE @CHIEUDAI FLOAT, @CHIEURONG FLOAT,@CHUVI FLOAT,@DIENTICH FLOAT
---GÁN GIÁ TRỊ
		SET @CHIEUDAI=35
		SET @CHIEURONG=30
		SET @CHUVI=(@CHIEUDAI+@CHIEURONG)*2  
		SET @DIENTICH=@CHIEUDAI*@CHIEURONG
---TRUY VẤN
					--CÁCH 1: 
--SELECT N'DIỆN TÍCH HÌNH CHỮ NHẬT LÀ: '+CAST(@DIENTICH AS nvarchar);
--SELECT N'CHU VI HÌNH CHỮ NHẬT LÀ: '+CAST(@CHUVI AS nvarchar);
					--CÁCH 2:
PRINT N'DIỆN TÍCH HÌNH CHỮ NHẬT LÀ:' + CONVERT(CHAR(10), @DIENTICH);
PRINT N'CHU VI HÌNH CHỮ NHẬT LÀ:' + CONVERT(CHAR(10), @CHUVI);

	/*
3. Sử dụng T-SQL thực hiện các truy vấn có dùng biến
	a. Sử dụng biến thể thực hiện
		+. Chương trình tính diện tích hình chữ nhật, khi biết chiều dài và chiều rộng
		+. Chương trình tính chu vi hình chữ nhật, khi biết chiều dài và chiều rộng
	b. Dựa trên CSDL QLDA thực hiện truy vấn "Sử dụng biến"
		1. Cho biêt nhân viên có lương cao nhất
		2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu”
		3. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó
		4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
*/

--1. Tính diện tích
Declare @chieudai float, @chieurong float, @dientich float, @chuvi float;
--- gán giá trị cho các biến 
set @chieudai=10
set @chieurong=5 
set @dientich=@chieudai*@chieurong 
set @chuvi=2*(@chieudai+@chieurong) 
--- hiển thị kết quả
---SELECT N'Diện tích hình chữ nhật là: ' + CAST(@dientich as nvarchar); 
PRINT N'Diện tích hình chữ nhật là: '+ CONVERT(CHAR(10), @dientich);
PRINT N'CHU VI hình chữ nhật là: '+ CONVERT(CHAR(10), @chuvi);
--1. Cho biêt nhân viên có lương cao nhất

SELECT * FROM NHANVIEN
DECLARE @MAX FLOAT;
--- TÌM MỨC LƯƠNG CAO NHẤT TRONG BẢNG NHÂN VIÊN
SELECT @MAX = MAX(LUONG) FROM NHANVIEN;
-- HIỂN THỊ THÔNG TIN NHÂN VIEN CÓ LƯƠNG CAO NHẤT
SELECT * FROM NHANVIEN WHERE LUONG = @MAX;

--2.Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu"
--- tìm mức lưng trung bình của phòng nghiên cứu
--- tìm nhân viên có lương lớn hơn trên mức lương trung bình
SELECT * FROM NHANVIEN
SELECT * FROM PHONGBAN
SELECT AVG(LUONG) FROM NHANVIEN
--KHAI BÁO VÔ HƯỚNG 
DECLARE @AVG FLOAT, @MA_P INT;
--TÌM MỨC LƯƠNG TRUNG BÌNH
SELECT @AVG = AVG(LUONG) FROM NHANVIEN
---TÌM PHÒNG NGHIÊN CỨU
SELECT @MA_P=MAPHG FROM PHONGBAN WHERE TENPHG =N'Nghiên cứu';
--- HIỂN THỊ .........
SELECT HONV, TENLOT, TENNV FROM NHANVIEN WHERE LUONG > @AVG AND PHG = @MA_P;

--3.Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
---KHAI BÁO BIẾN MẢNG
DECLARE @KETQUA TABLE (TENPHONGBAN NVARCHAR(15), SLNHANVIEN INT, LUONGTB FLOAT);
---CHÈN DỮ LIỆU VÀO BIẾN MẢNG
INSERT INTO @KETQUA
SELECT TENPHG, COUNT(MANV), AVG(LUONG) FROM  NHANVIEN JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY TENPHG;
---TRUY CẬP DỮ LIỆU TỪ BIẾN MẢNG
SELECT TENPHONGBAN, SLNHANVIEN, LUONGTB FROM @KETQUA WHERE LUONGTB > 30000
--4.Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
DECLARE @THONGKE TABLE(MAPHONG NVARCHAR(20), SOLUONG INT)
INSERT INTO @THONGKE
SELECT PHONG, COUNT(MADA) FROM DEAN
GROUP BY PHONG
SELECT A.TENPHG FROM PHONGBAN A JOIN @THONGKE B ON A.MAPHG = B.MAPHONG
SELECT * FROM @THONGKE

