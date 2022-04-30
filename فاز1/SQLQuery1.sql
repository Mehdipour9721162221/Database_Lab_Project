--------------------------------------------------------------------------------------CREATION
Create database AceVisit
ON
(
name=AceVisit_dat,
Filename='F:\Mehdipour\Data\AceVisit.mdf',
Size=10,
Maxsize=100,
Filegrowth=5)
Log on
(name=AceVisit_log,
Filename= 'F:\Mehdipour\Data\AceVisit.ldf',
Size=8,
Maxsize=100,
Filegrowth=4)
----------------------------------------------
use AceVisit
go 
create table Country
( 
	country_id varchar(30) not null constraint prim_country primary key,
	country_language1 nvarchar(20) not null,
	country_language2 nvarchar(20) ,
	country_Continent varchar(20) not null,
	country_weather nvarchar(50)  null,
	country_population numeric(12,2) ,
	country_nationality nvarchar(20),
	country_top_mountain nvarchar(20),
	country_lattitude Decimal(10,6),
	country_longitude Decimal(10,6),
	country_description nvarchar(max),
	country_capital	int unique
)
----------------------------------------------
create table City
( 
	city_id int not null constraint prim_city primary key,
	city_Country varchar(30) constraint city_country_fk foreign key(city_Country)references Country(country_id),
	city_Province nvarchar(30) not null,
	city_language1 nvarchar(20) not null,
	city_language2 nvarchar(20) ,
	city_population numeric(12,2) ,
	city_top_mountain nvarchar(20),
	city_lattitude Decimal(10,6),
	city_longitude Decimal(10,6),
	city_description nvarchar(max)
)
----------------------------------------------
alter table country
add constraint country_capital_fk foreign key(country_capital) references City(city_id)
----------------------------------------------
alter table City
add city_name nvarchar(25)
----------------------------------------------
create table hotel 
(
	hotel_id int not null constraint prim_hotel primary key,
	hotel_name varchar(30) not null,
	hotel_city int not null constraint hotel_city_fk foreign key(hotel_city) references City(city_id),
	hotel_website varchar(200),
	hotel_lattitude Decimal(10,6),
	hotel_longitude Decimal(10,6),
	hotel_class tinyint,
	hotel_languages_spoken nvarchar(50),
	hotel_style varchar(50),
	hotel_floors tinyint,
	has_wifi bit,
	has_free_breakfast bit,
	has_taxi_service bit,
	has_pets_allowed bit,
	has_free_wifi bit,
	has_restaurant bit,
	has_bar_lounge bit,
	has_loundry_service bit,
	has_indoor_pool bit,
	has_outdoor_pool bit,
	has_shops bit,
	has_Meeting_rooms bit,
	has_parking bit,
	has_dry_cleaning bit,
	has_shoeshine_service bit,
	has_multilanguage_staff bit,
	has_library bit,
	has_roof_garden bit,
	hotel_description nvarchar(max),
	hotel_policies nvarchar(max),
	hotel_date_opened date
)
----------------------------------------------
alter table hotel
add hotel_address nvarchar(50),
	hotel_phone1 varchar(12),
	hotel_phone2 varchar(12),
	hotel_fax varchar(12)
----------------------------------------------
create table Room 
(
	room_id nvarchar(30) not null constraint prim_room primary key,
	room_type nvarchar(30) not null,
	room_hotel_id int not null constraint room_hotel_fk foreign key(room_hotel_id) references Hotel(hotel_id),
	room_floor tinyint,
	room_length smallint,
	room_width smallint,
	room_beds_count tinyint,
	room_price money,
	room_off_percent decimal(4,2),
	room_description nvarchar(max),
	has_inroom_wifi bit,
	has_King_bed bit,
	has_shampoo bit,
	has_soap bit,
	has_Towels bit,
	has_Blackout_curtains bit,
	has_Heating bit,
	has_Air_Conditioning bit,
	has_Corner_lounge bit,
	has_telephone bit,
	has_minibar bit,
	has_Hairdrayer bit,
)
----------------------------------------------
alter table Room
add room_name nvarchar(50),
 other_properties nvarchar(200)
----------------------------------------------
create table Normal_user (
N_user_id nvarchar(20) not null constraint prim_username primary key,
N_user_fname nvarchar(30) ,
N_user_lname nvarchar(30) ,
N_user_password  BINARY(256) NOT NULL, --using sha256 hash algorithm
N_user_Current_City int constraint user_city_fk foreign key(N_user_Current_City) references City(city_id),
N_user_Website nvarchar(100),
N_user_phone_number varchar(12),
N_user_Email varchar(50),
N_user_join_datetime datetime ,
N_user_Profile_photo varchar(2000),			--Link of photo on Server
N_user_Cover_photo varchar(2000),			--Link of photo on Server
N_user_last_log datetime,
N_user_Setting nvarchar(2000),				--Link of Setting file on Server for this user includes : theme-fonts-chat settings and ... 
N_user_score tinyint default 0
)
---------------------------------------------
create table Restaurant (
Restaurant_id int not null constraint prim_restaurant primary key,
Restaurant_name nvarchar(20),
Restaurant_title nvarchar(20),
Restaurant_class tinyint,
Restaurant_address nvarchar(50),
Restaurant_phone1 varchar(12),
Restaurant_phone2 varchar(12),
Restaurant_fax varchar(12),
Restaurant_lattitude decimal(10,6),
Restaurant_longitude decimal(10,6),
Restaurant_city_id int constraint Restaurant_city_fk foreign key(Restaurant_city_id) references City(city_id),
Restaurant_website nvarchar(2000),
Restaurant_Description nvarchar(max),
Restaurant_cuisines nvarchar(200),
Restaurant_Meals nvarchar(100),
Restaurant_icon nvarchar(2000)       --Link of Restaurant icon on our server
)
---------------------------------------------
create table R_table (
table_id int not null constraint prim_table primary key,
table_restaurant_id int constraint Table_Restaurant_fk foreign key(table_restaurant_id) references Restaurant(Restaurant_id),
table_capacity tinyint ,
table_specifications nvarchar(200)
)
----------------------------------------------
create table Hotel_Reservation_Form
(
Form_id nvarchar(50) not null constraint prim_Form primary key,
Form_creation_date datetime,
Form_first_name nvarchar(20),
Form_last_name nvarchar(20),
Form_email_address nvarchar(200),
Form_country_name varchar(20),
Form_city_name varchar(20),
Form_Zip_Postal_code varchar(20) ,
Form_phone_number varchar(12),
Form_national_code varchar(12),
Form_passport_code varchar(25),
Form_special_Requests nvarchar(50),
Form_additional_guests nvarchar(200)
)
----------------------------------------------
create table H_Deals (
deal_id nvarchar(30) not null constraint prim_deal primary key,
deal_room_id nvarchar(30) constraint deal_room_fk foreign key (deal_room_id) references Room(room_id),
deal_date_begin datetime,
deal_date_expired datetime,
deal_totall_price money,
deal_off_percentage smallint
)
-----------------------------------------------
create table Hotel_Reservation(
Reserve_id nvarchar(30) not null constraint Hotel_Reservation_prim primary key,
Reserve_form_id nvarchar(50) unique not null constraint Reserve_Form_fk foreign key(Reserve_form_id) references Hotel_Reservation_Form(Form_id),
Reserve_deal_id nvarchar(30) unique not null constraint Reserve_Deal_fk foreign key(Reserve_deal_id) references H_Deals(deal_id),
Reserve_user_id nvarchar(20) constraint Reserve_user_fk foreign key (Reserve_user_id) references Normal_user(N_user_id),
Reserve_status nvarchar(15),
Reserve_Description nvarchar(50)
)
-----------------------------------------------
create table H_Transaction (
Transaction_id nvarchar(30) not null constraint prim_Transaction primary key,
Transaction_begin datetime,
Transaction_end datetime,
Transaction_status int ,
Transaction_Reservation_id nvarchar(30) not null constraint Transaction_Reservation_fk foreign key(Transaction_Reservation_id) references Hotel_Reservation(Reserve_id)
)
-----------------------------------------------
create table Restaurant_Reservation_Form
(
Form_id nvarchar(50) not null constraint prim_R_Form primary key,
Form_creation_date datetime,
Form_first_name nvarchar(20),
Form_last_name nvarchar(20),
Form_email_address nvarchar(200),
Form_Zip_Postal_code varchar(20) ,
Form_phone_number varchar(12),
Form_national_code varchar(12),
Form_special_Requests nvarchar(50),
Form_additional_guests nvarchar(200)
)
-------------------------------------------------
create table R_Deals (
deal_id nvarchar(30) not null constraint prim_R_deal primary key,
deal_table_id int constraint Rdeal_table_fk foreign key (deal_table_id) references R_table(table_id),
deal_date_begin datetime,
deal_date_expired datetime,
deal_totall_price money,
deal_off_percentage smallint
)
-------------------------------------------------
create table Restaurant_Reservation(
Reserve_id nvarchar(30) not null constraint Restaurant_Reservation_prim primary key,
Reserve_form_id nvarchar(50) unique not null constraint Reserve_R_Form_fk foreign key(Reserve_form_id) references Restaurant_Reservation_Form(Form_id),
Reserve_deal_id nvarchar(30) unique not null constraint Reserve_R_Deal_fk foreign key(Reserve_deal_id) references R_Deals(deal_id),
Reserve_user_id nvarchar(20) constraint R_Reserve_user_fk foreign key (Reserve_user_id) references Normal_user(N_user_id),
Reserve_status nvarchar(15),
Reserve_Description nvarchar(50)
)
-------------------------------------------------
create table R_Transaction (
Transaction_id nvarchar(30) not null constraint prim_R_Transaction primary key,
Transaction_begin datetime,
Transaction_end datetime,
Transaction_status int ,
Transaction_Reservation_id nvarchar(30) not null constraint R_Transaction_Reservation_fk foreign key(Transaction_Reservation_id) references Restaurant_Reservation(Reserve_id)
)
-------------------------------------------------
create table H_Review(
review_id nvarchar(50) not null constraint prim_post primary key,
review_user_id nvarchar(20) constraint Hreview_user_fk foreign key (review_user_id) references Normal_user(N_user_id),
review_hotel_id int constraint Hreview_hotel_fk foreign key (review_hotel_id) references hotel(hotel_id),
review_subject nvarchar(50),
review_text nvarchar(max),
review_picture nvarchar(2000),
review_create_time datetime,
review_likes int default 0,
review_dislikes int default 0
)
-------------------------------------------------
create table R_Review(
review_id nvarchar(50) not null constraint R_prim_post primary key,
review_user_id nvarchar(20) constraint Rreview_user_fk foreign key (review_user_id) references Normal_user(N_user_id),
review_restaurant_id int constraint R_review_hotel_fk foreign key (review_restaurant_id) references restaurant(restaurant_id),
review_subject nvarchar(50),
review_text nvarchar(max),
review_picture nvarchar(2000),
review_create_time datetime,
review_likes int default 0,
review_dislikes int default 0
)
-------------------------------------------------
create table H_Pictures(
picture_id nvarchar(50) not null constraint prim_picture primary key,
picture_link nvarchar(2000) ,
picture_upload_date datetime,
picture_Hotel_id int constraint Hpicture_hotel_fk foreign key (picture_Hotel_id) references hotel(hotel_id)
)
-------------------------------------------------
create table R_Pictures(
picture_id nvarchar(50) not null constraint R_prim_picture primary key,
picture_link nvarchar(2000) ,
picture_upload_date datetime,
picture_Restaurant_id int constraint picture_Restaurant_fk foreign key (picture_Restaurant_id) references Restaurant(restaurant_id)
)
-------------------------------------------------
create table User_Avatars(
avatar_id nvarchar(50) not null constraint a_prim_picture primary key,
avatar_link nvarchar(2000) ,
avatar_upload_date datetime,
avatar_User_id nvarchar(20) constraint avatar_user_fk foreign key (avatar_User_id) references Normal_user(N_user_id)
)
--------------------------------------------------------------------------------------OPTIMAZATION
Create index City_name on City(city_name)
Create index Hotel_name on hotel(hotel_name)
Create index Hotel_city on hotel(hotel_city)
Create index Restaurant_name on Restaurant(Restaurant_name)
Create index Room_name on Room(room_name)
Create index User_Avatars_link on User_Avatars(avatar_link)
Create index R_Pictures_link on R_Pictures(picture_link)
Create index H_Pictures_link on H_Pictures(picture_link)
Create index Table_capacity on R_Table (table_capacity)
---------------------------------------------------------------------------------------
