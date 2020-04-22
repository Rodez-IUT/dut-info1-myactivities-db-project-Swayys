- Description de la vue :  

    - *Nom de la vue* :  
    "gds.vue_reservations"  
    - *Description* :   
    la vue retourne la liste de toutes les réservations. Chaque ligne retournée affiche :
        - lid de la réservation 
        - le nom de la salle réservée
        - la date de début de la réservation
        - la date de fin de la réservation
    Les réservations sont triées sur les noms des salles puis de la date de début la plus récente à la date de début la plus ancienne.

    CREATE VIEW gds.vue_reservations AS
        SELECT gds.reservation.id as id, gds.salle.nom as nom_salle, gds.reservation.date_debut as date_debut, gds.reservation.date_fin as date_fin
        FROM gds.reservation
        JOIN gds.salle
        ON gds.reservation.salle_id = gds.salle.id
        ORDER BY gds.salle.nom, gds.reservation.date_debut;

Vous pouvez tester le bon fonctionnement de votre vue avec la requête suivante :

    select * from gds.vue_reservations;   

    