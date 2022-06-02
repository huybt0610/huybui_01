--1. Tìm các nhân viên làm việc ở phòng số 4
USE QLDA
	SELECT * FROM NHANVIEN
	SELECT * FROM dbo.NHANVIEN WHERE PHG = 4;

--2. Tìm các nhân viên có mức lương trên 30000
USE QLDA
	SELECT * FROM dbo.NHANVIEN
	SELECT * FROM dbo.NHANVIEN WHERE LUONG > 30000;

--3. Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên có mức lương trên 30,000 ở phòng 5
USE QLDA
	SELECT * FROM dbo.NHANVIEN
	SELECT * FROM dbo.NHANVIEN
		WHERE (LUONG > 25000 AND PHG = 4) OR (LUONG > 30000 AND PHG = 5);

--4. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
USE QLDA
	SELECT * FROM dbo.NHANVIEN
	SELECT HONV+' '+TENLOT+' '+TENNV AS N'HỌ TÊN ĐẦY ĐỦ', DCHI FROM dbo.NHANVIEN
		WHERE DCHI LIKE N'%TP HCM%';
  
 --5. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
 USE QLDA
	SELECT * FROM dbo.NHANVIEN
    SELECT HONV+' '+TENLOT+' '+TENNV AS N'HỌ TÊN ĐẦY ĐỦ', DCHI FROM dbo.NHANVIEN
		WHERE HONV LIKE N'N%';

--6. Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien.
USE QLDA
	SELECT * FROM dbo.NHANVIEN
	SELECT DAY(NGSINH) AS N'NGÀY SINH', DCHI FROM dbo.NHANVIEN
		WHERE HONV = N'Đinh' and TENLOT = N'Bá' and TENNV = N'Tiên';

 