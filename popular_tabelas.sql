USE rh;

INSERT INTO colaborador (nome, cpf, data_admissao, email, telefone, endereco)
VALUES
('Ana Costa', '12345678901', '2020-01-10', 'ana.costa@empresa.com', '(11) 99999-0001', 'Rua das Flores, 100, São Paulo, SP'),
('Bruno Souza', '23456789012', '2019-05-15', 'bruno.souza@empresa.com', '(11) 98888-0002', 'Av. Central, 200, Campinas, SP'),
('Carlos Pereira', '34567890123', '2021-08-01', 'carlos.pereira@empresa.com', '(11) 97777-0003', 'Rua dos Andradas, 300, Rio de Janeiro, RJ'),
('Daniela Lima', '45678901234', '2022-03-12', 'daniela.lima@empresa.com', '(21) 96666-0004', 'Av. Atlântica, 400, Rio de Janeiro, RJ'),
('Eduardo Silva', '56789012345', '2018-11-25', 'eduardo.silva@empresa.com', '(31) 95555-0005', 'Rua Minas Gerais, 500, Belo Horizonte, MG');

INSERT INTO departamento (nome, descricao)
VALUES
('Desenvolvimento', 'Responsável pela criação e manutenção de software'),
('Recursos Humanos', 'Responsável pela gestão de pessoas e processos internos'),
('Financeiro', 'Responsável pela gestão financeira da empresa');

INSERT INTO cargo (nome, cbo, descricao)
VALUES
('Desenvolvedor Backend', '2123-05', 'Desenvolvimento e manutenção de sistemas do lado do servidor'),
('Desenvolvedor Frontend', '2123-10', 'Desenvolvimento de interfaces e experiências do usuário'),
('Analista de Recursos Humanos', '2524-15', 'Atendimento e gestão dos colaboradores'),
('Gerente de Projetos', '1425-05', 'Gerenciamento de equipes e projetos de software');

INSERT INTO historico_salario (id_colaborador, salario, data_inicio)
VALUES
(1, 6000.00, '2020-01-10'),
(2, 7000.00, '2019-05-15'),
(3, 8000.00, '2021-08-01'),
(4, 5000.00, '2022-03-12'),
(5, 9000.00, '2018-11-25'),
(1, 6500.00, '2021-06-01'),
(1, 7000.00, '2023-01-01'),
(2, 7500.00, '2020-10-01'),
(2, 8000.00, '2022-04-01'),
(3, 8500.00, '2022-02-01'),
(4, 5500.00, '2023-05-01'),
(5, 9500.00, '2020-03-01'),
(5, 10000.00, '2021-09-01');

INSERT INTO historico_departamento (id_colaborador, id_departamento, data_inicio)
VALUES
(1, 1, '2020-01-10'),
(2, 1, '2019-05-15'),
(3, 1, '2021-08-01'),
(4, 2, '2022-03-12'),
(5, 1, '2018-11-25'),
(1, 3, '2022-01-01'),
(1, 1, '2023-07-01'),
(2, 2, '2021-03-01'),
(2, 1, '2022-09-01'),
(3, 2, '2023-06-01'),
(4, 3, '2023-11-01'),
(5, 2, '2020-06-01');

INSERT INTO historico_cargo (id_colaborador, id_cargo, data_inicio)
VALUES
(1, 2, '2020-01-10'),
(2, 1, '2019-05-15'),
(3, 1, '2021-08-01'),
(4, 3, '2022-03-12'),
(5, 4, '2018-11-25'),
(1, 1, '2021-01-01'),
(1, 4, '2023-02-01'),
(2, 4, '2022-01-01'),
(3, 2, '2022-08-01'),
(3, 1, '2023-10-01'),
(5, 3, '2021-05-01');