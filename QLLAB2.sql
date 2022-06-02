-- Bài tập:
--1. Tính diện tích hình chữ nhật khi biết chiều dài và chiều rộng
--2. Tính chu vi hình chữ nhật khi biết chiều dài và chiều rộng

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
SELECT @MA_P=MAPHG FROM PHONGBAN	WHERE TENPHG =N'Nghiên cứu';
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
SELECT TENPHONGBAN, SLNHANVIEN, LUONGTB FROM @KETQUA WHERE LUONGTB > 30000;
--4.Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
DECLARE @THONGKE TABLE(MAPHONG NVARCHAR(20), SOLUONG INT)
INSERT INTO @THONGKE
SELECT PHONG, COUNT(MADA) FROM DEAN
GROUP BY PHONG
SELECT A.TENPHG FROM PHONGBAN A JOIN @THONGKE B ON A.MAPHG = B.MAPHONG
SELECT * FROM @THONGKE
