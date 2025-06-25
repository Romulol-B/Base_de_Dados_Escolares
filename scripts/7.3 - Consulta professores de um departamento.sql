SELECT DISTINCT
    dep.Nome AS Nome_Departamento,
    u.Nome AS Nome_Professor,
    u.Sobrenome AS Sobrenome_Professor
FROM
    Departamento dep
JOIN Curso c ON dep.ID_Departamento = c.ID_Departamento
JOIN Curso_Disciplina cd ON c.ID_Curso = cd.ID_Curso
JOIN Disciplina d ON cd.ID_Disciplina = d.ID_Disciplina
JOIN Professor_Disciplina pd ON d.ID_Disciplina = pd.ID_Disciplina
JOIN Professor p ON pd.ID_Usuario_Professor = p.ID_Usuario
JOIN Usuario u ON p.ID_Usuario = u.ID_Usuario
WHERE
    dep.Nome = 'Departamento de Ciência da Computação'