CREATE DATABASE hoa;
USE hoa;

CREATE TABLE `regions` (
  `region` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`region`));


CREATE TABLE `provinces` (
  `province`     VARCHAR(45)     NOT NULL,
  `region`       VARCHAR(45)     NOT NULL,
  PRIMARY KEY (`province`),
  INDEX `region_idx` (`region` ASC) VISIBLE,
  CONSTRAINT `region`
    FOREIGN KEY (`region`)
    REFERENCES `regions` (`region`)
    );


CREATE TABLE `zipcodes` (
  `barangay`     VARCHAR(45)    NOT NULL,
  `city`         VARCHAR(45)    NOT NULL,
  `province`     VARCHAR(45)    NOT NULL,
  `zipcode`      INT            NOT NULL,
  PRIMARY KEY (`zipcode`),
  INDEX `province_idx` (`province` ASC) VISIBLE,
  CONSTRAINT `province`
    FOREIGN KEY (`province`)
    REFERENCES `provinces` (`province`)
    );


CREATE TABLE `hoa` (
  `hoaname`         VARCHAR(100)    NOT NULL,
  `office_streetno` VARCHAR(20)     NOT NULL,
  `office_street`   VARCHAR(45)     NOT NULL,
  `office_zipcode`  INT             NOT NULL,
  `office_mapx`     VARCHAR(45)     NOT NULL,
  `office_mapy`     VARCHAR(45)     NOT NULL,
  `year_est`        INT(4)          NOT NULL,
  `website`         VARCHAR(45)     NULL,
  `subd_name`       VARCHAR(45)     NOT NULL,
  `monthly_dues`    INT(2)          NOT NULL,
  PRIMARY KEY (`hoaname`),
  INDEX `zipcode_idx` (`office_zipcode` ASC) VISIBLE,
  CONSTRAINT `zipcode`
    FOREIGN KEY (`office_zipcode`)
    REFERENCES `zipcodes` (`zipcode`)
    );


CREATE TABLE `hoa_docs` (
  `submission_type` INT             NOT NULL,
  `doc_name`        VARCHAR(200)    NOT NULL,
  PRIMARY KEY (`submission_type`));


CREATE TABLE `hoa_submissions` (
  `hoa_hoaname`                 VARCHAR(100)    NOT NULL,
  `hoa_docs_submission_type`    INT             NOT NULL,
  `submission_date`             DATETIME        NOT NULL,
  PRIMARY KEY (`hoa_hoaname`, `hoa_docs_submission_type`, `submission_date`),
  INDEX `fk_hoa_submissions_hoa_document1_idx` (`hoa_docs_submission_type` ASC) VISIBLE,
  CONSTRAINT `fk_hoa_submissions_hoa`
    FOREIGN KEY (`hoa_hoaname`)
    REFERENCES `hoa` (`hoaname`)
    ,
  CONSTRAINT `fk_hoa_submissions_hoa_document1`
    FOREIGN KEY (`hoa_docs_submission_type`)
    REFERENCES `hoa_docs` (`submission_type`)
    );


CREATE TABLE `individual` (
  `individualid`    INT             NOT NULL,
  `lastname`        VARCHAR(45)     NOT NULL,
  `firstname`       VARCHAR(45)     NOT NULL,
  `mi`              VARCHAR(2)      NULL,
  `email`           VARCHAR(45)     NOT NULL,
  `birthday`        DATE            NOT NULL,
  `gender`          ENUM('M', 'F')  NOT NULL,
  `facebook_url`    VARCHAR(45)     NULL,
  `pic_filename`    VARCHAR(45)     NOT NULL,
  `undertaking`     TINYINT(1)      NOT NULL,
  PRIMARY KEY (`individualid`));


CREATE TABLE `homeowner` (
  `homeownerid`       INT           NOT NULL,
  `residency_start`   DATE          NULL,
  `membership`        TINYINT(1)    NOT NULL,
  `isresident`        TINYINT(1)    NOT NULL,
  PRIMARY KEY (`homeownerid`),
  CONSTRAINT `fk_homeowner_individual1`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `individual` (`individualid`)
    );


CREATE TABLE `homeowner_addinfo` (
  `homeownerid`     INT                 NOT NULL,
  `add2_streetno`   VARCHAR(20)         NULL,
  `add2_street`     VARCHAR(45)         NULL,
  `add2_zipcode`    INT                 NOT NULL,
  `add2_mapx`       VARCHAR(45)         NULL,
  `add2_mapy`       VARCHAR(45)         NULL,
  `email2`          VARCHAR(45)         NULL,
  `mobile2`         INT(11) ZEROFILL    NULL,
  PRIMARY KEY (`homeownerid`),
  INDEX `zipcode_idx` (`add2_zipcode` ASC) VISIBLE,
  CONSTRAINT `fk_homeowner_addinfo_hoaowner1`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `homeowner` (`homeownerid`)
    ,
  CONSTRAINT `fk_zipcode_addinfo`
    FOREIGN KEY (`add2_zipcode`)
    REFERENCES `zipcodes` (`zipcode`)
    );


CREATE TABLE `mobile` (
  `mobilenum`       INT(11) ZEROFILL    NOT NULL,
  `individualid`    INT                 NOT NULL,
  PRIMARY KEY (`mobilenum`),
  INDEX `fk_mobile_individual1_idx` (`individualid` ASC) VISIBLE,
  CONSTRAINT `fk_mobile_individual1`
    FOREIGN KEY (`individualid`)
    REFERENCES `individual` (`individualid`)
    );


CREATE TABLE `property` (
  `propertycode`     VARCHAR(6)     NOT NULL,
  `homeownerid`      INT            NOT NULL,
  `hoaname`          VARCHAR(100)   NOT NULL,
  `size`             INT            NOT NULL,
  `turnover_date`    DATE           NOT NULL,
  PRIMARY KEY (`propertycode`),
  INDEX `fk_property_homeowner1_idx` (`homeownerid` ASC) VISIBLE,
  INDEX `fk_property_hoa1_idx` (`hoaname` ASC) VISIBLE,
  CONSTRAINT `fk_property_homeowner1`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `homeowner` (`homeownerid`)
    ,
  CONSTRAINT `fk_property_hoa1`
    FOREIGN KEY (`hoaname`)
    REFERENCES `hoa` (`hoaname`)
    );


CREATE TABLE `household` (
  `householdid`     INT         NOT NULL,
  `propertycode`    VARCHAR(6)  NOT NULL,
  PRIMARY KEY (`householdid`),
  INDEX `fk_household_property1_idx` (`propertycode` ASC) VISIBLE,
  CONSTRAINT `fk_household_property1`
    FOREIGN KEY (`propertycode`)
    REFERENCES `property` (`propertycode`)
    );


CREATE TABLE `resident` (
  `residentid`          INT                         NOT NULL,
  `renter`              TINYINT(1)                  NOT NULL,
  `rel_homeowner`       VARCHAR(45)                 NOT NULL,
  `householdid`         INT                         NOT NULL,
  `authorized`          TINYINT(1)                  NOT NULL,
  `status`              ENUM('A', 'L', 'C')         NOT NULL,
  `last_update`         DATETIME                    NOT NULL,
  PRIMARY KEY (`residentid`),
  INDEX `fk_resident_individual1_idx` (`residentid` ASC) VISIBLE,
  INDEX `fk_resident_household1_idx` (`householdid` ASC) VISIBLE,
  CONSTRAINT `fk_resident_individual1`
    FOREIGN KEY (`residentid`)
    REFERENCES `individual` (`individualid`)
    ,
  CONSTRAINT `fk_resident_household1`
    FOREIGN KEY (`householdid`)
    REFERENCES `household` (`householdid`)
    );


CREATE TABLE `payment` (
  `orno`        INT          NOT NULL,
  `amount`      FLOAT        NOT NULL,
  PRIMARY KEY (`orno`));


CREATE TABLE `election_info` (
  `elec_date`        DATE               NOT NULL,
  `venue`            VARCHAR(45)        NOT NULL,
  `quorum`           TINYINT(1)         NOT NULL,
  `wit_lastname`     VARCHAR(45)        NOT NULL,
  `wit_firstname`    VARCHAR(45)        NOT NULL,
  `wit_mi`           VARCHAR(45)        NOT NULL,
  `wit_mobile`       VARCHAR(45)        NULL,
  PRIMARY KEY (`elec_date`));


CREATE TABLE `hoa_officer` (
  `homeownerid`    INT                              NOT NULL,
  `hoaname`        VARCHAR(100)                     NOT NULL,
  `position`       ENUM('P', 'VP', 'T', 'A', 'S')   NOT NULL,
  `start_date`     DATE                             NOT NULL,
  `end_date`       DATE                             NOT NULL,
  `elec_date`      DATE                             NOT NULL,
  `avail_Mon`      ENUM('M', 'A', 'NA')             NOT NULL,
  `avail_Tue`      ENUM('M', 'A', 'NA')             NOT NULL,
  `avail_Wed`      ENUM('M', 'A', 'NA')             NOT NULL,
  `avail_Thu`      ENUM('M', 'A', 'NA')             NOT NULL,
  `avail_Fri`      ENUM('M', 'A', 'NA')             NOT NULL,
  `avail_Sat`      ENUM('M', 'A', 'NA')             NOT NULL,
  `avail_Sun`      ENUM('M', 'A', 'NA')             NOT NULL,
  PRIMARY KEY (`homeownerid`, `position`),
  INDEX `hoaname_idx` (`hoaname` ASC) VISIBLE,
  INDEX `elec_date_idx` (`elec_date` ASC) VISIBLE,
  CONSTRAINT `homeownerid`
    FOREIGN KEY (`homeownerid`)
    REFERENCES `homeowner` (`homeownerid`)
    ,
  CONSTRAINT `hoaname`
    FOREIGN KEY (`hoaname`)
    REFERENCES `hoa` (`hoaname`)
    ,
  CONSTRAINT `elec_date`
    FOREIGN KEY (`elec_date`)
    REFERENCES `election_info` (`elec_date`)
    );


CREATE TABLE `resident_id` (
  `cardno`          INT                     NOT NULL,
  `request_date`    DATE                    NOT NULL,
  `request_reason`  VARCHAR(45)             NOT NULL,
  `issue_date`      DATE                    NOT NULL,
  `hoa_officer`     INT                     NOT NULL,
  `residentid`      INT                     NOT NULL,
  `status`          ENUM('A', 'L', 'C')     NOT NULL,
  `orno`            INT                     NULL,
  PRIMARY KEY (`cardno`),
  INDEX `fk_resident_id_resident1_idx` (`residentid` ASC) VISIBLE,
  INDEX `fk_resident_id_payment1_idx` (`orno` ASC) VISIBLE,
  INDEX `fk_resident_id_1_idx` (`hoa_officer` ASC) VISIBLE,
  CONSTRAINT `fk_resident_id_resident1`
    FOREIGN KEY (`residentid`)
    REFERENCES `resident` (`residentid`)
    ,
  CONSTRAINT `fk_resident_id_payment1`
    FOREIGN KEY (`orno`)
    REFERENCES `payment` (`orno`)
    ,
  CONSTRAINT `fk_resident_id_1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoa_officer` (`homeownerid`)
    );


CREATE TABLE `asset` (
  `assetid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `acq_date` DATE NOT NULL,
  `forrent` TINYINT(1) NOT NULL,
  `value` FLOAT NOT NULL,
  `type` ENUM('P', 'E', 'FF', 'OA') NOT NULL,
  `status` ENUM('W', 'D', 'FR', 'FD', 'DI') NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `location_mapx` VARCHAR(45) NOT NULL,
  `location_mapy` VARCHAR(45) NOT NULL,
  `location_assetid` INT NULL,
  `hoaname` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`assetid`),
  INDEX `fk_asset_hoa1_idx` (`hoaname` ASC) VISIBLE,
  INDEX `fk_asset_asset1_idx` (`location_assetid` ASC) VISIBLE,
  CONSTRAINT `fk_asset_hoa1`
    FOREIGN KEY (`hoaname`)
    REFERENCES `hoa` (`hoaname`)
    ,
  CONSTRAINT `fk_asset_asset1`
    FOREIGN KEY (`location_assetid`)
    REFERENCES `asset` (`assetid`)
    );


CREATE TABLE `asset_transfer` (
  `asset_transferid` INT NOT NULL,
  `assetid` INT NOT NULL,
  `schedule` DATE NOT NULL,
  `hoa_officer` INT NOT NULL,
  `actual_date` DATE NOT NULL,
  `location_origin` VARCHAR(45) NOT NULL,
  `location_dest` VARCHAR(45) NOT NULL,
  `status` ENUM('S', 'O', 'C') NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `mi` VARCHAR(2) NOT NULL,
  `mobilenum` INT(11) NOT NULL,
  `orno` INT NULL,
  PRIMARY KEY (`asset_transferid`),
  INDEX `assetid_idx` (`assetid` ASC) VISIBLE,
  INDEX `fk_asset_transfer_1_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `fk_asset_transfer_2_idx` (`orno` ASC) VISIBLE,
  CONSTRAINT `assetid`
    FOREIGN KEY (`assetid`)
    REFERENCES `asset` (`assetid`)
    ,
  CONSTRAINT `fk_asset_transfer_1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoa_officer` (`homeownerid`)
    ,
  CONSTRAINT `fk_asset_transfer_2`
    FOREIGN KEY (`orno`)
    REFERENCES `payment` (`orno`)
    );


CREATE TABLE `asset_activity` (
  `asset_activityid` INT NOT NULL,
  `assetid` INT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `hoa_officer` INT NOT NULL,
  `tent_start` DATE NOT NULL,
  `tent_end` DATE NOT NULL,
  `actual_start` DATE NOT NULL,
  `actual_end` DATE NOT NULL,
  `orno` INT NULL,
  `status` ENUM('S', 'O', 'C') NOT NULL,
  PRIMARY KEY (`asset_activityid`),
  INDEX `fk_asset_activity_asset1_idx` (`assetid` ASC) VISIBLE,
  INDEX `fk_asset_activity_hoa_officer1_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `fk_asset_activity_1_idx` (`orno` ASC) VISIBLE,
  CONSTRAINT `fk_asset_activity_asset1`
    FOREIGN KEY (`assetid`)
    REFERENCES `asset` (`assetid`)
    ,
  CONSTRAINT `fk_asset_activity_hoa_officer1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoa_officer` (`homeownerid`)
    ,
  CONSTRAINT `fk_asset_activity_1`
    FOREIGN KEY (`orno`)
    REFERENCES `payment` (`orno`)
    );


CREATE TABLE `delete_activity` (
  `asset_activityid` INT NOT NULL,
  `pres_approval` TINYINT(1) NOT NULL,
  PRIMARY KEY (`asset_activityid`),
  CONSTRAINT `fk_delete_activity_asset_activity1`
    FOREIGN KEY (`asset_activityid`)
    REFERENCES `asset_activity` (`asset_activityid`)
    );


CREATE TABLE `delete_transfer` (
  `asset_transferid` INT NOT NULL,
  `pres_approval` TINYINT(1) NOT NULL,
  PRIMARY KEY (`asset_transferid`),
  CONSTRAINT `fk_delete_transfer_asset_transfer1`
    FOREIGN KEY (`asset_transferid`)
    REFERENCES `asset_transfer` (`asset_transferid`)
    );


CREATE TABLE `asset_rental` (
  `asset_rentalid` INT NOT NULL,
  `renter_residentid` INT NOT NULL,
  `reservation_date` DATE NOT NULL,
  `rental_date` DATE NOT NULL,
  `hoa_officer` INT NOT NULL,
  `discount` DECIMAL(5,2) NOT NULL,
  `status` ENUM('RV', 'C', 'OR', 'RT', 'D') NOT NULL,
  `return_details` VARCHAR(200) NOT NULL,
  `orno` INT NULL,
  PRIMARY KEY (`asset_rentalid`),
  INDEX `fk_asset_rental_hoa_officer1_idx` (`hoa_officer` ASC) VISIBLE,
  INDEX `fk_asset_rental_resident1_idx` (`renter_residentid` ASC) VISIBLE,
  INDEX `fk_asset_rental_1_idx` (`orno` ASC) VISIBLE,
  CONSTRAINT `fk_asset_rental_hoa_officer1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoa_officer` (`homeownerid`)
    ,
  CONSTRAINT `fk_asset_rental_resident1`
    FOREIGN KEY (`renter_residentid`)
    REFERENCES `resident` (`residentid`)
    ,
  CONSTRAINT `fk_asset_rental_1`
    FOREIGN KEY (`orno`)
    REFERENCES `payment` (`orno`)
    );


CREATE TABLE `assets_rented` (
  `assetid` INT NOT NULL,
  `asset_rentalid` INT NOT NULL,
  `cost` FLOAT NOT NULL,
  PRIMARY KEY (`assetid`, `asset_rentalid`),
  INDEX `fk_assets_rented_asset_rental1_idx` (`asset_rentalid` ASC) VISIBLE,
  CONSTRAINT `fk_assets_rented_asset1`
    FOREIGN KEY (`assetid`)
    REFERENCES `asset` (`assetid`)
    ,
  CONSTRAINT `fk_assets_rented_asset_rental1`
    FOREIGN KEY (`asset_rentalid`)
    REFERENCES `asset_rental` (`asset_rentalid`)
    );


CREATE TABLE `delete_rental` (
  `asset_rentalid` INT NOT NULL,
  `pres_approval` TINYINT(1) NULL,
  PRIMARY KEY (`asset_rentalid`),
  CONSTRAINT `fk_delete_rental_asset_rental1`
    FOREIGN KEY (`asset_rentalid`)
    REFERENCES `asset_rental` (`asset_rentalid`)
    );


CREATE TABLE `asset_donation` (
  `asset_donationid` INT NOT NULL,
  `donor_lastname` VARCHAR(45) NOT NULL,
  `donor_firstname` VARCHAR(45) NOT NULL,
  `donor_mi` VARCHAR(45) NOT NULL,
  `donor_add` VARCHAR(45) NULL,
  `hoa_officer` INT NOT NULL,
  PRIMARY KEY (`asset_donationid`),
  INDEX `fk_asset_donation_hoa_officer1_idx` (`hoa_officer` ASC) VISIBLE,
  CONSTRAINT `fk_asset_donation_hoa_officer1`
    FOREIGN KEY (`hoa_officer`)
    REFERENCES `hoa_officer` (`homeownerid`)
    );


CREATE TABLE `items_donated` (
  `asset_donationid` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `amount` FLOAT NOT NULL,
  PRIMARY KEY (`asset_donationid`, `item_name`),
  CONSTRAINT `fk_items_donated_asset_donation1`
    FOREIGN KEY (`asset_donationid`)
    REFERENCES `asset_donation` (`asset_donationid`)
    );


CREATE TABLE `donation_event` (
  `asset_donationid` INT NOT NULL,
  `pic_filename` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`asset_donationid`, `pic_filename`),
  CONSTRAINT `fk_donation_event_asset_donation1`
    FOREIGN KEY (`asset_donationid`)
    REFERENCES `asset_donation` (`asset_donationid`)
    );


CREATE TABLE `delete_donation` (
  `asset_donationid` INT NOT NULL,
  `pres_approval` TINYINT(1) NOT NULL,
  PRIMARY KEY (`asset_donationid`),
  CONSTRAINT `fk_delete_donation_asset_donation1`
    FOREIGN KEY (`asset_donationid`)
    REFERENCES `asset_donation` (`asset_donationid`)
    );


CREATE TABLE `program` (
  `program_id` INT NOT NULL,
  `hoa_name` VARCHAR(45) NOT NULL,
  `program_desc` VARCHAR(45) NOT NULL,
  `program_purpose` VARCHAR(45) NOT NULL,
  `target_participants` INT NOT NULL,
  `sponsor` VARCHAR(45) NOT NULL,
  `officer_id` INT NOT NULL,
  `max_participants` INT NOT NULL,
  `program_start` DATE NOT NULL,
  `program_end` DATE NOT NULL,
  `reg_start` DATE NOT NULL,
  `program_status` ENUM('OR', 'CR', 'CA', 'CO') NOT NULL,
  `budget` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`program_id`),
  INDEX `fk_program_1_idx` (`hoa_name` ASC) VISIBLE,
  INDEX `fk_program_2_idx` (`officer_id` ASC) VISIBLE,
  CONSTRAINT `fk_program_1`
    FOREIGN KEY (`hoa_name`)
    REFERENCES `hoa` (`hoaname`)
    ,
  CONSTRAINT `fk_program_2`
    FOREIGN KEY (`officer_id`)
    REFERENCES `hoa_officer` (`homeownerid`)
    );


CREATE TABLE `committee` (
  `committee_id` INT NOT NULL,
  `program_id` INT NOT NULL,
  `hoa_officerid` INT NOT NULL,
  PRIMARY KEY (`committee_id`),
  INDEX `fk_committee_1_idx` (`program_id` ASC) VISIBLE,
  INDEX `fk_committee_2_idx` (`hoa_officerid` ASC) VISIBLE,
  CONSTRAINT `fk_committee_1`
    FOREIGN KEY (`program_id`)
    REFERENCES `program` (`program_id`)
    ,
  CONSTRAINT `fk_committee_2`
    FOREIGN KEY (`hoa_officerid`)
    REFERENCES `hoa_officer` (`homeownerid`)
    );


CREATE TABLE `program_evidence` (
  `evidence_id` INT NOT NULL,
  `program_id` INT NOT NULL,
  `evidence_desc` VARCHAR(200) NOT NULL,
  `filename` VARCHAR(45) NOT NULL,
  `resident_id` INT NOT NULL,
  `officer_id` INT NOT NULL,
  `date_submitted` DATE NOT NULL,
  PRIMARY KEY (`evidence_id`),
  INDEX `fk_program_evidence_1_idx` (`program_id` ASC) VISIBLE,
  INDEX `fk_program_evidence_2_idx` (`resident_id` ASC) VISIBLE,
  INDEX `fk_program_evidence_3_idx` (`officer_id` ASC) VISIBLE,
  CONSTRAINT `fk_program_evidence_1`
    FOREIGN KEY (`program_id`)
    REFERENCES `program` (`program_id`)
    ,
  CONSTRAINT `fk_program_evidence_2`
    FOREIGN KEY (`resident_id`)
    REFERENCES `resident` (`residentid`)
    ,
  CONSTRAINT `fk_program_evidence_3`
    FOREIGN KEY (`officer_id`)
    REFERENCES `hoa_officer` (`homeownerid`)
    );


CREATE TABLE `registration` (
  `reg_id` INT NOT NULL,
  `program_id` INT NOT NULL,
  `resident_id` INT NOT NULL,
  `isPriority` TINYINT(1) NOT NULL,
  PRIMARY KEY (`reg_id`),
  INDEX `fk_registration_1_idx` (`program_id` ASC) VISIBLE,
  INDEX `fk_registration_2_idx` (`resident_id` ASC) VISIBLE,
  CONSTRAINT `fk_registration_1`
    FOREIGN KEY (`program_id`)
    REFERENCES `program` (`program_id`)
    ,
  CONSTRAINT `fk_registration_2`
    FOREIGN KEY (`resident_id`)
    REFERENCES `resident` (`residentid`)
    );


CREATE TABLE `participant_approval` (
  `reg_id` INT NOT NULL,
  `member_id` INT NOT NULL,
  `isAccepted` TINYINT(1) NOT NULL,
  `reason` VARCHAR(100) NULL,
  PRIMARY KEY (`reg_id`),
  CONSTRAINT `fk_participant_approval_1`
    FOREIGN KEY (`reg_id`)
    REFERENCES `registration` (`reg_id`)
    );


CREATE TABLE `members` (
  `member_id` INT NOT NULL,
  `committee_id` INT NOT NULL,
  `resident_id` INT NOT NULL,
  `position` ENUM('M', 'H') NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_members_1_idx` (`committee_id` ASC) VISIBLE,
  INDEX `fk_members_2_idx` (`resident_id` ASC) VISIBLE,
  CONSTRAINT `fk_members_1`
    FOREIGN KEY (`committee_id`)
    REFERENCES `committee` (`committee_id`)
    ,
  CONSTRAINT `fk_members_2`
    FOREIGN KEY (`resident_id`)
    REFERENCES `resident` (`residentid`)
    );


CREATE TABLE `feedback` (
  `reg_id` INT NOT NULL,
  `feedback` VARCHAR(200) NOT NULL,
  `rating` ENUM('1', '2', '3', '4', '5') NOT NULL,
  `suggestion` VARCHAR(200) NULL,
  PRIMARY KEY (`reg_id`),
  CONSTRAINT `fk_feedback_1`
    FOREIGN KEY (`reg_id`)
    REFERENCES `registration` (`reg_id`)
    );


CREATE TABLE `expenses` (
  `expense_id` INT NOT NULL,
  `member_id` INT NOT NULL,
  `expense_desc` VARCHAR(100) NOT NULL,
  `exp_date` DATE NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `official_receipt` BLOB NOT NULL,
  PRIMARY KEY (`expense_id`),
  INDEX `fk_expenses_1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_expenses_1`
    FOREIGN KEY (`member_id`)
    REFERENCES `members` (`member_id`)
    );


CREATE TABLE `expense_type` (
  `expense_id` INT NOT NULL,
  `type` ENUM('MA', 'S', 'M', 'O') NOT NULL,
  PRIMARY KEY (`expense_id`),
  CONSTRAINT `fk_expense_type_1`
    FOREIGN KEY (`expense_id`)
    REFERENCES `expenses` (`expense_id`)
    );

