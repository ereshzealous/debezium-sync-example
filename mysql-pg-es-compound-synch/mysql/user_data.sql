GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicator' IDENTIFIED BY 'replpass';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'debezium' IDENTIFIED BY 'mysql';

# Create the database that we'll use to populate data and watch the effect in the binlog
CREATE DATABASE user_data;
GRANT ALL PRIVILEGES ON user_data.* TO 'mysql'@'%';

# Switch to this database
USE user_data;

# Create and populate our products using a single insert with many rows
CREATE TABLE users (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email varchar(255) not null,
  mobile_number VARCHAR(512),
  created_at timestamp default CURRENT_TIMESTAMP()
);
ALTER TABLE users AUTO_INCREMENT = 1;

INSERT INTO users
VALUES (default,"John Smith","john.smith@email.com","9876543211", default),
       (default,"Tom Cruise","tom.cruise@gmail.com","9876543212", default),
       (default,"Jack Peterson","jack.peterson@gmail.com","9876543213", default),
       (default,"John Wick","john.wick@gmail.com","9876543214", default),
       (default,"Jason Bourne","jason.bourne@gmail.com","9876543215", default),
       (default,"Jack Reacher","jack.reacher@gmail.com","9876543216", default),
       (default,"James Bond","james.bond@gmail.com","9876543217", default),
       (default,"Terminator","terminator@gmail.com","9876543218", default),
       (default,"Punisher","punisher@gmail.com","9876543219", default);

# Create table with Spatial/Geometry type
CREATE TABLE geom (
	id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	g GEOMETRY NOT NULL,
	h GEOMETRY);

INSERT INTO geom
VALUES(default, ST_GeomFromText('POINT(100.1234 -19.09001)'), NULL),
      (default, ST_GeomFromText('POINT(99.1234 -25.09001)'), NULL),
      (default, ST_GeomFromText('POINT(49.1234 -29.09001)'), NULL);