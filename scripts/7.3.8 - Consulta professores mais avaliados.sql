-- 7.3 - Consulta professores mais avaliados.sql
-- Objetivo: Listar os professores com base na média de suas avaliações.

SELECT
    u.Nome,
    u.Sobrenome,
    COUNT(ap.ID_Avaliacao) AS Total_Avaliacoes,
    AVG(ap.NotaDidatica) AS Media_Nota_Didatica
FROM
    AvaliacaoProfessor ap
JOIN
    Professor p ON ap.ID_Usuario = p.ID_Usuario
JOIN
    Usuario u ON p.ID_Usuario = u.ID_Usuario
GROUP BY
    u.ID_Usuario, u.Nome, u.Sobrenome
ORDER BY
    Media_Nota_Didatica DESC;
