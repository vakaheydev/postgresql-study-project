update ticket set number_ticket = 'ПБЗ-000000002/23' where id_ticket = 2;
update ticket set number_ticket = 'ПБЗ-000000003/23' where id_ticket = 3;
update ticket set number_ticket = 'ПБЗ-000000004/23' where id_ticket = 4;
update ticket set number_ticket = 'ПБЗ-000000005/23' where id_ticket = 5;
update ticket set number_ticket = 'ПБЗ-000000006/23' where id_ticket = 6;
update ticket set number_ticket = 'ПБЗ-000000007/23' where id_ticket = 7;	

select * from ticket;

delete from Territory_Ticket;
alter sequence public.territory_ticket_id_territory_ticket_seq restart with 1;

call territory_ticket_insert(1, 1);
call territory_ticket_insert(1, 2);
call territory_ticket_insert(1, 3);
call territory_ticket_insert(1, 4);
call territory_ticket_insert(1, 5);
call territory_ticket_insert(1, 6);
call territory_ticket_insert(1, 7);

call territory_ticket_insert(2, 2);
call territory_ticket_insert(2, 3);
call territory_ticket_insert(2, 4);
call territory_ticket_insert(2, 7);

call territory_ticket_insert(3, 6);
call territory_ticket_insert(3, 7);

create or replace view Tickets_to_Territories (
	"Территория", "Цена за вход", "Билеты", "Количество билетов")
as
select
	name_territory,
	price_territory,
	string_agg(number_ticket, ', '),
	count(number_ticket)
from territory as ter
	inner join territory_ticket as ter_tic on
		ter.id_territory = ter_tic.id_territory
	inner join ticket as tic on
		ter_tic.id_ticket = tic.id_ticket
	group by name_territory, price_territory;
select * from Tickets_to_Territories;

create table animal_zone (
	animal_zone_code serial not null constraint PK_Animal_Zone primary key,
	animal_zone_name varchar(100) not null constraint UQ_Animal_Zone_Name unique
);

create index if not exists index_animal_zone_code on animal_zone(animal_zone_code);
create index if not exists index_animal_zone_name on animal_zone(animal_zone_name);

create or replace procedure Animnal_Zoo_Zone_Insert (p_animal_zone_name varchar(100))
language plpgsql
as $$
	begin
		insert into animal_zone (animal_zone_name)
		values (p_animal_zone_name);
		exception when others then
			raise notice 'Указанная зона зоопарка животного уже есть в таблице!';
	end;
$$;

create or replace procedure Animnal_Zoo_Zone_Update (p_animal_zone_code int, p_animal_zone_name Varchar(100))
language plpgsql
as $$
	begin
		update animal_zone set
			animal_zone_name = p_animal_zone_name
				where
					animal_zone_code = p_animal_zone_code;
				exception when others then
				raise notice 'Указанная зона зоопарка животного уже есть в таблице!';
	end;
$$;

create or replace procedure Animnal_Zoo_Zone_Delete (p_animal_zone_code int)
language plpgsql
as $$
	declare
		p_Exist_Animals smallint := count(*) from animal
			where code_animal_zone = p_animal_zone_code;
	begin
		if(p_Exist_Animals > 0) then
			raise notice 'Данная зона зоопарка не может быть удалена, т.к. она используется в животных';
	else
		delete from animal_zone
			where
				animal_zone_code = p_animal_zone_code;
	end if;
	end;
$$;

call Animnal_Zoo_Zone_Insert('Хищники');
call Animnal_Zoo_Zone_Insert('Травоядные');
call Animnal_Zoo_Zone_Insert('Воздушные');

alter table enclosure
	add column 
		code_animal_zone int references animal_zone(animal_zone_code);
		
		
update enclosure set code_animal_zone = 1 where name_enclosure like 'X%';
update enclosure set code_animal_zone = 2 where name_enclosure like 'T%';
update enclosure set code_animal_zone = 3 where name_enclosure like 'B%';

alter table enclosure
	 alter column code_animal_zone set not null;
		

create or replace view Animal_Characteristics (
	"Зона зоопарка", "Вольер", "Животное", "Семейство", "Отряд", "Ареал обитания", "Краткое описание")
as
select
	animal_zone_name,
	'№ вольера: ' || name_enclosure || ', статус: «' || enclosure_status_name || '»',
	COALESCE('№ животного: ' || number_animal || ', название: ' || name_animal_type, 'Нет данных'),
	COALESCE(name_animal_family, 'Нет данных'),
	COALESCE(name_animal_squad, 'Нет данных'),
	COALESCE(habitat_name, 'Нет данных'),
	COALESCE(description_animal, 'Нет данных')
from enclosure
	left join animal as an on
		enclosure.id_enclosure = an.id_enclosure
	left join territory as ter on
		ter.id_territory = an.id_territory
	left join habitat as hab on
		an.habitat_code = hab.habitat_code
	left join animal_zone as a_z on
		enclosure.code_animal_zone = a_z.animal_zone_code
	left join enclosure_status on
		enclosure.status_enclosure = enclosure_status.enclosure_status_code
	left join animal_type on 
		an.id_animal_type = animal_type.id_animal_type
	left join animal_family on 
		animal_type.id_animal_family = animal_family.id_animal_family
	left join animal_squad on 
		animal_family.id_animal_squad = animal_squad.id_animal_squad;
select * from Animal_Characteristics;
	
alter table visitor_document
	add column
		name_document varchar(100);
		
update visitor_document set
	name_document = 'Пенсионное удостоверение' where id_document = 2 or id_document = 4;
update visitor_document set
	name_document = 'Свидетельство о рождении' where id_document = 1 or id_document = 6;
update visitor_document set
	name_document = 'Студенческий билет' where id_document = 3 or id_document = 5;
	
delete from visitor_document where id_document = 7;

create or replace view Employee_And_Visitors_Characteristics(
	"ФИО", "Данные профиля", "Логин", "Пароль", "Вид профиля")
as
select 
	surname_employee || ' ' || name_employee || ' ' || patronymic_employee,
	employee_post_name,
	login_employee,
	password_employee,
	'Сотрудник'
from employee
	inner join employee_post on
		employee.employee_post_code = employee_post.employee_post_code
union all
select
	surname_visitor || ' ' || name_visitor || ' ' || patronymic_visitor,
	COALESCE(string_agg(name_document || ': ' || number_document, ', '), 'Нет льготных документов'),
	login_visitor,
	password_visitor,
	'Посетитель'
from visitor
	left join visitor_document on
		visitor.id_visitor = visitor_document.id_visitor
	group by surname_visitor || ' ' || name_visitor || ' ' || patronymic_visitor, login_visitor, password_visitor;
select * from Employee_And_Visitors_Characteristics;

create or replace view Employees_Care_time (
	"Сотрудник", "Вольер", "Дни недели", "Время кормления")
as
select
	surname_employee || ' ' || name_employee || ' ' || patronymic_employee || ', ' || employee_post_name,
	'Вольер: ' || name_enclosure || ', зона: ' || animal_zone_name,
	string_agg(distinct(enclosure_care_day::varchar), ', '),
	string_agg(distinct(care_time)::varchar, ', ')
from employee		
	inner join employee_post on
		employee.employee_post_code = employee_post.employee_post_code
	inner join employee_enclosure on
		employee.id_employee = employee_enclosure.id_employee
	inner join enclosure on
		employee_enclosure.id_enclosure = enclosure.id_enclosure
	inner join animal_zone on
		enclosure.code_animal_zone = animal_zone.animal_zone_code
	inner join enclosure_care_day on
		employee_enclosure.id_employee_enclosure = enclosure_care_day.id_employee_enclosure
	inner join care_time on
		enclosure_care_day.id_enclosure_care_day = care_time.id_enclosure_care_day
	group by surname_employee || ' ' || name_employee || ' ' || patronymic_employee || ', ' || employee_post_name, 	'Вольер: ' || name_enclosure || ', зона: ' || animal_zone_name;
select * from Employees_Care_time;

create or replace view visitor_documents (
	"visitor", "documents"
)
as
select 
	visitor.id_visitor,
	coalesce(
		string_agg(name_document || ': ' || number_document, ', '), 
		'Нет льготных документов'
	) as documents
from visitor
	left join visitor_document on
		visitor_document.id_visitor = visitor.id_visitor
group by visitor.id_visitor;

update ticket set total_sum_ticket = 1200 where id_ticket = 2;
update ticket set total_sum_ticket = 750 where id_ticket = 1;
	
create or replace view Visitors_Tickets_Info (
	"Посетитель", "Билет", "Базовая стоимость", "Дополнительно", "Дополнительная стоимость", "Всего", "Льготные документы", "Скидка", "Итого")
as
select distinct 
	surname_visitor || ' ' || name_visitor || ' ' || patronymic_visitor,
	number_ticket || ' , дата создания: ' || datetime_ticket,
	'750 р.',
	case 
        when count(*) = 1 and max(ter.name_territory) = 'Общая территория' then 'Без дополнительных областей'
        else STRING_AGG(
            case 
                when ter.name_territory = 'Общая территория' THEN null
                else ter.name_territory
            end, ', ')
    end,
	
	case 
        when count(*) = 1 and max(ter.name_territory) = 'Общая территория' then 0
        else sum(price_territory) - 750
    end || ' р.',
	price_ticket,
	documents,
	benefits_visitor || ' %',
	total_sum_ticket
from territory_ticket as ter_tic
	inner join ticket as tic on
		ter_tic.id_ticket = tic.id_ticket
	inner join visitor as vis on
		vis.id_visitor = tic.id_visitor
	left join visitor_documents on
		vis.id_visitor = visitor_documents.visitor
	inner join territory as ter on
		ter_tic.id_territory = ter.id_territory
	group by 
		number_ticket,
		surname_visitor,
		surname_visitor || ' ' || name_visitor || ' ' || patronymic_visitor,
		number_ticket || ' , дата создания: ' || datetime_ticket,
		documents,
		price_ticket,
		benefits_visitor,
		total_sum_ticket;
	
select * from Visitors_Tickets_Info;

create or replace view Work_Plan_Info (
	"Номер строительного графика", "Вольер", "Период", "Переселение", "Ремонтные работы", "Статус графика")
as
select
	work_plan_number || ', дата формирования: ' || work_plan_date,
	name_enclosure as "Номер вольера",
	work_plan_start_date || ' - ' || work_plan_end_date,
	substring(work_plan_instruction, 23, 100),
	string_agg('- ' || work_list_name, ';'),
	work_status_name
from work_plan
	inner join enclosure on
		work_plan.work_plan_enclosure = enclosure.id_enclosure
	inner join work_list_plan on
		work_plan_code = code_work_plan
	inner join work_list on
		work_list_code = code_work_list
	inner join work_status on
		work_plan.work_plan_status = work_status.work_status_code
	group by
		work_plan_number || ', дата формирования: ' || work_plan_date,
		name_enclosure,
		work_plan_start_date || ' - ' || work_plan_end_date,
		work_plan_instruction,
		work_status_name;
select * from Work_Plan_Info;

grant select on Animal_Characteristics to zoo_visitor;
grant select on Animal_Characteristics to zoo_employee;
grant select on Animal_Characteristics to zoo_administrator;

grant select on Employee_And_Visitors_Characteristics to zoo_employee;
grant select on Employee_And_Visitors_Characteristics to zoo_administrator;

grant select on Employees_Care_Time to zoo_employee;
grant select on Employees_Care_Time to zoo_administrator;

grant select on Tickets_To_Territories to zoo_employee;
grant select on Tickets_To_Territories to zoo_administrator;

grant select on Visitor_Documents to zoo_employee;
grant select on Visitor_Documents to zoo_administrator;

grant select on Visitors_Tickets_Info to zoo_employee;
grant select on Visitors_Tickets_Info to zoo_administrator;

grant select on Work_Plan_Info to zoo_administrator;