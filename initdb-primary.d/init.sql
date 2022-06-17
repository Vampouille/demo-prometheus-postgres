CREATE EXTENSION pg_stat_statements;
CREATE DATABASE organisme;
\c organisme

CREATE TABLE data(
  id   serial,
  data int
);

INSERT INTO data (data) SELECT g.id FROM generate_series(1, 50000) AS g (id);
INSERT INTO data (data) SELECT g.id FROM generate_series(1, 50000) AS g (id);
INSERT INTO data (data) SELECT g.id FROM generate_series(1, 50000) AS g (id);

UPDATE data SET data = data + 1 WHERE id % 10 <> 1;

CREATE DATABASE animaux;
\c animaux

CREATE TABLE animal(
  id   serial,
  nom  text
);
