if OBJECT_ID('Zamestnanci', 'U') is not null
begin
	alter table Zamestnanci
	drop constraint if exists fk_Oddeleni_Vedouci;

drop table if exists Zamestnanci;
create table Zamestnanci(
	Id int primary key identity(0, 1), 
	Jmeno nvarchar(50) not null,
	Prijmeni nvarchar(50) not null,
	Plat decimal not null check(plat > 0),
	Pohlavi nchar(1) check (pohlavi = N'Z' or pohlavi = N'M'),
	DatumNarozeni Date not null,
	Oddeleni int,
);

create table Oddeleni(
	Id int primary key
	Nazev nvarchar(50) not null,
	Vedouci int,
	foreign key (Vedouci) references Zamestnanci(Id)
);

alter table Oddeleni add constraint fk_Oddeleni_Vedouci
foreign key (Vedouci) references Zamestnanci(Id);
 
 
alter table Oddeleni add constraint fk_Oddeleni_Vedouci
foreign key (Vedouci) references Zamestnanci(Id);