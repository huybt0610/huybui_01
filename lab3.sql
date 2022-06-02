---bai 1
use QLDA
select TENDEAN,sum(ThoiGian) from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN

use QLDA
select TENDEAN,cast(Sum(ThoiGian) as decimal(5,2)) from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN

use QLDA
select TENDEAN,cast(Sum(ThoiGian) as varchar(10)) from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN

use QLDA
select TENDEAN,CONVERT(decimal(5,2) , sum(ThoiGian)) from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN

use QLDA
select TENDEAN,CONVERT(varchar(10), sum(ThoiGian)) from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN


select TENPHG , AVG(Luong) as 'Luong tb' from PHONGBAN
join NHANVIEN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

select TENPHG ,CAST( AVG(Luong) as decimal(10,2)) as 'Luong tb' from PHONGBAN
join NHANVIEN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

select TENPHG ,CONVERT(decimal(10,2), AVG(Luong)) as 'Luong tb' from PHONGBAN
join NHANVIEN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

select TENPHG ,CAST( AVG(Luong) as varchar(10)) as 'Luong tb',
LEFT (cast(avg(luong) as varchar(10)),3)+
REPLACE(CAST( AVG(Luong) as varchar(10)),LEFT (cast(avg(luong) as varchar(10)),3),',')

from PHONGBAN
join NHANVIEN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

select TENPHG ,CONVERT(varchar(10), AVG(Luong)) as 'Luong tb' from PHONGBAN
join NHANVIEN on NHANVIEN.PHG=PHONGBAN.MAPHG
group by TENPHG

--bai 2
select TENDEAN,sum(Thoigian) as 'tong gio',
ceiling (sum(Thoigian)) as 'tong gio moi'
from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN

select TENDEAN,sum(Thoigian) as 'tong gio',
floor (sum(Thoigian)) as 'tong gio moi'
from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN

select TENDEAN,sum(Thoigian) as 'tong gio',
round (sum(Thoigian),1) as 'tong gio moi'
from DEAN
join CONGVIEC on CONGVIEC.MADA=DEAN.MADA
join PHANCONG on PHANCONG.MADA=DEAN.MADA
group by TENDEAN

select ROUND( AVG(luong),2) from NHANVIEN
join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG
where TENPHG=N'Nghiên cứu'

select HONV+'' +TENLOT+''+TENNV,LUONG from NHANVIEN
where LUONG >=(select ROUND( AVG(luong),2) from NHANVIEN
join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG
where TENPHG=N'Nghiên cứu')
---bai3
select UPPER( HONV) AS ' HONV' , LOWER (TENLOT) AS ' TENLOT',
LOWER ( LEFT(TENNV,1)) + UPPER(SUBSTRING (TENNV, 2,1)) + SUBSTRING(TENNV,3,LEN(TENNV)-2),TENNV
, DCHI ,COUNT (MA_NVIEN) AS 'SO THAN NHAN'
from NHANVIEN join THANNHAN on  THANNHAN.MA_NVIEN = NHANVIEN.MANV
group by HONV , TENLOT, TENNV , DCHI 
having COUNT (MA_NVIEN) >= 2

-- bai 4
SELECT * FROM NHANVIEN
WHERE YEAR(NGSINH) >=  1960 AND YEAR (NGSINH) <= 1965

SELECT * FROM NHANVIEN
WHERE YEAR (NGSINH) BETWEEN 1960 AND  1965 

SELECT *,  YEAR(GETDATE()) - YEAR(NGSINH) AS 'TUOI ' FROM NHANVIEN
  