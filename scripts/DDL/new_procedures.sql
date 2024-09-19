create or replace procedure Territory_Insert (p_Name_Territory varchar(100), p_Price_Territory decimal(2, 5))
language plpgsql
as $$
	begin
		insert into Territory (Name_Territory, Price_Territory)
		values (p_Name_Territory, p_Price_Territory);
		exception when others then
			raise notice 'Указанная территория уже есть в таблице!';
	end;
$$;

select * from territory;

select * from work_plan;

create or replace procedure Work_Plan_Insert(p_Work_Plan_Date date, p_Work_Plan_Start_Date date, 
											 p_Work_Plan_End_Date date, p_Work_Plan_Instruction varchar(100), p_Work_Plan_Enclosure int, p_Work_Plan_Status int)
language plpgsql
as $$
	declare
		work_plan_year varchar(4) := date_part('year', p_Work_Plan_Date);
	  	p_Work_plan_number varchar(20) := 'ГРМ-'||substring(work_plan_year, 3, 2);
    	work_plan_counter integer := (
			select count(*) + 1 from work_plan
				where to_char(work_plan_date, 'YY') = substring(work_plan_year, 3, 2));
    	work_plan_zeros varchar(11) := LPAD(work_plan_counter::text, 10, '0');
	begin
		p_Work_plan_number := p_Work_plan_number || '-' || work_plan_zeros;
		insert into Work_Plan(Work_Plan_Number, Work_Plan_Date, Work_Plan_Start_Date, Work_Plan_End_Date, Work_Plan_Instruction, Work_Plan_Enclosure, Work_Plan_Status)
		values (p_Work_Plan_Number, p_Work_Plan_Date, p_Work_Plan_Start_Date, p_Work_Plan_End_Date, p_Work_Plan_Instruction, p_Work_Plan_Enclosure, p_Work_Plan_Status);
	end;
$$;

create or replace procedure work_plan_Update (p_work_plan_code int, p_Work_Plan_Date date, p_Work_Plan_Start_Date date, 
											 p_Work_Plan_End_Date date, p_Work_Plan_Instruction varchar(100), p_Work_Plan_Enclosure int, p_Work_Plan_Status int)
language plpgsql
as $$
	begin
		update Work_Plan set
			Work_Plan_Date = p_Work_Plan_Date,
			Work_Plan_Start_Date = p_Work_Plan_Start_Date,
			Work_Plan_End_Date = p_Work_Plan_End_Date,
			Work_Plan_Instruction = p_Work_Plan_Instruction,
			Work_Plan_Enclosure = p_Work_Plan_Enclosure,
			Work_Plan_Status = p_Work_Plan_Status
				where
					work_plan_code = p_work_plan_code;
	end;
$$;

create or replace procedure work_plan_Delete (p_work_plan_code int)
language plpgsql
as $$
declare
		p_Exist_Work_Plans smallint := count(*) from Work_List_plan
			where code_work_plan = p_work_plan_code;
	begin
		if(p_Exist_Works > 0) then
			raise notice 'Данный план не может быть удален, т.к. он используется в списке работ';
		else
			delete from work_plan
			where
				work_plan_code = p_work_plan_code;
		end if;		
	end;
$$;

select * from work_plan;

select * from work_status;
select 
	work_plan_number as "Номер плана",
	name_enclosure as "Вольер",
	work_status_name as "Статус"
from work_plan 
	inner join Enclosure on
		id_enclosure = 	Work_Plan_Enclosure
	inner join Work_Status on
		work_Status_code = work_plan_status;
		

select * from enclosure_Status;

create or replace procedure Enclosure_Status_Insert (p_enclosure_status_name varchar(100))
language plpgsql
as $$
	begin
		insert into enclosure_Status (enclosure_status_name)
		values (p_enclosure_status_name);
		exception when others then
			raise notice 'Указанный статус вольера уже есть в таблице!';
	end;
$$;

create or replace procedure Enclosure_Status_Update (p_enclosure_status_code int, p_enclosure_status_name Varchar(100))
language plpgsql
as $$
	begin
		update Enclosure_Status set
			enclosure_status_name = p_enclosure_status_name
				where
					enclosure_status_code = p_enclosure_status_code;
	end;
$$;

create or replace procedure Enclosure_Status_Delete (p_ID_Enclosure_Status int)
language plpgsql
as $$
	declare
		p_Exist_Enclosures smallint := count(*) from Enclosure
			where status_enclosure = p_ID_Enclosure_Status;
	begin
		if(p_Exist_Enclosures > 0) then
			raise notice 'Данный статус вольера не может быть удалён, т.к. он используется в вольерах';
		else
			delete from Enclosure
				where
					ID_Enclosure = p_ID_Enclosure;
		end if;
	end;
$$;


create or replace procedure Animal_Update (p_ID_Animal int, p_Number_Animal varchar(11), p_Description_Animal varchar(100), p_Picture_Animal varchar(100), p_ID_Animal_Type int, p_Habitat_Code int, p_ID_Enclosure int, p_ID_Territory int)
language plpgsql
as $$
	declare 
		p_old_animal_habitat_code int := (select Habitat_Code from animal where id_animal = p_id_animal);
	begin
		if(p_old_animal_habitat_code = p_Habitat_Code) then
			raise notice 'Выбранный ареал уже есть у указанного животного!';
		else
			update Animal set
				Number_Animal = p_Number_Animal,
				Description_Animal = p_Description_Animal,
				Picture_Animal = p_Picture_Animal,
				ID_Animal_Type = p_ID_Animal_Type,
				Habitat_Code = p_Habitat_Code,
				ID_Enclosure = p_ID_Enclosure,
				ID_Territory = p_ID_Territory
					where
						ID_Animal = p_ID_Animal;
		end if;
	end;
$$;
select * from animal;

select * from territory;
select * from ticket;

create or replace procedure Territory_Ticket_Insert (p_ID_Territory int, p_ID_Ticket int)
language plpgsql
as $$
	declare
		p_territory_ticket_old_sum decimal(6, 2) := (select total_sum_ticket from ticket where id_ticket = p_id_ticket);
		p_Visitor_Id int := (select id_visitor from ticket where id_ticket = p_id_ticket);
		p_Visitor_Benefits int := (select benefits_visitor from visitor where id_visitor = p_Visitor_Id);
		p_territory_price decimal(5, 2) := (select price_territory from territory where id_territory = p_ID_Territory);
		p_territory_ticket_new_sum decimal(6, 2) := 0;
	begin
		if (p_Visitor_Benefits > 0) then
			p_territory_ticket_new_sum := p_territory_ticket_old_sum + (p_territory_price * p_Visitor_Benefits);
		else
			p_territory_ticket_new_sum := p_territory_ticket_old_sum + p_territory_price;
		end if;
		update ticket set 
			total_sum_ticket = p_territory_ticket_new_sum 
			where id_ticket = p_id_ticket;
		insert into Territory_Ticket (ID_Territory, ID_Ticket)
		values (p_ID_Territory, p_ID_Ticket);
	end;
$$;


select * from territory_ticket where id_ticket = 1;
select * from ticket where id_ticket = 1;
select * from visitor where id_visitor = 1;

create or replace procedure Habitat_Insert (p_habitat_name varchar(100))
language plpgsql
as $$
	begin
		insert into Habitat (habitat_name)
		values (p_habitat_name);
		exception when others then
			raise notice 'Указанный ареал обитания уже есть в таблице!';
	end;
$$;

create or replace procedure Habitat_Update (p_habitat_code int, p_habitat_name Varchar(100))
language plpgsql
as $$
	begin
		update Habitat set
			habitat_name = p_habitat_name
				where
					habitat_code = p_habitat_code;
				exception when others then
					raise notice 'Указанный ареал обитания уже есть в таблице!';
	end;
$$;


create or replace procedure Habitat_Delete (p_habitat_code int)
language plpgsql
as $$
	declare
		p_Exist_animals smallint := count(*) from animal
			where habitat_code = p_habitat_code;
	begin
	if(p_Exist_animals > 0) then
			raise notice 'Данный ареал обитания не может быть удален, т.к. он используется у животных';
	else
		delete from Habitat
			where
				habitat_code = p_habitat_code;
	end if;
	end;
$$;


select * from work_list;

create or replace procedure work_list_Insert (p_work_list_name varchar(100), p_work_list_interval interval)
language plpgsql
as $$
	begin
		insert into work_list (work_list_name, work_list_interval)
		values (p_work_list_name, p_work_list_interval);
		exception when others then
			raise notice 'Указанная работа уже есть в таблице!';
	end;
$$;

create or replace procedure work_list_Update (p_work_list_code int, p_work_list_name varchar(100), p_work_list_interval interval)
language plpgsql
as $$
	begin
		update work_list set
			work_list_name = p_work_list_name,
			work_list_interval = p_work_list_interval
				where
					work_list_code = p_work_list_code;
	end;
$$;

create or replace procedure work_list_Delete (p_work_list_code int)
language plpgsql
as $$
	declare
		p_Exist_Works smallint := count(*) from Work_List_plan
			where code_work_list = p_work_list_code;
	begin
		if(p_Exist_Works > 0) then
			raise notice 'Данная работа не может быть удалена, т.к. она используется в плане работ';
		else
			delete from work_list
				where
					work_list_code = p_work_list_code;
		end if;
	end;
$$;

select * from Work_Status;

create or replace procedure Work_Status_Insert (p_Work_Status_Name varchar(100))
language plpgsql
as $$
	begin
		insert into Work_Status (Work_Status_name)
		values (p_Work_Status_name);
		exception when others then
			raise notice 'Указанный статус работы уже есть в таблице!';
	end;
$$;

create or replace procedure Work_Status_Update (p_Work_Status_code int, p_Work_Status_name Varchar(100))
language plpgsql
as $$
	begin
		update Work_Status set
			Work_Status_name = p_Work_Status_name
				where
					Work_Status_code = p_Work_Status_code;
	end;
$$;

create or replace procedure Work_Status_Delete (p_Work_Status_code int)
language plpgsql
as $$
	begin
		delete from Work_Status
			where
				Work_Status_code = p_Work_Status_code;
	end;
$$;

select * from Work_List_Plan;

create or replace procedure Work_List_Plan_Insert (p_code_Work_List int, p_code_Work_Plan int)
language plpgsql
as $$
	begin
		insert into Work_List_Plan (code_Work_List, code_Work_Plan)
		values (p_code_Work_List, p_code_Work_Plan);
	end;
$$;

create or replace procedure Work_List_Plan_Update (p_work_list_plan_code int, p_code_Work_List int, p_code_Work_Plan int)
language plpgsql
as $$
	begin
		update Work_List_Plan set
			code_work_List = p_code_Work_List,
			code_work_plan = p_code_Work_Plan
				where
					work_list_plan_code = p_work_list_plan_code;
	end;
$$;

create or replace procedure Work_List_Plan_Delete (p_work_list_plan_code int)
language plpgsql
as $$
	begin
		delete from Work_List_Plan
			where
				work_list_plan_code = p_work_list_plan_code;
	end;
$$;

create or replace procedure Employee_Post_Insert (p_Employee_Post_Name varchar(100))
language plpgsql
as $$
	begin
		insert into Employee_Post (Employee_Post_Name)
		values (p_Employee_Post_Name);
		exception when others then
			raise notice 'Указанная должность сотрудника уже есть в таблице!';
	end;
$$;

create or replace procedure Employee_Post_Update (p_Employee_Post_Code int, p_Employee_Post_Name Varchar(50))
language plpgsql
as $$
	begin
		update Employee_Post set
			Employee_Post_Name = p_Employee_Post_Name
				where
					Employee_Post_Code = p_Employee_Post_Code;
				exception when others then
				raise notice 'Указанная должность сотрудника уже есть в таблице!';
	end;
$$;

create or replace procedure Employee_Post_Delete (p_Employee_Post_Code int)
language plpgsql
as $$
	declare
		p_Exist_employees smallint := count(*) from employee
			where employee_post_code = p_Employee_Post_Code;
	begin
		if(p_Exist_employees > 0) then
			raise notice 'Данная должность сотрудника не может быть удалена, т.к. она используется в сотрудниках';
	else
		delete from Employee_Post
			where
				Employee_Post_Code = p_Employee_Post_Code;
	end if;
	end;
$$;

create or replace procedure Visitor_Insert (p_Login_Visitor varchar(50), p_Name_Visitor varchar(50), p_Surname_Visitor varchar(50), p_Patronymic_Visitor varchar(50), p_Passport_Series_Visitor varchar(4), p_Passport_Number_Visitor varchar(6), p_Benefits_Visitor int, p_Password_Visitor varchar(36))
language plpgsql
as $$
	begin
		insert into Visitor (Login_Visitor, Name_Visitor, Surname_Visitor, Patronymic_Visitor, Passport_Series_Visitor, Passport_Number_Visitor, 
							Benefits_Visitor, Password_Visitor)
		values (p_Login_Visitor, p_Name_Visitor, p_Surname_Visitor, p_Patronymic_Visitor, p_Passport_Series_Visitor, p_Passport_Number_Visitor, 
			   p_Benefits_Visitor, p_Password_Visitor);
		exception when others then
			raise notice 'Указанный посетитель уже есть в таблице!';
	end;
$$;

create or replace procedure Visitor_Update (p_ID_Visitor int, p_Login_Visitor varchar(50), p_Name_Visitor varchar(50), p_Surname_Visitor varchar(50), p_Patronymic_Visitor varchar(50), p_Passport_Series_Visitor varchar(4), p_Passport_Number_Visitor varchar(6), p_Benefits_Visitor int, p_Password_Visitor varchar(36))
language plpgsql
as $$
	begin
		update Visitor set
			Login_Visitor = p_Login_Visitor,
			Name_Visitor = p_Name_Visitor,
			Surname_Visitor = p_Surname_Visitor,
			Patronymic_Visitor = p_Patronymic_Visitor,
			Passport_Series_Visitor = p_Passport_Series_Visitor,
			Passport_Number_Visitor = p_Passport_Number_Visitor,
			Benefits_Visitor = p_Benefits_Visitor,
			Password_Visitor = p_Password_Visitor
				where
					ID_Visitor = p_ID_Visitor;
				exception when others then
				raise notice 'Указанный посетитель уже есть в таблице!';
	end;
$$;

create or replace procedure Visitor_Delete (p_ID_Visitor int)
language plpgsql
as $$
	declare
		p_Exist_visitors smallint := count(*) from ticket
			where id_visitor = p_ID_Visitor;
	begin
	if(p_Exist_visitors > 0) then
			raise notice 'Данная посетитель не может быть удален, т.к. он используется в билетах';
	else
		delete from Visitor
			where
				ID_Visitor = p_ID_Visitor;
		end if;
	end;
$$;

create or replace procedure Visitor_Type_Insert (p_Name_Visitor_Type varchar(50))
language plpgsql
as $$
	begin
		insert into Visitor_Type (Name_Visitor_Type)
		values (p_Name_Visitor_Type);
		exception when others then
				raise notice 'Указанный вид посетителя уже есть в таблице!';
	end;
$$;

create or replace procedure Visitor_Type_Update (p_ID_Visitor_Type int, p_Name_Visitor_Type Varchar(50))
language plpgsql
as $$
	begin
		update Visitor_Type set
			Name_Visitor_Type = p_Name_Visitor_Type
				where
					ID_Visitor_Type = p_ID_Visitor_Type;
				exception when others then
				raise notice 'Указанный вид посетителя уже есть в таблице!';
	end;
$$;

create or replace procedure Visitor_Type_Delete (p_ID_Visitor_Type int)
language plpgsql
as $$
	declare
		p_Exist_type_visitors smallint := count(*) from Visitor_Document
			where id_visitor = p_ID_Visitor_Type;
	begin
	if(p_Exist_type_visitors > 0) then
			raise notice 'Данная вид посетителя не может быть удален, т.к. он используется в документах';
	else
		delete from Visitor_Type
			where
				ID_Visitor_Type = p_ID_Visitor_Type;
		end if;
	end;
$$;

create or replace procedure Visitor_Document_Insert (p_Number_Document varchar(100), p_ID_Visitor_Type int, p_ID_Visitor int)
language plpgsql
as $$
	begin
		insert into Visitor_Document (Number_Document, ID_Visitor_Type, ID_Visitor)
		values (p_Number_Document, p_ID_Visitor_Type, p_ID_Visitor);
		exception when others then
				raise notice 'Указанный документ уже есть в таблице!';
	end;
$$;

create or replace procedure Visitor_Document_Update (p_ID_Document int, p_Number_Document varchar(100), p_ID_Visitor_Type int, p_ID_Visitor int)
language plpgsql
as $$
	begin
		update Visitor_Document set
			Number_Document = p_Number_Document,
			ID_Visitor_Type = p_ID_Visitor_Type,
			ID_Visitor = p_ID_Visitor
				where
					ID_Document = p_ID_Document;
				exception when others then
				raise notice 'Указанный документ уже есть в таблице!';
	end;
$$;


create or replace procedure Enclosure_Insert (p_Name_Enclosure varchar(50), p_Status_Enclosure int)
language plpgsql
as $$
	begin
		insert into Enclosure (Name_Enclosure, Status_Enclosure)
		values (p_Name_Enclosure, p_Status_Enclosure);
		exception when others then
				raise notice 'Указанный вольер уже есть в таблице!';
	end;
$$;

create or replace procedure Enclosure_Update (p_ID_Enclosure int, p_Name_Enclosure varchar(50), p_Status_Enclosure int)
language plpgsql
as $$
	begin
		update Enclosure set
			Name_Enclosure = p_Name_Enclosure,
			Status_Enclosure = p_Status_Enclosure
				where
					ID_Enclosure = p_ID_Enclosure;
				exception when others then
				raise notice 'Указанный вольер уже есть в таблице!';
	end;
$$;

create or replace procedure Enclosure_Delete (p_ID_Enclosure int)
language plpgsql
as $$
	declare
		p_Exist_Enclosures smallint := count(*) from employee_enclosure
			where id_enclosure = p_ID_Enclosure;
	begin
	if(p_Exist_Enclosures > 0) then
			raise notice 'Данная вольер не может быть удален, т.к. он используется в сотрудниках-вольерах';
	else
		delete from Enclosure
			where
				ID_Enclosure = p_ID_Enclosure;
		end if;
	end;
$$;

create or replace procedure Employee_Insert (p_Login_Employee varchar(100), p_Surname_Employee varchar(50), p_Name_Employee varchar(50), 
											p_Patronymic_Employee varchar(50), p_Password_Employee varchar(36), p_Employee_Post_Code int)
language plpgsql
as $$
	begin
		insert into Employee (Login_Employee, Surname_Employee, Name_Employee, Patronymic_Employee, Password_Employee, Employee_Post_Code)
		values (p_Login_Employee, p_Surname_Employee, p_Name_Employee, p_Patronymic_Employee, p_Password_Employee, p_Employee_Post_Code);
		exception when others then
				raise notice 'Указанный сотрудник уже есть в таблице!';
	end;
$$;

create or replace procedure Employee_Update (p_ID_Employee int, p_Login_Employee varchar(100), p_Surname_Employee varchar(50), p_Name_Employee varchar(50), 
											p_Patronymic_Employee varchar(50), p_Password_Employee varchar(36), p_Employee_Post_Code int)
language plpgsql
as $$
	begin
		update Employee set
			Login_Employee = p_Login_Employee,
			Surname_Employee = p_Surname_Employee,
			Name_Employee = p_Name_Employee,
			Patronymic_Employee = p_Patronymic_Employee,
			Password_Employee = p_Password_Employee,
			Employee_Post_Code = p_Employee_Post_Code
				where
					ID_Employee = p_ID_Employee;
				exception when others then
				raise notice 'Указанный сотрудник уже есть в таблице!';
	end;
$$;

create or replace procedure Employee_Delete (p_ID_Employee int)
language plpgsql
as $$
	declare
		p_Exist_employees smallint := count(*) from employee_enclosure
			where id_employee = p_ID_Employee;
	begin
	if(p_Exist_employees > 0) then
			raise notice 'Данная сотрудник не может быть удален, т.к. он используется в сотрудниках-вольерах';
	else
		delete from Employee
			where
				ID_Employee = p_ID_Employee;
		end if;
	end;
$$;

create or replace procedure Animal_Squad_Insert (p_Name_Animal_Squad varchar(100))
language plpgsql
as $$
	begin
		insert into Animal_Squad (Name_Animal_Squad)
		values (p_Name_Animal_Squad);
		exception when others then
				raise notice 'Указанный отдряд уже есть в таблице!';
	end;
$$;

create or replace procedure Animal_Squad_Update (p_ID_Animal_Squad int, p_Name_Animal_Squad Varchar(100))
language plpgsql
as $$
	begin
		update Animal_Squad set
			Name_Animal_Squad = p_Name_Animal_Squad
				where
					ID_Animal_Squad = p_ID_Animal_Squad;
				exception when others then
				raise notice 'Указанный отдряд уже есть в таблице!';
	end;
$$;

create or replace procedure Animal_Squad_Delete (p_ID_Animal_Squad int)
language plpgsql
as $$
	declare
		p_Exist_squads smallint := count(*) from Animal_Family
			where id_animal_squad = p_ID_Animal_Squad;
	begin
	if(p_Exist_squads > 0) then
			raise notice 'Данный отряд не может быть удален, т.к. он используется в семействах';
	else
		delete from Animal_Squad
			where
				ID_Animal_Squad = p_ID_Animal_Squad;
	end if;
	end;
$$;

create or replace procedure Animal_Family_Insert (p_Name_Animal_Family varchar(100), p_ID_Animal_Squad int)
language plpgsql
as $$
	begin
		insert into Animal_Family (Name_Animal_Family, ID_Animal_Squad)
		values (p_Name_Animal_Family, p_ID_Animal_Squad);
		exception when others then
				raise notice 'Указанное семейство уже есть в таблице!';
	end;
$$;

create or replace procedure Animal_Family_Update (p_ID_Animal_Family int, p_Name_Animal_Family varchar(100), p_ID_Animal_Squad int)
language plpgsql
as $$
	begin
		update Animal_Family set
			Name_Animal_Family = p_Name_Animal_Family,
			ID_Animal_Squad = p_ID_Animal_Squad
				where
					ID_Animal_Family = p_ID_Animal_Family;
				exception when others then
				raise notice 'Указанное семейство уже есть в таблице!';
	end;
$$;

create or replace procedure Animal_Family_Delete (p_ID_Animal_Family int)
language plpgsql
as $$
	declare
		p_Exist_families smallint := count(*) from animal_type
			where id_animal_family = p_ID_Animal_Family;
	begin
	if(p_Exist_families > 0) then
			raise notice 'Данное семейство не может быть удалено, т.к. оно используется в видах';
	else
		delete from Animal_Family
			where
				ID_Animal_Family = p_ID_Animal_Family;
	end if;
	end;
$$;

create or replace procedure Animal_Type_Insert (p_Name_Animal_Type varchar(100), p_ID_Animal_Family int)
language plpgsql
as $$
	begin
		insert into Animal_Type (Name_Animal_Type, ID_Animal_Family)
		values (p_Name_Animal_Type, p_ID_Animal_Family);
		exception when others then
				raise notice 'Указанный вид уже есть в таблице!';
	end;
$$;

create or replace procedure Animal_Type_Update (p_ID_Animal_Type int, p_Name_Animal_Type varchar(100), p_ID_Animal_Family int)
language plpgsql
as $$
	begin
		update Animal_Type set
			Name_Animal_Type = p_Name_Animal_Type,
			ID_Animal_Family = p_ID_Animal_Family
				where
					ID_Animal_Type = p_ID_Animal_Type;
				exception when others then
				raise notice 'Указанный вид уже есть в таблице!';
	end;
$$;

create or replace procedure Animal_Type_Delete (p_ID_Animal_Type int)
language plpgsql
as $$
	declare
		p_Exist_types smallint := count(*) from animal_type
			where id_animal_family = p_ID_Animal_Family;
	begin
	if(p_Exist_types > 0) then
			raise notice 'Данное семейство не может быть удалено, т.к. оно используется в видах';
	else
		delete from Animal_Type
			where
				ID_Animal_Type = p_ID_Animal_Type;
	end if;
	end;
$$;

create or replace procedure Territory_Update (p_ID_Territory int, p_Name_Territory varchar(100), p_Price_Territory decimal(2, 5))
language plpgsql
as $$
	begin
		update Territory set
			 Name_Territory = p_Name_Territory,
			 Price_Territory = p_Price_Territory
				where
					ID_Territory = p_ID_Territory;
				exception when others then
				raise notice 'Указанная территория уже есть в таблице!';
	end;
$$;

create or replace procedure Territory_Delete (p_ID_Territory int)
language plpgsql
as $$
	declare
		p_Exist_territories smallint := count(*) from animal
			where id_territory = p_ID_Territory;
	begin
	if(p_Exist_territories > 0) then
			raise notice 'Данная территория не может быть удалена, т.к. она используется в животных';
	else
		delete from Territory
			where
				ID_Territory = p_ID_Territory;
	end if;
	end;
$$;

create or replace procedure Animal_Insert (p_Number_Animal varchar(11), p_Description_Animal varchar(100), p_Picture_Animal varchar(100), p_ID_Animal_Type int, p_Habitat_Code int, p_ID_Enclosure int, p_ID_Territory int)
language plpgsql
as $$
	begin
		insert into Animal (Number_Animal, Description_Animal, Picture_Animal, ID_Animal_Type, Habitat_Code, ID_Enclosure, ID_Territory)
		values (p_Number_Animal, p_Description_Animal, p_Picture_Animal, p_ID_Animal_Type, p_Habitat_Code, p_ID_Enclosure, p_ID_Territory);
		exception when others then
				raise notice 'Указанное животное уже есть в таблице!';
	end;
$$;

create or replace procedure Ticket_Insert (p_Number_Ticket varchar(16), p_Datetime_Ticket timestamp, p_Price_Ticket decimal(6, 2), p_Total_Sum_Ticket decimal(6, 2), p_ID_Visitor int)
language plpgsql
as $$
	begin
		insert into Ticket (Number_Ticket, Datetime_Ticket, Price_Ticket, Total_Sum_Ticket, ID_Visitor)
		values (p_Number_Ticket, p_Datetime_Ticket, p_Price_Ticket, p_Total_SUm_Ticket, p_ID_Visitor);
		exception when others then
				raise notice 'Указанный билет уже есть в таблице!';
	end;
$$;

create or replace procedure Ticket_Update (p_ID_Ticket int, p_Number_Ticket varchar(15), p_Datetime_Ticket timestamp, p_Price_Ticket decimal(6,2 ), p_Total_Sum_Ticket decimal(6, 2), p_ID_Visitor int)
language plpgsql
as $$
	begin
		update Ticket set
			Number_Ticket = p_Number_Ticket,
			Datetime_Ticket = p_Datetime_Ticket,
			Price_Ticket = p_Price_Ticket,
			Total_SUm_Ticket = p_Total_SUm_Ticket,
			ID_Visitor = p_ID_Visitor
				where
					ID_Ticket = p_ID_Ticket;
				exception when others then
				raise notice 'Указанный билет уже есть в таблице!';
	end;
$$;

create or replace procedure Ticket_Delete (p_ID_Ticket int)
language plpgsql
as $$
	declare
		p_Exist_tickets smallint := count(*) from territory_ticket
			where id_ticket = p_ID_Ticket;
	begin
	if(p_Exist_tickets > 0) then
			raise notice 'Данный билет не может быть удален, т.к. он используется в территориях-билетах';
	else
		delete from Ticket
			where
				ID_Ticket = p_ID_Ticket;
	end if;
	end;
$$;

create or replace procedure Enclosure_Care_Day_Insert (p_ID_Employee_Enclosure int, p_Enclosure_Care_Day varchar(11))
language plpgsql
as $$
	begin
		insert into Enclosure_Care_Day (ID_Employee_Enclosure,Enclosure_Care_Day)
		values (p_ID_Employee_Enclosure, p_Enclosure_Care_Day);
		exception when others then
				raise notice 'Указанный день недели ухода не существует. Используйте один из дней недели';
	end;
$$;

create or replace procedure Enclosure_Care_Day_Update (p_ID_Enclosure_Care_Day int, p_ID_Employee_Enclosure int, p_Enclosure_Care_Day varchar(11))
language plpgsql
as $$
	begin
		update Enclosure_Care_Day set
			ID_Employee_Enclosure = p_ID_Employee_Enclosure,
			Enclosure_Care_Day = p_Enclosure_Care_Day
				where
					ID_Enclosure_Care_Day = p_ID_Enclosure_Care_Day;
				exception when others then
				raise notice 'Указанный день недели ухода не существует. Используйте один из дней недели';
	end;
$$;

create or replace procedure Enclosure_Care_Day_Delete (p_ID_Enclosure_Care_Day int)
language plpgsql
as $$
	declare
		p_Exist_care_days smallint := count(*) from Care_Time
			where id_enclosure_care_day = p_ID_Enclosure_Care_Day;
	begin
	if(p_Exist_care_days > 0) then
			raise notice 'Данный день ухода не может быть удален, т.к. он используется во времени ухода';
	else
		delete from Enclosure_Care_Day
			where
				ID_Enclosure_Care_Day = p_ID_Enclosure_Care_Day;
	end if;
	end;
$$;

grant select on Enclosure_Status to zoo_employee;
grant select on Work_List to zoo_employee;
grant select on Work_Status to zoo_employee;
grant select on Work_Plan to zoo_employee;
grant select on Work_List_Plan to zoo_employee;

grant select, insert, update on Enclosure_Status to zoo_administrator;
grant usage, select on sequence enclosure_status_enclosure_status_code_seq to zoo_administrator;

grant select, insert, update on Work_List to zoo_administrator;
grant usage, select on sequence work_list_work_list_code_seq to zoo_administrator;

grant select, insert, update on Work_Status to zoo_administrator;
grant usage, select on sequence work_status_work_status_code_seq to zoo_administrator;

grant select, insert, update on Work_Plan to zoo_administrator;
grant usage, select on sequence work_plan_work_plan_code_seq to zoo_administrator;

grant select, insert, update on Work_List_Plan to zoo_administrator;
grant usage, select on sequence work_list_plan_work_list_plan_code_seq to zoo_administrator;


grant execute on procedure Enclosure_Status_Insert to zoo_administrator;
grant execute on procedure Enclosure_Status_Update to zoo_administrator;
grant execute on procedure Work_List_Insert to zoo_administrator;
grant execute on procedure Work_List_Update to zoo_administrator;
grant execute on procedure Work_Status_Update to zoo_administrator;
grant execute on procedure Work_Status_Insert to zoo_administrator;
grant execute on procedure Work_Plan_Update to zoo_administrator;
grant execute on procedure Work_Plan_Insert to zoo_administrator;
grant execute on procedure Work_List_Plan_Insert to zoo_administrator;
grant execute on procedure Work_List_Plan_Update to zoo_administrator;