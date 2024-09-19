create or replace function get_animal_info(p_number_animal varchar(100))
returns text
language plpgsql
as $$
	declare res text;
	declare exist_animal smallint := count(*) from animal where number_animal = p_number_animal;
	begin
		if exist_animal = 0 then
			res := 'Данные о животном не найдены!';
		else
			select 
				name_animal_type || ', ' ||
				'семейство: ' || name_animal_family || ', ' ||
				'отряд: ' || name_animal_squad || ', ' ||
				'ареал обитания: ' || habitat_name || ', ' ||
  				'краткое описание: ' || description_animal || '.'
			into res
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
					animal_family.id_animal_squad = animal_squad.id_animal_squad
			where number_animal = p_number_animal; 
		end if;
		return res;
	end;
$$;

select get_animal_info('PRD00000002');
select get_animal_info('PRD00000005');
select get_animal_info('HRS00000002');
select get_animal_info('HRS00000003');
select get_animal_info('FL00000010');

create or replace function get_enclosure_of_employee(p_login_employee varchar(100), p_password_employee varchar(100))
returns text
language plpgsql
as $$
	declare res text;
	declare exist_employee smallint := count(*) from employee where login_employee = p_login_employee and password_employee = p_password_employee; 
	begin
		if exist_employee = 0 then
			res := 'Пользователь не найден!';
		else
			select 
				string_agg(name_enclosure, ', ')
			into res
			from employee
				inner join employee_enclosure on
					employee.id_employee = employee_enclosure.id_employee
				inner join enclosure on
					employee_enclosure.id_enclosure = enclosure.id_enclosure
			where login_employee = p_login_employee and password_employee = p_password_employee; 
		end if;
		return coalesce(res, 'Нет назначенных вольеров');
	end;
$$;

select get_enclosure_of_employee('wk_IvanovII', 'Pa$$w0rd');
select get_enclosure_of_employee('wk_PetrovPP', 'Pa$$w0rd');
select get_enclosure_of_employee('wk_AlekseevAA', 'Pa$$w0rd');
select get_enclosure_of_employee('wk_PavlovPP', 'Pa$$w0rd');
select get_enclosure_of_employee('User_1', 'Password');

drop function get_work_plan_info;

create or replace function get_work_plan_info(p_work_plan_number varchar(100))
returns table ("Начало, Вольер, Срок" text, "Перемещение" text, "Задача, срок" text, "Статус" text)
language plpgsql
as $$
	declare
    	exist_plan int;
	begin
    	select count(*) into exist_plan from work_plan where work_plan_number = p_work_plan_number;

    if exist_plan = 0 then
        return query select
            'Нет данных',
            'Нет данных',
            'Нет данных',
            'Нет данных';
	else
		return query select
			coalesce(work_plan_date || ', вольер номер: ' || name_enclosure || ', период работ: ' || work_plan_start_date || ' - ' || work_plan_end_date, 'Нет данных'),
			coalesce(substring(work_plan_instruction, 23, 100), 'Нет данных'),
			coalesce(work_list_name::text, 'Нет данных'),
			coalesce(work_status_name::text, 'Нет данных')
		from work_plan
			inner join enclosure on
				work_plan.work_plan_enclosure = enclosure.id_enclosure
			inner join work_list_plan on
				work_plan_code = code_work_plan
			inner join work_list on
				work_list_code = code_work_list
			inner join work_status on
				work_plan.work_plan_status = work_status.work_status_code
		where work_plan_number = p_work_plan_number;
	end if;
	end;
$$;

select * from get_work_plan_info('ГРМ-23-0000000001');
select * from get_work_plan_info('ГРМ-24-0000000001');
select * from get_work_plan_info('ГРМ-24-0000000002');
select * from get_work_plan_info('ГРМ-24-0000000004');

grant execute on function get_animal_info to zoo_visitor;
grant select on animal, enclosure, habitat, territory, animal_zone, enclosure_status, animal_type, animal_family, animal_squad to zoo_visitor;

grant execute on function get_animal_info to zoo_employee;
grant execute on function get_enclosure_of_employee to zoo_employee;
grant select on animal, enclosure, habitat, territory, animal_zone, enclosure_status, animal_type, animal_family, animal_squad to zoo_employee;

grant execute on function get_animal_info to zoo_administrator;
grant execute on function get_enclosure_of_employee to zoo_administrator;
grant execute on function get_work_plan_info to zoo_administrator;
grant select on work_list_plan, work_list, work_plan to zoo_administrator;