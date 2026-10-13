select cena, nazev, zanr from knihy
where (zanr = 'fantasy' or zanr = 'sci-fi') and cena < 300;

-----------------------------------------------------

select nazev, (cena * skladem) as skladova_cena from knihy
where (cena * skladem) > 5000;

-----------------------------------------------------

select jmeno, prijmeni, email from Zakaznici where 
len(prijmeni) > 6 and email not like '%seznam.cz';

-----------------------------------------------------

select zanr, cena from knihy
where (zanr = 'fantasy' or zanr = 'sci-fi') and  (cena >= 200 and cena <= 400) and rok_vydani < 2000;

-----------------------------------------------------

select mesto, vip from Zakaznici 
where (mesto = 'Praha' or mesto = 'Brno') and vip = 1 or mesto = 'Ostrava';

-----------------------------------------------------

select jmeno, email from Zakaznici 
where (email like '%@seznam.cz' or email like '%@email.cz') and not (jmeno like 'P%' or jmeno like 'M%');

-----------------------------------------------------

select * from Knihy where (cena * 0.80) > 230 and cena <= 400;

-----------------------------------------------------

select top 30 percent * from Knihy order by zanr desc, cena desc;

-----------------------------------------------------

select jmeno, prijmeni, len(prijmeni) as delka_prijmeni from Zakaznici order by delka_prijmeni;

-----------------------------------------------------

select nazev, cena, round(cena / (2026 - rok_vydani), 2) as hodnota from Knihy
order by hodnota;

-----------------------------------------------------

select * from Knihy
order by case when skladem > 0 then 1 else 2 end asc, cena desc;

-----------------------------------------------------

select top 4 * from Knihy order by rok_vydani asc, nazev;

-----------------------------------------------------

select top 5 *, len(nazev) as delka_nazvu from Knihy order by delka_nazvu;

-----------------------------------------------------

select top 3 *, pocet * cena_za_kus as celkova_cena from PolozkyObjednavky order by castka_za_polozku desc;

-----------------------------------------------------

select *, (cena * skladem) as skladova_cena from Knihy order by skladova_cena desc;
