Sélectionner le username et la date de création des utilisateurs créés avant le 1er septembre 2019 triés par ordre alphabétique sur les "username".

SELECT username, date_created
FROM public.user
WHERE date_created < '2019-09-01'
ORDER BY username