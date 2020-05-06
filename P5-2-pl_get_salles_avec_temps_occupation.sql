- Nouvelle description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_get_salles_avec_temps_occupation"  
    - *Argument de la fonction* :   
    "curs" de type refcursor
    - *Description* :   
    La fonction retourne **un curseur correspondant à** la liste des noms de toutes les salles avec leur temps d'occupation respectif 
    ordonnés par temps d'occupation décroissant puis par nom.
    Cette fonction fera appel à la fonction "gds.pl_calcule_temps_occupation".

> Indication technique : pour tester votre fonction, référez vous à l'exemple donné dans le support de cours.'

CREATE FUNCTION gds.pl_get_salles_avec_temps_occupation(curs refcursor) RETURNS 
    refcursor AS $$

    BEGIN
	OPEN curs FOR SELECT nom, gds.pl_calcule_temps_occupation(nom) AS temps_occupation 
                  FROM gds.salle 
                  ORDER BY temps_occupation DESC, nom ASC;
    RETURN curs;
    END;
    $$ LANGUAGE plpgsql;