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