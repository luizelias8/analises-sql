USE rh;

-- Colaboradores que mudaram de cargo mais de uma vez
SELECT id_colaborador, COUNT(*) AS mudancas_de_cargo
FROM historico_cargo
GROUP BY id_colaborador
HAVING COUNT(*) > 1;

-- Salário atual de cada colaborador
SELECT c.nome, hs.salario
FROM colaborador c
JOIN historico_salario hs ON hs.id_colaborador = c.id
WHERE hs.data_inicio = (
	SELECT MAX(data_inicio) 
    FROM historico_salario 
    WHERE id_colaborador = c.id
);

-- Departamentos com mais colaboradores atualmente
SELECT d.nome AS departamento, COUNT(hd.id_colaborador) AS total_colaboradores
FROM departamento d
JOIN historico_departamento hd ON hd.id_departamento = d.id
WHERE hd.data_inicio = (
	SELECT MAX(data_inicio) 
    FROM historico_departamento 
    WHERE id_colaborador = hd.id_colaborador
)
GROUP BY d.nome
ORDER BY total_colaboradores DESC;

-- Número total de promoções realizadas por colaborador
SELECT id_colaborador, COUNT(*) - 1 AS numero_promocoes
FROM historico_cargo
GROUP BY id_colaborador
HAVING COUNT(*) > 1;

-- Colaboradores que já trabalharam em mais de um departamento
SELECT id_colaborador, COUNT(DISTINCT id_departamento) AS departamentos_distintos
FROM historico_departamento
GROUP BY id_colaborador
HAVING COUNT(DISTINCT id_departamento) > 1;

-- Média salarial dos colaboradores por cargo atual
SELECT c.nome AS cargo, AVG(hs.salario) AS media_salarial
FROM cargo c
JOIN historico_cargo hc ON hc.id_cargo = c.id
JOIN historico_salario hs ON hs.id_colaborador = hc.id_colaborador
WHERE hc.data_inicio = (
	SELECT MAX(data_inicio)
    FROM historico_cargo
    WHERE id_colaborador = hc.id_colaborador
)
AND hs.data_inicio = (
	SELECT MAX(data_inicio)
    FROM historico_salario
    WHERE id_colaborador = hs.id_colaborador
)
GROUP BY c.nome;

-- Colaborador com mais tempo de empresa (considerando data de admissão)
SELECT nome, DATEDIFF(CURDATE(), data_admissao) AS dias_na_empresa
FROM colaborador
ORDER BY dias_na_empresa DESC
LIMIT 1;

-- Salário atual de cada colaborador
WITH ultimo_salario AS (
	SELECT id_colaborador, 
		salario, 
		data_inicio, 
		ROW_NUMBER() OVER (
			PARTITION BY id_colaborador 
			ORDER BY data_inicio DESC
		) AS ordem
	FROM historico_salario
)
SELECT c.nome, us.salario
FROM colaborador c
JOIN ultimo_salario us ON us.id_colaborador = c.id
WHERE us.ordem = 1;

SELECT c.nome, 
	hs.salario,
    CASE
		WHEN hs.salario < (SELECT AVG(salario) FROM historico_salario) THEN 'Abaixo da média'
        WHEN hs.salario = (SELECT AVG(salario) FROM historico_salario) THEN 'Na média'
        ELSE 'Acima da média'
    END AS categoria_salario
FROM colaborador c
JOIN historico_salario hs ON hs.id_colaborador = c.id
AND hs.data_inicio = (
	SELECT MAX(data_inicio)
    FROM historico_salario
    WHERE id_colaborador = hs.id_colaborador
);

CREATE OR REPLACE VIEW vw_colaboradores_info AS
SELECT c.nome AS nome_colaborador, 
	ca.nome AS cargo_atual, 
    d.nome AS departamento_atual, 
    hs.salario AS salario_atual
FROM colaborador c
JOIN historico_cargo hc ON hc.id_colaborador = c.id
JOIN cargo ca ON ca.id = hc.id_cargo
JOIN historico_departamento hd ON hd.id_colaborador = c.id
JOIN departamento d ON d.id = hd.id_departamento
JOIN historico_salario hs ON hs.id_colaborador = c.id
WHERE hc.data_inicio = (
	SELECT MAX(data_inicio)
    FROM historico_cargo
    WHERE id_colaborador = hc.id_colaborador
)
AND hd.data_inicio = (
	SELECT MAX(data_inicio)
    FROM historico_departamento
    WHERE id_colaborador = hd.id_colaborador
)
AND hs.data_inicio = (
	SELECT MAX(data_inicio)
    FROM historico_salario
    WHERE id_colaborador = hs.id_colaborador
);

SELECT * FROM vw_colaboradores_info;

DROP PROCEDURE IF EXISTS obter_informacoes_colaborador;

DELIMITER //
CREATE PROCEDURE obter_informacoes_colaborador (
	IN p_id_colaborador INT,
    IN p_data DATE
)
BEGIN
	DECLARE v_nome VARCHAR(100);
    DECLARE v_cargo VARCHAR(100);
    DECLARE v_departamento VARCHAR(100);
    DECLARE v_salario DECIMAL(10,2);
    
    -- Obter o nome do colaborador
    SELECT nome 
    INTO v_nome 
    FROM colaborador 
    WHERE id = p_id_colaborador;
    
    -- Obter o cargo do colaborador na data especificada
    SELECT c.nome 
    INTO v_cargo
	FROM historico_cargo hc
	JOIN cargo c ON hc.id_cargo = c.id
	WHERE hc.id_colaborador = p_id_colaborador 
	AND hc.data_inicio <= p_data
	ORDER BY hc.data_inicio DESC
	LIMIT 1;
    
    -- Obter o departamento do colaborador na data especificada
	SELECT d.nome
    INTO v_departamento
	FROM historico_departamento hd
	JOIN departamento d ON d.id = hd.id_departamento
	WHERE hd.id_colaborador = p_id_colaborador 
    AND hd.data_inicio <= p_data
	ORDER BY hd.data_inicio DESC
	LIMIT 1;
    
    -- Obter o salário do colaborador na data especificada
    SELECT salario
    INTO v_salario
	FROM historico_salario hs
	WHERE hs.id_colaborador = p_id_colaborador AND hs.data_inicio <= p_data
	ORDER BY hs.data_inicio DESC
	LIMIT 1;
    
    -- Retornar os resultados
    SELECT v_nome AS nome, v_cargo AS cargo, v_departamento AS departamento, v_salario AS salario;
END //
DELIMITER ;

CALL obter_informacoes_colaborador(1, '2022-01-01');