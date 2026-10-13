select count(distinct zanr) from Knihy;

select sum(skladem) from Knihy;

select avg(cena) prum_cena from Knihy;

select max(cena) max_cena from Knihy;

-----------------------------------------

select count(id_zakaznik) from Zakaznici

-----------------------------------------

select avg(celkova_cena) from Objednavky

-----------------------------------------

select sum(pocet) pocet_kusu from PolozkyObjednavky

-----------------------------------------

select min(cena) nejlevnejsi, max(cena) nejdrazsi from Knihy

-----------------------------------------

select count(distinct mesto) from Zakaznici

-----------------------------------------

select sum(cena * skladem) celkova_financni_hodnota from Knihy

-----------------------------------------

select 
count(*) pocet_knih,
avg(cena) prum_cena, 
min(zanr) zanr from Knihy
where zanr = 'Fantasy'

-----------------------------------------

select sum(celkova_cena) celkova_trzba  from Objednavky where stav != 'Stornována'

-----------------------------------------

select min(celkova_cena) nejmensi, max(celkova_cena) nejvetsi from Objednavky where id_zakaznik = 1

-----------------------------------------

select 
count(*) pocet_knih,
avg(cena) prum_cena,
nazev, zanr
from Knihy
group by zanr

-----------------------------------------

select mesto, count(id_zakaznik) pocet_zakazniku from Zakaznici group by mesto

-----------------------------------------

select autor, sum(skladem) skladem from Knihy group by autor

-----------------------------------------

select zanr, min(cena) nejlevnejsi, max(cena) nejdrazsi from Knihy group by zanr

-----------------------------------------

select mesto, vip, count(id_zakaznik) pocet_zakazniku from Zakaznici group by mesto, vip 

-----------------------------------------

select zanr, min(cena) nejlevnesi from Knihy where cena > 200 group by zanr

-----------------------------------------

select autor, avg(cena) prum_cena, sum(skladem) dostupne from Knihy where skladem >= 1 group by autor