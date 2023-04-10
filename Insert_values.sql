-- REGIONS

INSERT INTO regions (
    region
)
VALUE (
    'REGION1'
);

INSERT INTO regions (
    region
)
VALUE (
    'REGION2'
);

-- PROVINCE 
INSERT INTO provinces (
    province,
    region
)
VALUE (
    'PROVINCE1',
    'REGION1'
);

INSERT INTO provinces (
    province,
    region
)
VALUE (
    'PROVINCE2',
    'REGION2'
);

-- ZIPCODES
INSERT INTO zipcodes (
    barangay, 
    city,
    province, 
    zipcode
)
VALUES(
    'BARANGAY1',
    'CITY1',
    'PROVINCE1',
    '1234'
);

INSERT INTO zipcodes (
    barangay, 
    city,
    province, 
    zipcode
)
VALUES(
    'BARANGAY2',
    'CITY2',
    'PROVINCE2',
    '5678'
);

-- HOA 
INSERT INTO hoa (
        hoaname,
        office_streetno,
        office_street,
        office_zipcode,
        office_mapx,
        office_mapy,
        year_est,
        subd_name,
        monthly_dues
    )
VALUES(
        'subdhoa1',
        '12A',
        'Muralla',
        '1234',
        '1,222,444',
        '1,333,555',
        '1984',
        'oursubd',
        '16'
    );

INSERT INTO hoa (
        hoaname,
        office_streetno,
        office_street,
        office_zipcode,
        office_mapx,
        office_mapy,
        year_est,
        website,
        subd_name,
        monthly_dues
    )
VALUES(
        'hoazers',
        '13B',
        'Bonifacio',
        '5678',
        '1,666,888',
        '1,555,777',
        '2019',
        'www.facebook.com',
        'oursubd',
        '16'
    );


-- HOA DOCUMENTS REFERENCE TABLE
INSERT INTO hoa_docs (doc_name)
VALUES
        ('notarized_articles'),
        ('notarized_bylaws'),
        ('motm'),
        ('attendance'),
        ('certificate'),
        ('ethics_code');

-- HOA SUBMISSIONS
INSERT INTO hoa_submissions(
        hoa_hoaname,
        hoa_docs_submission_type,
        submission_date
    )
VALUES('subdhoa1', '1', '2022-01-01');

INSERT INTO hoa_submissions(
        hoa_hoaname,
        hoa_docs_submission_type,
        submission_date
    )
VALUES('hoazers', '2', '2022-01-02');

-- INDIVIDUAL
INSERT INTO individual (
    lastname,
    firstname,
    mi,
    email,
    birthday,
    gender,
    facebook_url,
    pic_filename, 
    undertaking
) VALUES ('Santos', 'Jerrick', 'Q.', 'jerrick@gmail.com', '2003-01-22', 'M', 'www.facebook/jer.com', 'jerrick.png', '0'),
         ('Reyes', 'Carlo', 'O.', 'carlo@gmail.com', '2001-09-11',  'M', 'www.facebook/car.com', 'carlo.png', '0'),
         ('Andres', 'Nathan', 'M', 'nathan@gmail.com', '2002-11-12', 'M', 'www.facebook.com/nathan', 'nathan.png', '1'),
         ('Arao', 'Patty', 'T', 'pat@gmail.com', '2003-07-15', 'F', 'www.facebook.com/patty', 'patty.png', '1');


INSERT INTO mobile (
    mobilenum,
    individualid
) VALUES    ('916550596', '1'), -- 9 characters
            ('956589700', '2'), -- 9 characters
            ('956100990', '3'), -- 9 characters
            ('916765537', '4'); -- 9 characters

-- PROGRAM 
INSERT INTO program (
    hoa_name,
    program_desc, 
    program_purpose, 
    target_participants, 
    sponsor,
    officer_id, 
    max_participants,
    program_start,
    program_end,
    reg_start, 
    program_status,
    budget
) VALUES ('subdhoa1', 'Description of program 1', 'Purpose of program 1', '50', 'Sponsor 1', '1',
          '50', '2023-05-10', '2023-05-15', '2023-04-09' 'OR', '10000.00'),
          ('subdhoa1', 'Description of program 2', 'Purpose of program 2', '100', 'Sponsor 1', '2',
          '50', '2023-05-10', '2023-05-15', '2023-04-09' 'OR', '10000.00');