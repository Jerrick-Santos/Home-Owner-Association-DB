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
    facebook,
    pic_filename, 
    undertaking
) VALUES ('Santos', 'Jerrick', 'Q.', 'jerrick@gmail.com', 'M', 'www.facebook/jer.com', 'jerrick.png', '0')
         ('Reyes', 'Carlo', 'O.', 'carlo@gmail.com', 'M', 'www.facebook/car.com', 'carlo.png', '0');

INSERT INTO individual (
    lastname,
    firstname,
    email,
    birthday,
    gender,
    pic_filename, 
    undertaking
) VALUES ('Arao', 'Patty', 'pat@gmail.com', 'F', 'patty.png', '1')
         ('Andres', 'Nathan', 'nathan@gmail.com', 'M', 'neytan.png', '1');
