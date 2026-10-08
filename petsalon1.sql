-- คำสั่งสร้างตารางดาต้า pet salon ทั้งหมด
use master;
go


if exists (select name from sys.databases where name = N'petsalonDB')
begin
    alter database petsalonDB set single_user with rollback immediate;
    drop database petsalonDB;
end
go

create database petsalonDB;
go

alter database petsalonDB collate Thai_CI_AS;
go
use petsalonDB;
go

create table customer (
    customer_id int primary key identity(1,1),
    full_name nvarchar(100) not null,
    phone varchar(20) not null,
);

CREATE TABLE pet (
    pet_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    pet_name nVARCHAR(50) NOT NULL,
    species NVARCHAR(10) NOT NULL CHECK (species IN (N'หมา', N'แมว')),
    breed nVARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

create table Employee (
    employee_id int primary key identity(1,1),
    full_name nVarchar(100) not null,
    phone varchar(20)
);

CREATE TABLE service (
    service_id int primary key identity(1,1),
    service_name nvarchar(20) not null check (service_name in (N'อาบน้ำ', N'ตัดขน',N'ตัดเล็บ')),
    species nvarchar(10) not null check (species in (N'หมา', N'แมว')),
    price decimal(10,2) not null,
    unique(service_name, species)
);
create table appointment (
    appointment_id INT PRIMARY KEY IDENTITY(1,1),
    pet_id int NOT NULL,
    employee_id INT not null,
    start_time datetime NOT NULL,
    end_time DATETIME,
    status NVARCHAR(20) DEFAULT 'จองแล้ว' CHECK (status IN (N'จองแล้ว', N'กำลังทำ', N'เสร็จสิ้น', N'ยกเลิก')),
    foreign key (pet_id) references pet(pet_id),
    foreign key (employee_id) references Employee(employee_id)
);

CREATE TABLE appointment_service (
    appointment_id int,
    service_id int,
    price decimal(10,2) not null,
    primary key (appointment_id, service_id),
    foreign key (appointment_id) references appointment(appointment_id),
    foreign key (service_id) references service(service_id)
);

create table receipt (
    receipt_id int primary key identity(1,1),
    appointment_id int not null unique,
    issue_date datetime not null,
    total_amount decimal(10,2) not null,
    payment_method nvarchar(20) not null check (payment_method in (N'เงินสด', N'โอนเงิน', N'บัตรเครดิต')),
    foreign key (appointment_id) references appointment(appointment_id)
);
