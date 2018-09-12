
-- import name/clock pairs..
-- unique index on name+clock means that duplicates will silently be ignored..



-- LOAD DATA LOCAL 
-- INFILE "/home/file/import1/Enterprise_employee_schedulelisting.txt" \
-- INTO TABLE hrdb.employees FIELDS TERMINATED BY ',' \
-- optionally enclosed by '\"' escaped by '\\' LINES TERMINATED BY '\r\n' (@cola,@colb,@colc,@cold,@cole,@colf,@colg,@colh,@coli,@colj) \
-- set clock=lpad(@cola,5,0), name=@colb ;

insert ignore into  hrdb.employees ( clock,name )
  select 
    clock,name
      from  lukup.emp_enterprise   ;  





-- mark z status employees - left the company, as inactive..
use hrdb;


-- update employees e1  
-- join  emp_enterprise as e2
-- on e1.clock = e2.clock  COLLATE utf8_general_ci
-- set e1.active=2
-- where       e2.status = 'z';

-- removed collate...   pmdsdata4 requires it. hmm..
update employees e1  
join  emp_enterprise as e2
on e1.clock = e2.clock  
set e1.active=2
  where
      e2.status = 'z';


            
      
-- mark older duplicate clock number entries as inactive. the highest id number will be active. These will be a choice for new records..

-- removed.. COLLATE utf8_general_ci
update employees e1  
  join  employees as e2
    on e1.clock = e2.clock  
set e1.active=3 
  where
      e1.id <  e2.id AND  e1.clock=e2.clock ;


	  
-- 2018-06-27 mark returned employees at active so - a status in emp_enterprise should be active in employees again. 
update employees e1  
join  emp_enterprise as e2
on e1.clock = e2.clock  
set e1.active=1
  where
      e2.status = 'A';

 
 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-- import name/clock pairs..
-- unique index on name+clock means that duplicates will silently be ignored..




-- LOAD DATA LOCAL 
-- INFILE "/home/file/import1/Enterprise_employee_schedulelisting.txt" \
-- INTO TABLE hrdb.stf_employees FIELDS TERMINATED BY ','  \
-- optionally enclosed by '\"' escaped by '\\' LINES TERMINATED BY '\r\n' (@cola,@colb,@colc,@cold,@cole,@colf,@colg,@colh,@coli,@colj) \
-- set clocknum=lpad(@cola,5,0), name=@colb ;

insert ignore into  hrdb.stf_employees ( clocknum,name )
  select 
    clock,name
      from  lukup.emp_enterprise   ;  




-- mark z status employees - left the company, as inactive..
use hrdb;

update stf_employees e1  
join  emp_enterprise as e2
on e1.clocknum = e2.clock  COLLATE utf8_general_ci
set e1.active_status=2
  where
      e2.status = 'z';

	  
-- 2018-06-27 mark returned employees at active so - a status in emp_enterprise should be active in employees again. 
update stf_employees e1  
join  emp_enterprise as e2
on e1.clock = e2.clock  
set e1.active=1
  where
      e2.status = 'A';
      
      
-- mark older duplicate clock number entries as inactive. the highest id number will be active. These will be a choice for new records..

update stf_employees e1  
  join  stf_employees as e2
    on e1.clocknum = e2.clocknum  COLLATE utf8_general_ci
set e1.active_status=3 
  where
      e1.id <  e2.id AND  e1.clocknum=e2.clocknum ;
  