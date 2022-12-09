-----------------------------
--- insert fully new person into table 'people'
create or replace function insert_person(name text, height integer, birth_date date) returns integer as
$$
declare
person integer;

begin
select nextval('people_id_seq') into person;

insert into people (id, name, height, birth_date)
values (person, insert_person.name, insert_person.height, insert_person.birth_date);

return person;
end;
$$ language plpgSQL;

--- insert fully new devil_fruits_type record
create or replace function insert_devil_fruit_type(name text, description text) returns integer as
$$
declare
type_id integer;

begin
select nextval('devil_fruits_type_id_seq') into type_id;

insert into devil_fruits_type (id, name, description)
values (type_id, insert_devil_fruit_type.name, insert_devil_fruit_type.description);

return type_id;
end;
$$ language plpgSQL;

--- insert fully  new devil_fruit record
create or replace function insert_devil_fruit (name text, type_id integer, description text) returns integer as
$$
declare
id integer;
begin
	if (select count(*) from devil_fruits_type where devil_fruits_type.id = insert_devil_fruit.type_id) = 0 then
		raise exception 'type id does not exist!';
end if;

select nextval('devil_fruits_id_seq' into id);

insert into devil_fruits (id, name, fruit_type_id, description)
values (id, insert_devil_fruit.name, insert_devil_fruit.type_id, insert_devil_fruit.description);

return id;
end;
$$ language plpgSQL;

--- insert fully new devil_fruit_owner
create or replace function insert_devil_fruit_owner (person_id integer, fruit_id integer, owner_level integer) returns VOID as
$$
begin
	if (select count(*) from devil_fruits where devil_fruits.id  = insert_devil_fruit_owner.fruit_id) = 0 then
		raise exception 'fruit does not exist!';
end if;

	if (select count(*) from people where people.id  = insert_devil_fruit_owner.person_id) = 0 then
		raise exception 'owner does not exist!';
end if;

insert into devil_fruits_owner (person_id, fruit_id, owner_level)
values (insert_devil_fruit_owner.person_id, insert_devil_fruit_owner.fruit_id, insert_devil_fruit_owner.owner_level);

end;
$$ language plpgSQL;

--- insert fully pirate
create or replace function insert_pirate (person_id integer, capture_reward integer) returns integer as
$$
declare
id integer;
begin
	if (select count(*) from people where people.id = insert_pirate.person_id) = 0 then
		raise exception 'person does not exist!';
end if;

select nextval('pirate_id_seq' into id);

insert into pirate (id, person_id, capture_reward)
values (id, insert_pirate.person_id, insert_pirate.capture_reward);

return id;
end;
$$ language plpgSQL;

--- insert fully ship
create or replace function insert_ship (name text) returns integer as
$$
declare
id integer;
begin
select nextval('ship_id_seq' into id);

insert into ship (id, name)
values (id, insert_ship.name);

return id;
end;
$$ language plpgSQL;

---insert fully team
create or replace function insert_team (name text, ship_id integer, value integer) returns integer as
$$
declare
id integer;
begin
	if (select count(*) from ship where ship.id = insert_team.ship_id) = 0 then
		raise exception 'ship does not exist!';
end if;

select nextval('team_id_seq' into id);

insert into team (id, name, ship_id, value)
values (id, insert_team.name, insert_team.ship_id, insert_team.value);

return id;
end;
$$ language plpgSQL;


--- insert fully pirate_team
create or replace function insert_pirate_team (pirate_id integer, team_id integer, title text) returns VOID as
$$
begin
	if (select count(*) from pirate where pirate.id  = insert_pirate_team.pirate_id) = 0 then
		raise exception 'pirate does not exist!';
end if;

	if (select count(*) from team where team.id  = insert_pirate_team.team_id) = 0 then
		raise exception 'team does not exist!';
end if;

insert into pirate_team (pirate_id, team_id, title)
values (insert_pirate_team.pirate_id, insert_pirate_team.team_id, insert_pirate_team.title);

end;
$$ language plpgSQL;



--- insert fully sentinel
create or replace function insert_sentinel (person_id integer, ranking_id integer, base_id integer) returns integer as
$$
declare
id integer;
begin
	if (select count(*) from people where people.id  = insert_sentinel.person_id) = 0 then
		raise exception 'person does not exist!';
end if;

	if (select count(*) from ranking where ranking.id  = insert_sentinel.ranking_id) = 0 then
		raise exception 'ranking does not exist!';
end if;

	if (select count(*) from base where base.id  = insert_sentinel.base_id) = 0 then
		raise exception 'base does not exist!';
end if;

select nextval('sentinel_id_seq' into id);

insert into sentinel (id, person_id, ranking_id, base_id)
values (id, insert_sentinel.person_id, insert_sentinel.ranking_id, insert_sentinel.base_id);

return id;
end;
$$ language plpgSQL;

--- insert fully ranking
create or replace function insert_ranking (title text) returns integer as
$$
declare
id integer;
begin
select nextval('ranking_id_seq' into id);

insert into ranking (id, title)
values (id, insert_ranking.title);

return id;
end;
$$ language plpgSQL;


--- insert fully base
create or replace function insert_base (name text) returns integer as
$$
declare
id integer;
begin
select nextval('base_id_seq' into id);

insert into base (id, name)
values (id, insert_base.name);

return id;
end;
$$ language plpgSQL;


--- insert fully will
create or replace function insert_will (name text, description text) returns integer as
$$
declare
id integer;
begin
select nextval('will_id_seq' into id);

insert into will (id, name, description)
values (id, insert_will.name, insert_will.description);

return id;
end;
$$ language plpgSQL;


--- insert fully will_owner
create or replace function insert_will_owner (will_id integer, person_id integer, owner_level integer) returns VOID as
$$
begin
	if (select count(*) from will where will.id  = insert_will_owner.will_id) = 0 then
		raise exception 'will does not exist!';
end if;

	if (select count(*) from people where people.id  = insert_will_owner.person_id) = 0 then
		raise exception 'person does not exist!';
end if;

insert into will_owner (will_id, person_id, owner_level)
values (insert_will_owner.will_id, insert_will_owner.person_id, insert_will_owner.owner_level);

end;
$$ language plpgSQL;


--- insert fully weapon
create or replace function insert_weapon (name text, damage_level integer, description text) returns integer as
$$
declare
id integer;
begin
select nextval('weapon_id_seq' into id);

insert into weapon (id, name, damage_level, description)
values (id, insert_weapon.name, insert_weapon.damage_level, insert_weapon.description);

return id;
end;
$$ language plpgSQL;


--- insert fully weapon_owner
create or replace function insert_weapon_owner (weapon_id integer, person_id integer, owner_level integer) returns VOID as
$$
begin
	if (select count(*) from weapon where weapon.id  = insert_weapon_owner.weapon_id) = 0 then
		raise exception 'weapon does not exist!';
end if;
но
if (select count(*) from people where people.id  = insert_weapon_owner.person_id) = 0 then
		raise exception 'person does not exist!';
end if;

insert into weapon_owner (weapon_id, person_id, owner_level)
values (insert_weapon_owner.weapon_id, insert_weapon_owner.person_id, insert_weapon_owner.owner_level);
end;
$$ language plpgSQL;