create or replace procedure Structure_Re_Create()
language plpgsql
as $$
	begin
		revoke usage, select on sequence habitat_habitat_code_seq from zoo_employee;
		revoke usage, select on sequence visitor_document_id_document_seq from zoo_employee;
		revoke usage, select on sequence enclosure_id_enclosure_seq from zoo_employee;
		revoke usage, select on sequence animal_id_animal_seq from zoo_employee;
		revoke usage, select on sequence territory_id_territory_seq from zoo_employee;
		revoke usage, select on sequence ticket_id_ticket_seq from zoo_employee;
		revoke usage, select on sequence territory_ticket_id_territory_ticket_seq from zoo_employee;
		revoke usage, select on sequence enclosure_care_day_id_enclosure_care_day_seq from zoo_employee;
		revoke usage, select on sequence care_time_id_care_time_seq from zoo_employee;
		revoke usage, select on sequence habitat_habitat_code_seq from zoo_administrator;
		revoke usage, select on sequence employee_post_employee_post_code_seq  from zoo_administrator;
		revoke usage, select on sequence visitor_id_visitor_seq  from zoo_administrator;
		revoke usage, select on sequence visitor_document_id_document_seq from zoo_administrator;
		revoke usage, select on sequence enclosure_id_enclosure_seq from zoo_administrator;
		revoke usage, select on sequence employee_id_employee_seq from zoo_administrator;
		revoke usage, select on sequence employee_enclosure_id_employee_enclosure_seq from zoo_administrator;
		revoke usage, select on sequence animal_id_animal_seq from zoo_administrator;
		revoke usage, select on sequence territory_id_territory_seq from zoo_administrator;
		revoke usage, select on sequence ticket_id_ticket_seq from zoo_administrator;
		revoke usage, select on sequence territory_ticket_id_territory_ticket_seq from zoo_administrator;
		revoke usage, select on sequence enclosure_care_day_id_enclosure_care_day_seq from zoo_administrator;
		revoke usage, select on sequence care_time_id_care_time_seq from zoo_administrator;
	
		revoke select on Habitat from zoo_visitor;
		revoke select on Animal from zoo_visitor;
		revoke select on Territory from zoo_visitor;
				
		revoke select, insert, update on Habitat from zoo_employee;
		revoke select on Employee_Post from zoo_employee;
		revoke select on Visitor from zoo_employee;
		revoke select on Visitor_Type from zoo_employee;
		revoke select, insert on Visitor_Document from zoo_employee;
		revoke select, insert on Enclosure from zoo_employee;
		revoke select on Employee from zoo_employee;
		revoke select on Employee_Enclosure from zoo_employee;
		revoke select, insert, update, delete on Animal from zoo_employee;
		revoke select, insert on Territory from zoo_employee;
		revoke select, insert on Ticket from zoo_employee;
		revoke select, insert on Territory_Ticket from zoo_employee;
		revoke select, insert on Enclosure_Care_Day from zoo_employee;
		revoke select, insert on Care_Time from zoo_employee;
		
		revoke select, insert, update, delete on Habitat from zoo_administrator;
		revoke select, insert, update, delete on Employee_Post from zoo_administrator;
		revoke select, insert, update, delete on Visitor from zoo_administrator;
		revoke select, insert on Visitor_Document from zoo_administrator;
		revoke select, insert, update, delete on Enclosure from zoo_administrator;
		revoke select, insert, update, delete on Employee from zoo_administrator;
		revoke select, insert, update, delete on Employee_Enclosure from zoo_administrator;
		revoke select, insert, update, delete on Animal from zoo_administrator;
		revoke select on Animal_Squad from zoo_administrator;
		revoke select on Animal_Family from zoo_administrator;
		revoke select on Animal_Type from zoo_administrator;
		revoke select, insert, update, delete on Territory from zoo_administrator;
		revoke select, insert, update on Ticket from zoo_administrator;
		revoke select, insert, update on Territory_Ticket from zoo_administrator;
		revoke select, insert, update, delete on Enclosure_Care_Day from zoo_administrator;		
		revoke select, insert, update, delete on Care_Time from zoo_administrator;
		
		drop index if exists index_Habitat_Code;
		drop index if exists index_Habitat_Name;
		
		drop index if exists index_Employee_Post_Code;
		drop index if exists index_Employee_Post_Name;
		
		drop index if exists index_ID_Visitor;
		drop index if exists index_Visitor_Login_Password;
		drop index if exists index_Visitor_Passport_Series_Passport_Number;
		drop index if exists index_Visitor_Name_Surname_Patronymic;
		
		drop index if exists index_ID_Visitor_Type;
		drop index if exists index_Name_Visitor_Type;
				
		drop index if exists index_ID_Document;
		drop index if exists index_Number_Document;
		
		drop index if exists index_ID_Enclosure;
		drop index if exists index_Name_Enclosure;
				
		drop index if exists index_Employee_Name_Surname_Patronymic;
		drop index if exists index_Employee_Login_Password;
		drop index if exists index_ID_Employee;
		
		drop index if exists index_ID_Employee_Enclosure;
		
		drop index if exists index_ID_Animal;
		drop index if exists index_Number_Animal;
		
		drop index if exists index_ID_Animal_Squad;
		drop index if exists index_Name_Animal_Squad;
		
		drop index if exists index_ID_Animal_Family;
		drop index if exists index_Name_Animal_Family;
		
		drop index if exists index_ID_Animal_Type;
		drop index if exists index_Name_Animal_Type;
		
		drop index if exists index_ID_Territory;
		drop index if exists index_Name_Territory;
		
		drop index if exists index_ID_Ticket;
		drop index if exists index_Number_Ticket;
		
		drop index if exists index_ID_Territory_Ticket;
		
		drop index if exists index_ID_Enclosure_Care_Day;
		
		drop index if exists index_ID_Caretime;
		
		

		drop table if exists animal;
		drop table if exists animal_type;
		
		drop table if exists visitor_document;
		drop table if exists care_time;
		drop table if exists territory_ticket;
		drop table if exists ticket;
		drop table if exists enclosure_care_day;

		drop table if exists employee_enclosure;

		drop table if exists habitat;
		drop table if exists visitor;
		drop table if exists visitor_type;
		drop table if exists territory;
		drop table if exists employee;
		drop table if exists employee_post;


		drop table if exists animal_family;
		drop table if exists animal_squad;
		
		drop table if exists enclosure;

	end;
$$;