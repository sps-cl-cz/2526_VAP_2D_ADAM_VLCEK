select p.nazev nazev_produktu, K.nazev nazev_kategorie from Produkty p join Kategorie k on P.id_kategorie = K.id_kategorie
 
select z.jmeno, z.prijmeni, o.celkova_cena from Objednavky o join Zakaznici z on o.id_zakaznik = z.id_zakaznik where

o.celkova_cena>25000 and z.jmeno like 'p%'

--------------------------------------------
 
select p.nazev nazev_produktu, p.cena cena_produktu, d.nazev_firmy firma, d.zeme zeme from
Produkty p join Dodavatele d
on p.id_kategorie = d.id_dodavatel

--------------------------------------------

select z.jmeno, z.prijmeni, z.email, r.hodnoceni, r.text_recenze from Recenze r join Zakaznici z on z.id_zakaznik = r.id_zakaznik
where r.hodnoceni = 5;

--------------------------------------------

select top 3 p.cena, p.nazev, d.zeme, d.nazev_firmy from Produkty p join Dodavatele d on p.id_dodavatel = d.id_dodavatel 
where d.zeme <> 'Èeská republika' order by p.cena desc

--------------------------------------------

select p.nazev produkt, po.pocet_kusu, (po.pocet_kusu * po.cena_za_kus) hodnota_radku, p.zaruka_mesice from
PolozkyObjednavky po join Produkty p on po.id_produkt = p.id_produkt where po.pocet_kusu >= 2

--------------------------------------------

select k.nazev, avg(p.cena) prum_cena, count(*) pocet_produktu, sum(cena) celkova_cena from
Produkty p join Kategorie k on p.id_kategorie = k.id_kategorie group by k.id_kategorie, k.nazev having sum(cena) > 15000 order by celkova_cena

--------------------------------------------

select avg(p.cena), d.nazev_firmy, count(*) as pocet from Produkty p join Dodavatele d on
p.id_dodavatel = d.id_dodavatel group by d.nazev_firmy order by count(*) desc

--------------------------------------------

select d.zeme, sum(p.skladem) pocet_skladem, sum(p.cena * p.skladem) celkova_hodnota from
Produkty p join Dodavatele d on p.id_dodavatel = d.id_dodavatel
group by d.zeme having sum(p.cena * p.skladem) > 200000 order by sum(p.cena * p.skladem) desc

--------------------------------------------

select top 3 p.nazev, sum(po.pocet_kusu * po.cena_za_kus * (100 - po.sleva_procenta) / 100.0) as cista_trzba from
PolozkyObjednavky po join Produkty p on po.id_produkt = p.id_produkt group by p.nazev order by cista_trzba desc

--------------------------------------------

select top 1 with ties k.nazev, sum(p.skladem) as pocet_produktu from 
Produkty p join Kategorie k on p.id_kategorie = k.id_kategorie group by k.nazev order by sum(p.skladem) desc