DROP DATABASE IF EXISTS rh;

CREATE DATABASE IF NOT EXISTS rh;

USE rh;

DROP TABLE IF EXISTS historico_salario;
DROP TABLE IF EXISTS historico_departamento;
DROP TABLE IF EXISTS historico_cargo;
DROP TABLE IF EXISTS departamento;
DROP TABLE IF EXISTS cargo;
DROP TABLE IF EXISTS colaborador;

CREATE TABLE colaborador (
	id 				INT PRIMARY KEY AUTO_INCREMENT,
    nome 			VARCHAR(100)	NOT NULL,
    cpf 			VARCHAR(11) 	NOT NULL UNIQUE,
    data_admissao	DATE 			NOT NULL,
    data_demissao 	DATE,
    email 			VARCHAR(100),
    telefone 		VARCHAR(15),
    endereco 		VARCHAR(200)
);

CREATE TABLE departamento (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE cargo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cbo VARCHAR(10),
    descricao TEXT
);

CREATE TABLE historico_salario (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    id_colaborador	INT 			NOT NULL,
    salario 		DECIMAL(10,2)	NOT NULL,
    data_inicio 	DATE 			NOT NULL,
    FOREIGN KEY (id_colaborador) REFERENCES colaborador (id)
);

CREATE TABLE historico_departamento (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    id_colaborador	INT 	NOT NULL,
    id_departamento	INT 	NOT NULL,
    data_inicio 	DATE	NOT NULL,
    FOREIGN KEY (id_colaborador) REFERENCES colaborador (id),
    FOREIGN KEY (id_departamento) REFERENCES departamento (id)
);

CREATE TABLE historico_cargo (
	id 				INT PRIMARY KEY AUTO_INCREMENT,
    id_colaborador	INT 	NOT NULL,
    id_cargo 		INT 	NOT NULL,
    data_inicio 	DATE	NOT NULL,
    FOREIGN KEY (id_colaborador) REFERENCES colaborador (id),
    FOREIGN KEY (id_cargo) REFERENCES cargo (id)
);