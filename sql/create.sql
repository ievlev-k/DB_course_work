CREATE TABLE people
(
    id     SERIAL PRIMARY KEY,
    name   Varchar(32) not null,
    height integer     not null,
    birth_date    date     not null
);

CREATE TABLE devil_fruits_type
(
    id SERIAL PRIMARY KEY,
    name varchar(32) not null,
    description varchar not null
);

CREATE TABLE devil_fruits
(
    id serial primary key,
    name varchar(32) not null,
    fruit_type_id integer not null
        references devil_fruits_type,
    description varchar(32)
);

CREATE TABLE devil_fruits_owner (
                                    person_id integer references people,
                                    fruit_id integer references  devil_fruits,
                                    owner_level integer
                                        check ( owner_level > 0 and owner_level < 1000),
                                    primary key (person_id, fruit_id)
);

CREATE TABLE weapon
(
    id serial primary key,
    name varchar(32) not null ,
    damage_level integer
        check (damage_level > 0 and damage_level < 1000),
    description varchar(32)
);

CREATE TABLE weapon_owner (
                              person_id integer references people,
                              weapon_id integer references  weapon,
                              owner_level integer
                                  check ( owner_level > 0 and owner_level < 1000),
                              primary key (person_id, weapon_id)
);

CREATE TABLE will
(
    id serial primary key,
    name varchar(32) not null ,

    description varchar(32)
);

CREATE TABLE will_owner (
                            person_id integer references people,
                            will_id integer references  will,
                            owner_level integer
                                check ( owner_level > 0 and owner_level < 1000),
                            primary key (person_id, will_id)
);


CREATE table ship(
                     id serial primary key,
                     name varchar(32)
);


CREATE TABLE team
(
    id serial primary key,
    name varchar(32) NOT NULL,
    ship_id integer
        REFERENCES ship,
    value integer
        check ( value>0 )
);

CREATE TABLE pirate
(
    id serial primary key,
    person_id integer not null
        references people,
    capture_reward integer
        check ( capture_reward > 0 )
);

CREATE TABLE pirate_team
(
    pirate_id integer references pirate,
    team_id integer references team,
    title varchar(32),
    primary key (pirate_id, team_id)
);

CREATE TABLE base(
                     id serial primary key ,
                     name varchar(32) not null
);

CREATE TABLE Ranking(
                        id serial primary key ,
                        title varchar(32) not null
);


CREATE TABLE sentinel
(
    id serial primary key,
    person_id integer not null references people,
    ranking_id integer not null references ranking,
    base_id integer references base
);
