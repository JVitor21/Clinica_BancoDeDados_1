-- Criando banco de dados CLINICA
CREATE DATABASE IF NOT EXISTS CLINICA
DEFAULT CHARACTER SET utf8 
DEFAULT COLLATE utf8_general_ci;

USE CLINICA;

-- Tabela RECEPCIONISTA
CREATE TABLE IF NOT EXISTS RECEPCIONISTA (
    Matricula_Recepcionista INT NOT NULL,
    Email VARCHAR(20) NOT NULL,
    Nome CHAR(20) NOT NULL,
    Telefone VARCHAR(40) NOT NULL,
    PRIMARY KEY (Matricula_Recepcionista)
);

-- Alterando o tamanho do campo Telefone para VARCHAR(40)
ALTER TABLE RECEPCIONISTA
CHANGE Telefone Telefone VARCHAR(40) NOT NULL;

-- Inserindo dados na tabela RECEPCIONISTA
INSERT INTO RECEPCIONISTA (Matricula_Recepcionista, Email, Nome, Telefone)
VALUES (01, 'E-mail', 'Danilo', '(83)9123-456');

-- Tabela PACIENTE
CREATE TABLE IF NOT EXISTS PACIENTE (
    Id_paciente INT NOT NULL AUTO_INCREMENT,
    Matricula_recepcionista INT NOT NULL,
    CPF VARCHAR(40) NOT NULL,
    Nome CHAR(20) NOT NULL,
    Telefone VARCHAR(40) NOT NULL, -- Alterado para VARCHAR(40)
    Email VARCHAR(20) NOT NULL,
    Rua VARCHAR(20) NOT NULL,
    Bairro VARCHAR(20) NOT NULL,
    Cidade VARCHAR(20) NOT NULL,
    PRIMARY KEY (Id_paciente),
    FOREIGN KEY (Matricula_recepcionista) REFERENCES RECEPCIONISTA (Matricula_Recepcionista)
);

-- Alterando o tamanho do campo Email para VARCHAR(20)
ALTER TABLE PACIENTE
CHANGE Email Email VARCHAR(20) NOT NULL;

-- Inserindo dados na tabela PACIENTE
INSERT INTO PACIENTE (Matricula_recepcionista, CPF, Nome, Telefone, Email, Rua, Bairro, Cidade)
VALUES 
(01, '1234567-89', 'Engels', '(83)9789-456', 'Email', 'Chico Bento', 'Maria Cambota', 'Patos'),
(01, '4587963-56', 'João Vitor', '(83)9874-589', 'Email', 'Pega Pega', 'Tatu Bola', 'Patos');

-- Tabela MEDICO
CREATE TABLE IF NOT EXISTS MEDICO (
    Matricula_medico INT NOT NULL,
    Email VARCHAR(20) NOT NULL,
    Nome CHAR(20) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Especialidade CHAR(20) NOT NULL,
    PRIMARY KEY (Matricula_medico)
);

-- Inserindo dados na tabela MEDICO
INSERT INTO MEDICO (Matricula_medico, Email, Nome, Telefone, Especialidade)
VALUES (01, 'Email', 'Kauã', '(83)9456892', 'Nutricionista');

-- Tabela Agendamento
CREATE TABLE IF NOT EXISTS Agendamento (
    Id_agendamento INT NOT NULL,
    Matricula_recepcionista INT NOT NULL,
    Datas VARCHAR(20) NOT NULL,
    Hora VARCHAR(20) NOT NULL,
    Nome_Medico CHAR(20) NOT NULL,
    Nome_Paciente CHAR(20) NOT NULL,
    PRIMARY KEY (Id_agendamento),
    FOREIGN KEY (Matricula_recepcionista) REFERENCES RECEPCIONISTA (Matricula_Recepcionista)
);

-- Inserindo dados na tabela Agendamento
INSERT INTO Agendamento (Id_agendamento, Matricula_recepcionista, Datas, Hora, Nome_Medico, Nome_Paciente)
VALUES 
(01, 01, '01/01/2023', '14:30', 'Kauã', 'Engels'),
(02, 01, '06/01/2023', '13:30', 'Kauã', 'João Vitor');

-- Tabela Avaliacao_fisica
CREATE TABLE IF NOT EXISTS Avaliacao_fisica (
    Matricula_medico INT NOT NULL,
    Id_avaliacao_fisica INT NOT NULL AUTO_INCREMENT,
    Porcentagem_massa_magra FLOAT(20,2) NOT NULL,
    Altura VARCHAR(20) NOT NULL,
    Peso FLOAT(20,2) NOT NULL,
    PRIMARY KEY (Id_avaliacao_fisica),
    FOREIGN KEY (Matricula_medico) REFERENCES MEDICO (Matricula_medico)
);

-- Inserindo dados na tabela Avaliacao_fisica
INSERT INTO Avaliacao_fisica (Matricula_medico, Porcentagem_massa_magra, Altura, Peso)
VALUES
(01, 25.0, '1.71', 82.0),
(01, 25.0, '1.65', 70.0);

-- Tabela Plano_dieta
CREATE TABLE IF NOT EXISTS Plano_dieta (
    Id_avaliacao_fisica INT NOT NULL,
    Id_plano_dieta INT NOT NULL AUTO_INCREMENT,
    Item_lanche_1 VARCHAR(40) NOT NULL,
    Item_lanche_2 VARCHAR(40) NOT NULL,
    Item_janta_1 VARCHAR(40) DEFAULT NULL,
    Item_janta_2 VARCHAR(40) DEFAULT NULL,
    Item_janta_3 VARCHAR(40) DEFAULT NULL,
    Item_almoco_1 VARCHAR(40) DEFAULT NULL,
    Item_almoco_2 VARCHAR(40) DEFAULT NULL,
    Item_almoco_3 VARCHAR(40) DEFAULT NULL,
    Item_cafe_1 VARCHAR(40) DEFAULT NULL,
    Item_cafe_2 VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY (Id_plano_dieta),
    FOREIGN KEY (Id_avaliacao_fisica) REFERENCES Avaliacao_fisica (Id_avaliacao_fisica)
);

-- Inserindo dados na tabela Plano_dieta
INSERT INTO Plano_dieta (Id_avaliacao_fisica, Item_lanche_1, Item_lanche_2)
VALUES 
(1, 'Tapioca', 'Banana'),
(2, 'Pão', 'Ovo');

-- Tabela Executa
CREATE TABLE IF NOT EXISTS Executa (
    Id_agendamento INT NOT NULL,
    Matricula_recepcionista INT NOT NULL,
    Id_paciente INT NOT NULL,
    FOREIGN KEY (Id_agendamento) REFERENCES Agendamento (Id_agendamento),
    FOREIGN KEY (Matricula_recepcionista) REFERENCES RECEPCIONISTA (Matricula_Recepcionista),
    FOREIGN KEY (Id_paciente) REFERENCES PACIENTE (Id_paciente)
);

-- Inserindo dados na tabela Executa
INSERT INTO Executa (Id_agendamento, Matricula_recepcionista, Id_paciente)
VALUES
(01, 01, 01),
(02, 01, 02);

-- Tabela Realiza
CREATE TABLE IF NOT EXISTS Realiza (
    Matricula_medico INT NOT NULL,
    Id_paciente INT NOT NULL,
    Id_avaliacao_fisica INT NOT NULL,
    FOREIGN KEY (Matricula_medico) REFERENCES MEDICO (Matricula_medico),
    FOREIGN KEY (Id_paciente) REFERENCES PACIENTE (Id_paciente),
    FOREIGN KEY (Id_avaliacao_fisica) REFERENCES Avaliacao_fisica (Id_avaliacao_fisica)
);

-- Inserindo dados na tabela Realiza
INSERT INTO Realiza (Matricula_medico, Id_paciente, Id_avaliacao_fisica)
VALUES
(01, 01, 1),
(01, 02, 2);

-- Finalizando o script SQL
COMMIT;
