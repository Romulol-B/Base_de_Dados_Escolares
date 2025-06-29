-- 7.3 - Consulta professores de um departamento.sql
-- Objetivo: Listar os professores de um departamento específico.

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
