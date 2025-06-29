-- 7.3 - Consulta Historia de mensagens enviada de um usuario.sql
-- Objetivo: Listar o histórico de mensagens enviadas por um usuário.

SELECT
    m.TimeStamp,
    m.Texto
FROM
    Mensagem m -- Usando a tabela 'Mensagem' assumida
JOIN
    Usuario u ON m.ID_Remetente = u.ID_Usuario
WHERE
    u.Email = 'alberto.santos@escola.edu'
ORDER BY
    m.TimeStamp DESC;
