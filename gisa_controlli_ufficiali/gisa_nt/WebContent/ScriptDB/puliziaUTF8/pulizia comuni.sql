--------------------- pulizia comuni da lettere accentate ------------------------------

--SELECT id,nome FROM comuni1  where notused is null and  cod_regione != '15' order by nome

-- SELECT id,nome, nome::bytea ,regexp_replace(nome, '\303\271\250', 'u''', 'g') FROM comuni1  where regexp_replace(nome, '\303\271\250', 'u''', 'g') != nome


-- SELECT id, nome, nome::bytea FROM comuni1  where nome ilike '%�%' order by 1


 --update comuni1 set nome = regexp_replace(nome, 'é', 'e''', 'g')  where nome ilike '%é%'

-- �
update comuni1 set nome = regexp_replace(nome, 'é', 'e''', 'g')  where nome ilike '%é%'

-- �
update comuni1  set nome=regexp_replace(nome, '\303\271\250', 'u''', 'g') where regexp_replace(nome, '\303\271\250', 'u''', 'g') != nome

-- �
update comuni1  set nome=regexp_replace(nome, '\303\254', 'u''', 'g') where regexp_replace(nome, '\303\254', 'i''', 'g') != nome

-- �
update comuni1  set nome=regexp_replace(nome, '\303\240', 'a''', 'g') where regexp_replace(nome, '\303\240', 'a''', 'g') != nome

--�
update comuni1  set nome=regexp_replace(nome, '\303\262', 'o''', 'g') where regexp_replace(nome, '\303\262', 'o''', 'g') != nome

--e
update comuni1  set nome=regexp_replace(nome, '\303\250', 'e', 'g') where regexp_replace(nome, '\303\250', 'e', 'g') != nome