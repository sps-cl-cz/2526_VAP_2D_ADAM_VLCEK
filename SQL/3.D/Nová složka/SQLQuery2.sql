-- 1) uloha
select * from knihy where zanr in ('fantasy', 'sci-fi') and (cena * 0.85) between 150 and 350 and skladem > 0

-- 5) uloha
select * from Knihy where zanr != 'sci-fi' and cena <= 299

-- 4) uloha
select * from Zakaznici where (email like '%email.cz' or email like '%seznam.cz') and not (prijmeni like 'N%' or prijmeni like 'K%')

-- 2) uloha
select * from Zakaznici where (mesto = 'Praha' or mesto = 'Brno' and vip = 1) or datum_registrace between '2023-01-01' AND '2023-03-31'

-- 8) uloha
select top 40 percent * from Knihy where rok_vydani >= 1900 order by cena desc

-- 16) uloha
select top 50 percent id_objednavka, id_zakaznik, datum, celkova_cena, stav from Objednavky where stav = 'dokonèená' and celkova_cena > 200 order by celkova_cena desc

-- 6) uloha
select * from Objednavky where (stav NOT IN ('Stornována', 'Nová')) and (celkova_cena >= 200 and celkova_cena <= 600) and skladem > 0 order by zanr

-- 9) uloha
select top 2 with ties * from polozkyobjednavky where pocet_kusu = 1 order by cena_za_kus desc

-- 3) uloha
select * from knihy where (cena * skladem) > 2500 and cena <= 500 and rok_vydani > 1930    