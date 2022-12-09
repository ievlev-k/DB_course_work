DROP TABLE IF EXISTS people,
			devil_fruits_type,
			devil_fruits,
			devil_fruits_owner,
			weapon,
			weapon_owner,
			will,
			will_owner,
			ship,
			team,
			pirate,
			pirate_team,
			base,
			Ranking,
			sentinel;


DROP FUNCTION IF EXISTS insert_devil_fruit(text, integer, text) CASCADE;
DROP FUNCTION IF EXISTS insert_devil_fruit_owner(integer, integer, integer) CASCADE;
DROP FUNCTION IF EXISTS insert_devil_fruit_type(text, text) CASCADE;
DROP FUNCTION IF EXISTS insert_person(text, integer, date) CASCADE;
DROP FUNCTION IF EXISTS insert_pirate(integer, integer) CASCADE;
DROP FUNCTION IF EXISTS insert_pirate_team(integer, integer, text) CASCADE;
DROP FUNCTION IF EXISTS insert_ship(text) CASCADE;
DROP FUNCTION IF EXISTS insert_team(text, integer, integer) CASCADE;

DROP FUNCTION IF EXISTS insert_sentinel(integer, integer, integer) CASCADE;
DROP FUNCTION IF EXISTS insert_ranking(text) CASCADE;
DROP FUNCTION IF EXISTS insert_base(text) CASCADE;

DROP FUNCTION IF EXISTS insert_weapon(text, integer, integer) CASCADE;
DROP FUNCTION IF EXISTS insert_weapon_owner(integer, integer, integer) CASCADE;

DROP FUNCTION IF EXISTS insert_will(text, text) CASCADE;
DROP FUNCTION IF EXISTS insert_will_owner(integer, integer, integer) CASCADE;

drop function if exists check_fruit_owner() cascade;
drop function if exists check_sentinel() cascade;
drop function if exists check_pirate() cascade;
drop function if exists check_delete_weapon() cascade;
