- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_insert_reservation"  
    - *Arguments de la fonction* :  
    "une_date_debut" de type "timestamp without time zone"
    "une_date_fin" de type "timestamp without time zone" 
    "un_nom_de_salle" de type "character varying(250)"

    - *Description* :   
    La fonction tente d'inserer une nouvelle réservation dans la table "reservation" dont la date de début, 
    la date de fin et le nom de la salle réservée sont transmis en paramètres.

    Si la salle demandée n'existe pas dans la base alors un message doit s'afficher dans la console 
    (à l'aide d'une instruction "RAISE NOTICE") pour indiquer que la salle demandée n'existe pas. 

    La fonction retourne alors une ligne constituée de valeurs nulles. 
    Si la salle demandée existe, alors la fonction utilise la séquence "gds.reservation_seq" pour générer la valeur de la clé primaire 
    de la réservation à insérer dans la base. La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la réservation qui a été insérée.

    CREATE FUNCTION gds.pl_insert_reservation(une_date_debut timestamp without time zone, une_date_fin timestamp without time zone, 
											  un_nom_de_salle character varying(250)) RETURNS gds.reservation AS $$
											  
	DECLARE
		nouv_reservation gds.reservation%ROWTYPE;
		nom_de_salle_a_reserver gds.salle.nom%TYPE;
	BEGIN
		SELECT * INTO nom_de_salle_a_reserver FROM gds.salle WHERE nom = un_nom_de_salle;
		IF FOUND THEN 
            RAISE NOTICE 'La salle existe';
            INSERT INTO gds.reservation 
            VALUES (nextval('gds.reservation_seq'), une_date_debut, une_date_fin, now(), now(), (SELECT id FROM gds.salle WHERE nom = un_nom_de_salle))
			RETURNING * INTO nouv_reservation;			
		ELSE
			RAISE NOTICE 'La salle demandée existe pas.';
		END IF;
		RETURN nouv_reservation;
	END;
	$$ LANGUAGE plpgsql;


Testez votre fonction à l'aide des instructions suivantes  et vérifiez qu'un message s'affiche bien dans la console quand la salle demandée n'existe pas:

    select * from gds.pl_insert_reservation('2020-04-24 15:00:00','2020-04-24 17:00:00','marguerite');
    select * from gds.pl_insert_reservation('2020-04-22 15:00:00','2020-04-22 17:00:00','geranium');
    select * from gds.pl_insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','bambou');
    select * from gds.pl_insert_reservation('2020-04-22 18:00:00','2020-04-22 19:00:00','laurier');
    select * from gds.pl_insert_reservation('2020-04-25 14:00:00','2020-04-25 17:00:00','begonia');
    select * from gds.pl_insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','lilla');