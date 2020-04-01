Description de la fonction :  

    Modifiez la fonction "create_activity_with_owner" 
    pour qu'elle utilise la clause RETURNING au lieu de la dernière instruction SELECT pour retourner l'activité que la fonction vient de créer.

    CREATE OR REPLACE FUNCTION create_activity_with_owner(
        an_act_id bigint, 
        an_act_title VARCHAR(200), 
        an_act_descr text, 
        a_user_id bigint,
        a_username VARCHAR(500)) 
    RETURNS activity AS $$
        -- insert the owner
        INSERT INTO "user" (id, username, date_created) 
        VALUES (a_user_id, a_username, now());
        -- insert the activity
        INSERT INTO activity (id, title, description, creation_date, modification_date, owner_id)
        VALUES (an_act_id, an_act_title, an_act_descr, now(), now(), a_user_id);
        -- return the created activity
        RETURNING activity;
    $$
    LANGUAGE SQL;