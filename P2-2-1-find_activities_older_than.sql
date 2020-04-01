Description de la fonction :  

    - *Nom de la fonction* :  
    CREATE FUNCTION find_activities_older_than(old_date) RETURNS activity AS $$
        UPDATE activity
        WHERE modification_date < old_date;
        RETURNING activity

    - *Description* :   
    la fonction retourne la liste des activités qui n'ont pas été modifiées depuis la date "old_date" passée en paramètre.