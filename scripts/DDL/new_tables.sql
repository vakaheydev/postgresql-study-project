create table Work_List (
	Work_List_Code serial not null constraint PK_Work_List primary key,
	Work_List_Name varchar(100) not null,
	Work_List_Interval interval not null
);

create index if not exists index_Work_List_Code on Work_List (Work_List_Code);

create table Work_Status (
	Work_Status_Code serial not null constraint PK_Work_Status primary key,
	Work_Status_Name varchar(100) not null constraint UQ_Work_Status_Name unique
	constraint CH_Work_Status_Name check (Work_Status_Name in ('Ожидается начало', 'Ведутся ремонтные работы', 'Завершен'))
);

create index if not exists index_Work_Status_Code on Work_Status (Work_Status_Code);
create index if not exists index_Work_Status_Name on Work_Status (Work_Status_Name);

create table Work_Plan (
	Work_Plan_Code serial not null constraint PK_Work_Plan primary key,
	Work_Plan_Number varchar(20) not null constraint UQ_Work_Plan_Number unique
	constraint CH_Work_Plan_Number check (Work_Plan_Number similar to '(ГРМ)-(\d{2})-(\d{10})'),
	Work_Plan_Date  date not null,
	Work_Plan_Start_Date date not null,
	Work_Plan_End_Date date not null,
	Work_Plan_Instruction varchar(100) not null,
	Work_Plan_Enclosure int not null references Enclosure (ID_Enclosure),
	Work_Plan_Status int not null references Work_Status (Work_Status_Code)
);

create index if not exists index_Work_Plan_Code on Work_Plan (Work_Plan_Code);
create index if not exists index_Work_Plan_Number on Work_Plan (Work_Plan_Number);

create table Work_List_Plan (
	Work_List_Plan_Code serial not null constraint PK_Work_List_Plan primary key,
	Code_Work_List int not null references Work_List (Work_List_Code)
	constraint UQ_Code_Work_List unique,
	Code_Work_Plan int not null references Work_Plan (Work_Plan_Code)
);

create index if not exists index_Work_List_Plan_Code on Work_List_Plan (Work_List_Plan_Code);

create table Enclosure_Status (
	Enclosure_Status_Code serial not null constraint PK_Enclosure_Status primary key,
	Enclosure_Status_Name varchar(100) not null constraint UQ_Enclosure_Status_Name unique
);
create index if not exists index_Enclosure_Status_Code on Enclosure_Status(Enclosure_Status_Code);
create index if not exists index_Enclosure_Status_Name on Enclosure_Status(Enclosure_Status_Name);

insert into enclosure_status(enclosure_status_name) values('Открыт');
insert into enclosure_status(enclosure_status_name) values('Переоборудование');
insert into enclosure_status(enclosure_status_name) values('Ремонт');

alter table Habitat
	add constraint UQ_Habitat_Name unique (Habitat_Name);
	
alter table Employee_Post
	add constraint UQ_Employee_Post_Name unique (Employee_Post_Name);
		
alter table Visitor
	add constraint UQ_Login_Visitor unique (Login_Visitor),
	add constraint CH_Login_Visitor check (Login_Visitor similar to '[\w]{6,}'),
	alter column Patronymic_Visitor
		set default 'Нет данных',
	add constraint CH_Passport_Series_Visitor check (Passport_Series_Visitor similar to '[0-9]{4}'),
	add constraint CH_Passport_Number_Visitor check (Passport_Number_Visitor similar to '[0-9]{6}'),
	add constraint CH_Benefits_Visitor check (Benefits_Visitor >= 0),
	add constraint CH_Password_Visitor check (Password_Visitor similar to '[\w0-9!@#$%^&*()]{8,}');
	
alter table Visitor_Type
	add constraint UQ_Name_Visitor_Type unique (Name_Visitor_Type);
	
alter table Visitor_Document
	add constraint UQ_Number_Document unique (Number_Document),
	add constraint CH_Number_Document check (Number_Document similar to '\d+\/?\d*-?\d*-?\d*-?\d*');
	

update enclosure
	set status_enclosure = 1 where id_enclosure < 5;
	
update enclosure
	set status_enclosure = 1 where id_enclosure = 6  OR id_enclosure = 7;
	
update enclosure
	set status_enclosure = 3 where id_enclosure = 8;
	
update enclosure
	set status_enclosure = 2 where id_enclosure = 5;

alter table enclosure 
	alter column status_enclosure type int using status_enclosure::integer;
	
alter table enclosure
	add constraint fk_enclosure_status_enclosure
		foreign key (status_enclosure) references enclosure_status(enclosure_status_code);
	
alter table Enclosure
	add constraint UQ_Name_Enclosure unique (Name_Enclosure),
	add constraint CH_Name_Enclosure check (Name_Enclosure similar to '[A-Z]{1}[0-9]{1}');

alter table Enclosure_Status
	add constraint CH_Enclosure_Status_Name check (Enclosure_Status_Name similar to 'Открыт|Переоборудование|Ремонт');

alter table Employee
	add constraint UQ_Login_Employee unique (Login_Employee),
	add constraint CH_Login_Employee check (Login_Employee similar to '[\w]{6,}'),
	alter column Patronymic_Employee 
		set default 'Нет данных',
	add constraint CH_Password_Employee check (Password_Employee similar to '[\w0-9!@#$%^&*()]{8,}');
	
alter table Animal
	add constraint UQ_Number_Animal unique (Number_Animal),
	add constraint CH_Number_Animal check (Number_Animal similar to '[A-Z]+\d{8}');
	
alter table Animal_Squad
	add constraint UQ_Name_Animal_Squad unique(Name_Animal_Squad);
	
alter table Animal_Family
	add constraint UQ_Name_Animal_Family unique(Name_Animal_Family);
		
alter table Animal_Type
	add constraint UQ_Name_Animal_Type unique(Name_Animal_Type);
	
alter table Territory
	add constraint UQ_Name_Territory unique (Name_Territory),
	add constraint CH_Price_Territory check (Price_Territory >= 0);
	
alter table Ticket
	add constraint CH_Number_Ticket check (Number_Ticket similar to 'ПБЗ-\d{9}\/\d{2}'),
	add constraint CH_Price_Ticket check (Price_Ticket >= 0),
	add constraint CH_Total_Sum_Ticket check (Total_Sum_Ticket >= 0);
	
alter table Enclosure_Care_Day
	add constraint CH_Enclosure_Care_Day check (Enclosure_Care_Day similar to 'Понедельник|Вторник|Среда|Четверг|Пятница|Суббота|Воскресенье');