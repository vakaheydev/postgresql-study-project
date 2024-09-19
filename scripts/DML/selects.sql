call enclosure_status_insert('Открыт');
call enclosure_status_insert('Переоборудование');
call enclosure_status_insert('Ремонт');
select * from enclosure_status;

call work_list_insert('Замена ограждения по периметру', '0-2');
call work_list_insert('Обновление системы подачи водоснабжения и отчистки воды', '0-5');
call work_list_insert('Обновление купола вольера', '0-5');
call work_list_insert('Реконструкция крытого вольера содержания', '0-4');
call work_list_insert('Замена ветровых окон', '0-2');
call work_list_insert('Замена ограждения по периметру', '0-4');
call work_list_insert('Обновление системы подачи корма', 'P0Y2M15D');
call work_list_insert('Реконструкция дополнительных построек внутри вольера', '0-1');
call work_list_insert('Реконструкция систем освещения', '0-2');
call work_list_insert('Обновление системы подачи водоснабжения и отчистки воды', '0-5');
call work_list_insert('Реконструкция крытого вольера содержания', '0-4');
call work_list_insert('Реконструкция общей площадки обитания животных', '0-4');
call work_list_insert('Разработка системы автоматической подачи корма', '0-5');
call work_list_insert('Разработка системы температурного регулирования', '0-5');
select * from work_list;

call work_status_insert('Ожидается начало');
call work_status_insert('Ведутся ремонтные работы');
call work_status_insert('Завершен');
select * from work_status;

call work_plan_insert('10/09/2023', '15/09/2023', '15/03/2024', 'перемещение животных: Распределить
животных по вольерам В1 и В2', 8, 2);
call work_plan_insert('02/02/2024', '10/03/2024', '01/08/2024', 'перемещение животных: Перемещение
животных в вольер Т2', 4, 1);
call work_plan_insert('02/02/2024', '10/03/2024', '20/08/2024', 'перемещение животных: Перемещение
животных во временные крытые, закрытые вольеры', 1, 1);
call work_plan_insert('12/02/2024', '30/03/2024', '01/09/2024', 'перемещение животных: Перемещение
животных во временные крытые', 2, 1);
select * from work_plan;

call work_list_plan_insert(1, 1);
call work_list_plan_insert(2, 1);
call work_list_plan_insert(3, 1);
call work_list_plan_insert(4, 2);
call work_list_plan_insert(5, 2);
call work_list_plan_insert(6, 2);
call work_list_plan_insert(7, 2);
call work_list_plan_insert(8, 3);
call work_list_plan_insert(9, 3);
call work_list_plan_insert(10, 3);
call work_list_plan_insert(11, 3);
call work_list_plan_insert(12, 4);
call work_list_plan_insert(13, 4);
call work_list_plan_insert(14, 4);
select * from work_list_plan;

-- Равно
select 
	number_animal as "Номер животного",
	name_animal_type as "Название животного",
	habitat_name as "Ареал обитания",
	animal.id_enclosure as "Номер вольера"
from animal
	inner join animal_type on 
		animal.id_animal_type = animal_type.id_animal_type
	inner join habitat on 
		animal.habitat_code = habitat.habitat_code
	inner join enclosure on
		 animal.id_enclosure = enclosure.id_enclosure
	where name_enclosure = 'X1';
	
select * from animal_squad;
	
-- Не равно
select
	name_territory as "Название зоны",
	name_enclosure as "Номер вольера",
	enclosure_status_name as "Статус вольера",
	number_animal as "Номер животного",
	name_animal_type as "Название животного"
from animal
	inner join territory on
		animal.id_territory = territory.id_territory
	inner join enclosure on
		animal.id_enclosure = enclosure.id_enclosure
	inner join enclosure_status on
		status_enclosure = enclosure_status_code
	inner join animal_type on 
		animal.id_animal_type = animal_type.id_animal_type
	inner join animal_family on 
		animal_type.id_animal_family = animal_family.id_animal_family
	inner join animal_squad on 
		animal_family.id_animal_squad = animal_squad.id_animal_squad
	where name_animal_squad <> 'Хищные' and name_animal_squad <> 'Ястребообразные' and name_animal_squad <> 'Соколообразные';
	
-- Меньше
select
	number_ticket as "Номер билета",
	surname_visitor as "Фамилия посетителя",
	name_visitor as "Имя посетителя",
	patronymic_visitor as "Отчество посетителя",
	datetime_ticket as "Дата печати",
	total_sum_ticket as "Сумма к оплате"
from ticket
	inner join visitor on
		visitor.id_visitor = ticket.id_visitor
	where total_sum_ticket < 700;
		
-- Больше
select
	number_ticket as "Номер билета",
	surname_visitor as "Фамилия посетителя",
	name_visitor as "Имя посетителя",
	patronymic_visitor as "Отчество посетителя",
	datetime_ticket as "Дата печати",
	total_sum_ticket as "Сумма к оплате"
from ticket
	inner join visitor on
		visitor.id_visitor = ticket.id_visitor
	where total_sum_ticket > 1000;
	
-- Похоже на
select 
	number_animal as "Номер животного",
	name_animal_type as "Название животного",
	name_animal_family as "Название семейства",
	name_animal_squad as "Название отряда",
	habitat_name as "Ареал обитания"
from animal
	inner join animal_type on 
		animal.id_animal_type = animal_type.id_animal_type
	inner join animal_family on 
		animal_type.id_animal_family = animal_family.id_animal_family
	inner join animal_squad on 
		animal_family.id_animal_squad = animal_squad.id_animal_squad
	inner join habitat on 
		animal.habitat_code = habitat.habitat_code
	where habitat_name like '%Еврази%';
	
-- Не похоже на
select 
	number_animal as "Номер животного",
	name_animal_type as "Название животного",
	habitat_name as "Ареал обитания",
	description_animal as "Описание животного"
from animal
	inner join animal_type on 
		animal.id_animal_type = animal_type.id_animal_type
	inner join habitat on 
		animal.habitat_code = habitat.habitat_code
	where name_animal_type not like '%пард%';
	
-- Один из коллекции
select 
	name_enclosure as "Номер вольера",
	name_animal_type as "Название животного",
	name_animal_family as "Название семейства",
	description_animal as "Описание животного"
from animal
	inner join animal_type on 
		animal.id_animal_type = animal_type.id_animal_type
	inner join animal_family on 
		animal_type.id_animal_family = animal_family.id_animal_family
	inner join enclosure on
		 animal.id_enclosure = enclosure.id_enclosure
	where name_animal_family in ('Кошачьи', 'Соколиные');
	
-- Не один из коллекции
select
	number_ticket as "Номер билета",
	surname_visitor as "Фамилия посетителя",
	name_visitor as "Имя посетителя",
	patronymic_visitor as "Отчество посетителя",
	benefits_visitor as "Размер скидки"
from ticket
	inner join visitor on
		visitor.id_visitor = ticket.id_visitor
	where
		benefits_visitor not in(0, 30);
	
-- В диапазоне
select
	number_ticket as "Номер билета",
	surname_visitor as "Фамилия посетителя",
	name_visitor as "Имя посетителя",
	patronymic_visitor as "Отчество посетителя",
	name_territory as "Название территории",
	datetime_ticket as "Дата печати"
from ticket
	inner join visitor on
		visitor.id_visitor = ticket.id_visitor
	inner join territory_ticket on
		ticket.id_ticket = territory_ticket.id_ticket
	inner join territory on
		territory_ticket.id_territory = territory.id_territory
	where
		datetime_ticket between '2023-01-09' and '2023-05-09';
		
-- Вне диапазона
select
	name_enclosure as "Номер вольера",
	surname_employee as "Фамилия сотрудника",
	name_employee as "Имя сотрудника",
	patronymic_employee as "Отчество сотрудника",
	enclosure_care_day as "День недели",
	care_time as "Время кормления"
from employee
	inner join employee_enclosure on
		employee.id_employee = employee_enclosure.id_employee
	inner join enclosure on
		employee_enclosure.id_enclosure = enclosure.id_enclosure
	inner join enclosure_care_day on
		employee_enclosure.id_employee_enclosure = enclosure_care_day.id_employee_enclosure
	inner join care_time on
		enclosure_care_day.id_enclosure_care_day = care_time.id_enclosure_care_day
	where care_time between '08:00:00' and '15:00:00';
		
-- Два и более фильтра
select
	work_plan_number as "Номер плана ремонтных работ",
	work_plan_date as "Дата формирования",
	work_plan_start_date as "Начало работ",
	work_plan_end_date as "Конец работ",
	work_list_name as "Название перечня работ",
	work_list_interval as "Плановый срок выполнения работ"
from work_plan
	inner join work_list_plan on
		work_plan_code = code_work_plan
	inner join work_list on
		work_list_code = code_work_list
	where 
		work_list_name like '%Реконструкция%' and
		work_list_interval > '0-2';
				
-- Переключатель
select
	work_plan_number as "Номер плана ремонтных работ",
	work_plan_date as "Дата формирования",
	work_list_name as "Название перечня работ",
	work_list_interval as "srok",
	case 
		when work_list_interval between '0-1' and '0-2' then 'Краткосрочные работы'
		when work_list_interval between '0-3' and '0-4' then 'Продолжительные работы'
		when work_list_interval >= '0-5' then 'Долгосрочные работы'
		else 'Непредвиденный случай'
	end as "Cрок выполнения работ"
from work_plan
	inner join work_list_plan on
		work_plan_code = code_work_plan
	inner join work_list on
		work_list_code = code_work_list;	


-- Количество записей
select
	name_animal_family as "Название семейства",
	count(id_animal) as "Количество животных"
from animal_family
	inner join animal_type on
		animal_type.id_animal_family = animal_family.id_animal_family
	inner join animal on
		animal_type.id_animal_type = animal.id_animal_type
	group by 
		name_animal_family;
		
-- Суммарный результат
select
	name_territory as "Название территории",
	sum(total_sum_ticket) as "Суммарная выручка от билетов"
from territory
	inner join territory_ticket on
		territory.id_territory = territory_ticket.id_territory
	inner join ticket on
		territory_ticket.id_ticket = ticket.id_ticket
	group by
		name_territory;
		

-- Среднеарифмитический результат
select
	name_territory as "Название территории",
	avg(benefits_visitor) as "Ср. значение льгот"
from territory
	inner join territory_ticket on
		territory.id_territory = territory_ticket.id_territory
	inner join ticket on
		territory_ticket.id_ticket = ticket.id_ticket
	inner join visitor on
		ticket.id_visitor = visitor.id_visitor
	group by
		name_territory;
		
-- Округление значений
select
	number_ticket as "Номер билета",
	round((benefits_visitor / 100.0 * total_sum_ticket * 0.6), 1) as "Кэшбек"
from territory
	inner join territory_ticket on
		territory.id_territory = territory_ticket.id_territory
	inner join ticket on
		territory_ticket.id_ticket = ticket.id_ticket
	inner join visitor on
		ticket.id_visitor = visitor.id_visitor
	group by
		number_ticket, benefits_visitor, total_sum_ticket;
		
-- Объединение столбцов
select
	concat(name_territory , ' | ', name_enclosure , ' | ', number_animal) as "Информация про место",
	concat(name_animal_type , ' | ', name_animal_family , ' | ', name_animal_squad) as "Информация про животное"
from animal
	inner join territory on
		animal.id_territory = territory.id_territory
	inner join enclosure on
		animal.id_enclosure = enclosure.id_enclosure
	inner join animal_type on
		animal.id_animal_type = animal_type.id_animal_type
	inner join animal_family on
		animal_type.id_animal_family = animal_family.id_animal_family
	inner join animal_squad on
		animal_family.id_animal_squad = animal_squad.id_animal_squad;
		
-- Объединение строк
select
	concat(surname_employee, ' ', name_employee, ' ', patronymic_employee) as "ФИО сотрудника",
	name_enclosure as "Название вольера",
	string_agg(concat(enclosure_care_day, ': ', care_time), ', ') as "График кормления"
from employee
	inner join employee_enclosure on
		employee.id_employee = employee_enclosure.id_employee
	inner join enclosure on
		employee_enclosure.id_enclosure = enclosure.id_enclosure
	inner join enclosure_care_day on
		employee_enclosure.id_employee_enclosure = enclosure_care_day.id_employee_enclosure
	inner join care_time on
		enclosure_care_day.id_enclosure_care_day = care_time.id_enclosure_care_day
	group by surname_employee, name_employee, patronymic_employee, name_enclosure;
	
-- Длина строки
select
	name_territory as "Название зоны зоопарка",
	number_animal as "Номер животного",
	name_animal_type as "Вид животного",
	description_animal as "Краткое описание животного",
	length(description_animal) as "Длина описания"
from animal
	inner join territory on
		animal.id_territory = territory.id_territory
	inner join animal_type on
		animal.id_animal_type = animal_type.id_animal_type;

-- Подстрока
select
	substring(number_animal, 0, 4) as "Номер животного",
	name_animal_type as "Вид животного",
	name_animal_family as "Семейство животного",
	description_animal as "Краткое описание животного"
from animal
	inner join animal_type on
		animal.id_animal_type = animal_type.id_animal_type
	inner join animal_family on
		animal_type.id_animal_family = animal_family.id_animal_family;
		
-- Верхний регистр
select
	number_animal as "Номер животного",
	name_animal_type as "Название животного",
	upper(habitat_name) as "Ареал обитания"
from animal
	inner join habitat on
		animal.habitat_code = habitat.habitat_code
	inner join animal_type on
		animal.id_animal_type = animal_type.id_animal_type;
		
-- Нижний регистр
select
	concat(surname_employee, ' ', name_employee, ' ', patronymic_employee) as "ФИО сотрудника",
	lower(name_enclosure) as "Номер вольера",
	enclosure_care_day as "Дни недели кормления"
from employee
	inner join employee_enclosure on
		employee.id_employee = employee_enclosure.id_employee
	inner join enclosure on
		employee_enclosure.id_enclosure = enclosure.id_enclosure
	inner join enclosure_care_day on
		employee_enclosure.id_employee_enclosure = enclosure_care_day.id_employee_enclosure;
		
-- Форматированный вывод даты и/или времени
select
	number_ticket as "Номер билета",
	concat(surname_visitor, ' ', name_visitor, ' ', patronymic_visitor ) as "ФИО посетителя",
	benefits_visitor as "Размер льготы",
	total_sum_ticket as "Итоговая стоимость",
	to_char(datetime_ticket, 'YYYY, MM/DD') as "Дата печати билета"
from territory
	inner join territory_ticket on
		territory.id_territory = territory_ticket.id_territory
	inner join ticket on
		territory_ticket.id_ticket = ticket.id_ticket
	inner join visitor on
		ticket.id_visitor = visitor.id_visitor;
		
-- Вывод части даты
select
	concat(surname_employee, ' ', name_employee, ' ', patronymic_employee) as "ФИО сотрудника",
	name_enclosure as "Название вольера",
	enclosure_care_day as "День недели",
	'Часы: '||date_part('Hour', care_time) as "Часы",
	'Минуты: '||date_part('Minutes', care_time) as "Минуты"
from employee
	inner join employee_enclosure on
		employee.id_employee = employee_enclosure.id_employee
	inner join enclosure on
		employee_enclosure.id_enclosure = enclosure.id_enclosure
	inner join enclosure_care_day on
		employee_enclosure.id_employee_enclosure = enclosure_care_day.id_employee_enclosure
	inner join care_time on
		enclosure_care_day.id_enclosure_care_day = care_time.id_enclosure_care_day;
		
-- Сложение дат и/или времени
select
	work_plan_number as "Номер плана ремонтных работ",
	work_plan_date as "Дата формирования",
	work_plan_enclosure as "Номер вольера",
	work_list_name as "Название перечня работ",
	work_list_interval as "Плановый срок выполнения работ",
	work_plan_start_date + work_list_interval as "Дата окончания работ"
from work_plan
	inner join work_list_plan on
		work_plan_code = code_work_plan
	inner join work_list on
		work_list_code = code_work_list;
		
-- Вычитание дат и/или времени
select
	work_plan_number as "Номер плана ремонтных работ",
	work_plan_enclosure as "Номер вольера",
	work_list_name as "Название перечня работ",
	work_plan_date as "Дата формирования",
	work_plan_start_date as "Дата начала работ",
	work_plan_end_date as "Дата окончания работ",
	round((work_plan_end_date - work_plan_start_date) / 30.0, 0) as "Время за весь период работ (мес.)"
from work_plan
	inner join work_list_plan on
		work_plan_code = code_work_plan
	inner join work_list on
		work_list_code = code_work_list;
		
-- Возвращение возраста
select
	work_plan_number as "Номер плана ремонтных работ",
	work_plan_date as "Дата формирования",
	work_plan_start_date as "Дата начала работ",
	work_plan_end_date as "Дата окончания работ",
	age(work_plan_start_date, work_plan_date) as "Формирование - начало",
	age(work_plan_end_date, work_plan_date) as "Формирование - конец"
from work_plan
	inner join work_list_plan on
		work_plan_code = code_work_plan;
		
-- Проверка наличия файла
select
	name_territory as "Название зоны зоопарка",
	name_enclosure as "Название вольера",
	number_animal as "Номер животного",
	case 
		when pg_stat_file(picture_animal, true) is null then 'Файл отсутствует'
		else picture_animal
	end as "Файл фото"
from animal
	inner join territory on
		animal.id_territory = territory.id_territory
	inner join enclosure on
		animal.id_enclosure = enclosure.id_enclosure;
		
-- Максимальное значение столбца
select
	number_ticket as "Номер билета",
	concat(surname_visitor, ' ', name_visitor, ' ', patronymic_visitor ) as "ФИО посетителя",
	datetime_ticket as "Дата печати билета",
	total_sum_ticket as "Итоговая стоимость"
from ticket
	inner join visitor on
		ticket.id_visitor = visitor.id_visitor
	where total_sum_ticket = (SELECT MAX(total_sum_ticket) FROM ticket);
	
-- Минимальное значение столбца
select
	name_territory as "Название территории",
	price_territory as "Стоимость территории"
from territory
	where price_territory = (select min(price_territory) from territory);
	
-- Нумерация выводимых строк
select
	name_territory as "Название территории",
	name_enclosure as "Номер вольера",
	number_animal as "Номер животного",
	name_animal_type as "Вид животного", 
	name_animal_family as "Семейство животного",
	row_number() over (order by number_animal, name_animal_type, name_animal_family) as "№ П/П"
from animal
	inner join territory on
		animal.id_territory = territory.id_territory
	inner join enclosure on
		animal.id_enclosure = enclosure.id_enclosure
	inner join animal_type on
		animal.id_animal_type = animal_type.id_animal_type
	inner join animal_family on
		animal_type.id_animal_family = animal_family.id_animal_family
	inner join animal_squad on
		animal_family.id_animal_squad = animal_squad.id_animal_squad
	where name_enclosure = 'T1';
	
-- Уникальные строки
select
	distinct datetime_ticket as "Дата печати билета"
from ticket;

-- Лимит выводимых строк
select
	name_territory as "Название зоны зоопарка",
	count(number_animal) as "Количество животных"
from animal
	inner join territory on
		animal.id_territory = territory.id_territory
	group by 
		name_territory
	order by count(number_animal) DESC
	limit 2;
	
-- Арифмитические действия
select
	name_territory as "Название территории",
	round(sum(total_sum_ticket) * 15.0 / 100.0, 1) as "Выручка на закупку корма"
from territory
	inner join territory_ticket on
		territory.id_territory = territory_ticket.id_territory
	inner join ticket on
		territory_ticket.id_ticket = ticket.id_ticket
	group by name_territory;