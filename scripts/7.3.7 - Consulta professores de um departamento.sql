-- ==================================================================================
-- 7.3 - Consulta professores de um departamento.sql
-- Objetivo: Listar os professores de um departamento específico.
-- Correções:
-- 1. A consulta original era impossível de ser executada no novo esquema, pois não há uma tabela ligando professores a disciplinas.
-- 2. A consulta foi simplificada para responder à pergunta de forma direta, usando a relação que existe: listar todos os professores que pertencem a um departamento.
-- ==================================================================================
SELECT
    dep.Nome AS Nome_Departamento,
    u.Nome AS Nome_Professor,
    u.Sobrenome AS Sobrenome_Professor
FROM
    Departamento dep
JOIN
    Professor p ON dep.ID = p.ID_Departamento
JOIN
    Usuario u ON p.ID_Usuario = u.ID_Usuario
WHERE
    dep.Nome = 'Departamento de Ciência da Computação';
