-- Informações sobre avaliação de professores
CREATE OR REPLACE VIEW view_avaliacao_professores AS
SELECT
    ap.ID_Usuario AS ID_Professor,
    CONCAT(u.Nome, ' ', u.Sobrenome) AS nome_professor,
    d.Nome AS disciplina,
    COUNT(ap.ID_Avaliacao) AS total_avaliacoes,
    ROUND(AVG(ap.NotaDidatica), 2) AS media_didatica,
    ROUND(AVG(ad.NotadoMaterial), 2) AS media_material,
    ROUND(AVG(ad.NotaRelevancia), 2) AS media_relevancia,
    ROUND(AVG(ad.NotaInfraestrutura), 2) AS media_infraestrutura
FROM AvaliacaoProfessor AS ap
JOIN Avaliacao AS a ON ap.ID_Avaliacao = a.ID_Avaliacao
JOIN AvaliacaoDisciplina AS ad ON a.ID_Avaliacao = ad.ID_Avaliacao
JOIN Disciplina AS d ON ad.ID_Disciplina = d.ID
JOIN Usuario AS u ON ap.ID_Usuario = u.ID_Usuario
GROUP BY
    ap.ID_Usuario,
    u.Nome,
    u.Sobrenome,
    d.Nome
ORDER BY
    nome_professor,
    disciplina;


-- Consulta de avaliação por especialização do professor e material didático
SELECT
    v_ava.nome_professor,
    p.Especializacao,
    v_ava.disciplina,
    d.MaterialDidatica,
    v_ava.media_didatica,
    v_ava.total_avaliacoes
FROM view_avaliacao_professores AS v_ava
LEFT JOIN Professor AS p ON v_ava.ID_Professor = p.ID_Usuario
LEFT JOIN Disciplina AS d ON v_ava.disciplina = d.Nome
ORDER BY
    p.Especializacao,
    v_ava.media_didatica DESC;


    
