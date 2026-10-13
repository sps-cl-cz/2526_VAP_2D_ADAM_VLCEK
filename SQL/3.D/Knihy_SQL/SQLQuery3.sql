select 
z.jmeno name,
z.prijmeni lastname,
z.email, z.mesto
from Zakaznici z where z.mesto <> 'brno' and z.jmeno != 'jana';

-------------------------------------------

select nazev, autor, cena, rok_vydani 
from Knihy where rok_vydani >= 2010 and rok_vydani <= 2020 and cena <= 400;

-------------------------------------------

select jmeno, prijmeni, mesto, email 
from Zakaznici where (mesto = 'praha' or mesto = 'brno') and vip = 1;

-------------------------------------------

select nazev, cena, skladem
from Knihy where (nazev like 'clean%' or nazev like 'hobit%') and skladem > 5;

-------------------------------------------

select * from Objednavky 
where (celkova_cena >= 500 and celkova_cena <= 1500) and (stav = 'odeslaná' or stav = 'nová');

