select Jmeno, Prijmeni from Zamestnanci where Plat >= 30000 and Plat <= 60000;

select count(Pohlavi) as Pocet_muzu from Zamestnanci where Pohlavi = N'M';

select sum(Plat) / count(Plat) as Prumer_platu from Zamestnanci where oddeleni = 0;

select * from Zamestnanci where Plat > (select sum(Plat) / count(Plat) from Zamestnanci);

select * from Zamestnanci where DatumNarozeni = (select min(DatumNarozeni) from Zamestnanci);

select * from Zamestnanci where Plat > (select sum(Plat) / count(Plat) from Zamestnanci where Oddeleni = Zamestnanci.Oddeleni);

























