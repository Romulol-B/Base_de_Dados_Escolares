SELECT
    u.Nome,
    u.Sobrenome,
	d.Nome
FROM
    Usuario u
JOIN
    Aluno a ON u.ID_Usuario = a.ID_Usuario
JOIN
    Matricula m ON a.ID_Usuario = m.ID_Aluno
JOIN
    Disciplina d ON m.ID_Disciplina = d.ID_Disciplina
WHERE
    d.Nome = 'Cálculo I'
    AND m.Periodo_Letivo = '2025.1'