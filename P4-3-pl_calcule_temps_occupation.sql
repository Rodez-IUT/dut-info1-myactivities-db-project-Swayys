- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_calcule_temps_occupation"  
    - *Argument de la fonction* :   
    "un_nom_de_salle" de type "character varying(250)"
    - *Description* :   
    la fonction tente de calculer le temps d'occupation de la salle dont le nom est passé en paramètre. Si la salle demandée 
    n'existe pas dans la base alors un message doit s'afficher dans la console (à l'aide d'une instruction "RAISE NOTICE") 
    pour indiquer que la salle demandée n'existe pas. La fonction retourne null.
    Si la salle existe, la fonction parcourt la liste des réservations de cette salle et ajoute les durées de chacune des réservations pour calculer 
    le temps d'occupation de la salle. Le résultat de cette somme est retournée par la fonction sous forme d'un "interval". 
    L'utilisation de [la fonction "age"](https://www.postgresql.org/docs/9.6/functions-datetime.html) sera bien utile :-).
'f

CREATE FUNCTION gds.pl_calcule_temps_occupation(un_nom_de_salle character varying(250)) RETURNS interval AS $$
DECLARE
	id_de_salle_demandee bigint;
	temps_occupation interval := 0;
	reservation_enregistree gds.reservation%ROWTYPE;
BEGIN
	SELECT * INTO id_de_salle_demandee FROM gds.salle WHERE nom = un_nom_de_salle;
	IF FOUND THEN
		FOR reservation_enregistree IN (SELECT * FROM gds.reservation WHERE salle_id = id_de_salle_demandee) LOOP
			temps_occupation := temps_occupation + AGE(reservation_enregistree.date_fin, reservation_enregistree.date_debut);	
		END LOOP;
	ELSE 
		RAISE NOTICE 'La salle demandée existe pas';
	END IF;
	RETURN temps_occupation;
END;
$$ LANGUAGE plpgsql;



Testez votre fontion avec les requêtes suivantes :
    
    select * from gds.pl_calcule_temps_occupation('Lilla');
    select * from gds.pl_calcule_temps_occupation('paquerette');
    select * from gds.pl_calcule_temps_occupation('rose');

Si vous avez inséré les données tel que cela était demandé dans les énoncés précédent, ces requêtes doivent retourner respectivement :

- [null]
- 04:00:00
- 02:00:00
