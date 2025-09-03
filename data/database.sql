-- Supprimer les tables si elles existent (cascade supprime les dépendances)
DROP TABLE IF EXISTS arrets CASCADE;
DROP TABLE IF EXISTS transports CASCADE;
DROP TABLE IF EXISTS communes CASCADE;

-- Création de la table communes
CREATE TABLE communes (
    nom_commune TEXT NOT NULL,
    departement TEXT NOT NULL,
    PRIMARY KEY (nom_commune, departement)
);

-- Création de la table transports
CREATE TABLE transports (
    nom TEXT NOT NULL,
    mode TEXT NOT NULL,
    operateur TEXT NOT NULL,
    PRIMARY KEY (nom, mode, operateur)
);

-- Création de la table des arrêts
CREATE TABLE arrets (
    id TEXT NOT NULL,
    route_long_name TEXT,
    stop_id TEXT,
    stop_name TEXT,
    stop_lon DOUBLE PRECISION,
    stop_lat DOUBLE PRECISION,
    operator TEXT,
    shortname TEXT,
    mode TEXT,
    pointgeo TEXT,
    nom_commune TEXT,
    departement TEXT,
    
    -- Clés étrangères vers transports
    CONSTRAINT fk_transport FOREIGN KEY (shortname, mode, operator)
        REFERENCES transports(nom, mode, operateur)
        ON DELETE CASCADE,
    
    -- Clés étrangères vers communes
    CONSTRAINT fk_commune FOREIGN KEY (nom_commune, departement)
        REFERENCES communes(nom_commune, departement)
        ON DELETE CASCADE
);

-- Import des données depuis les CSV
\copy communes FROM 'final_data/communes_departements.csv' DELIMITER ';' CSV HEADER;
\copy transports FROM 'final_data/transports.csv' DELIMITER ';' CSV HEADER;
\copy arrets FROM 'final_data/arrets_departements.csv' DELIMITER ';' CSV HEADER;