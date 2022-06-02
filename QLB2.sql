
--BÀI THỰC HÀNH LAB01-COM2034 LỚP IT17320 - BL1-SU2022
/*
I. Sinh viên tự thực hiện các phần sau
1. Trình bày các tính năng của HQTCSDL SQL server (word)
2. Cài đặt và viết hướng dẫn để cài đặt được HQTCSDL SQL server (word)
3. Sử dụng công cụ SSMS để viết các bước thực hiện attach và Detach CSDL (word)
4. Tạo CSDL theo yêu cầu bài LAB 01 (T-SQL)
5. Thực hiện kết nối ràng buộc khóa ngoại cho 2 bảng Nhân viên và phòng ban (T-SQL)
6. Thêm các bản ghi theo yêu cầu (tham khảo CSDL QLDA tài nguyên) (T-SQL)
*/

--II.THAM KHẢO TRUY VẤN => các bạn làm thêm 1 số cách khác để lấy ra kết quả theo đúng yêu cầu

--1. Tìm các nhân viên làm việc ở phòng số 4
	SELECT * FROM dbo.NHANVIEN
	SELECT * FROM dbo.NHANVIEN WHERE PHG = 4;

--2. Tìm các nhân viên có mức lương trên 30000
	SELECT * FROM dbo.NHANVIEN
	SELECT * FROM dbo.NHANVIEN WHERE LUONG > 30000;

--3. Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên có mức lương trên 30,000 ở phòng 5
	SELECT * FROM dbo.NHANVIEN
	SELECT * FROM dbo.NHANVIEN
		WHERE (LUONG > 25000 AND PHG = 4) OR (LUONG > 30000 AND PHG = 5);

--4. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
	SELECT * FROM dbo.NHANVIEN
	SELECT HONV+' '+TENLOT+' '+TENNV AS N'HỌ TÊN ĐẦY ĐỦ', DCHI FROM dbo.NHANVIEN
		WHERE DCHI LIKE N'%TP HCM%';
  
 --5. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
	SELECT * FROM dbo.NHANVIEN
    SELECT HONV+' '+TENLOT+' '+TENNV AS N'HỌ TÊN ĐẦY ĐỦ', DCHI FROM dbo.NHANVIEN
		WHERE HONV LIKE N'N%';

--6. Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien.
	SELECT * FROM dbo.NHANVIEN
	SELECT DAY(NGSINH) AS N'NGÀY SINH', DCHI FROM dbo.NHANVIEN
		WHERE HONV = N'Đinh' and TENLOT = N'Bá' and TENNV = N'Tiên';

--CHÚ Ý:
-- CÁC BẠN XEM LẠI BÀI HỌC VÀ THỰC HÀNH LẠI MÔN COM2012 "CẦN BẮT TAY VÀO LÀM LẠI" 
-- Dựa vào hướng dẫn này các bạn hoàn thiện LAB 01 nhé
-- THỰC HIỆN ĐẦY ĐỦ BÁO CÁO + Truy vấn + Detach và Attach cơ sở dữ liệu,...LAB 01