alter sequence public.animal_family_id_animal_family_seq restart with 1;
alter sequence public.animal_id_animal_seq restart with 1;
alter sequence public.animal_squad_id_animal_squad_seq restart with 1;
alter sequence public.animal_type_id_animal_type_seq restart with 1;
alter sequence public.care_time_id_care_time_seq restart with 1;
alter sequence public.employee_enclosure_id_employee_enclosure_seq restart with 1;
alter sequence public.employee_id_employee_seq restart with 1;
alter sequence public.employee_post_employee_post_code_seq restart with 1;
alter sequence public.enclosure_care_day_id_enclosure_care_day_seq restart with 1;
alter sequence public.enclosure_id_enclosure_seq restart with 1;
alter sequence public.enclosure_status_enclosure_status_code_seq restart with 1;
alter sequence public.habitat_habitat_code_seq restart with 1;
alter sequence public.territory_id_territory_seq restart with 1;
alter sequence public.territory_ticket_id_territory_ticket_seq restart with 1;
alter sequence public.ticket_id_ticket_seq restart with 1;
alter sequence public.visitor_document_id_document_seq restart with 1;
alter sequence public.visitor_id_visitor_seq restart with 1;
alter sequence public.visitor_type_id_visitor_type_seq restart with 1;
alter sequence public.work_list_plan_work_list_plan_code_seq restart with 1;
alter sequence public.work_list_work_list_code_seq restart with 1;
alter sequence public.work_plan_work_plan_code_seq restart with 1;
alter sequence public.work_status_work_status_code_seq restart with 1;

insert into Habitat (Habitat_Name)
	values 
		('Практически на всех континентах северного полушария'),
		('Азиатская часть Евразии'),
		('Ближе к экватору'),
		('Африка');
call habitat_insert('Северо-восточная часть Южной Америки');
call habitat_insert('Евразия, Африка');
call habitat_insert('Везде, кроме Антарктики');

insert into Employee_Post (Employee_Post_Name)
	values
		('Главный ветеринар');
call employee_post_insert('Сотрудник по уходу');

insert into Visitor (Login_Visitor, Name_Visitor, Surname_Visitor, Patronymic_Visitor, Passport_Series_Visitor, Passport_Number_Visitor, Benefits_Visitor, Password_Visitor)
	values 
		('KonstantinovaAV', 'Анастасия', 'Константинова', 'Вячеславовна', '4507', '229864', 0, 'Pa$$w0rd'),
		('IgorevDA', 'Дмитрий', 'Игорев', 'Андреевич', '4106', '323969', 30, 'Pa$$w0rd'),
		('MaksimovKI', 'Константин', 'Максимов', 'Иванович', '4750', '139592', 20, 'Pa$$w0rd');
call visitor_insert('VasilevAI', 'Анатолий', 'Васильев', 'Игоревич', '4565', '665925', 30, 'Pa$$w0rd');	
call visitor_insert('KirillovaMS', 'Марина', 'Кириллова', 'Сергеевна', '4831', '732962', 50, 'Pa$$w0rd');

insert into Visitor_Type (Name_Visitor_Type)
	values
		('Обычный'),
		('Студент');
call visitor_type_insert('Пенсионер');
call visitor_type_insert('Ребёнок');

insert into Visitor_Document (Number_Document, ID_Visitor_Type, ID_Visitor)
	values
		('873372', 2, 2),
		('254-877-174-87', 3, 2),
		('5/62- 82962672-20', 2, 3);
call visitor_document_insert('763-883-167-24', 3, 4);
call visitor_document_insert('01/054-89833237-20', 2, 5);
call visitor_document_insert('672367', 4, 5);

insert into enclosure (Name_Enclosure, Status_Enclosure)
	values
		('X1', 1),
		('X2', 1),
		('X3', 1),
		('T1', 1);
call enclosure_insert('T2', 2);
call enclosure_insert('B1', 1);
call enclosure_insert('B2', 1);
call enclosure_insert('B3', 3);

select * from enclosure;

insert into employee (Login_Employee, Surname_Employee, Name_Employee, Patronymic_Employee, Password_Employee, Employee_Post_Code)
	values
		('wk_IvanovII', 'Иванов', 'Иван', 'Иванович', 'Pa$$w0rd', 1),
		('wk_PetrovPP', 'Петров', 'Петр', 'Петрович', 'Pa$$w0rd', 2);
call employee_insert('wk_AlekseevAA', 'Алексеев', 'Алексей', 'Алексеевич', 'Pa$$w0rd', 2);
call employee_insert('wk_PavlovPP', 'Павлов', 'Павел', 'Павлович', 'Pa$$w0rd', 2);
call employee_insert('wk_RuslanovRR', 'Русланов', 'Русланов', 'Русланович', 'Pa$$w0rd', 2);

insert into Employee_Enclosure (ID_Employee, ID_Enclosure)
	values
		(2, 1),
		(3, 2),
		(2, 3);
call employee_enclosure_insert(4, 4);
call employee_enclosure_insert(4, 6);
call employee_enclosure_insert(4, 7);

select * from employee_enclosure;

insert into Animal_Squad(Name_Animal_Squad)
	values
		('Хищные'),
		('Китопарнокопытные'),
		('Грызуны');
call animal_squad_insert('Ястребообразные');
call animal_squad_insert('Соколообразные');

insert into Animal_Family(Name_Animal_Family, ID_Animal_Squad)
	values
		('Медьвежьи', 1),
		('Кошачьи', 1),
		('Полорогие', 2);
call animal_family_insert('Свинковые', 3);
call animal_family_insert('Ястребиные', 4);
call animal_family_insert('Соколиные', 5);

insert into Animal_Type (Name_Animal_Type, ID_Animal_Family)
	values
		('Медведь', 1),
		('Тигр', 2),
		('Леопард', 2),
		('Гепард', 2);
call animal_type_insert('Газель', 3);
call animal_type_insert('Капибара', 4);
call animal_type_insert('Орел', 5);
call animal_type_insert('Сокол', 6);

select * from animal_type;

insert into Territory (Name_Territory, Price_Territory)
	values
		('Общая территория', 750),
		('Океанариум', 450);
call territory_insert('Контактный зоопарк', 350);

select * from territory;

insert into Animal (Number_Animal, Description_Animal, Picture_Animal, ID_Animal_Type, Habitat_Code, ID_Enclosure, ID_Territory)
	values
		('PRD00000001', 'Плюшевый, но смертноносный зверь', 'Ссылка', 1, 1, 1, 1),
		('PRD00000002', 'Полосатый, может мяукать, но может и напугать', 'Ссылка', 2, 2, 2, 1),
		('PRD00000003', 'Похоже на гепарда, но это леопард', 'Ссылка', 3, 3, 3, 1),
		('PRD00000004', 'Похоже на гепарда, но это леопард', 'Ссылка', 3, 3, 3, 1),
		('PRD00000005', 'Грациозный и молниеносный хищник', 'Ссылка', 4, 4, 3, 1);
call animal_insert('HRS00000001', 'Прыткие и юркие', 'Ссылка', 5, 4, 4, 3);
call animal_insert('HRS00000002', 'Тотемное животное всех спокойных людей и кому на все с высокой колокольни', 'Ссылка', 6, 5, 4, 3);
call animal_insert('HRS00000003', 'Тотемное животное всех спокойных людей и кому на все с высокой колокольни', 'Ссылка', 6, 5, 4, 3);
call animal_insert('FL00000001', 'Белая голова, жёлтый клюв, коричневое тело - что ещё добавить', 'Ссылка', 7, 6, 6, 1);
call animal_insert('FL00000002', 'Красивый, быстрый хищник неба', 'Ссылка', 8, 7, 7, 1);

select * from animal;

		
insert into Ticket (Number_Ticket, datetime_ticket, Price_Ticket, Total_SUm_Ticket, ID_Visitor)
	values
		('ПБЗ-000000001/23', '1.09.2023', 750, 750, 1),
		('ПБЗ-000000001/23', '2.09.2023', 1200, 1200, 1),
		('ПБЗ-000000001/23', '1.09.2023', 1200, 840, 2),
		('ПБЗ-000000001/23', '2.09.2023', 1200, 960, 3);
		
call ticket_insert('ПБЗ-000000001/23', '3.09.2023', 750, 525, 4);		
call ticket_insert('ПБЗ-000000001/23', '4.09.2023', 1100, 550, 5);		
call ticket_insert('ПБЗ-000000001/23', '5.09.2023', 1550, 775, 5);		

select * from ticket;

insert into Territory_Ticket(ID_Territory, ID_Ticket)
	values
		(1, 1),
		(2, 1),
		(1, 2),
		(2, 2),
		(1, 3),
		(1, 4);
		
call territory_ticket_insert(1, 5);
call territory_ticket_insert(3, 6);
call territory_ticket_insert(1, 6);
call territory_ticket_insert(3, 7);
call territory_ticket_insert(2, 7);

select * from territory_ticket;

insert into Enclosure_Care_Day(ID_Employee_Enclosure, Enclosure_Care_Day)
	values
		 (1, 'Понедельник'),
		 (1, 'Среда'),
		 (1, 'Пятница'),
		 (2, 'Понедельник'),
		 (2, 'Среда'),
		 (2, 'Пятница'),
		 (3, 'Понедельник'),
		 (3, 'Среда'),
		 (3, 'Пятница');
		 
call enclosure_care_day_insert(4, 'Понедельник');
call enclosure_care_day_insert(4, 'Среда');
call enclosure_care_day_insert(4,'Пятница');
call enclosure_care_day_insert(5, 'Понедельник');
call enclosure_care_day_insert(5, 'Среда');
call enclosure_care_day_insert(5, 'Пятница');
call enclosure_care_day_insert(6, 'Понедельник');
call enclosure_care_day_insert(6, 'Среда');
call enclosure_care_day_insert(6, 'Пятница');

insert into Care_Time(ID_Enclosure_Care_Day, Care_Time)
	values
		(1, '9:00'),
		(1, '16:00'),
		(1, '21:00'),
		(2, '9:00'),
		(2, '16:00'),
		(2, '21:00'),
		(3, '9:00'),
		(3, '16:00'),
		(3, '21:00'),
		(4, '9:00'),
		(4, '16:00'),
		(4, '21:00'),
		(5, '9:00'),
		(5, '16:00'),
		(5, '21:00'),
		(6, '9:00'),
		(6, '16:00'),
		(6, '21:00'),
		(7, '10:00'),
		(7, '17:00'),
		(7, '21:00'),
		(8, '10:00'),
		(8, '17:00'),
		(8, '21:00'),
		(9, '10:00'),
		(9, '17:00'),
		(9, '21:00'),
		(10, '11:00'),
		(10, '18:00'),
		(10, '22:00'),
		(11, '11:00'),
		(11, '18:00'),
		(11, '22:00'),
		(12, '11:00'),
		(12, '18:00'),
		(12, '22:00');
		
call care_time_insert(13, '8:00');
call care_time_insert(13, '15:00');
call care_time_insert(13, '20:00');
call care_time_insert(14, '8:00');
call care_time_insert(14, '15:00');
call care_time_insert(14, '20:00');
call care_time_insert(15, '8:00');
call care_time_insert(15, '15:00');
call care_time_insert(15, '20:00');
call care_time_insert(16, '8:00');
call care_time_insert(16, '15:00');
call care_time_insert(16, '20:00');
call care_time_insert(17, '8:00');
call care_time_insert(17, '15:00');
call care_time_insert(17, '20:00');
call care_time_insert(18, '8:00');
call care_time_insert(18, '15:00');
call care_time_insert(18, '20:00');

select * from Habitat;
select * from Employee_Post;
select * from visitor;
select * from visitor_type;
select * from visitor_document;
select * from enclosure;
select * from employee;
select * from employee_enclosure;
select * from animal_squad;
select * from animal_family;
select * from animal_type;
select * from territory;
select * from animal;
select * from ticket;
select * from territory_ticket;
select * from Enclosure_Care_Day;
select * from care_time;

