- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_insert_salle"  
    - *Arguments de la fonction* :  
    "un_nom" de type "character varying(250)"
    "un_nb_personnes_max" de type "integer"  
    - *Description* :   
    La fonction insert une nouvelle salle dans la table "salle" dont le nom et le nombre de personnes max dans la salle sont transmis en paramètres.
    La fonction utilise la séquence "gds.salle_seq" pour générer la valeur de la clé primaire de la salle à insérer dans la base. 
    La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la salle qui a été insérée.

    CREATE FUNCTION gds.pl_insert_salle(un_nom character varying(250), un_nb_personnes_max integer) RETURNS gds.salle AS $$
    DECLARE 
	    nouv_salle gds.salle%ROwTYPE;
    BEGIN
    INSERT INTO gds.salle 
        VALUES(nextval('gds.salle_seq'), un_nom, un_nb_personnes_max, now(), now()) 
        RETURNING * INTO nouv_salle;
        RETURN nouv_salle;
    END;
    $$ LANGUAGE plpgsql;

    Insérez 4 salles dans votre BD à laide des instructions suivantes :

    select * from gds.pl_insert_salle('marguerite', 12);
    select * from gds.pl_insert_salle('geranium', 6);
    select * from gds.pl_insert_salle('laurier', 24);
    select * from gds.pl_insert_salle('bambou', 32);