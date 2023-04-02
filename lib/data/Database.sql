--USER DATABASE
SET TIME ZONE 'Asia/Ho_Chi_Minh';
CREATE TABLE IF NOT EXISTS user_info (
    uid uuid REFERENCES auth.users ON DELETE CASCADE NOT NULL PRIMARY KEY,
    address JSONB,
    isMale BOOLEAN DEFAULT false,
    avatarUrl TEXT,
    fullName varchar (255),
    birthday timestamp,
    lastActivityAt timestamp,
    description TEXT
);

create or replace function handle_new_user() returns trigger as $$
    begin
		set timezone='Asia/Ho_Chi_Minh';
        insert into public.user_info(uid, lastActivityAt)
        values(new.id, now());
        return new;
    end;
$$ language plpgsql security definer;

-- Trigger to call `handle_new_user` when new user signs up
create trigger on_auth_user_created
    after insert on auth.users
    for each row
    execute function handle_new_user();

--Table Follow
CREATE TABLE user_follow (
    follower_id uuid NOT NULL,
    followed_id uuid NOT NULL,
    follow_date TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (follower_id, followed_id),
    FOREIGN KEY (follower_id) REFERENCES auth.users(id) ON DELETE CASCADE,
    FOREIGN KEY (followed_id) REFERENCES auth.users(id) ON DELETE CASCADE
);

CREATE TABLE conservations (
    id uuid not null primary key default uuid_generate_v4(),
    user1_id uuid NOT NULL,
    user2_id uuid NOT NULL,
    CHECK(user1_id != user2_id),
    FOREIGN KEY (user1_id) REFERENCES auth.users(id) ON DELETE CASCADE,
    FOREIGN KEY (user2_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
ALTER publication supabase_realtime add table public.conservations;

CREATE TABLE messages (
    id uuid not null primary key default uuid_generate_v4(),
    sender_id uuid NOT NULL REFERENCES auth.users(id),
    message TEXT NOT NULL,
    sent_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (sender_id) REFERENCES auth.users(id) ON DELETE CASCADE
);
ALTER publication supabase_realtime add table public.messages;


--Model
CREATE TABLE post (
    id uuid not null primary key default uuid_generate_v4(),
    area NUMERIC NOT NULL,
    project_name VARCHAR(255),
    property_type VARCHAR(255) NOT NULL, 
    address JSONB NOT NULL,
    user_id uuid NOT NULL,
    price INT NOT NULL,
    deposit INT,
    is_lease BOOLEAN NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    posted_at TIMESTAMP NOT NULL DEFAULT NOW(),
    expiry_date TIMESTAMP NOT NULL,
    images_url TEXT[] NOT NULL,
    is_pro_seller BOOLEAN NOT NULL,
    FOREIGN KEY (user_id) REFERENCES auth.users(id) on delete cascade,
	CHECK (area > 0),
	CHECK (property_type IN ('Apartment', 'Land', 'Office', 'Motel', 'House')),
    CHECK (property_type != 'Motel' OR is_lease = true),
	CHECK (price > 0),
	CHECK (deposit IS NULL OR deposit > 0),
	CHECK (expiry_date > posted_at),
    CHECK (address->>'city_code' IS NOT NULL AND address->>'district_code' IS NOT NULL AND address->>'ward_code' IS NOT NULL )
)
CREATE TABLE offices (
	furniture_status VARCHAR(255), 
	has_wide_alley BOOLEAN,
    is_facade BOOLEAN,
    office_type VARCHAR(50) NOT NULL,
    main_door_direction VARCHAR(255),
    legal_document_status VARCHAR(255),

    CHECK (office_type IS NULL OR office_type IN ( 'Office', 'Officetel', 'Commercial Space', 'Shop House')),
    CHECK (main_door_direction IS NULL OR main_door_direction IN ('North', 'South', 'East', 'West', 'North East', 'North West', 'South East', 'South West')),
    CHECK (furniture_status IS NULL OR furniture_status IN (NULL, 'Empty', 'Basic', 'High end')),
    CHECK (legal_document_status IS NULL OR legal_document_status IN ( 'Waiting for certificate', 'Have certificate', 'Other documents'))
) INHERITS (post)

CREATE TABLE motels (
	furniture_status VARCHAR(255),
	electric_price INT ,
 	water_price INT,

	CHECK (furniture_status IS NULL OR furniture_status IN ('Empty', 'Basic', 'High end')),
	CHECK (electric_price IS NULL OR electric_price > 0),
    CHECK (water_price IS NULL OR water_price > 0)
) INHERITS (post)

CREATE TABLE lands (
    land_lot_code VARCHAR(255),
    subdivision_name VARCHAR(255),
    land_type VARCHAR(255),
    width DOUBLE PRECISION NOT NULL,
    length DOUBLE PRECISION NOT NULL,
    land_direction VARCHAR(255),
    legal_document_status VARCHAR(255),
    is_facade BOOLEAN,
    is_widens_towards_the_back BOOLEAN,
    has_wide_alley BOOLEAN,
    CHECK (land_type IS NULL OR land_type IN ( 'Residential', 'Agricultural', 'Industrial', 'Project')),
    CHECK (land_direction IS NULL OR land_direction IN ('North', 'South', 'East', 'West', 'North East', 'North West', 'South East', 'South West')),
	CHECK(width > 0 and length > 0),
    CHECK (legal_document_status IS NULL OR legal_document_status IN ('Waiting for certificate', 'Have certificate', 'Other documents'))
) INHERITS (post)

CREATE TABLE houses (
	furniture_status VARCHAR(255),
	has_wide_alley BOOLEAN,
	is_facade BOOLEAN,
	area_used NUMERIC,
	width DOUBLE PRECISION,
	length DOUBLE PRECISION,
	house_type VARCHAR(255),
	num_of_bedrooms INT,
	num_of_toilets INT,
	num_of_floors INT,
	main_door_direction VARCHAR(255),
	legal_document_status VARCHAR(255),
    
    CHECK (house_type IS NULL OR house_type IN ( 'FrontHouse', 'Town House', 'Alley House', 'Villa', 'Row House')),
    CHECK (main_door_direction IS NULL OR main_door_direction IN ('North', 'South', 'East', 'West', 'North East', 'North West', 'South East', 'South West')),
    CHECK (area_used is NULL OR area_used > 0),
    CHECK (num_of_bedrooms is NULL OR num_of_bedrooms >= 0),
    CHECK (num_of_toilets is NULL OR num_of_toilets >= 0),
    CHECK (num_of_floors is NULL OR num_of_floors >= 0),
	CHECK((width is NULL and length is NULL) or (width > 0 and length > 0)),
    CHECK (furniture_status IS NULL OR furniture_status IN (NULL, 'Empty', 'Basic', 'High end')),
    CHECK (legal_document_status IS NULL OR legal_document_status IN ('Waiting for certificate', 'Have certificate', 'Other documents'))
) INHERITS (post)

CREATE TABLE apartments (
	furniture_status VARCHAR(255),
	apartment_type VARCHAR(255),
	is_corner BOOLEAN,
	is_hand_over BOOLEAN,
	num_of_bedrooms INTEGER,
	num_of_toilets INTEGER,
	balcony_direction VARCHAR(255),
	main_door_direction VARCHAR(255),
	block VARCHAR(255),
	floor INTEGER NOT NULL,
	legal_document_status VARCHAR(255),

    CHECK (apartment_type IS NULL OR apartment_type IN ( 'Duplex', 'Penhouse', 'Service', 'Dormitory', 'Officetel')),
    CHECK (balcony_direction IS NULL OR balcony_direction IN ('North', 'South', 'East', 'West', 'North East', 'North West', 'South East', 'South West')),
    CHECK (main_door_direction IS NULL OR main_door_direction IN ('North', 'South', 'East', 'West', 'North East', 'North West', 'South East', 'South West')),
    CHECK (num_of_bedrooms is NULL OR num_of_bedrooms >= 0),
    CHECK (num_of_toilets is NULL OR num_of_toilets >= 0),
    CHECK (furniture_status IS NULL OR furniture_status IN (NULL, 'Empty', 'Basic', 'High end')),
    CHECK (legal_document_status IS NULL OR legal_document_status IN ('Waiting for certificate', 'Have certificate', 'Other documents')),
    CHECK (floor >= 0)
) INHERITS (post)

--
CREATE TABLE user_like (
    user_id uuid NOT NULL,
    post_id uuid NOT NULL,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES public.post(id) ON DELETE CASCADE
)