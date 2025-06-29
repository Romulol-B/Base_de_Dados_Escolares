-- 7.3 - Consulta média geral de um aluno.sql
-- Objetivo: Calcular a média geral das notas de um aluno específico.

SELECT
    u.Nome,
    u.Sobrenome,
    AVG(m.Nota) AS Media_Geral
FROM
    Usuario u
JOIN
    Aluno a ON u.ID_Usuario = a.ID_Usuario
JOIN
    Matriculas m ON a.ID_Usuario = m.ID_Aluno
WHERE
    u.ID_Usuario = 42
GROUP BY
    u.ID_Usuario, u.Nome, u.Sobrenome;
