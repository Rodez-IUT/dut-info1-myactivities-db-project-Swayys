Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_get_salles_avec_temps_occupation"  
    - *Argument de la fonction* :   
    Aucun
    - *Description* :   
    La fonction retourne la liste des noms de toutes les salles avec leur temps d'occupation respectif ordonnés 
    par temps d'occupation décroissant puis par nom.
    Cette fonction fera appel à la fonction "gds.pl_calcule_temps_occupation".

> Indication technique : comme nous renvoyons une liste personnalisée qui ne correspond pas à une liste de lignes de table de notre BD, 
le type de retour de la fonction doit spécifier la structure des lignes retournées avec une clause "TABLE". Dans notre cas, le type de retour doit être :  

    TABLE(nom_salle varchar(250), temps_occupation interval)

    CREATE FUNCTION gds.pl_get_salles_avec_temps_occupation() RETURNS 
    TABLE(nom_salle varchar(250), temps_occupation interval) AS $$

    BEGIN
    RETURN QUERY SELECT nom, gds.pl_calcule_temps_occupation(nom) AS temps_occupation 
                FROM gds.salle 
                ORDER BY temps_occupation DESC, nom ASC;
    RETURN;
    END;
    $$ LANGUAGE plpgsql;
