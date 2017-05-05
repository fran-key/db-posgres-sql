\timing
SELECT host0_.id AS col_0_0_,
         host0_.name AS col_1_0_,
        
    CASE
    WHEN host0_.type <> 2 AND host0_.type <> 3  THEN
    count(distinct hostinitia2_.id)+count(distinct hostinitia4_.id)
    ELSE null
    END AS col_2_0_
FROM host host0_ left outer
JOIN host_iscsiHostInitiators iscsihosti1_
    ON host0_.id=iscsihosti1_.id left outer
JOIN host_initiator hostinitia2_
    ON iscsihosti1_.elementvalue=hostinitia2_.id left outer
JOIN host_fcHostInitiators fchostinit3_
    ON host0_.id=fchostinit3_.id left outer
JOIN host_initiator hostinitia4_
    ON fchostinit3_.elementvalue=hostinitia4_.id
GROUP BY  host0_.id , host0_.name , host0_.type having
    (CASE
    WHEN host0_.type <> 2 AND host0_.type <> 3  THEN
    count(distinct hostinitia2_.id)+count(distinct hostinitia4_.id)
    ELSE null
    END) < 10 
ORDER BY  col_2_0_
OFFSET 20
LIMIT 100;