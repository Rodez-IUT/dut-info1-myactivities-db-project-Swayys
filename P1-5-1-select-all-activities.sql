- Description de la requête :

    Sélectionner le "title", la description et le "username" du propriétaire de toutes les activités créées après le 1er septembre 2019 triés par ordre alphabétique sur les "title" puis sur les "username".
    Si une activité n'est attachée à aucun propriétaire, la ligne correspondante doit s'afficher quand même avec le champ "username" laissé vide.

   SELECT title, description, username
    FROM activity
    LEFT OUTER JOIN public.user ON public.user.id = owner_id
    WHERE creation_date < '2019-09-01'
    ORDER by title, username