-- ==================================================================================
-- 7.3 - Consulta alunos matriculado.sql 
-- Objetivo Real: Listar os cursos que NÃO TIVERAM matrículas em um período letivo.
-- Correções:
-- 1. A subconsulta foi ajustada para navegar pela nova estrutura de tabelas: Matriculas -> Turmas -> Disciplina -> Disciplina_Curso.
-- 2. Nomes de colunas e tabelas atualizados.
-- ==================================================================================
SELECT
    c.Nome_Curso,
    c.NivelEnsino
FROM
    Curso c
WHERE NOT EXISTS (
    SELECT 1
    FROM
        Matriculas m
    JOIN
        Turmas t ON m.ID_Turma = t.ID_Turma
    JOIN
        Disciplina_Curso dc ON t.ID_Disciplina = dc.ID_Disciplina
    WHERE
        dc.ID_Curso = c.ID AND t.PeriodoLetivo = '2025.2'
)
ORDER BY
    c.Nome_Curso;
