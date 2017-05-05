\timing
--SELECT * FROM host_iscsiHostInitiators limit 100;
SELECT * FROM host_fcHostInitiators WHERE id = 'host_10';
SELECT * FROM host_initiator WHERE id = 'initiator_20';


SELECT hostinitia9_.id
    FROM host hostbean7_
    INNER JOIN host_iscsiHostInitiators iscsihosti8_
        ON hostbean7_.id=iscsihosti8_.id
    INNER JOIN host_initiator hostinitia9_
        ON iscsihosti8_.elementvalue=hostinitia9_.id
    WHERE hostbean7_.id='host_10';

    SELECT count(hostinitia12_.id)
        FROM host hostbean10_
        INNER JOIN host_fcHostInitiators fchostinit11_
            ON hostbean10_.id=fchostinit11_.id
        INNER JOIN host_initiator hostinitia12_
            ON fchostinit11_.elementvalue=hostinitia12_.id
        WHERE hostbean10_.id='host_10';
