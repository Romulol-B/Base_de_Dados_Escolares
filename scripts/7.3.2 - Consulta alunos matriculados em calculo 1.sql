-- ==================================================================================
-- 7.3 - Consulta alunos matriculados em calculo 1.sql
-- Objetivo: Listar todos os alunos matriculados em uma disciplina específica em um determinado período.
-- Correções:
-- 1. O JOIN foi reestruturado para seguir o novo caminho: Usuario -> Aluno -> Matriculas -> Turmas -> Disciplina.
-- 2. A condição de 'PeriodoLetivo' foi movida para a tabela 'Turmas'.
-- ==================================================================================
SELECT
    u.Nome,
    u.Sobrenome,
    d.Nome AS Nome_Disciplina
FROM
    Usuario u
JOIN
    Aluno a ON u.ID_Usuario = a.ID_Usuario
JOIN
    Matriculas m ON a.ID_Usuario = m.ID_Aluno
JOIN
    Turmas t ON m.ID_Turma = t.ID_Turma
JOIN
    Disciplina d ON t.ID_Disciplina = d.ID
WHERE
    d.Nome = 'Cálculo I'
    AND t.PeriodoLetivo = '2025.1';
