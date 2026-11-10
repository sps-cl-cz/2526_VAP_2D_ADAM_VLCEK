-- uloha 1
select mesto, count(*) as pocet_zakazniku from Zakaznici
group by mesto having count(*) >= 2 order by pocet_zakazniku desc

--uloha 3
select stav, sum(celkova_cena) as celkovy_obrat, count(*) as pocet_objednavek from Objednavky 
group by stav having count(*) > 1 and sum(celkova_cena) > 20000 order by celkovy_obrat desc

-- uloha 4
select id_dodavatel, count(*) as pocet_produktu, sum(skladem) as celkem_kusu from Produkty
where aktivni = 1 and skladem > 0 and id_dodavatel is not null group by id_dodavatel
having sum(skladem) > 20 order by celkem_kusu desc

--uloha 7
select id_objednavka, sum(pocet_kusu) as celkem_kusu, round(sum(pocet_kusu * cena_za_kus * (1.0 - sleva_procenta / 100.0)), 2) as skutecna_cena_polozek from PolozkyObjednavky group by id_objednavka
having sum(pocet_kusu) > 1 and round(sum(pocet_kusu * cena_za_kus * (1.0 - sleva_procenta / 100.0)), 2) > 10000 order by skutecna_cena_polozek desc


-- uloha 6
select zaruka_mesice, min(cena) as nejnizsi_cena, max(cena) as nejvyssi_cena, count(*) as pocet_produktu
from Produkty group by zaruka_mesice having max(cena) > 10000 order by zaruka_mesice asc

-- uloha 2
select id_kategorie, round(avg(cena), 2) as prumerna_cena from Produkty
where id_kategorie is not null group by id_kategorie having avg(cena) > 5000 order by prumerna_cena desc

--uloha 9
select mesto, count(*) as pocet_novych_zakazniku from Zakaznici 
where year(datum_registrace) = 2023 group by mesto having count(*) >= 2 order by mesto asc


-- uloha 8
select id_produkt, count(*) as pocet_recenzi, round(avg(cast(hodnoceni as float)), 2) as prumerne_hodnoceni 
from Recenze group by id_produkt having avg(cast(hodnoceni as float)) >= 4.0
order by prumerne_hodnoceni desc, pocet_recenzi desc

-- uloha 5
select zpusob_platby, stav, count(*) as pocet_objednavek, round(avg(celkova_cena), 2) as prumerna_cena from Objednavky 
group by zpusob_platby, stav having count(*) >= 2 order by pocet_objednavek desc, prumerna_cena desc




