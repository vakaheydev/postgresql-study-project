create or replace procedure Habitat_Insert (p_habitat_name varchar(100))
language plpgsql
as $$
	begin
		insert into Habitat (habitat_name)
		values (p_habitat_name);
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
	end;
$$;

create or replace procedure Habitat_Delete (p_habitat_code int)
language plpgsql
as $$
	begin
		delete from Habitat
			where
				habitat_code = p_habitat_code;
	end;
$$;

create or replace procedure Employee_Post_Insert (p_Employee_Post_Name varchar(100))
language plpgsql
as $$
	begin
		insert into Employee_Post (Employee_Post_Name)
		values (p_Employee_Post_Name);
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
	end;
$$;

create or replace procedure Employee_Post_Delete (p_Employee_Post_Code int)
language plpgsql
as $$
	begin
		delete from Employee_Post
			where
				Employee_Post_Code = p_Employee_Post_Code;
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
	end;
$$;

create or replace procedure Visitor_Delete (p_ID_Visitor int)
language plpgsql
as $$
	begin
		delete from Visitor
			where
				ID_Visitor = p_ID_Visitor;
	end;
$$;

create or replace procedure Visitor_Type_Insert (p_Name_Visitor_Type varchar(50))
language plpgsql
as $$
	begin
		insert into Visitor_Type (Name_Visitor_Type)
		values (p_Name_Visitor_Type);
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
	end;
$$;

create or replace procedure Visitor_Type_Delete (p_ID_Visitor_Type int)
language plpgsql
as $$
	begin
		delete from Visitor_Type
			where
				ID_Visitor_Type = p_ID_Visitor_Type;
	end;
$$;

create or replace procedure Visitor_Document_Insert (p_Number_Document varchar(100), p_ID_Visitor_Type int, p_ID_Visitor int)
language plpgsql
as $$
	begin
		insert into Visitor_Document (Number_Document, ID_Visitor_Type, ID_Visitor)
		values (p_Number_Document, p_ID_Visitor_Type, p_ID_Visitor);
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
	end;
$$;

create or replace procedure Visitor_Document_Delete (p_ID_Document int)
language plpgsql
as $$
	begin
		delete from Visitor_Document
			where
				ID_Document = p_ID_Document;
	end;
$$;

create or replace procedure Enclosure_Insert (p_Name_Enclosure varchar(50), p_Status_Enclosure varchar(16))
language plpgsql
as $$
	begin
		insert into Enclosure (Name_Enclosure, Status_Enclosure)
		values (p_Name_Enclosure, p_Status_Enclosure);
	end;
$$;

create or replace procedure Enclosure_Update (p_ID_Enclosure int, p_Name_Enclosure varchar(50), p_Status_Enclosure varchar(16))
language plpgsql
as $$
	begin
		update Enclosure set
			Name_Enclosure = p_Name_Enclosure,
			Status_Enclosure = p_Status_Enclosure
				where
					ID_Enclosure = p_ID_Enclosure;
	end;
$$;

create or replace procedure Enclosure_Delete (p_ID_Enclosure int)
language plpgsql
as $$
	begin
		delete from Enclosure
			where
				ID_Enclosure = p_ID_Enclosure;
	end;
$$;

create or replace procedure Employee_Insert (p_Login_Employee varchar(100), p_Surname_Employee varchar(50), p_Name_Employee varchar(50), 
											p_Patronymic_Employee varchar(50), p_Password_Employee varchar(36), p_Employee_Post_Code int)
language plpgsql
as $$
	begin
		insert into Employee (Login_Employee, Surname_Employee, Name_Employee, Patronymic_Employee, Password_Employee, Employee_Post_Code)
		values (p_Login_Employee, p_Surname_Employee, p_Name_Employee, p_Patronymic_Employee, p_Password_Employee, p_Employee_Post_Code);
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
	end;
$$;

create or replace procedure Employee_Delete (p_ID_Employee int)
language plpgsql
as $$
	begin
		delete from Employee
			where
				ID_Employee = p_ID_Employee;
	end;
$$;


create or replace procedure Employee_Enclosure_Insert (p_ID_Employee int, p_ID_Enclosure int)
language plpgsql
as $$
	begin
		insert into Employee_Enclosure (ID_Employee, ID_Enclosure)
		values (p_ID_Employee, p_ID_Enclosure);
	end;
$$;

create or replace procedure Employee_Enclosure_Update (p_ID_Employee_Enclosure int, p_ID_Employee int, p_ID_Enclosure int)
language plpgsql
as $$
	begin
		update Employee_Enclosure set
			ID_Employee = p_ID_Employee,
			ID_Enclosure = p_ID_Enclosure
				where
					ID_Employee_Enclosure = p_ID_Employee_Enclosure;
	end;
$$;

create or replace procedure Employee_Enclosure_Delete (p_ID_Employee_Enclosure int)
language plpgsql
as $$
	begin
		delete from Employee_Enclosure
			where
				ID_Employee_Enclosure = p_ID_Employee_Enclosure;
	end;
$$;

create or replace procedure Animal_Squad_Insert (p_Name_Animal_Squad varchar(100))
language plpgsql
as $$
	begin
		insert into Animal_Squad (Name_Animal_Squad)
		values (p_Name_Animal_Squad);
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
	end;
$$;

create or replace procedure Animal_Squad_Delete (p_ID_Animal_Squad int)
language plpgsql
as $$
	begin
		delete from Animal_Squad
			where
				ID_Animal_Squad = p_ID_Animal_Squad;
	end;
$$;

create or replace procedure Animal_Family_Insert (p_Name_Animal_Family varchar(100), p_ID_Animal_Squad int)
language plpgsql
as $$
	begin
		insert into Animal_Family (Name_Animal_Family, ID_Animal_Squad)
		values (p_Name_Animal_Family, p_ID_Animal_Squad);
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
	end;
$$;

create or replace procedure Animal_Family_Delete (p_ID_Animal_Family int)
language plpgsql
as $$
	begin
		delete from Animal_Family
			where
				ID_Animal_Family = p_ID_Animal_Family;
	end;
$$;

create or replace procedure Animal_Type_Insert (p_Name_Animal_Type varchar(100), p_ID_Animal_Family int)
language plpgsql
as $$
	begin
		insert into Animal_Type (Name_Animal_Type, ID_Animal_Family)
		values (p_Name_Animal_Type, p_ID_Animal_Family);
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
	end;
$$;

create or replace procedure Animal_Type_Delete (p_ID_Animal_Type int)
language plpgsql
as $$
	begin
		delete from Animal_Type
			where
				ID_Animal_Type = p_ID_Animal_Type ;
	end;
$$;

create or replace procedure Territory_Insert (p_Name_Territory varchar(100), p_Price_Territory decimal(2, 5))
language plpgsql
as $$
	begin
		insert into Territory (Name_Territory, Price_Territory)
		values (p_Name_Territory, p_Price_Territory);
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
	end;
$$;

create or replace procedure Territory_Delete (p_ID_Territory int)
language plpgsql
as $$
	begin
		delete from Territory
			where
				ID_Territory = p_ID_Territory;
	end;
$$;

create or replace procedure Animal_Insert (p_Number_Animal varchar(11), p_Description_Animal varchar(100), p_Picture_Animal varchar(100), p_ID_Animal_Type int, p_Habitat_Code int, p_ID_Enclosure int, p_ID_Territory int)
language plpgsql
as $$
	begin
		insert into Animal (Number_Animal, Description_Animal, Picture_Animal, ID_Animal_Type, Habitat_Code, ID_Enclosure, ID_Territory)
		values (p_Number_Animal, p_Description_Animal, p_Picture_Animal, p_ID_Animal_Type, p_Habitat_Code, p_ID_Enclosure, p_ID_Territory);
	end;
$$;

create or replace procedure Animal_Update (p_ID_Animal int, p_Number_Animal varchar(11), p_Description_Animal varchar(100), p_Picture_Animal varchar(100), p_ID_Animal_Type int, p_Habitat_Code int, p_ID_Enclosure int, p_ID_Territory int)
language plpgsql
as $$
	begin
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
	end;
$$;

create or replace procedure Animal_Delete (p_ID_Animal int)
language plpgsql
as $$
	begin
		delete from Animal
			where
				ID_Animal = p_ID_Animal;
	end;
$$;

create or replace procedure Ticket_Insert (p_Number_Ticket varchar(16), p_Datetime_Ticket timestamp, p_Price_Ticket decimal(6, 2), p_Total_Sum_Ticket decimal(6, 2), p_ID_Visitor int)
language plpgsql
as $$
	begin
		insert into Ticket (Number_Ticket, Datetime_Ticket, Price_Ticket, Total_Sum_Ticket, ID_Visitor)
		values (p_Number_Ticket, p_Datetime_Ticket, p_Price_Ticket, p_Total_SUm_Ticket, p_ID_Visitor);
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
	end;
$$;

create or replace procedure Ticket_Delete (p_ID_Ticket int)
language plpgsql
as $$
	begin
		delete from Ticket
			where
				ID_Ticket = p_ID_Ticket;
	end;
$$;

create or replace procedure Territory_Ticket_Insert (p_ID_Territory int, p_ID_Ticket int)
language plpgsql
as $$
	begin
		insert into Territory_Ticket (ID_Territory, ID_Ticket)
		values (p_ID_Territory, p_ID_Ticket);
	end;
$$;

create or replace procedure Territory_Ticket_Update (p_ID_Territory_Ticket int, p_ID_Territory int, p_ID_Ticket int)
language plpgsql
as $$
	begin
		update Territory_Ticket set
			ID_Territory = p_ID_Territory,
			ID_Ticket = p_ID_Ticket
				where
					ID_Territory_Ticket = p_ID_Territory_Ticket;
	end;
$$;

create or replace procedure Territory_Ticket_Delete (p_ID_Territory_Ticket int)
language plpgsql
as $$
	begin
		delete from Territory_Ticket
			where
				ID_Territory_Ticket = p_ID_Territory_Ticket;
	end;
$$;

create or replace procedure Enclosure_Care_Day_Insert (p_ID_Employee_Enclosure int, p_Enclosure_Care_Day varchar(11))
language plpgsql
as $$
	begin
		insert into Enclosure_Care_Day (ID_Employee_Enclosure,Enclosure_Care_Day)
		values (p_ID_Employee_Enclosure, p_Enclosure_Care_Day);
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
	end;
$$;

create or replace procedure Enclosure_Care_Day_Delete (p_ID_Enclosure_Care_Day int)
language plpgsql
as $$
	begin
		delete from Enclosure_Care_Day
			where
				ID_Enclosure_Care_Day = p_ID_Enclosure_Care_Day;
	end;
$$;

create or replace procedure Care_Time_Insert (p_ID_Enclosure_Care_Day int, p_Care_Time time)
language plpgsql
as $$
	begin
		insert into Care_Time (ID_Enclosure_Care_Day, Care_Time)
		values (p_ID_Enclosure_Care_Day, p_Care_Time);
	end;
$$;

create or replace procedure Care_Time_Update (p_ID_Care_Time int, p_ID_Enclosure_Care_Day int, p_Care_Time time)
language plpgsql
as $$
	begin
		update Care_Time set
			ID_Enclosure_Care_Day = p_ID_Enclosure_Care_Day,
			Care_Time = p_Care_Time
				where
					ID_Care_Time = p_ID_Care_Time;
	end;
$$;

create or replace procedure Care_Time_Delete (p_ID_Care_Time int)
language plpgsql
as $$
	begin
		delete from Care_Time
			where
				ID_Care_Time = p_ID_Care_Time;
	end;
$$;

grant execute on procedure Habitat_Insert to zoo_employee;
grant execute on procedure Habitat_Update to zoo_employee;
grant execute on procedure Visitor_Document_Insert to zoo_employee;
grant execute on procedure Enclosure_Insert to zoo_employee;
grant execute on procedure Territory_Insert to zoo_employee;
grant execute on procedure Animal_Insert to zoo_employee;
grant execute on procedure Animal_Update to zoo_employee;
grant execute on procedure Animal_Delete to zoo_employee;
grant execute on procedure Ticket_Insert to zoo_employee;
grant execute on procedure Territory_Ticket_Insert to zoo_employee;
grant execute on procedure Enclosure_Care_Day_Insert to zoo_employee;
grant execute on procedure Care_Time_Insert to zoo_employee;

grant execute on procedure Habitat_Insert to zoo_administrator;
grant execute on procedure Habitat_Update to zoo_administrator;
grant execute on procedure Habitat_Delete to zoo_administrator;
grant execute on procedure Employee_Post_Insert to zoo_administrator;
grant execute on procedure Employee_Post_Update to zoo_administrator;
grant execute on procedure Employee_Post_Delete to zoo_administrator;
grant execute on procedure Visitor_Insert to zoo_administrator;
grant execute on procedure Visitor_Update to zoo_administrator;
grant execute on procedure Visitor_Delete to zoo_administrator;
grant execute on procedure Visitor_Document_Insert to zoo_administrator;
grant execute on procedure Enclosure_Insert to zoo_administrator;
grant execute on procedure Enclosure_Update to zoo_administrator;
grant execute on procedure Enclosure_Delete to zoo_administrator;
grant execute on procedure Employee_Enclosure_Insert to zoo_administrator;
grant execute on procedure Employee_Enclosure_Update to zoo_administrator;
grant execute on procedure Employee_Enclosure_Delete to zoo_administrator;
grant execute on procedure Territory_Insert to zoo_administrator;
grant execute on procedure Territory_Update to zoo_administrator;
grant execute on procedure Territory_Delete to zoo_administrator;
grant execute on procedure Animal_Insert to zoo_administrator;
grant execute on procedure Animal_Update to zoo_administrator;
grant execute on procedure Animal_Delete to zoo_administrator;
grant execute on procedure Ticket_Insert to zoo_administrator;
grant execute on procedure Ticket_Update to zoo_administrator;
grant execute on procedure Territory_Ticket_Insert to zoo_administrator;
grant execute on procedure Territory_Ticket_Update to zoo_administrator;
grant execute on procedure Enclosure_Care_Day_Insert to zoo_administrator;
grant execute on procedure Enclosure_Care_Day_Update to zoo_administrator;
grant execute on procedure Enclosure_Care_Day_Delete to zoo_administrator;
grant execute on procedure Care_Time_Insert to zoo_administrator;
grant execute on procedure Care_Time_Update to zoo_administrator;
grant execute on procedure Care_Time_Delete to zoo_administrator;
