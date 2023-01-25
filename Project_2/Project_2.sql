-- Create new schema as alumni
CREATE DATABASE alumni;
USE alumni;

-- Q.2. Import all .csv files into MySQL
-- all files imported into Mysql --

-- Q.3. Run SQL command to see the structure of six tables
desc college_a_hs;
desc college_a_se;
desc college_a_sj;
desc college_b_hs;
desc college_b_se;
desc college_b_sj;

-- Q.4. Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) with Python.
-- Please refer ipynb file --

-- 5.Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) into MS Excel.
-- files imported in ms-excel(kindly refer excel sheet)

-- 6.Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 

CREATE VIEW College_A_HS_V AS
    SELECT 
        *
    FROM
        college_a_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;

-- 7.Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.

CREATE VIEW College_A_SE_V AS
    SELECT 
        *
    FROM
        college_a_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;

-- 8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.

CREATE VIEW College_A_SJ_V AS
    SELECT 
        *
    FROM
        college_a_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;

-- 9.Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.

CREATE VIEW College_B_HS_V AS
    SELECT 
        *
    FROM
        college_b_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;

-- 10.Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.

CREATE VIEW College_B_SE_V AS
    SELECT 
        *
    FROM
        college_b_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;

-- 11.Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.

CREATE VIEW College_B_SJ_V AS
    SELECT 
        *
    FROM
        college_b_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;
            
/* Q.12. Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views 
		(College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) */

delimiter $
create procedure V1()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_HS_V;
end $
delimiter ;

call V1();

delimiter $
create procedure V2()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_SE_V;
end $
delimiter ;

call V2();

delimiter $
create procedure V3()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_SJ_V;
end $
delimiter ;

call V3();

delimiter $
create procedure V4()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_B_HS_V;
end $
delimiter ;

call V4();

delimiter $
create procedure V5()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_SE_V;
end $
delimiter ;

call V5();

delimiter $
create procedure V6()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_B_SJ_V;
end $
delimiter ;

call V6();

/* Q.13. Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
		 into MS Excel and make pivot chart for location of Alumni. */ 
-- pivotchart created--(refer exdcel sheet)

-- 14.Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.

delimiter $$
create  procedure get_name_collegeA(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from college_b_hs
		union
		select Name from college_a_se
		union
		select Name from college_a_sj;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name_collegeA(@l);
select @l student_names_get_name_collegeA;

-- 15.Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.

delimiter $$
create  procedure get_name_collegeB(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from college_b_hs
		union
		select Name from college_b_se
		union
		select Name from college_b_sj;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name_collegeB(@l);
select @l student_names_get_name_collegeB;

-- 16.Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.
select ((select count(*) from college_a_hs) + (select count(*) from college_a_se) + (select count(*) from college_a_sj)) total_of_college_a;
select ((select count(*) from college_b_hs) + (select count(*) from college_b_se) + (select count(*) from college_b_sj)) total_of_college_b;

SELECT 
    'Higher Studies',
    (SELECT 
            ROUND(COUNT(*) / 5887 * 100, 4)
        FROM
            college_a_hs) 'College A Percentage',
    (SELECT 
            ROUND(COUNT(*) / 2259 * 100, 4)
        FROM
            college_b_hs) 'College B Percentage'

UNION SELECT 
    'Self Employeed',
    (SELECT 
            ROUND(COUNT(*) / 5887 * 100, 4)
        FROM
            college_a_se) 'College A Percentage',
    (SELECT 
            ROUND(COUNT(*) / 2259 * 100, 4)
        FROM
            college_b_se) 'College B Percentage'

UNION SELECT 
    'Service Job',
    (SELECT 
            ROUND(COUNT(*) / 5887 * 100, 4)
        FROM
            college_a_sj) 'College A Percentage',
    (SELECT 
            ROUND(COUNT(*) / 2259 * 100, 4)
        FROM
            college_b_sj) 'College B Percentage';
