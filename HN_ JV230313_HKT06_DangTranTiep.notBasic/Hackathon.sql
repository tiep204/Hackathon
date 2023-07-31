create database HACKATHON06;
use HACKATHON06;
create table dmkhoa
(
    MaKhoa  varchar(20) primary key,
    TenKhoa varchar(255)
);

create table dmnganh
(
    MaNganh  int auto_increment primary key,
    TenNganh varchar(255),
    MaKhoa   varchar(20) not null,
    foreign key (MaKhoa) references dmkhoa (MaKhoa)
);

create table dmhocphan
(
    MaHP    int primary key auto_increment,
    TenHP   varchar(255),
    Sodvht  int,
    MaNganh int not null,
    HocKy   int not null,
    foreign key (MaNganh) references dmnganh (MaNganh)
);

create table dmlop
(
    MaLop      varchar(20) primary key,
    TenLop     varchar(255),
    MaNganh    int not null,
    KhoaHoc    int,
    HeDT       varchar(255),
    NamNhapHoc int,
    foreign key (MaNganh) references dmnganh (MaNganh)
);

create table sinhvien
(
    MaSV     int primary key auto_increment,
    HoTen    varchar(255),
    MaLop    varchar(20) not null,
    GioiTinh tinyint(1),
    NgaySinh date,
    DiaChi   varchar(255),
    foreign key (MaLop) references dmlop (MaLop)
);

create table dienhp
(
    MaSV   int not null,
    MaHP   int not null,
    DiemHP float,
    foreign key (MaSV) references sinhvien (MaSV),
    foreign key (MaHP) references dmhocphan (MaHP)
);

-- 	Thêm dữ liệu vào các bảng như sau:
--  1.	dmkhoa
insert into dmkhoa
values ('CNTT', 'Công nghệ thông tin'),
       ('KT', 'Kế Toán'),
       ('SP', 'Sư Phạm');

-- 2.	dmnganh
insert into dmnganh
values (140902, 'Sư phạm toán tin ', 'SP'),
       (480202, 'Tin học ứng dụng', 'CNTT');

-- 3.	dmlop
insert into dmlop
values ('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
       ('CT12', 'Cao đẳng tin học', 480202, 12, 'CĐ', 2013),
       ('CT13', 'Cao đẳng tin học', 480202, 13, 'TC', 2014);

-- 4.	dmhocphan
insert into dmhocphan
values (1, 'Toán cao cấp A1', 4, 480202, 1),
       (2, 'Tiếng anh 1', 3, 480202, 1),
       (3, 'Vật lý đại cương', 4, 480202, 1),
       (4, 'Tiếng anh 2', 7, 480202, 1),
       (5, 'Tiếng anh 1', 3, 140902, 2),
       (6, 'Xác Xuất thống kê', 3, 480202, 2);

-- 5.	sinhvien
insert into sinhvien
values (1, 'Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
       (2, 'Nguyễn Thi Cấm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
       (3, 'võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
       (4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
       (5, 'Tran Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạch'),
       (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
       (7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù mỹ'),
       (8, 'Nguyễn Van Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
       (9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

-- 6.	diemhp

insert into dienhp
values (2, 2, 5.9),
       (2, 3, 4.5),
       (3, 1, 4.3),
       (3, 2, 6.7),
       (3, 3, 7.3),
       (4, 1, 4),
       (4, 2, 5.2),
       (4, 3, 3.5),
       (5, 1, 9.8),
       (5, 2, 7.9),
       (5, 3, 7.5),
       (6, 1, 6.1),
       (6, 2, 5.6),
       (6, 3, 4),
       (7, 1, 6.2);


-- 1.	 Cho biết họ tên sinh viên KHÔNG học học phần nào (5đ)\
select MaSV, HoTen
from sinhvien
where MaSV not in (select sv.MaSV
                   from sinhvien sv
                            join dienhp d on sv.MaSV = d.MaSV);

-- 2.	Cho biết họ tên sinh viên CHƯA học học phần nào có mã 1 (5đ)

select MaSV, HoTen
from sinhvien
where MaSV not in (select sv.MaSV
                   from sinhvien sv
                            join dienhp d on sv.MaSV = d.MaSV
                   where MaHP = 1);

-- 3.	Cho biết Tên học phần KHÔNG có sinh viên điểm HP <5. (5đ)
select MaHP, TenHP
from dmhocphan
where MaHP not in (select d2.MaHP
                   from dienhp d2
                   where DiemHP < 5);

-- 4.	Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5 (5đ)


select MaSV, HoTen
from sinhvien
where MaSV not in (select d.MaSV
                   from sinhvien sv
                            join dienhp d on sv.MaSV = d.MaSV
                   where DiemHP < 5);

-- 5.	Cho biết Tên lớp có sinh viên tên Hoa (5đ)
select TenLop
from sinhvien sv
         join dmlop d on d.MaLop = sv.MaLop
where sv.HoTen like '%Hoa';

-- 6.	Cho biết HoTen sinh viên có điểm học phần 1 là <5.

select d.MaSV, HoTen
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
where MaHP = 1
  and DiemHP < 5;

-- 7.	Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị học trình của học phần mã 1
select MaHP, TenHP, Sodvht, MaNganh, HocKy
from dmhocphan
where Sodvht >= (select Sodvht from dmhocphan where MaHP = 1);

-- 8.	Cho biết HoTen sinh viên có DiemHP cao nhất. (ALL)

SELECT sv.MaSV, sv.HoTen, d.MaHP, d.DiemHP
FROM sinhvien sv
         JOIN dienhp d ON sv.MaSV = d.MaSV
WHERE d.DiemHP = all (SELECT MAX(DiemHP) FROM dienhp);

-- 9.	Cho biết MaSV, HoTen sinh viên có điểm học phần mã 1 cao nhất. (ALL)
SELECT sv.MaSV, sv.HoTen
FROM sinhvien sv
         JOIN dienhp d ON sv.MaSV = d.MaSV
WHERE d.DiemHP = all (SELECT MAX(DiemHP) FROM dienhp where d.MaHP = 1);

-- 10.	Cho biết MaSV, MaHP có điểm HP lớn hơn bất kì các điểm HP của sinh viên mã 3 (ANY).

SELECT MaSV, MaHP
FROM dienhp
WHERE DiemHP > ANY (SELECT DiemHP FROM dienhp WHERE MaSV = '3');

-- 11.	Cho biết MaSV, HoTen sinh viên ít nhất một lần học học phần nào đó. (EXISTS)

SELECT MaSV, HoTen
FROM sinhvien sv
WHERE EXISTS(SELECT 1 FROM dienhp dh WHERE dh.MaSV = sv.MaSV);

-- 12.	Cho biết MaSV, HoTen sinh viên đã không học học phần nào. (EXISTS)

select MaSV, HoTen
from sinhvien sv
where not exists(select 0 from dienhp dh where dh.MaSV = sv.MaSV);

-- 13.	Cho biết MaSV đã học ít nhất một trong hai học phần có mã 1, 2.

select MaSV
from dienhp
where MaHP in (1, 2)
group by MaSV;

-- 14.	Tạo thủ tục có tên KIEM_TRA_LOP cho biết HoTen sinh viên KHÔNG có điểm HP <5 ở
-- lớp có mã chỉ định (tức là tham số truyền vào procedure là mã lớp). Phải kiểm tra MaLop
-- chỉ định có trong danh mục hay không, nếu không thì hiển thị thông báo
-- ‘Lớp này không có trong danh mục’. Khi lớp tồn tại thì đưa ra kết quả. Ví dụ gọi thủ tục: Call KIEM_TRA_LOP(‘CT12’).

DELIMITER //
CREATE PROCEDURE KIEM_TRA_LOP(IN ma1lop VARCHAR(20))
BEGIN
    DECLARE countLop INT;
    SELECT COUNT(*) INTO countLop FROM dmlop WHERE MaLop = ma1lop;
    IF countLop = 0 THEN
        SELECT 'Lớp này không có trong danh mục' AS KetQua;
    ELSE
        SELECT * FROM sinhvien WHERE MaLop = ma1lop;
    END IF;
END //
DELIMITER ;
call KIEM_TRA_LOP('CT12');

-- 15.	Tạo một trigger để kiểm tra tính hợp lệ của dữ liệu nhập vào bảng sinhvien là MaSV không được rỗng
--  Nếu rỗng hiển thị thông báo ‘Mã sinh viên phải được nhập’.

DELIMITER //
CREATE TRIGGER tr_kiem_tra_MaSV
    BEFORE INSERT ON sinhvien
    FOR EACH ROW
BEGIN
    IF NEW.MaSV IS NULL OR NEW.MaSV = '' or NEW.MaLop is null THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Mã sinh viên phải được nhập';
    END IF;
END //
DELIMITER ;
drop trigger tr_kiem_tra_MaSV;
INSERT INTO sinhvien ( HoTen) VALUES ('Nguyễn Văn A');

-- 16.	Tạo một TRIGGER khi thêm một sinh viên trong bảng sinhvien ở một lớp nào đó thì cột SiSo của
-- lớp đó trong bảng dmlop (các bạn tạo thêm một cột SiSo trong bảng dmlop) tự động tăng lên 1, đảm bảo tính toàn
-- vẹn dữ liệu khi thêm một sinh viên mới trong bảng sinhvien thì sinh viên đó phải có mã lớp trong bảng dmlop.
-- Đảm bảo tính toàn vẹn dữ liệu khi thêm là mã lớp phải có trong bảng dmlop.








