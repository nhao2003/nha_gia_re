--USER DATABASE
DROP TABLE IF EXISTS user_follow;
DROP TABLE IF EXISTS user_like;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS conservations;
DROP TABLE IF EXISTS offices;
DROP TABLE IF EXISTS motels;
DROP TABLE IF EXISTS houses;
DROP TABLE IF EXISTS apartments;
DROP TABLE IF EXISTS lands;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS user_info;
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP TRIGGER IF EXISTS on_auth_user_updated ON public.user_info;
DROP FUNCTION IF EXISTS handle_new_user();
DROP FUNCTION IF EXISTS handle_updated_user();



SET TIME ZONE 'Asia/Ho_Chi_Minh';
CREATE TABLE IF NOT EXISTS user_info
(
    uid
    uuid
    REFERENCES
    auth
    .
    users
    ON
    DELETE
    CASCADE
    NOT
    NULL
    PRIMARY
    KEY,
    email
    TEXT,
    phone
    TEXT,
    address
    JSONB,
    is_male
    BOOLEAN,
    avatar_url
    TEXT,
    full_name
    varchar
(
    255
),
    dob timestamp,
    last_activity_at timestamp,
    description TEXT,
    updated_at timestamp,
    --Số người theo dõi bạn
    num_of_followers int DEFAULT 0,
    --Số người bạn theo dõi
    num_of_following int DEFAULT 0,
    CHECK
(
    num_of_followers >= 0
),
    CHECK
(
    num_of_following >= 0
)
    );

-- Trigger to call `handle_new_user` when new user signs up
create
or replace function handle_new_user() returns trigger as
$$
begin
    set
timezone = 'Asia/Ho_Chi_Minh';
insert into public.user_info(uid, email, last_activity_at)
values (new.id, new.email, now());
return new;
end;
$$
language plpgsql security definer;

create trigger on_auth_user_created
    after
        insert
    on auth.users
    for each row
    execute function handle_new_user();


create
or replace function handle_updated_user() returns trigger as
$$
begin
    set
timezone = 'Asia/Ho_Chi_Minh';
UPDATE public.user_info
SET updated_at       = now(),
    last_activity_at = now()
WHERE uid = new.uid;
return new;
end
$$
language plpgsql security definer;

-- Trigger to call `handle_updated_user` when new user update data

create
or replace trigger on_auth_user_updated
    AFTER
UPDATE OF phone, is_male, avatar_url, full_name, dob, description
on public.user_info
    for each row
    execute function handle_updated_user();

--Table Follow

CREATE TABLE user_follow
(
    follower_id uuid NOT NULL,
    followed_id uuid NOT NULL,
    PRIMARY KEY (follower_id,
                 followed_id),
    FOREIGN KEY (follower_id) REFERENCES public.user_info (uid) ON DELETE CASCADE,
    FOREIGN KEY (followed_id) REFERENCES public.user_info (uid) ON DELETE CASCADE
);

insert into user_follow (follower_id, followed_id)
values ('de23a0b3-262b-4982-aa55-084dcb08961a'::uuid, 'f8a68af6-f0d7-45c8-8b9f-666f6e4f1314'::uuid)
    insert
into user_follow (follower_id, followed_id)
values ('f7f7631f-667b-4b38-924f-4a6d9e9db182'::uuid, '3ec257e0-0670-474d-bb8c-beb5178acd8c'::uuid)


delete
from auth.users
where id = 'f8a68af6-f0d7-45c8-8b9f-666f6e4f1314' ::uuid

delete
from user_info
where uid = '99785dd5-7516-4d5c-8310-d791a90256fc' ::uuid
--follow trigger;
CREATE
OR REPLACE FUNCTION handle_follow()
    RETURNS TRIGGER AS
$$
BEGIN
UPDATE user_info
SET num_of_followers = COALESCE((SELECT COUNT(*) FROM user_follow WHERE user_follow.followed_id = user_info.uid),
                                0)
WHERE user_info.uid = NEW.followed_id;

UPDATE user_info
SET num_of_following = COALESCE((SELECT COUNT(*) FROM user_follow WHERE user_follow.follower_id = user_info.uid),
                                0)
WHERE user_info.uid = NEW.follower_id;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE
OR REPLACE TRIGGER follow_trigger
    AFTER INSERT OR DELETE
ON user_follow
    FOR EACH ROW
EXECUTE FUNCTION handle_follow();


--Unfollow trigger
CREATE
OR REPLACE FUNCTION handle_unfollow()
    RETURNS TRIGGER AS
$$
BEGIN
UPDATE user_info
SET num_of_followers = COALESCE((SELECT COUNT(*) FROM user_follow WHERE user_follow.followed_id = user_info.uid),
                                0)
WHERE user_info.uid = old.followed_id;

UPDATE user_info
SET num_of_following = COALESCE((SELECT COUNT(*) FROM user_follow WHERE user_follow.follower_id = user_info.uid),
                                0)
WHERE user_info.uid = old.follower_id;
RETURN old;
END;
$$
LANGUAGE plpgsql;

CREATE
OR REPLACE TRIGGER unfollow_trigger
    AFTER INSERT OR DELETE
ON user_follow
    FOR EACH ROW
EXECUTE FUNCTION handle_unfollow();

CREATE TABLE conversations
(
    id                              uuid      not null primary key default uuid_generate_v4(),
    user1_id                        uuid      NOT NULL,
    user2_id                        uuid      NOT NULL,
    last_message_type VARCHAR DEFAULT NULL,
    last_message                    TEXT,
    last_message_sent_at            TIMESTAMP NOT NULL             DEFAULT timezone('Asia/Ho_Chi_Minh', now()),
    user1_joined_at                 TIMESTAMP                      DEFAULT timezone('Asia/Ho_Chi_Minh', now()),
    user2_joined_at                 TIMESTAMP                      DEFAULT timezone('Asia/Ho_Chi_Minh', now()),
    num_Of_unread_messages_of_user1 int       NOT NULL             DEFAULT 0,
    num_Of_unread_messages_of_user2 int       NOT NULL             DEFAULT 0,
    CHECK (user1_id != user2_id
) ,
    FOREIGN KEY (user1_id) REFERENCES public.user_info (uid) ON DELETE CASCADE,
    FOREIGN KEY (user2_id) REFERENCES public.user_info (uid) ON DELETE CASCADE
);

alter
publication supabase_realtime add table public.conversations;
CREATE TABLE messages
(
    id               uuid                                                        not null primary key default uuid_generate_v4(),
    conversation_id  uuid references public.conversations (id) on delete cascade not null,
    sender_id        uuid                                                        NOT NULL,
    message_type VARCHAR NOT NULL,
    message          TEXT,
    images           TEXT[],
    post_id          uuid,
    sent_at          TIMESTAMP                                                   NOT NULL             DEFAULT timezone('Asia/Ho_Chi_Minh', now()),
    is_receiver_read BOOLEAN                                                                          DEFAULT FALSE,
    CHECK (message IS NOT NULL OR cardinality(images) > 0),
    FOREIGN KEY (post_id) REFERENCES public.post (id),
    FOREIGN KEY (sender_id) REFERENCES public.user_info (uid) ON DELETE CASCADE
);
ALTER
publication supabase_realtime add table public.messages;

CREATE
OR REPLACE FUNCTION update_last_message()
  RETURNS TRIGGER AS $$
BEGIN
    set
timezone = 'Asia/Ho_Chi_Minh';
UPDATE conversations
SET last_message                    = NEW.message,
    last_message_type               = NEW.message_type,
    last_message_sent_at            = NEW.sent_at,
    user1_joined_at                 = CASE
                                          WHEN user1_joined_at IS NULL THEN timezone('Asia/Ho_Chi_Minh', now())
                                          ELSE user1_joined_at END,
    user2_joined_at                 = CASE
                                          WHEN user2_joined_at IS NULL THEN timezone('Asia/Ho_Chi_Minh', now())
                                          ELSE user2_joined_at END,
    num_Of_unread_messages_of_user1 = CASE
                                          WHEN user1_id = new.sender_id THEN 0
                                          ELSE (SELECT COUNT(*)
                                                FROM messages
                                                WHERE messages.conversation_id = new.conversation_id
                                                  AND messages.sender_id != new.sender_id AND
                                      messages.is_receiver_read = false )
END,
  num_Of_unread_messages_of_user2 = CASE WHEN user2_id = new.sender_id THEN 0 ELSE (
    SELECT COUNT(*) FROM messages
    WHERE messages.conversation_id = new.conversation_id AND messages.sender_id != new.sender_id AND messages.is_receiver_read = false
  )
END
  WHERE id = NEW.conversation_id;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER update_conversation_last_message
    AFTER INSERT
    ON messages
    FOR EACH ROW
    EXECUTE FUNCTION update_last_message();

CREATE OR REPLACE FUNCTION get_or_create_conversation(
    user_info_id uuid
) RETURNS conversations AS $$
DECLARE
    conversation conversations;
BEGIN
    SELECT * INTO conversation FROM conversations
     WHERE (user1_id = auth.uid() and user2_id = user_info_id) OR (user2_id = auth.uid() and user1_id = user_info_id)
    LIMIT 1;

    IF conversation IS NULL THEN
        INSERT INTO conversations (user1_id, user2_id, last_message_sent_at)
        VALUES (auth.uid(), user_info_id, timezone('Asia/Ho_Chi_Minh', now()))
        RETURNING * INTO conversation;
    ELSE
        UPDATE conversations
        SET user1_joined_at = CASE WHEN user1_joined_at IS NULL THEN timezone('Asia/Ho_Chi_Minh', now()) ELSE user1_joined_at END,
            user2_joined_at = CASE WHEN user2_joined_at IS NULL THEN timezone('Asia/Ho_Chi_Minh', now()) ELSE user2_joined_at END
        WHERE id = conversation.id;
        SELECT * INTO conversation FROM conversations
        WHERE id = conversation.id;
    END IF;
    RETURN conversation;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_conversation(p_user_id uuid, p_conversation_id uuid)
    RETURNS void AS $$
DECLARE
    conversation conversations;
BEGIN
    UPDATE conversations
    SET
        user1_joined_at = CASE WHEN user1_id = p_user_id THEN NULL ELSE user1_joined_at END,
        user2_joined_at = CASE WHEN user2_id = p_user_id THEN NULL ELSE user2_joined_at END,
        num_Of_unread_messages_of_user1 = CASE WHEN user1_id = p_user_id THEN 0 ELSE num_Of_unread_messages_of_user1 END,
        num_Of_unread_messages_of_user2 = CASE WHEN user2_id = p_user_id THEN 0 ELSE num_Of_unread_messages_of_user2 END
    WHERE id = p_conversation_id;

    SELECT INTO conversation *
    FROM conversations
    WHERE id = p_conversation_id;

    IF conversation.user1_joined_at IS NULL AND conversation.user2_joined_at IS NULL THEN
        BEGIN
            DELETE FROM storage.objects
            WHERE name LIKE p_conversation_id || '%';
            DELETE FROM conversations WHERE id = p_conversation_id;
        END;
    END IF;
END;
$$ LANGUAGE plpgsql;





--Model

CREATE TABLE post
(
    id            uuid         not null primary key default uuid_generate_v4(),
    area          NUMERIC      NOT NULL,
    project_name  VARCHAR(255),
    property_type VARCHAR(255) NOT NULL,
    address       JSONB        NOT NULL,
    user_id       uuid         NOT NULL,
    price         NUMERIC      NOT NULL,
    deposit       NUMERIC,
    is_lease      BOOLEAN      NOT NULL,
    title         VARCHAR(255) NOT NULL,
    description   TEXT         NOT NULL,
    posted_date   TIMESTAMP    NOT NULL             DEFAULT NOW(),
    expiry_date   TIMESTAMP    NOT NULL,
    images_url    TEXT[] NOT NULL,
    is_pro_seller BOOLEAN      NOT NULL,
    num_of_likes  INT          NOT NULL             DEFAULT 0,
    is_hide       BOOLEAN      NOT NULL             DEFAULT FALSE,
    status        VARCHAR                           default 'pending',
    rejected_info VARCHAR,
    FOREIGN KEY (user_id) REFERENCES public.user_info (uid) on delete cascade,
    CHECK (area > 0),
    CHECK (property_type IN ('Apartment',
                             'Land',
                             'Office',
                             'Motel',
                             'House')),
    CHECK (property_type != 'Motel'
        OR is_lease = true
) ,
    CHECK (price > 0),
    CHECK (deposit IS NULL
        OR deposit > 0),
    CHECK (expiry_date > posted_at),
    CHECK (address ->> 'city_code' IS NOT NULL
        AND address ->> 'district_code' IS NOT NULL
        AND address ->> 'ward_code' IS NOT NULL),
    CHECK (num_of_likes >= 0)
);


CREATE TABLE offices
(
    furniture_status      VARCHAR(255),
    has_wide_alley        BOOLEAN NOT NULL,
    is_facade             BOOLEAN NOT NULL,
    office_type           VARCHAR(50),
    main_door_direction   VARCHAR(255),
    legal_document_status VARCHAR(255),
    CHECK (office_type IS NULL
        OR office_type IN ('Office',
                           'Officetel',
                           'Commercial Space',
                           'Shop House')),
    CHECK (main_door_direction IS NULL
        OR main_door_direction IN ('North',
                                   'South',
                                   'East',
                                   'West',
                                   'North East',
                                   'North West',
                                   'South East',
                                   'South West')),
    CHECK (furniture_status IS NULL
        OR furniture_status IN (NULL,
                                'Empty',
                                'Basic',
                                'High end')),
    CHECK (legal_document_status IS NULL
        OR legal_document_status IN ('Waiting for certificate',
                                     'Have certificate',
                                     'Other documents'))
) INHERITS (post);


CREATE TABLE motels
(
    furniture_status VARCHAR(255),
    electric_price   INT,
    water_price      INT,
    CHECK (furniture_status IS NULL
        OR furniture_status IN ('Empty',
                                'Basic',
                                'High end')),
    CHECK (electric_price IS NULL
        OR electric_price > 0),
    CHECK (water_price IS NULL
        OR water_price > 0)
) INHERITS (post);


CREATE TABLE lands
(
    land_lot_code              VARCHAR(255),
    subdivision_name           VARCHAR(255),
    land_type                  VARCHAR(255),
    width                      DOUBLE PRECISION NOT NULL,
    length                     DOUBLE PRECISION NOT NULL,
    land_direction             VARCHAR(255),
    legal_document_status      VARCHAR(255),
    is_facade                  BOOLEAN          NOT NULL,
    is_widens_towards_the_back BOOLEAN          NOT NULL,
    has_wide_alley             BOOLEAN          NOT NULL,
    CHECK (land_type IS NULL
        OR land_type IN ('Residential',
                         'Agricultural',
                         'Industrial',
                         'Project')),
    CHECK (land_direction IS NULL
        OR land_direction IN ('North',
                              'South',
                              'East',
                              'West',
                              'North East',
                              'North West',
                              'South East',
                              'South West')),
    CHECK (width > 0
        and length > 0),
    CHECK (legal_document_status IS NULL
        OR legal_document_status IN ('Waiting for certificate',
                                     'Have certificate',
                                     'Other documents'))
) INHERITS (post);


CREATE TABLE houses
(
    furniture_status           VARCHAR(255),
    has_wide_alley             BOOLEAN NOT NULL,
    is_facade                  BOOLEAN NOT NULL,
    is_widens_towards_the_back BOOLEAN NOT NULL,
    area_used                  NUMERIC,
    width                      DOUBLE PRECISION,
    length                     DOUBLE PRECISION,
    house_type                 VARCHAR(255),
    num_of_bedrooms            INT,
    num_of_toilets             INT,
    num_of_floors              INT,
    main_door_direction        VARCHAR(255),
    legal_document_status      VARCHAR(255),
    CHECK (house_type IS NULL
        OR house_type IN ('Front house',
                          'Town house',
                          'Alley house',
                          'Villa',
                          'Row house')),
    CHECK (main_door_direction IS NULL
        OR main_door_direction IN ('North',
                                   'South',
                                   'East',
                                   'West',
                                   'North East',
                                   'North West',
                                   'South East',
                                   'South West')),
    CHECK (area_used is NULL
        OR area_used > 0),
    CHECK (num_of_bedrooms is NULL
        OR num_of_bedrooms >= 0),
    CHECK (num_of_toilets is NULL
        OR num_of_toilets >= 0),
    CHECK (num_of_floors is NULL
        OR num_of_floors >= 0),
    CHECK ((width is NULL
        and length is NULL)
        or (width > 0
            and length > 0)),
    CHECK (furniture_status IS NULL
        OR furniture_status IN (NULL,
                                'Empty',
                                'Basic',
                                'High end')),
    CHECK (legal_document_status IS NULL
        OR legal_document_status IN ('Waiting for certificate',
                                     'Have certificate',
                                     'Other documents'))
) INHERITS (post);


CREATE TABLE apartments
(
    furniture_status      VARCHAR(255),
    apartment_type        VARCHAR(255),
    is_corner             BOOLEAN NOT NULL,
    is_hand_over          BOOLEAN NOT NULL,
    num_of_bedrooms       INTEGER,
    num_of_toilets        INTEGER,
    balcony_direction     VARCHAR(255),
    main_door_direction   VARCHAR(255),
    block                 VARCHAR(255),
    floor                 INTEGER NOT NULL,
    legal_document_status VARCHAR(255),
    CHECK (apartment_type IS NULL
        OR apartment_type IN (
                              'Apartment',
                              'Duplex',
                              'Penhouse',
                              'Service',
                              'Dormitory',
                              'Officetel')),
    CHECK (balcony_direction IS NULL
        OR balcony_direction IN ('North',
                                 'South',
                                 'East',
                                 'West',
                                 'North East',
                                 'North West',
                                 'South East',
                                 'South West')),
    CHECK (main_door_direction IS NULL
        OR main_door_direction IN ('North',
                                   'South',
                                   'East',
                                   'West',
                                   'North East',
                                   'North West',
                                   'South East',
                                   'South West')),
    CHECK (num_of_bedrooms is NULL
        OR num_of_bedrooms >= 0),
    CHECK (num_of_toilets is NULL
        OR num_of_toilets >= 0),
    CHECK (furniture_status IS NULL
        OR furniture_status IN (NULL,
                                'Empty',
                                'Basic',
                                'High end')),
    CHECK (legal_document_status IS NULL
        OR legal_document_status IN ('Waiting for certificate',
                                     'Have certificate',
                                     'Other documents')),
    CHECK (floor >= 0)
) INHERITS (post);

--
--Gia hạn bài post
CREATE
OR REPLACE FUNCTION extend_post_expiry_date(post_id uuid) RETURNS void AS $$
DECLARE
now_time TIMESTAMP := NOW();
    expiry_time
TIMESTAMP;
BEGIN
SELECT expiry_date
INTO expiry_time
FROM post
WHERE id = post_id;

IF
expiry_time < now_time THEN
        expiry_time := now_time + INTERVAL '14 days';
ELSE
        expiry_time := expiry_time + INTERVAL '14 days';
END IF;

UPDATE post
SET expiry_date = expiry_time
WHERE id = post_id;
END;
$$
LANGUAGE plpgsql;

--

CREATE TABLE user_like
(
    user_id uuid NOT NULL,
    post_id uuid NOT NULL,
    PRIMARY KEY (user_id,
                 post_id),
    FOREIGN KEY (user_id) REFERENCES public.user_info (uid) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES public.post (id) ON DELETE CASCADE
);

-- Like Trigger
CREATE
OR REPLACE FUNCTION handle_like()
    RETURNS TRIGGER AS
$$
BEGIN
UPDATE post
SET num_of_likes = num_of_likes + 1
WHERE id = NEW.post_id;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER like_trigger
    AFTER INSERT
    ON user_like
    FOR EACH ROW
    EXECUTE FUNCTION handle_like();

--Unlike trigger
CREATE
OR REPLACE FUNCTION handle_unlike()
    RETURNS TRIGGER AS
$$
BEGIN
UPDATE post
SET num_of_likes = num_of_likes - 1
WHERE id = NEW.post_id;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER unlike_trigger
    AFTER DELETE
    ON user_like
    FOR EACH ROW
    EXECUTE FUNCTION handle_unlike();

create function title_description(post) returns text as $$
select unaccent($1.title) || ' ' || unaccent($1.description);
$$
language sql immutable;
