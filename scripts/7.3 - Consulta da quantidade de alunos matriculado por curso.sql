SELECT
    c.Nome AS Nome_Curso,
    c.Nivel,
    COUNT(m.ID_Aluno) AS Total_Matriculas
FROM
    Curso c
JOIN
    Curso_Disciplina cd ON c.ID_Curso = cd.ID_Curso
JOIN
    Matricula m ON cd.ID_Disciplina = m.ID_Disciplina
GROUP BY
    c.ID_Curso, c.Nome, c.Nivel
ORDER BY
    Total_Matriculas DESC;