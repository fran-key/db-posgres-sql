-- Procedure to insert a new city
CREATE OR REPLACE FUNCTION generate_data(entry_count INTEGER) 
RETURNS void AS $$
BEGIN

--  Start  --
DROP TABLE host CASCADE;
CREATE TABLE host (id VARCHAR(50), name VARCHAR(50), type INTEGER);

DROP TABLE host_initiator CASCADE;
CREATE TABLE host_initiator (id VARCHAR(50), name VARCHAR(50));

DROP TABLE host_iscsiHostInitiators;
CREATE TABLE host_iscsiHostInitiators (id VARCHAR(50), elementvalue VARCHAR(50));

DROP TABLE host_fcHostInitiators;
CREATE TABLE host_fcHostInitiators (id VARCHAR(50), elementvalue VARCHAR(50));

INSERT INTO host(id, name, type) 
    (SELECT 
        'host_'||i,
        'host_name_'||i,
        CASE WHEN (ROW_NUMBER() OVER ())%2 = 0 THEN 1 ELSE 2 END
    FROM generate_series(1, entry_count) as i)
;

INSERT INTO host_initiator (id, name) 
    (SELECT 
        'initiator_'||i,
        CASE WHEN (ROW_NUMBER() OVER ())%2 = 0 THEN 'fc_initiator_'||i ELSE 'iscsi_initiator_'||i END
    FROM generate_series(1, 4*entry_count) as i)
;

CREATE OR REPLACE VIEW fc_initiator AS 
    (SELECT id AS id, name AS name, (ROW_NUMBER() OVER ()) AS row_number 
    FROM host_initiator WHERE name like 'fc_%'
    );



-- host -> fc

FOR counter IN 0..3 LOOP
INSERT INTO host_fcHostInitiators (id, elementvalue) 
   (SELECT 
        'host_'||i,
        (SELECT id FROM fc_initiator WHERE row_number = (i+counter*entry_count/2))
    FROM generate_series(1, entry_count/2) as i)
    ;

END LOOP;


-- host -> iscsi

CREATE OR REPLACE VIEW iscsi_initiator AS 
    (SELECT id AS id, name AS name, (ROW_NUMBER() OVER ()) AS row_number 
    FROM host_initiator WHERE name like 'iscsi_%'
    );

FOR counter IN 0..3 LOOP
INSERT INTO host_iscsiHostInitiators (id, elementvalue) 
   (SELECT 
        'host_'||i,
        (SELECT id FROM iscsi_initiator WHERE row_number = (i-entry_count/2+(counter*entry_count/2)))
    FROM generate_series(entry_count/2+1, entry_count) as i)
    ;

END LOOP;

-- End --

END;
$$ LANGUAGE plpgsql;


SELECT generate_data(10000);
