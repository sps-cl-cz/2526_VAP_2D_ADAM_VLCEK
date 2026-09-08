select pohlavi, count(*) pocet_osob from Zamestnanci group by pohlavi;

select oddeleni, min(datumNarozeni) from Zamestnanci group by oddeleni;

select oddeleni, max(plat) plat from Zamestnanci group by oddeleni;

select oddeleni, count(*) pocet_osob from Zamestnanci group by oddeleni
having count(*) = 1;

select oddeleni, avg(plat) plat from Zamestnanci group by oddeleni
having avg(plat) > 60000;

select Oddeleni, avg(plat) from Zamestnanci group by oddeleni
having avg(plat) > 60000

select pohlavi, count(*) pocet_osob from Zamestnanci group by pohlavi
having count(*) > 5

select oddeleni, count(*) pocet_osob from Zamestnanci where DatumNarozeni >= '1980.1.1'
group by Oddeleni having count(*) >= 2;

select avg(plat) prum_plat from Zamestnanci where Pohlavi = 'Z' group by Oddeleni
having avg(Plat) > 50000;

select oddeleni from zamestnanci group by oddeleni
having max(plat) - min(plat) > 40000;

select oddeleni, count(*) pocet_muzu from zamestnanci where pohlavi = 'M' and plat > 80000 group by oddeleni
having count(*) >= 2;

select avg(plat) from Zamestnanci;

select * from Zamestnanci z1 where z1.Plat > (select avg(z2.plat) from Zamestnanci z2);

select count(*) pocet_zam, Oddeleni from Zamestnanci
group by Oddeleni having count(*) >
(select avg(cast(pocet_zam as float)) prum_pocet from
(select count(*) pocet_zam, z1.Oddeleni od from Zamestnanci z1 group by z1.Oddeleni) T;                 
