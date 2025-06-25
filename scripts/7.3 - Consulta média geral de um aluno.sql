SELECT
    u.Nome,
    u.Sobrenome,
    AVG(d.Nota) AS Media_Geral
FROM
    Usuario u
JOIN
    Aluno a ON u.ID_Usuario = a.ID_Usuario
JOIN
    Desempenho d ON a.ID_Usuario = d.ID_Aluno
WHERE
    u.ID_Usuario = 42 
GROUP BY
    u.ID_Usuario, u.Nome, u.Sobrenome;