Description de la fonction :  

    - *Nom de la fonction* :  
    CREATE FUNCTION find_activities_older_than(modification_date date, old_date date) RETURNS activity AS $$
        UPDATE activity
		SET modification_date = find_activities_older_than.modification_date
		WHERE modification_date < old_date
        RETURNING activity;
    $$ LANGUAGE SQL;

    - *Description* :   
    la fonction retourne la liste des activités qui n'ont pas été modifiées depuis la date "old_date" passée en paramètre.