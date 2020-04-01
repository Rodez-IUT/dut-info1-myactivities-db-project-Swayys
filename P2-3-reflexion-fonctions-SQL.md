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
        SELECT * FROM activity where id = an_act_id ;
    $$
    LANGUAGE SQL;

Les différents problèmes de la fonction : 

- utilisation de "an" ou "a" = inutiles. Autant mettre directement "act_id" 
- a_username VARCHAR(500) ; 500 est vraiment trop grand pour un nom d'utilisateur
- utilisations des now() qui limite les personnalisations ? 
- utilisation de RETURNING à la place de SELECT

Proposition de fonction : 

CREATE OR REPLACE FUNCTION create_activity_with_owner(
        act_id bigint, 
        act_title VARCHAR(200), 
        act_descr text, 
        user_id bigint,
        username VARCHAR(200)) 
    RETURNS activity AS $$
        -- insert the owner
        INSERT INTO "user" (id, username, date_created) 
        VALUES (user_id, username, date); --pas sûr de la date
        -- insert the activity
        INSERT INTO activity (id, title, description, creation_date, modification_date, owner_id)
        VALUES (act_id, act_title, act_descr, date, now(), user_id) --pas sûr de la date
        -- return the created activity 
        RETURNING activity;
    $$
    LANGUAGE SQL;