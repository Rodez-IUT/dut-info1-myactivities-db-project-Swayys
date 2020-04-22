- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.insert_salle"  
    - *Arguments de la fonction* :  
    "un_nom" de type "character varying(250)"
    "un_nb_personnes_max" de type "integer"  
    - *Description* :   
    la fonction insert une nouvelle salle dans la table "salle" dont le nom et le nombre de personnes max dans la salle sont transmis en paramètres.
    La fonction utilise la séquence "gds.salle_seq" pour générer la valeur de la clé primaire de la salle à insérer dans la base. 
    La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la salle qui a été insérée.

CREATE FUNCTION gds.insert_salle(
    un_nom character varying(250),
    un_nb_personnes_max integer)
		
RETURNS gds.salle AS $$

    INSERT INTO gds.salle (id, nom, nb_personnes_max, date_creation, date_modification)
    VALUES (nextval('gds.salle_seq'), un_nom, un_nb_personnes_max, now(), now())
    RETURNING salle;
$$
LANGUAGE SQL;


Insérez 4 salles dans votre BD à l'aide des instructions suivantes :

    select * from gds.insert_salle('paquerette', 12);
    select * from gds.insert_salle('rose', 6);
    select * from gds.insert_salle('dalhia', 24);
    select * from gds.insert_salle('tulipe', 32);


