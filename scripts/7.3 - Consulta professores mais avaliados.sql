SELECT
    u.Nome,
    u.Sobrenome,
    COUNT(a.ID_Avaliacao) AS Total_Avaliacoes,
    AVG((na.Nota_Didatica + na.Nota_Material + na.Nota_Relevancia + na.Nota_Infraestrutura) / 4.0) AS Media_Geral_Avaliacao
FROM
    Avaliacao a
JOIN
    Notas_Avaliacao na ON a.ID_Avaliacao = na.ID_Avaliacao
JOIN
    Professor p ON a.ID_Professor = p.ID_Usuario
JOIN
    Usuario u ON p.ID_Usuario = u.ID_Usuario
GROUP BY
    u.ID_Usuario, u.Nome, u.Sobrenome
ORDER BY
    Media_Geral_Avaliacao DESC