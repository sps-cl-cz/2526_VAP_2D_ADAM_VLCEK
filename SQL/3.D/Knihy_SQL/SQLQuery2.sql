-- len = délka øetìzce
-- charindex('.', email) = získá pozici znaku uvnitø øetìzce
-- substring(email, 2, len(email)) = získá èást øetìzce mezi zadanými pozicemi

select top 4 with ties * from Knihy order by len(nazev)

---------------------------------------------------------------

select top 3 * from Knihy where (zanr = 'Fantasy' or zanr = 'sci-fi') and cena < 400 order by cena, rok_vydani;

---------------------------------------------------------------

select top 1 with ties * from Knihy where skladem > 0 order by skladem

---------------------------------------------------------------

select top 2 * from Zakaznici where (email like '%email.cz' or email like '%seznam.cz') order by len(jmeno + ' ' + prijmeni) desc, prijmeni asc

---------------------------------------------------------------

select top 3 *, cena/ skladem as hodnota from Knihy where (rok_vydani >= 1950 and rok_vydani <= 2010) and (cena >= 200 and cena <= 600) and skladem > 0 order by hodnota