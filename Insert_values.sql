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
        'Muralla' '1234',
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
        'Bonifacio' '5678',
        '1,666,888',
        '1,555,777',
        '2019',
        'www.facebook.com',
        'oursubd',
        '16'
    );
INSERT INTO hoa_docs (doc_name)
VALUES(
        'notarized_articles',
        'notarized_bylaws',
        'motm',
        'attendance',
        'certificate',
        'ethics_code',
    );
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