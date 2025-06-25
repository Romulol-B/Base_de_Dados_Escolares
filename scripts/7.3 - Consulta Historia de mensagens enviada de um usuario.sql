SELECT
    m.Timestamp_Criacao,
    m.Texto
FROM
    Mensagens m
JOIN
    Usuario u ON m.ID_Remetente = u.ID_Usuario
WHERE
    u.Email = 'alberto.santos@escola.edu'
ORDER BY
    m.Timestamp_Criacao DESC