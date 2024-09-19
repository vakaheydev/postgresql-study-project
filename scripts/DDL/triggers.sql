CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
create table if not exists Ticket_History
(
	ID_Ticket_History uuid default uuid_generate_v4() constraint PK_Ticket_History primary key,
	Number_Ticket varchar (16) not null,
	Datetime_Ticket timestamp not null,
	Surname_Name_Patronymic_Visitor varchar(50) not null,
	Name_Territory varchar(100) not null,
	Total_Sum_Ticket decimal(6,2) not null,
	Number_Document varchar(100) not null,
	Ticket_History_Status varchar (20) not null constraint CH_Ticket_History_Status check (Ticket_History_Status in ('Новая запись','Изменение','Удалённая')),
	Timestamp_Create timestamp null default current_timestamp
);

drop table Ticket_History;

create or replace function fc_Ticket_History_Insert()
returns trigger
language plpgsql 
as $$
	begin
		insert into Ticket_History(Number_Ticket, Datetime_Ticket, Surname_Name_Patronymic_Visitor, Name_Territory, 
								   Total_Sum_Ticket, Number_Document, Ticket_History_Status)
		values (
			(select number_ticket from ticket where new.id_ticket = ticket.id_ticket),
			(select datetime_ticket from ticket where new.id_ticket = ticket.id_ticket),
			(select surname_visitor || ' ' || name_visitor || ' '|| patronymic_visitor
			 from ticket 
			 	inner join visitor on
			 		ticket.id_visitor = visitor.id_visitor
			 where ticket.id_ticket = new.id_ticket),
			(select name_territory from territory where new.id_territory = territory.id_territory),
			(select total_sum_ticket from ticket where new.id_ticket = ticket.id_ticket),
			coalesce(
				(select name_document || ': ' || number_document
				 from ticket
				 	inner join visitor on
				 		ticket.id_visitor = visitor.id_visitor
				 	inner join visitor_document on
				 		visitor.id_visitor = visitor_document.id_visitor
				 where ticket.id_ticket = new.id_ticket), 
				'Нет данных'),
			'Новая запись'
		);
		return new;
	end;
$$;

create trigger tg_Ticket_History_Insert
after insert on territory_ticket
for each row 
execute procedure fc_Ticket_History_Insert();

ПБЗ-000000001/24, Константинова Анастасия Вячеславовна, Океанариум

select * from visitor;
select * from visitor_document;
select * from territory;
select * from territory_ticket;
select * from ticket;

insert into ticket (number_ticket, datetime_ticket, price_ticket, total_sum_ticket, id_visitor) values 
	('ПБЗ-000000001/24', now(), 500, 1000, 1);
insert into territory_ticket (id_ticket, id_territory) values
	(8, 2);
	
create or replace function fc_Ticket_History_Update()
returns trigger
language plpgsql 
as $$
	begin
		insert into Ticket_History(Number_Ticket, Datetime_Ticket, Surname_Name_Patronymic_Visitor, Name_Territory, 
								   Total_Sum_Ticket, Number_Document, Ticket_History_Status)
		values (
			(select number_ticket from ticket where new.id_ticket = ticket.id_ticket),
			(select datetime_ticket from ticket where new.id_ticket = ticket.id_ticket),
			(select surname_visitor || ' ' || name_visitor || ' '|| patronymic_visitor
			 from ticket 
			 	inner join visitor on
			 		ticket.id_visitor = visitor.id_visitor
			 where ticket.id_ticket = new.id_ticket),
			(select name_territory from territory where new.id_territory = territory.id_territory),
			(select total_sum_ticket from ticket where new.id_ticket = ticket.id_ticket),
			coalesce(
				(select name_document || ': ' || number_document
				 from ticket
				 	inner join visitor on
				 		ticket.id_visitor = visitor.id_visitor
				 	inner join visitor_document on
				 		visitor.id_visitor = visitor_document.id_visitor
				 where ticket.id_ticket = new.id_ticket), 
				'Нет данных'),
			'Изменение'
		);
		return new;
	end;
$$;

create trigger tg_Ticket_History_Update
after update on territory_ticket
for each row 
execute procedure fc_Ticket_History_Update();

ПБЗ-000000001/24, Константинова Анастасия Вячеславовна, Океанариум → 
ПБЗ-000000001/24, Константинова Анастасия Вячеславовна, Контактный зоопарк

update territory_ticket set id_territory = 3 where id_ticket = 8;

ПБЗ-000000002/24, Максимов Константин Иванович - студенческий билет: 05/62-82962672-20, Контактный зоопарк

select * from ticket;

insert into ticket (number_ticket, datetime_ticket, price_ticket, total_sum_ticket, id_visitor) values 
	('ПБЗ-000000002/24', now(), 500, 1000, 3);	
insert into territory_ticket (id_ticket, id_territory) values
	(9, 3);
	
delete from territory_ticket where id_ticket = 9;
select * from territory_ticket;	
select * from ticket_history;
	
create or replace function fc_Ticket_History_Delete()
returns trigger
language plpgsql 
as $$
	begin
		insert into Ticket_History(Number_Ticket, Datetime_Ticket, Surname_Name_Patronymic_Visitor, Name_Territory, 
								   Total_Sum_Ticket, Number_Document, Ticket_History_Status)
		values (
			(select number_ticket from ticket where old.id_ticket = ticket.id_ticket),
			(select datetime_ticket from ticket where old.id_ticket = ticket.id_ticket),
			(select surname_visitor || ' ' || name_visitor || ' '|| patronymic_visitor
			 from ticket 
			 	inner join visitor on
			 		ticket.id_visitor = visitor.id_visitor
			 where ticket.id_ticket = old.id_ticket),
			(select name_territory from territory where old.id_territory = territory.id_territory),
			(select total_sum_ticket from ticket where old.id_ticket = ticket.id_ticket),
			coalesce(
				(select name_document || ': ' || number_document
				 from ticket
				 	inner join visitor on
				 		ticket.id_visitor = visitor.id_visitor
				 	inner join visitor_document on
				 		visitor.id_visitor = visitor_document.id_visitor
				 where ticket.id_ticket = old.id_ticket), 
				'Нет данных'),
			'Удалённая'
		);
		return old;
	end;
$$;

create trigger tg_Ticket_History_Delete
before delete on territory_ticket
for each row 
execute procedure fc_Ticket_History_Delete();

delete from territory_ticket where id_ticket = 15;

select * from ticket_history;

grant select on Ticket_History to zoo_visitor;
grant select on Ticket_History to zoo_employee;
grant select on Ticket_History to zoo_administrator;

create or replace function Function_Get_Ticket_History_List(p_login_visitor varchar(100))
returns table (num varchar(16), Datetime_Ticket timestamp, Surname_Name_Patronymic_Visitor varchar(50), Name_Territory varchar(100),
			  Total_Sum_Ticket decimal(6,2), Number_Document varchar(100), Ticket_History_Status varchar (20))
language plpgsql 
as $$
	declare
		primary_id_ticket int;
	begin
		select id_ticket into primary_id_ticket from ticket_history
			inner join ticket on
				ticket.number_ticket = ticket_history.number_ticket;
	
		return query select 
			Number_Ticket, 
			ticket_history.Datetime_Ticket,
			ticket_history.Surname_Name_Patronymic_Visitor,
			ticket_history.Name_Territory,
			ticket_history.Total_Sum_Ticket,
			ticket_history.Number_Document,
			ticket_history.Ticket_History_Status 
		from ticket_history where ticket_history.Surname_Name_Patronymic_Visitor = 
			(select distinct surname_visitor || ' ' || name_visitor || ' '|| patronymic_visitor
			 from ticket_history 
				inner join ticket on
					primary_id_ticket = ticket.id_ticket
				inner join visitor on
					ticket.id_visitor = visitor.id_visitor
			 where login_visitor = p_login_visitor);
	end;
$$;

select * from Function_Get_Ticket_History_List('KonstantinovaAV');

grant execute on function Function_Get_Ticket_History_List to zoo_visitor;
grant execute on function Function_Get_Ticket_History_List to zoo_employee;
grant execute on function Function_Get_Ticket_History_List to zoo_administrator;

select 
	table_name as "Таблица", 
	string_agg(trigger_name||' '||event_manipulation, ', ') as "Триггеры" 
from information_schema.triggers
	inner join information_schema.tables on 
		table_name = event_object_table
		group by 
			table_name
union all
select 
	'Количество'::name, 
	count(trigger_name)::text  
from information_schema.triggers
	inner join information_schema.tables on 
		table_name = event_object_table
		group by 
			table_name;
