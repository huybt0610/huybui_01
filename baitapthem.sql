-----1.Chuyển đổi ngầm trong sql
SELECT 10 * .6
SELECT 1232.8768*3
SELECT 25 * .5 
SELECT 23*5.0
SELECT 1.0*.10
--------2.CHUYỂN ĐỔI TƯỜNG MINH SỬ DỤNG HÀM CAST
--- cú pháp: CAST(bieuthuc AS kieudulieu [(do_dai)])
SELECT CAST(97.89 AS int);
--- chuyển đổi về kiểu int
SELECT CAST(161.122 AS float);
-- chuyển về kiểu f
SELECT CAST(212.3443 AS varchar(4));
-- chuyển về kiểu chuỗi
SELECT CAST('116.22' AS float);
---- chuyển về kiểu sô thực
SELECT CAST('2022-05-21' AS datetime);
---chuyển về kiểu ngày giờ
--------3.Thực hiện chuyển đổi từng minh sử dụng hàm CONVERT
--- cú pháp: CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
SELECT CONVERT(int, 89.5);
--- cắt bỏ phần thập phân
SELECT CONVERT(float, 67.4);
-- chuyển sang kiểu dữ liệu số thực
SELECT CONVERT(varchar(6), 78.44);
---chuyển sang kiểu chuỗi
SELECT CONVERT(datetime, '05/21/2022');
---chuyển về kiểu ngày giờ
SELECT CONVERT(varchar, '05/21/2022', 101);
-- chuyển về ngày tháng năm
----------4.Thực hiện các hàm toán học (mỗi hàm ít nhất 3 bài): 
SELECT ABS(-80)

SELECT CEILING(21.1);

SELECT FLOOR(19-9.5);

SELECT ROUND(1.23456,1);

SELECT SQRT(25);

SELECT SQUARE(9)

SELECT SIN(PI()/ SQRT(9-5)) as [SIN(PI()/2)], COS(PI()/ROUND(1.23456,1)) as [COS(PI()/(1.2))],TAN(PI()/3) as [TAN(PI()/FLOOR(10-6.4))];
----------5. Thực hiện các hàm sử lý chuỗi (mỗi hàm ít nhất 3 bài)
----SUBSTRING('Chuỗi', Vị_trí, Số_lượng)
SELECT SUBSTRING('buitruong',2,3);
---LEFT('Chuỗi',Số_ký_tự)
SELECT LEFT('pham huong',2); 
----RIGHT('Chuỗi',Số_ký_tự)
SELECT RIGHT('fpolytechlich',5);
----LEN('Chuỗi')
SELECT LEN('tammao'); --sẽ trả về số 6
----UPPER('Chuỗi')
SELECT UPPER('buitruong'); --sẽ trả về: 'BUITRUONG'
 ----LTRIM('Chuỗi')
SELECT LTRIM('   hoicham   '); --sẽ trả về: 'hoicham   '
----RTRIM('Chuỗi')
SELECT RTRIM('   hoicham   '); -- trả về chuỗi: '   hoicham'
----ASCII('Ký_tự')
SELECT ASCII('A'); -- → 65
----replace
PRINT REPLACE('vvvannn', 'van', 'VAN'); --> In ra: vvVANnn

--------6. Thực hiện các hàm về thời gian
---GETDATE
SELECT GETDATE() AS [Thời gian hiện tại của hệ thống];
----DATEADD(DATEPART,number,date)