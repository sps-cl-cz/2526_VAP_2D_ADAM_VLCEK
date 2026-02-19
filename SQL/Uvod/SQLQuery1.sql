--select - vyber
--as - prejmenovani sloupce ve vysledku
--where - podmninka, ktera ma byt splnena pro vlozeni zaznamu do vysledku
--count - funkce pro ziskani poctu nastavenych sloupcu ve vysledku
--sum - soucet hodnot sloupce
--min - minimum z hodnot sloupce
--max - maximum z hodnot sloupce

select sum(plat) as soucet_platy_pro_pet_poslednich from Zamestnanci
where id > 5;

insert into Zamestnanci values ('Adam', 'Dvoøák', 45000.0); 

select min(prijmeni) from Zamestnanci where plat > 50000;

select * from Zamestnanci where plat = (select min(plat) from Zamestnanci);

select top(1) * from Zamestnanci order by plat, jmeno desc;