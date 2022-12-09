
--- function for triggers

--- check two people not use the same devil fruit before insert update
create function check_fruit_owner() returns trigger as
    $checkFruitOwner$
begin
	if exists(
			select *
			from devil_fruits_owner
			where new.fruit_id = devil_fruits_owner.fruit_id) then
		raise exception 'fruit can only belong to one person';
end if;

	if exists(
			select *
			from devil_fruits_owner
			where new.person_id = devil_fruits_owner.person_id) then
		raise exception 'person can own only one fruit';
end if;

return new;
end;
$checkFruitOwner$ language plpgSQL;

--- check sentinel has unique person_id
create function check_sentinel() returns trigger as
    $checkSentinel$
begin
	if exists(
			select *
			from sentinel
			where new.person_id = sentinel.person_id) then
		raise exception 'sentinel must have unique person_id!';
end if;

return new;
end;
$checkSentinel$ language plpgSQL;

--- check pirate has unique person_id
create function check_pirate() returns trigger as
    $checkPirate$
begin
	if exists(
			select *
			from pirate
			where new.person_id = pirate.person_id) then
		raise exception 'pirate must have unique person_id!';
end if;

return new;
end;
$checkPirate$ language plpgSQL;

---- delete all weapon_owner if delete weapon
create function check_delete_weapon() returns trigger as
    $checkDeleteWeapon$
begin
	if exists(
			select *
			from weapon_owner
			where old.id = weapon_owner.weapon_id) then
delete from weapon_owner
where weapon_id = old.id;
end if;
return old;
end;
$checkDeleteWeapon$ language plpgSQL;

--- check if person_id does not exists, then add new person to
-- Triggers

create trigger checkFruitOwner
    before insert or update
                         on devil_fruits_owner
                         for each row
                         execute procedure check_fruit_owner();

create trigger checkSentinel
    before insert or update
                         on sentinel
                         for each row
                         execute procedure check_sentinel();

create trigger checkPirate
    before insert or update
                         on pirate
                         for each row
                         execute procedure check_pirate();

create trigger checkDeleteWeapon
    before delete
    on weapon
    for each row
    execute procedure check_delete_weapon();
