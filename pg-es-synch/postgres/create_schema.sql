START TRANSACTION;

CREATE EXTENSION if not exists "uuid-ossp";

CREATE TABLE users (
  id  TEXT PRIMARY KEY DEFAULT uuid_generate_v4(),
  email TEXT NOT NULL UNIQUE,
  mobile_number TEXT NOT NULL UNIQUE,
  gender TEXT,
  income INT NOT NULL DEFAULT -1,
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE user_address (
  id  TEXT PRIMARY KEY DEFAULT uuid_generate_v4(),
  address1 TEXT NOT NULL,
  address2 TEXT,
  street TEXT NOT NULL,
  city TEXT NOT NULL,
  state TEXT NOT NULL,
  country TEXT NOT NULL,
  user_id TEXT NOT NULL REFERENCES users(id),
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE user_additional_info (
  id  TEXT PRIMARY KEY DEFAULT uuid_generate_v4(),
  family_members INT NOT NULL DEFAULT 0,
  father_name TEXT,
  mother_name TEXT,
  marital_status TEXT,
  user_id TEXT NOT NULL REFERENCES users(id),
  created_at TIMESTAMP DEFAULT now()
);

CREATE OR REPLACE FUNCTION random_string(length integer) RETURNS TEXT AS
$$
  DECLARE
    chars text[] := '{A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
    result text := '';
    i INTEGER := 0;
  BEGIN
    IF length < 0 THEN
      raise exception 'Given length cannot be less than 0';
    END IF;
    FOR i IN 1..length LOOP
      result := result || chars[1+random()*(array_length(chars, 1)-1)];
    END LOOP;
    RETURN result;
  END;
$$ language plpgsql;

COMMIT;