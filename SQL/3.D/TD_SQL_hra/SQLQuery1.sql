select kategorie from veze group by kategorie order by kategorie

select typ_veze, min(nakupni_cena) as min_cena from veze where kategorie = 'utocne' group by typ_veze order by min_cena asc

select typ_veze, min(nakupni_cena) as min_cena from veze where kategorie = 'podpurne' group by typ_veze order by min_cena asc

select typ_veze, count(*) from veze where hra_id = 10  group by typ_veze

select  top 1 typ_veze, sum(spotreba_energie) as celkova_spotreba from veze where hra_id = 10  group by typ_veze order by celkova_spotreba desc

select typ_veze, sum(spotreba_energie) from veze where hra_id = 10 group by typ_veze having sum(spotreba_energie) > 80

select typ_veze, sum(zpusobene_poskozeni) from veze where kategorie = 'utocne' group by typ_veze having sum(zpusobene_poskozeni) >= 15000

select typ_veze, sum(pocet_vystrelu) from veze where kategorie = 'podpurne' group by typ_veze having sum(pocet_vystrelu) >= 15000