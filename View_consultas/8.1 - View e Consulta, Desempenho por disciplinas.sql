-- Desempenho de alunos por disciplinas e professores
CREATE VIEW view_desempenho_aluno AS
SELECT
    ds.Periodo_Letivo,
    d.Nome AS nome_disciplina,
    CONCAT(u_aluno.Nome, ' ', u_aluno.Sobrenome) AS nome_aluno,
    CONCAT(u_prof.Nome, ' ', u_prof.Sobrenome) AS nome_professor,
    ds.Nota,
    a.ID_Usuario AS ID_Aluno
FROM Desempenho AS ds
JOIN Aluno a
    ON ds.ID_Aluno = a.ID_Usuario
JOIN Usuario u_aluno
    ON a.ID_Usuario = u_aluno.ID_Usuario
JOIN Disciplina d
    ON ds.ID_Disciplina = d.ID_Disciplina
JOIN Professor_Disciplina pd
    ON ds.ID_Disciplina = pd.ID_Disciplina AND ds.Periodo_Letivo = pd.Periodo_Letivo
JOIN Professor p
    ON pd.ID_Usuario_Professor = p.ID_Usuario
JOIN Usuario u_prof
    ON p.ID_Usuario = u_prof.ID_Usuario;

-- Consulta de desempenho dos alunos por localidade
SELECT
    vd.nome_aluno,
    vd.nome_disciplina, 
    vd.Nota,     
    ue.Cidade
FROM
    view_desempenho_aluno AS vd 
JOIN Local_Usuario AS lu
    ON vd.ID_Aluno = lu.ID_Usuario 
JOIN Unidade_Escola AS ue
    ON lu.ID_Unidade_Escola = ue.ID_Unidade
WHERE
    ue.Cidade = 'São Carlos'
ORDER BY
    vd.nome_aluno, vd.Nota DESC;