create or replace procedure Structure_Create()
language plpgsql
as $$
	begin
		create table if not exists Habitat (
			Habitat_Code serial not null constraint PK_Habitat primary key,
			Habitat_Name varchar(100) not null
		);
		
		create table if not exists Employee_Post (
			Employee_Post_Code serial not null constraint PK_Employee_Post primary key,
			Employee_Post_Name varchar(50) not null
		);
		
		create table if not exists Visitor (
			ID_Visitor serial not null constraint PK_Visitor primary key,
			Login_Visitor varchar(50) not null,
			Name_Visitor varchar(50) not null,
			Surname_Visitor varchar(50) not null,
			Patronymic_Visitor varchar(50) null,
			Passport_Series_Visitor varchar(4) not null,
			Passport_Number_Visitor varchar(6) not null,
			Benefits_Visitor int not null,
			Password_Visitor varchar(36) not null
		);
		
		create table if not exists Visitor_Type (
			ID_Visitor_Type serial not null constraint PK_Visitor_Type primary key,
			Name_Visitor_Type varchar(50) not null
		);
		
		create table if not exists Visitor_Document (
			ID_Document serial not null constraint PK_Visitor_Document primary key,
			Number_Document varchar(20) not null,
			ID_Visitor_Type int not null references Visitor_Type (ID_Visitor_Type),
			ID_Visitor int not null references Visitor (ID_Visitor)
		);
		
		create table if not exists Enclosure (
			ID_Enclosure serial not null constraint PK_Enclosure primary key,
			Name_Enclosure varchar(50) not null,
			Status_Enclosure varchar(16) not null
		);
		
		create table if not exists Employee (
			ID_Employee serial not null constraint PK_Employee primary key,
			Login_Employee varchar(100) not null,
			Surname_Employee varchar(50) not null,
			Name_Employee varchar(50) not null,
			Patronymic_Employee varchar(50) null,
			Password_Employee varchar(36) not null,
			Employee_Post_Code int not null references Employee_Post (Employee_Post_Code)
		);
		
		create table if not exists Employee_Enclosure (
			ID_Employee_Enclosure serial not null constraint PK_Employee_Enclosure primary key,
			ID_Employee int not null references Employee (ID_Employee),
			ID_Enclosure int not null references Enclosure (ID_Enclosure)
		);
		
		
		create table if not exists Animal_Squad (
			ID_Animal_Squad serial not null constraint PK_Animal_Squad primary key,
			Name_Animal_Squad varchar(100) not null
		);
		
		create table if not exists Animal_Family (
			ID_Animal_Family serial not null constraint PK_Animal_Family primary key,
			Name_Animal_Family varchar(100) not null,
			ID_Animal_Squad int not null references Animal_Squad(ID_Animal_Squad)
		);
		
		create table if not exists Animal_Type (
			ID_Animal_Type serial not null constraint PK_Animal_Type primary key,
			Name_Animal_Type varchar(100) not null,
			ID_Animal_Family int not null references Animal_Family(ID_Animal_Family)
		);
		
		create table if not exists Territory (
			ID_Territory serial not null constraint PK_Territoty primary key,
			Name_Territory varchar(100) not null,
			Price_Territory decimal(5, 2) not null
		);
				
		create table if not exists Animal (
			ID_Animal serial not null constraint PK_Animal primary key,
			Number_Animal varchar(11) not null,
			Description_Animal varchar(100) not null,
			Picture_Animal varchar(100) not null,
			ID_Animal_Type int not null references Animal_Type (ID_Animal_Type),
			Habitat_Code int not null references Habitat (Habitat_Code),
			ID_Enclosure int not null references Enclosure (ID_Enclosure),
			ID_Territory int not null references Territory (ID_Territory)
		);
		
		create table if not exists Ticket (
			ID_Ticket serial not null constraint PK_Ticket primary key,
			Number_Ticket varchar(16) not null,
			Datetime_Ticket timestamp not null,
			Price_Ticket decimal(6, 2) not null,
			Total_Sum_Ticket decimal(6, 2) not null,
			ID_Visitor int not null references Visitor (ID_Visitor)
		);
				
		create table if not exists Territory_Ticket (
			ID_Territory_Ticket serial not null constraint PK_Territory_Ticket primary key,
			ID_Territory int not null references Territory (ID_Territory),
			ID_Ticket int not null references Ticket (ID_Ticket)
		);
		
		create table if not exists Enclosure_Care_Day (
			ID_Enclosure_Care_Day serial not null constraint PK_Enclosure_Care_Day primary key,
			ID_Employee_Enclosure int not null references Employee_Enclosure (ID_Employee_Enclosure),
			Enclosure_Care_Day varchar(11) not null
		);
		
		create table if not exists Care_Time (
			ID_Care_Time serial not null constraint PK_Care_Time primary key,
			ID_Enclosure_Care_Day int not null references Enclosure_Care_Day(ID_Enclosure_Care_Day),
			Care_Time time not null
		);
		
		create index if not exists index_Habitat_Code on Habitat (Habitat_Code);
		create index if not exists index_Habitat_Name on Habitat (Habitat_Name);
		
		create index if not exists index_Employee_Post_Code on Employee_Post (Employee_Post_Code);
		create index if not exists index_Employee_Post_Name on Employee_Post (Employee_Post_Name);
		
		create index if not exists index_ID_Visitor on Visitor (ID_Visitor);
		create index if not exists index_Visitor_Login_Password on Visitor (Login_Visitor, Password_Visitor);
		create index if not exists index_Visitor_Passport_Series_Passport_Number on Visitor (Passport_Series_Visitor, Passport_Number_Visitor);
		create index if not exists index_Visitor_Name_Surname_Patronymic on Visitor (Name_Visitor, Surname_Visitor, Patronymic_Visitor);
		
		create index if not exists index_ID_Visitor_Type on Visitor_Type (ID_Visitor_Type);
		create index if not exists index_Name_Visitor_Type on Visitor_Type (Name_Visitor_Type);
				
		create index if not exists index_ID_Document on Visitor_Document (ID_Document);
		create index if not exists index_Number_Document on Visitor_Document (Number_Document);
		
		create index if not exists index_ID_Enclosure on Enclosure (ID_Enclosure);
		create index if not exists index_Name_Enclosure on Enclosure (Name_Enclosure);
				
		create index if not exists index_Employee_Name_Surname_Patronymic on Employee (Name_Employee, Surname_Employee, Patronymic_Employee);
		create index if not exists index_Employee_Login_Password on Employee (Login_Employee, Password_Employee);
		create index if not exists index_ID_Employee on Employee (ID_Employee);
		
		create index if not exists index_ID_Employee_Enclosure on Employee_Enclosure (ID_Employee_Enclosure);
		
		create index if not exists index_ID_Animal on Animal (ID_Animal);
		create index if not exists index_Number_Animal on Animal (Number_Animal);
		
		create index if not exists index_ID_Animal_Squad on Animal_Squad (ID_Animal_Squad);
		create index if not exists index_Name_Animal_Squad on Animal_Squad (Name_Animal_Squad);
		
		create index if not exists index_ID_Animal_Family on Animal_Family (ID_Animal_Family);
		create index if not exists index_Name_Animal_Family on Animal_Family (Name_Animal_Family);
		
		create index if not exists index_ID_Animal_Type on Animal_Type (ID_Animal_Type);
		create index if not exists index_Name_Animal_Type on Animal_Type (Name_Animal_Type);
		
		create index if not exists index_ID_Territory on Territory (ID_Territory);
		create index if not exists index_Name_Territory on Territory (Name_Territory);
		
		create index if not exists index_ID_Ticket on Ticket (ID_Ticket);
		create index if not exists index_Number_Ticket on Ticket (Number_Ticket);
		
		create index if not exists index_ID_Territory_Ticket on Territory_Ticket (ID_Territory_Ticket);
		
		create index if not exists index_ID_Enclosure_Care_Day on Enclosure_Care_Day (ID_Enclosure_Care_Day);
		
		create index if not exists index_ID_Caretime on Care_time (ID_Care_time);
		
		grant select on Habitat to zoo_visitor;
		grant select on Animal to zoo_visitor;
		grant select on Territory to zoo_visitor;
				
		grant select, insert, update on Habitat to zoo_employee;
		grant usage, select on sequence habitat_habitat_code_seq to zoo_employee;
		
		grant select on Employee_Post to zoo_employee;
		grant select on Visitor to zoo_employee;
		grant select on Visitor_Type to zoo_employee;
		
		grant select, insert on Visitor_Document to zoo_employee;
		grant usage, select on sequence visitor_document_id_document_seq to zoo_employee;

		grant select, insert on Enclosure to zoo_employee;
		grant usage, select on sequence enclosure_id_enclosure_seq to zoo_employee;
		
		
		grant select on Employee to zoo_employee;
		grant select on Employee_Enclosure to zoo_employee;
		
		grant select, insert, update, delete on Animal to zoo_employee;
		grant usage, select on sequence animal_id_animal_seq to zoo_employee;
		
		grant select, insert on Territory to zoo_employee;
		grant usage, select on sequence territory_id_territory_seq to zoo_employee;
		
		grant select, insert on Ticket to zoo_employee;
		grant usage, select on sequence ticket_id_ticket_seq to zoo_employee;
		
		grant select, insert on Territory_Ticket to zoo_employee;
		grant usage, select on sequence territory_ticket_id_territory_ticket_seq to zoo_employee;
		
		grant select, insert on Enclosure_Care_Day to zoo_employee;
		grant usage, select on sequence enclosure_care_day_id_enclosure_care_day_seq to zoo_employee;
		
		grant select, insert on Care_Time to zoo_employee;
		grant usage, select on sequence care_time_id_care_time_seq to zoo_employee;		
		
		grant select, insert, update, delete on Habitat to zoo_administrator;
		grant usage, select on sequence habitat_habitat_code_seq to zoo_administrator;
		
		grant select, insert, update, delete on Employee_Post to zoo_administrator;
		grant usage, select on sequence employee_post_employee_post_code_seq to zoo_administrator;
		
		grant select, insert, update, delete on Visitor to zoo_administrator;
		grant usage, select on sequence visitor_id_visitor_seq to zoo_administrator;
		
		grant select, insert on Visitor_Document to zoo_administrator;
		grant usage, select on sequence visitor_document_id_document_seq to zoo_administrator;
		
		grant select, insert, update, delete on Enclosure to zoo_administrator;
		grant usage, select on sequence enclosure_id_enclosure_seq to zoo_administrator;
		
		grant select, insert, update, delete on Employee to zoo_administrator;
		grant usage, select on sequence employee_id_employee_seq to zoo_administrator;
		
		grant select, insert, update, delete on Employee_Enclosure to zoo_administrator;
		grant usage, select on sequence employee_enclosure_id_employee_enclosure_seq to zoo_administrator;
		
		grant select, insert, update, delete on Animal to zoo_administrator;
		grant usage, select on sequence animal_id_animal_seq to zoo_administrator;
		
		grant select on Animal_Squad to zoo_administrator;
		grant select on Animal_Family to zoo_administrator;
		grant select on Animal_Type to zoo_administrator;
		
		grant select, insert, update, delete on Territory to zoo_administrator;
		grant usage, select on sequence territory_id_territory_seq to zoo_administrator;
		
		grant select, insert, update on Ticket to zoo_administrator;
		grant usage, select on sequence ticket_id_ticket_seq to zoo_administrator;
		
		grant select, insert, update on Territory_Ticket to zoo_administrator;
		grant usage, select on sequence territory_ticket_id_territory_ticket_seq to zoo_administrator;
		
		grant select, insert, update, delete on Enclosure_Care_Day to zoo_administrator;	
		grant usage, select on sequence enclosure_care_day_id_enclosure_care_day_seq to zoo_administrator;
		
		grant select, insert, update, delete on Care_Time to zoo_administrator;	
		grant usage, select on sequence care_time_id_care_time_seq to zoo_administrator;
		
		
	end;
$$;