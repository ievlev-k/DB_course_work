create index people_id_idx ON people USING hash(id);

create index pirate_person_id_idx ON pirate USING hash(person_id);

create index sentinel_person_id_idx ON sentinel USING hash(person_id);

create index weapon_owner_person_id_idx ON weapon_owner USING hash(person_id);

create index will_owner_person_id_idx ON will_owner USING hash(person_id);

create index devil_fruits_owner_person_id_idx ON devil_fruits_owner USING hash(person_id);