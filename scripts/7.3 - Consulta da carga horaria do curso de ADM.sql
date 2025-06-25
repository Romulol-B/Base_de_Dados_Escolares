SELECT
    c.Nome AS Nome_Curso,
    c.Carga_Horaria
FROM
    Curso c
JOIN
    Departamento d ON c.ID_Departamento = d.ID_Departamento
WHERE
    d.Nome = 'Departamento de Administração' and c.Nivel = 'Graduação'
