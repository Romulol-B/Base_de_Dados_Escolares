-- 7.3 - Consulta da quantidade de alunos matriculado por curso.sql
-- Objetivo: Contar quantos alunos estão matriculados em cada curso.

    c.Nome_Curso,
    c.NivelEnsino,
    COUNT(DISTINCT m.ID_Aluno) AS Total_Alunos_Matriculados -- Usando DISTINCT para não contar o mesmo aluno várias vezes no mesmo curso.
FROM
    Curso c
JOIN
    Disciplina_Curso dc ON c.ID = dc.ID_Curso
JOIN
    Disciplina d ON dc.ID_Disciplina = d.ID
JOIN
    Turmas t ON d.ID = t.ID_Disciplina
JOIN
    Matriculas m ON t.ID_Turma = m.ID_Turma
GROUP BY
    c.ID, c.Nome_Curso, c.NivelEnsino
ORDER BY
    Total_Alunos_Matriculados DESC;
