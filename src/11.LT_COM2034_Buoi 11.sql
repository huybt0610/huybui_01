
--Bài 6: Trigger

/*
1. Trigger trong SQL là gì?
	Trigger trong SQL là một đoạn procedure code, chỉ được vận hành khi có một sự kiện xảy ra.
	Có nhiều loại sự kiện khác nhau để kích hoạt trigger trong SQL. Có thể kể đến như việc chèn các hàng trong bảng,
	thay đổi cấu trúc bảng hoặc thậm chí người dùng đăng nhập vào một phiên bản SQL Server.

2. Có ba đặc điểm chính làm cho trigger trong SQL khác với các stored procedures:
	a. Người dùng không thể thực hiện thủ công các trigger.
	b. Không có cơ hội cho trigger nhận thông số.
	c. Bạn sẽ không thể cam kết hoặc khôi phục một transaction bên trong trigger.

3. Cú pháp của Trigger (xem slide bài LT 06) => xem cú pháp cho từng loại Trigger

		CREATE TRIGGER tên_trigger  
		ON { Tên_bảng }   
		[ WITH <Options> ]  
		{ FOR | AFTER | INSTEAD OF }   
		{ [INSERT], [UPDATE] , [DELETE] }

4. Các lớp Trigger trong SQL Server
*. Có hai lớp trigger trong SQL Server:
	a. DDL (Data Definition Language) trigger:
		Loại trigger này kích hoạt khi các sự kiện thay đổi cấu trúc (như tạo, sửa đổi hay loại bỏ bảng).
		Hoặc trong các sự kiện liên quan đến server như thay đổi bảo mật hoặc sự kiện cập nhật thống kê.
	b. DML (Data Modification Language) trigger:
		Đây là loại trigger được sử dụng nhiều nhất.
		Trong trường hợp này, sự kiện kích hoạt là một câu lệnh sửa đổi dữ liệu. Nó có thể là một câu lệnh chèn,
		cập nhật hoặc xoá trên một bảng.

*. Ngoài ra, DML trigger còn có các loại khác nhau:

	FOR hoặc AFTER [[INSERT, UPDATE, DELETE]:
	Các loại trigger này được thực thi sau khi câu lệnh kích hoạt kết thúc.

	INSTEAD OF [INSERT, UPDATE, DELETE]: Trái ngược với FOR (AFTER), trigger INSTEAD OF thực thi thay vì thay cho câu lệnh kích hoạt.
	Nói cách khác, loại trigger này thay thế câu lệnh kích hoạt. Điều này rất hữu ích trong trường hợp bạn cần có tính toàn vẹn tham chiếu database chéo.

5. Trigger dùng để làm gì?
	*. Trigger SQL Server được sử dụng để kiểm tra ràng buộc (check constraints) trên nhiều quan hệ (nhiều bảng/table)
		hoặc trên nhiều dòng (nhiều record) của bảng.
	*. Bên cạnh đó, việc sử dụng Trigger để chương trình có những hàm chạy ngầm nhằm phục vụ những trường hợp hữu hạn
		và thường không sử dụng cho mục đích kinh doanh hoặc giao dịch.

6. Tầm quan trọng của Trigger trong SQL Server
	*. Một trong những đặc điểm cơ bản của relational databases là tính nhất quán dữ liệu.
		Bạn có thể hiểu là thông tin được lưu trữ trong database luôn nhất quán cho mọi chuyển đổi.
		Cách các công cụ relational database như SQL server thực hiện điều này bằng cách thực thi ràng buộc các primary key và foreign key.

	*. Trong SQL Server không có cơ hội thực thi tính toàn vẹn tham chiếu giữa hai bảng bằng foreign key
		nếu các bảng đó nằm trong database khác nhau hoặc server khác nhau.
		Trong trường hợp này, cách duy nhất để thực hiện là sử dụng trigger trong SQL Server.

7. Ưu điểm của Trigger
	1. Trigger trong SQL rất dễ để viết code. Thực tế là chúng được mã hóa giống như các stored procedure. Điều này giúp việc bắt đầu với các trigger trở nên dễ dàng hơn rất nhiều.
	2. Trigger cho phép bạn tạo audit cơ bản. Bằng cách sử dụng bảng đã xóa bên trong một trigger. Bạn có thể xây dựng một giải pháp kiểm tra phù hợp để chèn nội dung của dữ liệu bảng đã xóa vào một bảng kiểm tra lưu giữ dữ liệu đang bị xóa bởi câu lệnh DELETE hoặc được thay đổi bởi câu lệnh UPDATE.
	3. Bạn có thể call các store procedure và hàm được lưu trữ bên trong trigger.
	4. Trigger trong SQL hữu ích khi bạn cần xác thực dữ liệu được Insert hoặc update theo batch thay vì từng hàng.
	5. Bạn có thể sử dụng trigger trong SQL Server để vận hành tính toàn vẹn tham chiếu trên database.
	6. Trigger trong SQL rất hữu ích nếu bạn cần đảm bảo rằng các sự kiện luôn xảy ra khi dữ liệu được insert, update hoặc delete.
	7. Bạn có thể sử dụng code bên ngoài làm trigger bằng cách sử dụng CLR trigger. Loại trigger này chỉ định phương thức của một hợp ngữ được viết bằng .NET để liên kết với trigger.
	8. Các trigger có thể được lồng vào nhau đến 32 cấp độ. Một trigger được coi là lồng vào nhau khi nó thực hiện một hoạt động kích hoạt một trigger khác.

8. Nhược điểm của Trigger
	1. Khi bạn sử dụng BULK INSERT để chèn dữ liệu vào table, trigger sẽ không được kích hoạt trừ khi ban bao gồm tùy chọn FIRE_TRIGGERS trong hàng loạt câu lệnh Insert của mình. Điều này rất quan trọng, vì nếu bạn có trigger trên một table và bạn thực hiện hàng loạt thao tác Insert mà không bao gồm tùy chọn FIRE_TRIGGERS, bạn sẽ mất đi tính nhất quán của dữ liệu.
	2. Rất khó xác định các trigger trừ khi bạn có tài liệu thích hợp. Vì chúng không thể nhìn thấy đối với client.
	3. Mỗi khi bạn chạy một câu lệnh DML có một trigger được liên kết với nó, bạn thực sự đang thực thi câu lệnh DML và trigger. Nhưng theo định nghĩa, câu lệnh DML sẽ không kết thúc cho đến khi quá trình thực thi trigger hoàn tất. Điều này có thể tạo ra một thảm họa trong sản xuất.
	4. Vấn đề của việc sử dụng trigger trong SQL cho mục đích kiểm tra là khi trigger được bật. Chúng luôn thực thi bất kể trường hợp nào khiến trigger kích hoạt.
	5. Nếu có nhiều trigger lồng nhau, có thể rất khó gỡ lỗi và khắc phục sự cố. Điều này làm tiêu tốn thời gian và tài nguyên để phát triển.
	6. Nếu bạn sử dụng trigger trong SQL để thực thích tính toàn vẹn của tham chiếu, bạn phải lưu ý rằng trigger trong SQL có thể bị vô hiệu hóa bởi người dùng có quyền AFTER trên bảng hoặc chế độ xem nơi trigger được tạo ra. Để tránh điều này, bạn có thể phải xem xét các quyền của người dùng.
	7. Để CLR trigger hoạt động, bạn phải kích hoạt tùy chọn server “clr enabled” bằng cách sử dụng quy trình lưu trữ hệ thống sp_configure. Việc cho phép code CLR chạy trong phiên bản database tiềm ẩn mối đe dọa bảo mật. Vì người dùng độc hại có thể thêm các cụm CLR vào database và sau đó chiếm quyền kiểm soát server.
*/
--/////////////////////////////////////////////////////////////////////////////////

--1. Tạo một Insert Trigger nhằm đảm bảo giá trị của cột

		CREATE Trigger InsertLuong_NV_1
		On NhanVien
		For INSERT --Hành động insert
		As
		If (select Luong From inserted) < 5000
			Begin
				Print N'Tiền lương tối thiểu phải lớn hơn 5000.'
				Rollback TRANSACTION;
			End

			-- Kiểm tra Trigger insert
		INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'068','1976-06-04',N'P 506 Nghĩa Tân',N'Nam','7000',N'005','5');

		DELETE FROM dbo.NHANVIEN WHERE MANV = N'068'

		SELECT * FROM dbo.NHANVIEN
--/////////////////////////////////////////////////////////////////////////////////


-- 2. Tạo một Update Trigger nhằm đảm bảo giá trị của cột

		CREATE TRIGGER UpdateLuong_NV
		ON NhanVien
		FOR UPDATE --Hành động update
		AS 
		IF (SELECT LUONG FROM Inserted) < 5000 --Bảng ghi mới được ghi vào Inserted, gốc ghi vào Deleted
		BEGIN
		PRINT N'Tiền lương tối thiểu phải lớn hơn 5000.'
		ROLLBACK TRANSACTION;
		END

		-- Kiểm tra Trigger update
		UPDATE dbo.NHANVIEN SET LUONG = 8000 WHERE MANV LIKE N'005'

		SELECT * FROM dbo.NHANVIEN
--/////////////////////////////////////////////////////////////////////////////////

--3. --Tạo một Delete Trigger nhằm đảm bảo giá trị của cột (hạn chế người dùng xóa)
		CREATE Trigger Delete_NV
		On NhanVien
		For DELETE --Hành động xóa
		As
		If N'005' in (Select MaNV From deleted)
			Begin
				Print N'Không thể xóa bản ghi này:'
				Rollback TRANSACTION;
			END
    
			-- Kiểm tra Trigger delete
		Delete From NhanVien Where MaNV like N'068' --Kiểm tra ràng buộc trước khi kiểm tra trigger

		SELECT * FROM dbo.NHANVIEN

--/////////////////////////////////////////////////////////////////////////////////

--DEMO
-- 1. Viết trigger ràng buộc quy định mức lương của nhân viên không được <5000 cho thao tác thêm và cập nhật bảng nhân viên.

		CREATE TRIGGER MucLuong_NV
		ON NhanVien
		FOR INSERT, UPDATE --Thao tác thêm và cập nhật
		AS 
		IF (SELECT LUONG FROM Inserted) < 5000
			BEGIN
				PRINT N'Lương tối thiểu phải từ 5000.';
				ROLLBACK TRANSACTION;
			END
	
	--Kiểm tra trigger hành động chèn dữ liệu
		INSERT INTO NHANVIEN
				   ([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQL],[PHG])
			 VALUES
					(N'Trần',N'Thanh',N'Long',N'068','04-06-1976',N'P 506 Nghĩa Tân',N'Nam','4000',N'005','5');

	--Kiểm tra trigger hành động update (sinh vien thực hiện)

	--Kiểm tra kết quả
		SELECT * FROM dbo.NHANVIEN

-----------------------------------------------------------------------------

--2. Viết trigger ràng buộc không được xóa nhân viên ở TP HCM

		CREATE TRIGGER Delete_NV_HCM
		ON NhanVien
		FOR DELETE --Hành động xóa
		AS 
		IF EXISTS (SELECT * FROM Deleted WHERE DCHI LIKE '%HCM%')
		BEGIN
			PRINT N'Không thể xóa nhân viên ở HCM.';
			ROLLBACK TRANSACTION;
		END

	--Kiểm tra trigger
		SELECT * FROM dbo.NHANVIEN

		DELETE FROM dbo.NHANVIEN WHERE MANV = N'001' -- Tạo thêm 1 bản ghi mới mã 123

-----------------------------------------------------------------------------
--3. Viết trigger đếm số lượng nhân viên bị xóa khi thực hiện xóa các nhân viên ở TP HCM
			CREATE TRIGGER SoLuong_NV_Delete
			ON NhanVien
			FOR DELETE
			AS 
			DECLARE @Num INT;
			SELECT @Num = COUNT(*) FROM Deleted WHERE DCHI LIKE N'%HCM*';
			PRINT N'Tổng số nhân viên ở TP HCM bị xóa: ' + CAST(@Num AS Varchar);

			--Kiểm tra trigger
			SELECT * FROM dbo.NHANVIEN
			DELETE FROM dbo.NHANVIEN WHERE MANV = N'001';



--A. TRIGGER AFTER
--Viết trigger đếm số lượng nhân viên bị xóa khi có câu lệnh xóa trên bảng nhân viên
	Create Trigger AFTER_DELETE_NV
	On NhanVien
	After Delete
	As
		Begin
			Declare @Num nchar;
			Select @Num = COUNT(*) From deleted
			Print N'Số lượng nhân viên đã xóa = ' + @Num
		End
		--Kiểm tra
	Delete from NhanVien Where MaNV = '007'


--B. Trigger INSTEAD OF

--1. Xóa nhân viên có mã 017, các thân nhân của nhân viên này tự động bị xóa theo trên bảng thân nhân


			CREATE TRIGGER Delete_NV_NhanThan
			ON NhanVien
			INSTEAD OF DELETE
			AS
				BEGIN
					DELETE FROM dbo.THANNHAN WHERE MA_NVIEN IN (SELECT MANV FROM deleted) --Xóa nhân thân của nhân viên trong bảng thân nhân
					DELETE FROM dbo.NHANVIEN Where MANV in (Select MANV From deleted) --Xóa nhân viên trong bảng chính thức của nhân viên 
				End
			--Kiểm tra
			Delete From NhanVien Where MANV Like '017'

--2. Viết trigger xóa các thân nhân có liên quan đến nhân viên khi nhân viên bị xóa trong bảng nhân viên
			CREATE TRIGGER Delete_ThanNhan_NV
			ON NhanVien
			INSTEAD OF DELETE
			AS 
			DELETE FROM dbo.THANNHAN WHERE MA_NVIEN IN (SELECT MANV FROM deleted)
			DELETE FROM dbo.NHANVIEN Where MANV in (Select MANV From deleted)

			DELETE FROM dbo.NHANVIEN WHERE MANV = N'007'
	-----------

		CREATE TRIGGER MUCLUONG
		ON NhanVien
		FOR INSERT
		AS 
		IF (SELECT LUONG FROM Inserted) < 15000
			BEGIN
				PRINT N'Lương tối thiểu phải từ 5000.';
				ROLLBACK TRANSACTION;
			END
			INSERT INTO dbo.NHANVIEN VALUES (N'BUI',N'THE',N'HUY',N'018','2003-11-11',N'P 506 HOANG MAI',N'Nam','71000',N'002','5');
			SELECT * FROM NHANVIEN
---- RÀNG BUỘC  18<= TUỔI<= 65
--2. Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.

			CREATE TRIGGER TR_Insert_Tuoi_18_65
			ON NhanVien
			FOR INSERT 
			AS 

			DECLARE @Tuoi INT
			--ALTER
			SELECT @Tuoi = DATEDIFF(YEAR,NGSINH,GETDATE()) + 1 FROM inserted;
			IF @Tuoi < 18 OR @Tuoi > 65

			BEGIN

			PRINT N'Tuổi của nhân viên không hợp lệ 18 <= Tuổi >= 65.';
			ROLLBACK TRANSACTION;

			END

				--Kiểm tra hoạt động của trigger
				SELECT * FROM dbo.NHANVIEN
				SELECT NGSINH = DATEDIFF(YEAR,NGSINH,GETDATE()) FROM dbo.NHANVIEN

				INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'098','07-06-2004',N'Cầu Giấy, Hà Nội',N'Nam',25000,N'005',1);
				INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'098','07-06-2003',N'Cầu Giấy, Hà Nội',N'Nam',25000,N'005',1);

--3. Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM

				CREATE TRIGGER TR_Update_DCHI_HCM
				ON NhanVien
				FOR UPDATE
				AS 

				IF EXISTS (SELECT DCHI FROM inserted WHERE DCHI LIKE N'%HCM%')

				BEGIN
					PRINT N'Không thể cập nhật nhân viên ở HCM';
					ROLLBACK TRANSACTION;
				END;

				--Kiểm tra hoạt động của trigger
				SELECT * FROM dbo.NHANVIEN

				UPDATE NHANVIEN
				   SET PHAI = N'Nam'
					WHERE MANV = N'001'


--BÀI 02: Viết các Trigger AFTER:
--1. Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động thêm mới nhân viên.

			CREATE TRIGGER TR_Insert_Sum_Nu_Nam
			ON NhanVien
			AFTER INSERT

			AS 

			DECLARE @Nam INT, @Nu INT;

			SELECT @Nu = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nữ';
			SELECT @Nam = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nam';

			PRINT N'Tổng số nhân viên giới tính Nữ là: ' + CAST(@Nu AS NVARCHAR);
			PRINT N'Tổng số nhân viên giới tính Nam là: ' + CAST(@Nam AS NVARCHAR);

				-- Kiểm tra trigger
				INSERT INTO dbo.NHANVIEN VALUES (N'Trần',N'Thanh',N'Long',N'098','07-06-2004',N'Cầu Giấy, Hà Nội',N'Nam',25000,N'005',1);
				SELECT * FROM dbo.NHANVIEN

--2. Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động cập nhật phần giới tính nhân viên

			CREATE TRIGGER TR_Update_Sum_Nu_Nam
			ON NhanVien
			AFTER UPDATE
			AS 

			IF (SELECT TOP 1 PHAI FROM deleted) != (SELECT TOP 1 PHAI FROM inserted)
			BEGIN
					DECLARE @Nu INT, @Nam INT;
					SELECT @Nu = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nữ';
					SELECT @Nam = COUNT(MANV) FROM NHANVIEN WHERE PHAI = N'Nam';

					PRINT N'Tổng số nhân viên giới tính Nữ là: ' + CAST(@Nu AS NVARCHAR);
					PRINT N'Tổng số nhân viên giới tính Nam là: ' + CAST(@Nam AS NVARCHAR);
			END;

					--Kiểm tra hoạt động của Trigger
					SELECT * FROM dbo.NHANVIEN

						UPDATE NHANVIEN
						   SET PHAI = N'Nam'
							WHERE MANV = N'001'


--3. Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng DEAN

					CREATE TRIGGER TR_Sum_Delete_DEAN
					ON DeAn
					AFTER DELETE
					AS 

					SELECT MA_NVIEN, COUNT(MADA) AS N'Tổng số đề án nhân viên đã làm: ' FROM dbo.PHANCONG
					GROUP BY MA_NVIEN

					--Kiểm tra trigger (chú ý: Do ràng buộc => báo lỗi)

					DELETE FROM dbo.DEAN WHERE MADA LIKE N'30'

					SELECT * FROM dbo.PHANCONG
					SELECT * FROM dbo.DEAN

--BÀI 03: Viết các Trigger INSTEAD OF

--1. Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân viên trong bảng nhân viên
--Sinh viên thao khảo bài lý thuyết thầy đã thực hiện

--2. Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA là 1

		CREATE TRIGGER TR_Insert_Instead_of_NV
		ON NhanVien
		Instead of INSERT
		AS
		 BEGIN
			DECLARE @maNV CHAR(5)= (SELECT Inserted.MaNV FROM Inserted)
			INSERT INTO PhanCong( MaNV, MaDA, STT, ThoiGian ) VALUES (@maNV,1 ,1 ,15.00)
		 END
		GO

		INSERT INTO dbo.NhanVien VALUES  ( N'Nguyễn' , N'Thị' , N'Thu' ,  N'019' , '1998-12-11' , N'Vĩnh Phúc' , N'Nu' , 19000 , null , 1 );
		GO
		 SELECT * FROM dbo.PhanCong





