 Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.insert_reservation"  
    - *Arguments de la fonction* :  
    "une_date_debut" de type "timestamp without time zone"
    "une_date_fin" de type "timestamp without time zone" 
    "un_nom_de_salle" de type "character varying(250)"
    - *Description* :   
    la fonction insert une nouvelle réservation dans la table "reservation" dont la date de début, la date de fin et le nom de la salle réservée
    sont transmis en paramètres.
    La fonction utilise la séquence "gds.reservation_seq" pour générer la valeur de la clé primaire de la réservation à insérer dans la base.
    La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la réservation qui a été insérée.

    CREATE FUNCTION gds.insert_reservation (
         une_date_debut timestamp without time zone,
         une_date_fin timestamp without time zone,
         un_nom_de_salle character varying(250))
    RETURNS gds.reservation AS $$
    
    INSERT INTO gds.reservation (id, date_debut, date_fin, date_creation, date_modification, salle_id)
    VALUES (nextval('gds.reservation_seq'), une_date_debut, une_date_fin, now(), now(), (SELECT gds.salle.id FROM gds.salle WHERE gds.salle.nom = un_nom_de_salle))
    RETURNING reservation;
  $$
  LANGUAGE SQL;

  Insérez 6 réservations dans votre BD à l'aide des instructions suivantes :

    select * from gds.insert_reservation('2020-04-24 15:00:00','2020-04-24 17:00:00','paquerette');
    select * from gds.insert_reservation('2020-04-22 15:00:00','2020-04-22 17:00:00','paquerette');
    select * from gds.insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','rose');
    select * from gds.insert_reservation('2020-04-23 18:00:00','2020-04-22 19:00:00','tulipe');
    select * from gds.insert_reservation('2020-04-25 14:00:00','2020-04-25 17:00:00','dalhia');
    select * from gds.insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','dalhia');

POUR RAPPEL :  
CREATE TABLE gds.reservation
(
    id bigint NOT NULL,
    date_debut timestamp without time zone NOT NULL,
    date_fin timestamp without time zone NOT NULL,
    date_creation timestamp without time zone NOT NULL,
    date_modification timestamp without time zone NOT NULL,
    salle_id bigint NOT NULL,
    CONSTRAINT reservation_pkey PRIMARY KEY (id),
    CONSTRAINT fk_reservation_salle FOREIGN KEY (salle_id)
        REFERENCES gds.salle (id)
)