-- Creates the Room Table
-- Links to the Boss, Character, Monster, Animal and Weapon Tables through foreign keys
CREATE TABLE ROOM(
    ROOM_ID VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(ROOM_ID),
    FOREIGN KEY(BOSS_ID) REFERENCES BOSS(BOSS_ID) ON UPDATE CASCADE,
    FOREIGN KEY(CHARACTER_ID) REFERENCES CHARACTER(CHARACTER_ID) ON UPDATE CASCADE,
    FOREIGN KEY(MONSTER_ID) REFERENCES MONSTER(MONSTER_ID) ON UPDATE CASCADE,
    FOREIGN KEY(ANIMAL_ID) REFERENCES ANIMAL(ANIMAL_ID) ON UPDATE CASCADE,
    FOREIGN KEY(WEAPON_ID) REFERENCES WEAPTON(WEAPON_ID) ON UPDATE CASCADE);
    
-- Creates the Character Table
-- Links to the PotionBag, SkillBook, WeaponBag, Room through foreign keys and recursively to itself through Attack_Target
CREATE TABLE CHARACTER(
    CHARACTER_ID  VARCHAR(10) NOT NULL UNIQUE,
    NAME  VARCHAR(15) NOT NULL,
    AGE INTEGER NOT NULL,
    HEALTH INTEGER NOT NULL, CONSTRAINT HEALTH_Ck CHECK (HEALTH BETWEEN 0 AND 100),
    CLASS VARCHAR(15) NOT NULL,
    ROLE VARCHAR(15) NOT NULL,
    ATTACK_TARGET VARCHAR(10) UNIQUE,
    PRIMARY KEY(CHARACTER_ID),
    FOREIGN KEY(ATTACK_TARGET) REFERENCES CHARACTER(CHARACTER_ID) ON UPDATE CASCADE,
    FOREIGN KEY(POTION_BAG_ID) REFERENCES POTIONBAG(POTION_BAG_ID) ON UPDATE CASCADE,
    FOREIGN KEY(SKILL_BOOK_ID) REFERENCES SKILLBOOK(SKILL_BOOK_ID) ON UPDATE CASCADE,
    FOREIGN KEY(WEAPON_BAG_ID) REFERENCES WEAPONBAG(WEAPON_BAG_ID) ON UPDATE CASCADE,
    FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID) ON UPDATE CASCADE);

-- Creates the Animal Table
--  Links to Room through foreign key
CREATE TABLE ANIMAL(
    ANIMAL_ID VARCHAR(10) NOT NULL UNIQUE,
    NAME VARCHAR(15) NOT NULL,
    HEALTH INTEGER NOT NULL, CONSTRAINT HEALTH_Ck CHECK (HEALTH BETWEEN 0 AND 100),
    FRIENDLY_LEVEL INTEGER NOT NULL, CONSTRAINT FL_Ck CHECK (FRIENDLY_LEVEL BETWEEN 0 AND 100),
    ROLE VARCHAR(15) NOT NULL,
    PRIMARY KEY(ANIMAL_ID),
    FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID) ON UPDATE CASCADE);
    
-- Creates the Boss Tables
-- Links to Room and Skills through foreign keys
CREATE TABLE BOSS(
    BOSS_ID VARCHAR(10) NOT NULL UNIQUE,
    NAME VARCHAR(15) NOT NULL,
    HEALTH INTEGER NOT NULL, CONSTRAINT HEALTH_Ck CHECK (HEALTH BETWEEN 0 AND 100),
    DAMAGE INTEGER NOT NULL, CONSTRAINT DAMAGE_Ck CHECK (DAMAGE BETWEEN 0 AND 100),
    DIFFICULTY INTEGER NOT NULL, CONSTRAINT DIFFICULTY_Ck CHECK(DIFFICULTY BETWEEN 1 AND 10),
    PRIMARY KEY(BOSS_ID),
    FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID) ON UPDATE CASCADE,
    FOREIGN KEY(SKILL_DROP) REFERENCES SKILLS(SKILL_ID) ON UPDATE CASCADE);

-- Creates the Skills Table
CREATE TABLE SKILLS(
    SKILL_ID VARCHAR(10) NOT NULL UNIQUE,
    NAME VARCHAR(30) NOT NULL,
    DAMAGE INTEGER NOT NULL, CONSTRAINT DAMAGE_Ck CHECK(DAMAGE BETWEEN 0 AND 100),
    LEVEL INTEGER NOT NULL, CONTRAINT LEVEL_Ck CHECK (LEVEL BETWEEN 1 AND 10), 
    PRIMARY KEY(SKILL_ID),
    FOREIGN KEY(BOSS_ID) REFERENCES BOSS(BOSS_ID) ON UPDATE CASCADE,
    FOREIGN KEY(SKILL_BOOK_ID) REFERENCES SKILLBOOK(SKILL_BOOK_ID) ON UPDATE CASCADE);

-- Creates the Skill Book middleman table to link Skills and Character
CREATE TABLE SKILLBOOK(
    SKILL_BOOK_ID VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(SKILL_BOOK_ID),
    FOREIGN KEY(CHARACTER_ID) REFERENCES CHARACTER(CHARACTER_ID) ON UPDATE CASCADE,
    FOREIGN KEY(SKILL_ID) REFERENCES SKILLS(SKILL_ID) ON UPDATE CASCADE);

-- Creates the weapon bag middleman table to link Weapons and Characters
CREATE TABLE WEAPONBAG(
    WEAPON_BAG_ID VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(WEAPON_BAG_ID),
    FOREIGN KEY(CHARACTER_ID) REFERENCES CHARACTER(CHARACTER_ID) ON UPDATE CASCADE,
    FOREIGN KEY(WEAPON_ID) REFERENCES WEAPON(WEAPON_ID) ON UPDATE CASCADE);

-- Creates the Weapon Table
CREATE TABLE WEAPON(
    WEAPON_ID VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(WEAPON_ID),
    FOREIGN KEY(WEAPON_BAG_ID) REFERENCES WEAPONBAG(WEAPON_BAG_ID) ON UPDATE CASCADE,
    FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID) ON UPDATE CASCADE);
    
-- Create potion bag middleman table to link potions and characters
CREATE TABLE POTIONBAG(
    POTION_BAG_ID VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(POTION_BAG_ID),
    FOREIGN KEY(POTION_ID) REFERENCES POTION(POTION_ID) ON UPDATE CASCADE,
    FOREIGN KEY(CHARACTER_ID) REFERENCES CHARACTER(CHARACTER_ID) ON UPDATE CASCADE);

-- Creates the Potion Table
CREATE TABLE POTION(
    POTION_ID VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(POTION_ID),
    FOREIGN KEY(POTION_BAG_ID) REFERENCES POTIONBAG(POTION_BAG_ID) ON UPDATE CASCADE,
    FOREIGN KEY(OBSTACLE_ID) REFERENCES OBSTACLE(OBSTACLE_ID) ON UPDATE CASCADE);

--Creates the obstacle table
CREATE TABLE OBSTACLE(
    OBSTACLE_ID VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(OBSTACLE_ID),
FOREIGN KEY(POTION_ID) REFERENCES POTION(POTION_ID) ON UPDATE CASCADE);
