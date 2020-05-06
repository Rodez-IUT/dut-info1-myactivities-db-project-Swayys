- Nouvelle description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_calcule_temps_occupation"  
    - *Argument de la fonction* :   
    "un_nom_de_salle" de type "character varying(250)"
    - *Description* :   
    la fonction tente de calculer le temps d'occupation de la salle dont le nom est passé en paramètre. Si la salle demandée n'existe pas dans la base alors 
    ~~un message doit s'afficher dans la console (à l'aide d'une instruction "RAISE NOTICE") pour indiquer que la salle demandée n'existe pas. 
    La fonction retourne null.~~
    **une erreur est lancée avec le code d'erreur "invalid_parameter_value" et un message indiquant que le nom de la salle n'est pas valide.**
    Si la salle existe, la fonction parcourt la liste des réservations de cette salle et ajoute les durées de chacune des réservations pour calculer 
    le temps d'occupation de la salle. Le résultat de cette somme est retournée par la fonction sous forme d'un "interval". 
    L'utilisation de [la fonction "age"](https://www.postgresql.org/docs/9.6/functions-datetime.html) sera bien utile :-)'.


CREATE OR REPLACE FUNCTION gds.pl_calcule_temps_occupation(
	un_nom_de_salle character varying(250))
    RETURNS interval AS $$
	
	DECLARE
		temps_occuppation interval;
	
	BEGIN
		SELECT * INTO temps_occuppation FROM gds.salle WHERE nom = un_nom_de_salle;
		IF FOUND THEN
			SELECT SUM(age(date_fin, date_debut)) INTO temps_occuppation FROM gds.reservation WHERE salle_id = (SELECT id
																						                        FROM gds.salle
																						                        WHERE nom = un_nom_de_salle);
		ELSE
			RAISE invalid_parameter_value
				USING MESSAGE= 'La salle est non trouvée';
		END IF;
		
	RETURN temps_occuppation;
	END;
	$$ LANGUAGE plpgsql;


Testez votre fontion avec les requêtes suivantes :
    
    select * from gds.pl_calcule_temps_occupation('Lilla');
    select * from gds.pl_calcule_temps_occupation('paquerette');
    select * from gds.pl_calcule_temps_occupation('rose');

Si vous avez inséré les données tel que cela était demandé dans les énoncés précédent, ces requêtes doivent retourner respectivement :

- Aucun résultat mais un message d'erreur dans la console avec le code d'erreur 22023 indiqué.
- 04:00:00
- 02:00:00