--quere เบื้องต้นไว้ทดสอบกับอาจารย์

-- เรียกดูข้อมูลทั้งหมดในตาราง
Select * from customer;
SELECT * From 

--ลบข้อมูลในตารางทั้งหมด
DELETE FROM receipt;
Delete from ;

--จอยทุกตารางรวมกัน
use petsalonDB;
go

--จอยทุกตารางรวมกัน
select 
    e.employee_id,
    e.full_name as employee_name,
    a.appointment_id,
    a.start_time,
    a.status,
    p.pet_name,
    p.species,
    c.full_name as customer_name,
    s.service_name,
    aps.price as service_price,
    r.receipt_id,
    r.total_amount,
    r.payment_method
from customer c
inner join pet p on c.customer_id = p.customer_id
inner join appointment a on p.pet_id = a.pet_id
inner join appointment_service aps on a.appointment_id = aps.appointment_id
inner join service s on aps.service_id = s.service_id
left join receipt r on a.appointment_id = r.appointment_id
right join Employee e on a.employee_id = e.employee_id;

--รีเซ็ตตัวนับ ID  กลับไปเริ่มนับ 1 กรณีที่คิวไปรอบนึงแล้ว
DBCC CHECKIDENT ('receipt', RESEED, 0);
DBCC CHECKIDENT ('-------', RESEED, 0);


-- เลือกดูเฉพาะคอลัมน์ที่ต้องการจะเห็น
select full_name, phone from customer;

Select - From - 

-- กรองข้อมูลตามเงื่อนไข (WHERE)
select * From pet 
Where species = N'หมา';

SELECT * from appointment 
where status = N'เสร็จสิ้น';

select * From service 
WHERE price > 300;
 
select*from 
where

--เรียงลำดับข้อมูล (ORDER BY)
select * from service 
order BY price desc;

Select * From customer 
Order by full_name asc;


--คำนวณสรุปผลข้อมูล (COUNT, SUM, AVG)
SELECT count(*) as total_pets From pet;

select sum(total_amount) As total_revenue from receipt;

Select avg(price) as avg_price From service;


-- 6. เชื่อมตารางดึงข้อมูลมารวมกันJOIN ตาราง
-- ดูชื่อสัตว์เลี้ยงพร้อมชื่อเจ้าของสัตว์เลี้ยง
select 
    p.pet_id,p.pet_name,
    p.species,
    c.full_name as owner_name,c.phone
from pet p
inner join customer c On p.customer_id = c.customer_id;


-- ดูรายละเอียดใบนัดหมาย
Select 
    a.appointment_id, p.pet_name,
    e.full_name As employee_name,a.start_time,
    a.status
From appointment a
Join pet p ON a.pet_id = p.pet_id
join Employee e on a.employee_id = e.employee_id;


-- ออกรายงานประวัติการชำระเงิน
SELECT 
    r.receipt_id,
    r.issue_date,
    c.full_name As customer_name,
    p.pet_name,
    r.total_amount,
    r.payment_method
from receipt r
Inner Join appointment a On r.appointment_id = a.appointment_id
join pet p on a.pet_id = p.pet_id
Inner Join customer c ON p.customer_id = c.customer_id;
