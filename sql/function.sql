-- update value of will
create or replace function update_value_of_will(val int, people_id_arg int, will_id_arg int) returns void as
$$
DECLARE
new_value_of_will int;
old_value_of_will int;
BEGIN
    IF (val >= 1000) THEN new_value_of_will := 999;
ELSE
SELECT will_owner.owner_level
INTO old_value_of_will
FROM will_owner
         JOIN people on people.id = will_owner.person_id
where person_id = people_id_arg and will_id = will_id_arg;
new_value_of_will := old_value_of_will + val;
END IF;

UPDATE will_owner
SET owner_level = new_value_of_will
where person_id = people_id_arg and will_id = will_id_arg;
END;
$$ language plpgsql;


-- update value of weapon
create or replace function update_value_of_weapon(val int, people_id_arg int, weapon_id_arg int) returns void as
$$
DECLARE
    new_value_of_weapon int;
    old_value_of_weapon int;
BEGIN
    IF (val >= 1000) THEN new_value_of_weapon := 999;
    ELSE
        SELECT weapon_owner.owner_level
        INTO old_value_of_weapon
        FROM weapon_owner
                 JOIN people on people.id = weapon_owner.person_id
        where person_id = people_id_arg and weapon_id = weapon_id_arg;
        new_value_of_weapon := old_value_of_weapon + val;
    END IF;

    UPDATE weapon_owner
    SET owner_level = new_value_of_weapon
    where person_id = people_id_arg and weapon_id = weapon_id_arg;
END;
$$ language plpgsql;


-- update value of weapon
create or replace function update_value_of_fruits(val int, people_id_arg int, fruits_id_arg int) returns void as
$$
DECLARE
    new_value_of_fruits int;
    old_value_of_fruits int;
BEGIN
    IF (val >= 1000) THEN new_value_of_fruits := 999;
    ELSE
        SELECT fruits_owner.owner_level
        INTO old_value_of_fruits
        FROM devil_fruits_owner
                 JOIN people on people.id = devil_fruits_owner.person_id
        where person_id = people_id_arg and devil_fruits_id = fruits_id_arg;
        new_value_of_fruits := old_value_of_fruits + val;
    END IF;

    UPDATE devil_fruits_owner
    SET owner_level = new_value_of_fruits
    where person_id = people_id_arg and devil_fruits_id = fruits_id_arg;
END;
$$ language plpgsql;



-- obtaining the power that the character owns
create or replace function get_power_level(people_id_arg int) returns int as
$$
DECLARE
    devil_fruits_power int;
    weapon_owner_power int;
    will_owner_power int;

BEGIN
    weapon_owner_power = (SELECT COALESCE(SUM (weapon_owner.owner_level), 0)
                          FROM weapon_owner
                                   JOIN people on people.id = weapon_owner.person_id
                          where people_id_arg = people.id);
    will_owner_power = (SELECT COALESCE(SUM (will_owner.owner_level), 0)
                        FROM will_owner
                                 JOIN people on people.id = will_owner.person_id
                        where people_id_arg = people.id);
    devil_fruits_power = (SELECT COALESCE(SUM (devil_fruits_owner.owner_level), 0)
                          FROM devil_fruits_owner
                                   JOIN people on people.id = devil_fruits_owner.person_id
                          where people_id_arg = people.id);
    return weapon_owner_power + will_owner_power + devil_fruits_power;
END ;
$$ language plpgsql;

--- list of available pirates
create or replace function get_pirates() RETURNS TABLE(id int) as
$$

SELECT people.id  as result
FROM people
         join pirate on people.id = pirate.person_id;

$$ language sql;


--- list of available sentinels
create or replace function get_sentinels() RETURNS bigint[] as
$$
BEGIN
    return (SELECT people.id  as result
        FROM people
             join sentinel on people.id = sentinel.person_id);
END ;
$$ language plpgsql;

--- the list of pirates that this sentinel can defeat
create or replace function list_of_pirates_that_sentinel_can_defeat(sentinel_id int) returns TABLE (id int) as
$$
DECLARE
    check_ID bool = FALSE;
    sentinel_person_id int;
BEGIN
    sentinel_person_id = (Select sentinel.person_id
                          FROM sentinel
                          WHERE sentinel.id = sentinel_id);
    check_ID = EXISTS(Select sentinel.id
                      FROM sentinel
                      WHERE sentinel.id = sentinel_id);
    IF (check_ID = TRUE) THEN
        Return QUERY
            SELECT people.id
            FROM people
                     join pirate on people.id = pirate.person_id
            where get_power_level(sentinel_person_id) > get_power_level(pirate.person_id);
    END IF;

END;
$$ language plpgsql;

---shows the difference in strength
create or replace function get_the_difference_in_strength(sentinel_id int, pirate_id int) returns int as
$$
    DECLARE
        sentinel_person_id int;
        pirate_person_id int;
    BEGIN
        sentinel_person_id = (Select sentinel.person_id
                              FROM sentinel
                              WHERE sentinel.id = sentinel_id);
        pirate_person_id = (Select pirate.person_id
                              FROM pirate
                              WHERE pirate.id = pirate_id);
        return get_power_level(sentinel_person_id) - get_power_level(pirate_person_id);
    end;
$$  language plpgsql






