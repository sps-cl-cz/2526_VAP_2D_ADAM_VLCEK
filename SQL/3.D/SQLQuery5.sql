select zanr, avg(cena) prum_cena from Knihy group by zanr having avg(cena) > 300

----------------------------------------------------

select zanr, count(zanr) from Knihy group by zanr having count(zanr) > 2

----------------------------------------------------

select mesto, count(id_zakaznik) from Zakaznici group by mesto having count(id_zakaznik) = 2

----------------------------------------------------

select autor, max(cena) from Knihy group by autor having max(cena) > 500

----------------------------------------------------

select zanr, sum(cena*skladem) from Knihy group by zanr having sum(cena*skladem) > 3000

----------------------------------------------------

select id_zakaznik, avg(celkova_cena), min(celkova_cena) from Objednavky group by id_zakaznik 
having avg(celkova_cena) >= 660 and min(celkova_cena) < 650

----------------------------------------------------

select id_zakaznik from Objednavky where celkova_cena > 500 group by id_zakaznik 
having count(*) > 1

----------------------------------------------------

select top 2 zanr, avg(cena) as prum_cena from Knihy where rok_vydani > 1950
having avg(cena) > 250 order by prum_cena desc

----------------------------------------------------

select autor from Knihy where rok_vydani < 2000 group by autor
having count(id_kniha) > 1 order by autor desc

----------------------------------------------------

select id_zakaznik from Objednavky where stav = 'Dokonèená' group by id_zakaznik 
having sum(celkova_cena) > 500

----------------------------------------------------

select top 1 zanr, sum(skladem) celkem_skladem from Knihy where cena > 200
group by zanr order by celkem_skladem desc

----------------------------------------------------

select autor, avg(cena) from Knihy where rok_vydani > 1940 group by autor having avg(cena) > 300

----------------------------------------------------

select zanr, max(cena) as nejdrazsi, min(cena) as nejlevnejsi from Knihy
group by zanr having count(id_kniha) >= 2 order by nejdrazsi desc