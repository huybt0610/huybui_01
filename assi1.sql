create database QLNT_HUYBTPH26874
-----TẠO BẢNG
--- BẢNG LOẠI NHÀ
if OBJECT_ID('loaiNha') is not null
drop table loaiNha
GO

create table loaiNha(
MaLN nvarchar(10) primary key,
TenLN nvarchar(150)
)

----BẢNG NGƯỜI DÙNG
if OBJECT_ID('nguoiDung') is not null
drop table nguoiDung
go
create table nguoiDung(
MaND nvarchar(20) primary key,
TenND nvarchar(150),
GioiTinh nvarchar(15),
DienThoai nvarchar(10),
DiaChi nvarchar(150),
Quan nvarchar(10),
Email nvarchar(30),

)
------BẢNG NHÀ TRỌ 
if OBJECT_ID('nhaTro') is not null
drop table nhaTro
go

create table nhaTro(
MaNhaTro nvarchar(10) primary key,
MaLN nvarchar(10),
DienTich nvarchar(30),
GiaPhong money,
DiaChinha nvarchar(150),
Quan nvarchar(10),
MoTa nvarchar(150),
NgayDang datetime null,
NguoiLH nvarchar (20),
foreign key (MaLN) references loaiNha,
foreign key (NguoiLH) references nguoiDung


)

-----BẢNG ĐÁNH GIÁ
if OBJECT_ID('danhGia') is not null
drop table danhGia
go

create table danhGia(
nguoiDG nvarchar(20) ,
MaNhaTro nvarchar(10) ,
Likes nvarchar(10),
Noidung nvarchar(150),
foreign key (MaNhaTro) references  nhaTro,
foreign key (nguoiDG) references nguoiDung,
  CONSTRAINT PK_DANHGIA PRIMARY KEY (MANHATRO,nguoiDG)

)


-----------CHÈN DỮ LIỆU
---BẢNG LOẠI NHÀ
insert into loaiNha values
('NHA01',N'Chung cư'),
('NHA02',N'Biệt thự'),
('NHA03',N'Ký túc'),
('NHA04',N'Căn hộ cao cấp'),
('NHA05',N'Nhà trọ'),
('NHA06',N'nhà trọ'),
('NHA07',N'Chung cư'),
('NHA08',N'Vin home'),
('NHA09',N'Nhà trọ'),
('NHA010',N'Chung cư')

------BẢNG NGƯỜI DÙNG
insert into nguoiDung values
('NGDUNG01',N'Cao Đức Việt','nam','098684456',N'Thái Bình',N'Cầu Giấy','vietcdph26889@gmail.com'),
('NGDUNG02',N'Bùi Trúc Quỳnh','nữ','0986844234',N'vĩnh yên',N'Dịch Vọng','quynhbt26435@gmail.com'),
('NGDUNG03',N'Bùi Văn Trường','nam','0986844876',N'hải phòng',N'Cổ Nhuế','truongbv36462@gmail.com'),
('NGDUNG04',N'Ngô Ngọc Văn','nam','0986844579',N'vĩnh yên',N'Hồ Tùng Mậu','vannn364323@gmail.com'),
('NGDUNG05',N'Bùi Thế Huy','nam','0986844235',N'Thái Bình',N'Cầu Diễn','huybt36233@gmail.com'),
('NGDUNG06',N'Đặng Đức Thành','nam','0986844852',N'Sơn Tây',N'Phú Diễn','thanhđ26672@gmail.com'),
('NGDUNG07',N'Trịnh Thị Uyên','nữ','0986843574',N'hòa nình',N'Mỹ Đình','uyentt63332@gmail.com'),
('NGDUNG08',N'Lê Hồng Ngọc','nữ','0986847274',N'Bắc Giang',N'Nguyễn Hoàng','ngoclh66362@gmail.com'),
('NGDUNG09',N'Trần Anh Thư','nữ','0986849874',N'hưng yên',N'Cầu Giấy','thuta262367@gmail.com'),
('NGDUNG010',N'Trần Hải Ly','nữ','0986841256',N'phú thọ',N'Cầu Giấy','lyth372773@gmail.com')

----BẢNG NHÀ TRỌ 
insert into nhaTro values

('NHTR01',N'NHA03',100,100000000,N'xã Hiền Ninh, huyện Sóc Sơn, Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG01'),
('NHTR02',N'NHA03',70,50000000,N'nam từ liêm , Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG02'),
('NHTR03',N'NHA03',20,2000000,N'bắc từ liêm, Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG03'),
('NHTR04',N'NHA03',1000,2500000,N'hà đông,Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG04'),
('NHTR05',N'NHA03',1000,1000000,N'phạm văn đồng, Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG05'),
('NHTR06',N'NHA03',1000,1500000,N'hoàng quốc việt, Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG06'),
('NHTR07',N'NHA03',120,9000000,N'lê đức thọ, Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG07'),
('NHTR08',N'NHA03',150,1000000,N'hồ tùng mậu, Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG08'),
('NHTR09',N'NHA03',50,4500000,N'đào tấn, Hà Nội',N'Cầu Giấy',N'Rộng rãi,thoáng moát,...','05/29/2022','NGDUNG09'),
('NHTR010',N'NHA03',20,1200000,N'xã Hiền Ninh, huyện Sóc Sơn, Hà Nội',N'Cầu Giấy',N'không gian nhỏ, chật...','05/29/2022','NGDUNG010')
----BẢNG ĐÁNH GIÁ
insert into danhGia values
('NHTR01','NGDUNG01','like',N'Đúng như mô tả'),
('NHTR02','NGDUNG01','like',N'Đúng như mô tả'),
('NHTR03','NGDUNG01','dislike',N'không giống như mô tả'),
('NHTR04','NGDUNG01','like',N'Đúng như mô tả'),
('NHTR05','NGDUNG01','dislike',N'khác mô tả'),
('NHTR06','NGDUNG01','like',N'Đúng như mô tả'),
('NHTR07','NGDUNG01','dislike',N'khác trong ảnh'),
('NHTR08','NGDUNG01','dislike',N'Đúng như mô tả'),
('NHTR09','NGDUNG01','like',N'Đúng như mô tả')


select* from loaiNha
select* from nguoiDung
select* from nhaTro
select * from danhGia