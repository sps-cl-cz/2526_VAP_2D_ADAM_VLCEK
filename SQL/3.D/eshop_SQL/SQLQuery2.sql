select * from Zakaznici z left join Objednavky o
on z.id_zakaznik = o.id_zakaznik where o.id_objednavka is null

-------------------------------------------------

select * from Zakaznici cross join Objednavky

-------------------------------------------------

select * from Produkty p left join Kategorie k on p.id_kategorie = k.id_kategorie    

-------------------------------------------------

select * from Objednavky o full outer join Dopravci d on o.id_dopravce = d.id_dopravce
where o.id_dopravce is null or o.id_objednavka is null

-------------------------------------------------

select * from Recenze r left join Zakaznici z on r.id_zakaznik = z.id_zakaznik
where z.id_zakaznik is null order by r.hodnoceni