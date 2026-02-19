drop table Zamestnanci;
create table Zamestnanci(
	id int primary key identity,
	jmeno nvarchar(50) not null,
	prijmeni nvarchar(50) not null
	plat decimal not null
);
