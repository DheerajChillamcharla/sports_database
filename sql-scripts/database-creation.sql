CREATE DATABASE "Group20ProjectImplementation"
USE "Group20ProjectImplementation"
CREATE TABLE Team(
  team_id VARCHAR(10) NOT NULL PRIMARY KEY,
  team_name VARCHAR(45) NOT NULL,
  );
 
CREATE TABLE "Position" (
  position_id VARCHAR(10) NOT NULL PRIMARY KEY,
  position_name VARCHAR(45) NOT NULL,
  position_abbr VARCHAR(10) NOT NULL
 );

CREATE TABLE Staff (
  staff_id VARCHAR(10) NOT NULL PRIMARY KEY,
  staff_first_name VARCHAR(45) NOT NULL,
  staff_last_name VARCHAR(45) NOT NULL,
  staff_dob DATE,
  staff_gender VARCHAR(1),
  team_id VARCHAR(10) REFERENCES Team(team_id) ON DELETE SET NULL
  );

 CREATE TABLE Other_staff (
  staff_id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES Staff(staff_id) ON DELETE CASCADE,
  wage VARBINARY(250) NOT NULL -- CHANGED
);

CREATE TABLE Management_staff (
  staff_id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES Staff(staff_id) ON DELETE CASCADE,
  share_percentage INT NOT NULL, -- changed
);

CREATE TABLE Coaching_staff (
  staff_id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES Staff(staff_id) ON DELETE CASCADE,
  wage MONEY NOT NULL, -- CHANGED
  Designation VARCHAR(45) NOT NULL
);

CREATE TABLE Country (
  country_id VARCHAR(10) NOT NULL PRIMARY KEY,
  country_name VARCHAR(45) NOT NULL
);


CREATE TABLE Matches (
  match_id VARCHAR(10) NOT NULL PRIMARY KEY,
  team1_id VARCHAR(10) NOT NULL REFERENCES Team(team_id) ON DELETE NO ACTION,
  team2_id VARCHAR(10) NOT NULL REFERENCES Team(team_id) ON DELETE NO ACTION
);



CREATE TABLE Team_match_stats (
  team_id VARCHAR(10) NOT NULL REFERENCES Team(team_id) ON DELETE NO ACTION,
  match_id VARCHAR(10) NOT NULL REFERENCES Matches(match_id) ON DELETE CASCADE,
  "Result" VARCHAR (10),
  Goals INT,
  Posession INT
);

ALTER TABLE Team_match_stats ADD CONSTRAINT PK_TMID PRIMARY KEY(team_id, match_id);

CREATE TABLE Player (
  player_id VARCHAR(10) NOT NULL PRIMARY KEY,
  player_first_name VARCHAR(45) NOT NULL,
  player_last_name VARCHAR(45) NOT NULL,
  player_dob DATE,
  player_value INT NOT NULL,
  player_wage MONEY , --CHANGED
  height INT,
  jersey_number INT NOT NULL,
  country_id VARCHAR(10) NOT NULL REFERENCES Country(Country_id),
  preferred_foot VARCHAR(45),
  work_rate VARCHAR(45) 
);
  
CREATE TABLE Player_rating (
  player_id VARCHAR(10) NOT NULL PRIMARY KEY REFERENCES Player(player_id) ON DELETE CASCADE,
  rating INT,
  potential INT,
  pace INT,
  shooting INT,
  passing INT,
  defending INT,
  physical INT,
  attacking INT
);

CREATE TABLE Player_position (
  player_position_id VARCHAR(10) NOT NULL,
  player_id VARCHAR(10) NOT NULL REFERENCES Player(player_id) ON DELETE CASCADE,
  position_id VARCHAR(10) NOT NULL REFERENCES "Position"(position_id) ON DELETE NO ACTION,
  team_id VARCHAR(10) NOT NULL REFERENCES Team(team_id) ON DELETE CASCADE
);

ALTER TABLE Player_position ADD CONSTRAINT PK_PPID PRIMARY KEY(player_position_id, player_id, position_id, team_id);

CREATE TABLE Team_players (
  team_player_id VARCHAR(10) NOT NULL PRIMARY KEY,
  team_id VARCHAR(10) NOT NULL REFERENCES Team(team_id) ON DELETE CASCADE,
  player_id VARCHAR(10) NOT NULL REFERENCES Player(player_id) ON DELETE CASCADE,
  current_player INT NOT NULL
);

CREATE TABLE Player_matches (
  team_player_id VARCHAR(10) NOT NULL REFERENCES Team_players(team_player_id),
  match_id VARCHAR(10) NOT NULL REFERENCES Matches (match_id),
);

ALTER TABLE Player_matches ADD CONSTRAINT PK_PMID PRIMARY KEY(team_player_id, match_id);