\timing
SELECT hostbean0_.id AS col_0_0_,
    CASE
    WHEN hostbean0_.type<>2
        AND hostbean0_.type<>3 THEN
    cast(
    (SELECT count(hostinitia3_.id)
    FROM host hostbean1_
    INNER JOIN host_iscsiHostInitiators iscsihosti2_
        ON hostbean1_.id=iscsihosti2_.id
    INNER JOIN host_initiator hostinitia3_
        ON iscsihosti2_.elementvalue=hostinitia3_.id
    WHERE hostbean1_.id=hostbean0_.id)+
        (SELECT count(hostinitia6_.id)
        FROM host hostbean4_
        INNER JOIN host_fcHostInitiators fchostinit5_
            ON hostbean4_.id=fchostinit5_.id
        INNER JOIN host_initiator hostinitia6_
            ON fchostinit5_.elementvalue=hostinitia6_.id
        WHERE hostbean4_.id=hostbean0_.id) AS float4)
        ELSE null
    END AS col_1_0_
FROM host hostbean0_ where
    (CASE
    WHEN hostbean0_.type<>2
        AND hostbean0_.type<>3 THEN
    cast(
    (SELECT count(hostinitia9_.id)
    FROM host hostbean7_
    INNER JOIN host_iscsiHostInitiators iscsihosti8_
        ON hostbean7_.id=iscsihosti8_.id
    INNER JOIN host_initiator hostinitia9_
        ON iscsihosti8_.elementvalue=hostinitia9_.id
    WHERE hostbean7_.id=hostbean0_.id)+
        (SELECT count(hostinitia12_.id)
        FROM host hostbean10_
        INNER JOIN host_fcHostInitiators fchostinit11_
            ON hostbean10_.id=fchostinit11_.id
        INNER JOIN host_initiator hostinitia12_
            ON fchostinit11_.elementvalue=hostinitia12_.id
        WHERE hostbean10_.id=hostbean0_.id) AS float4)
        ELSE NULL END )<10
ORDER BY  col_0_0_ limit 100;