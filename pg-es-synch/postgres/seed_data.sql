START TRANSACTION;

INSERT INTO users(email, mobile_number, gender, income)
SELECT
  	random_string(10)|| seq || '@' || (
    CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 'gmail'
      WHEN 1 THEN 'hotmail'
      WHEN 2 THEN 'yahoo'
    END
  ) || '.com' AS email,
  regexp_replace(CAST (random() AS text),'^0\.(\d{3})(\d{3})(\d{4}).*$','\1\2\3') AS mobile_number,
  CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 'Male'
      WHEN 1 THEN 'Female'
      WHEN 2 THEN 'Not Disclosed'
    end,
  regexp_replace(CAST (random() AS text),'^0\.(\d{3})(\d{3}).*$','\1\2')::INT AS income
FROM GENERATE_SERIES(1, 10) seq;


INSERT INTO user_address (user_id, address1, address2, street, city, state, country)
WITH expanded AS (
  SELECT RANDOM(), seq, u.id AS user_id
  FROM GENERATE_SERIES(1, 50) seq, users u
), shuffled AS (
  SELECT e.*
  FROM expanded e
  INNER JOIN (
    SELECT ei.seq, MIN(ei.random) FROM expanded ei GROUP BY ei.seq
  ) em ON (e.seq = em.seq AND e.random = em.min)
  ORDER BY e.seq
)
SELECT
  s.user_id,
  random_string(floor(random() * 50 + 1)::int) as address1,
  random_string(floor(random() * 50 + 1)::int) as address2,
  random_string(floor(random() * 75 + 1)::int) as street,
  'Hyderabad',
  'Telangana',
  'India'
FROM shuffled s;


INSERT INTO user_additional_info (user_id, family_members, father_name, mother_name, marital_status)
WITH expanded AS (
  select * from users
)
SELECT
  e.id,
  floor(random() * 10 + 1)::int as family_members ,
  random_string(floor(random() * 25 + 5)::int) as father_name ,
  random_string(floor(random() * 25 + 5)::int) as mother_name ,
  CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 'Married'
      WHEN 1 THEN 'Single'
      WHEN 2 THEN 'Divorced'
      WHEN 4 THEN 'Widow'
    end
FROM expanded e;

COMMIT;

