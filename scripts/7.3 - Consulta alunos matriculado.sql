SELECT
    c.Nome as Curso,
    c.Nivel
FROM
    Curso c
WHERE NOT EXISTS (
    SELECT 1
    FROM Matricula m
    JOIN Curso_Disciplina cd ON m.ID_Disciplina = cd.ID_Disciplina
    WHERE cd.ID_Curso = c.ID_Curso AND m.Periodo_Letivo = '2025.2'
)
ORDER BY
    c.Nome