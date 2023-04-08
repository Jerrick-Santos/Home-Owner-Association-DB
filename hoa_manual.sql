
-- This part is from assets onward
CREATE TABLE `asset`(
	`assetid` 			INT 				NOT NULL AUTO_INCREMENT, 
    `name` 				VARCHAR(45)			NOT NULL DEFAULT '',
    `description` 		VARCHAR(100)		NOT NULL DEFAULT '',
    `acq_date`			DATE 				NOT NULL DEFAULT '9999-99-99',
    `forrent`			BOOLEAN				NOT NULL DEFAULT '0',
    `value`				FLOAT				NOT NULL DEFAULT '0.00',
    `type`				ENUM('A','B')		NOT NULL DEFAULT 'X',		-- enum to be clarified
    `status` 			ENUM('A','B')		NOT NULL DEFAULT 'X',		-- enum to be clarified
    `location`			VARCHAR(45)			NOT NULL DEFAULT '',
    `location_mapx`		VARCHAR(45)			NOT NULL DEFAULT '',
    `location_mapy`		VARCHAR(45)			NOT NULL DEFAULT '',
    `location_assetid`	INT					NOT NULL DEFAULT '-1', 
    `hoaname`			VARCHAR(45)			NOT NULL DEFAULT ''
    
    
);