-- Informações sobre avaliação de professores
CREATE OR REPLACE VIEW view_avaliacao_professores AS
SELECT
    a.ID_Professor, 
    CONCAT(u.Nome, ' ', u.Sobrenome) AS nome_professor,
    d.Nome AS disciplina,
    COUNT(a.ID_Avaliacao) AS total_avaliacoes,
    ROUND(AVG(na.Nota_Didatica), 2) AS media_didatica,
    ROUND(AVG(na.Nota_Material), 2) AS media_material,
    ROUND(AVG(na.Nota_Relevancia), 2) AS media_relevancia,
    ROUND(AVG(na.Nota_Infraestrutura), 2) AS media_infraestrutura
FROM Avaliacao AS a
JOIN Notas_Avaliacao AS na 
    ON a.ID_Avaliacao = na.ID_Avaliacao
JOIN Usuario AS u 
    ON a.ID_Professor = u.ID_Usuario
JOIN Disciplina AS d 
    ON a.ID_Disciplina = d.ID_Disciplina
GROUP BY
    a.ID_Professor, 
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
    d.Material_Didatico,
    v_ava.media_didatica,
    v_ava.total_avaliacoes
FROM
    view_avaliacao_professores AS v_ava
LEFT JOIN Professor AS p 
    ON v_ava.ID_Professor = p.ID_Usuario
LEFT JOIN Disciplina AS d
    ON v_ava.disciplina = d.Nome
ORDER BY
    p.Especializacao,
    v_ava.media_didatica DESC;