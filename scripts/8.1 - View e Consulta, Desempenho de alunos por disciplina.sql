-- Desempenho de alunos por disciplinas e professores
CREATE VIEW view_desempenho_aluno AS
SELECT
    t.PeriodoLetivo,
    d.Nome AS nome_disciplina,
    CONCAT(u_aluno.Nome, ' ', u_aluno.Sobrenome) AS nome_aluno,
    CONCAT(u_prof.Nome, ' ', u_prof.Sobrenome) AS nome_professor,
    m.Nota,
    a.ID_Usuario AS ID_Aluno
FROM Matriculas m
JOIN Aluno a ON m.ID_Aluno = a.ID_Usuario
JOIN Usuario u_aluno ON a.ID_Usuario = u_aluno.ID_Usuario
JOIN Turmas t ON m.ID_Turma = t.ID_Turma
JOIN Disciplina d ON t.ID_Disciplina = d.ID
JOIN Curso c ON c.ID_Departamento = (
    SELECT p.ID_Departamento
    FROM Professor p
    WHERE p.ID_Usuario = (
        SELECT ID_Usuario
        FROM Professor
        LIMIT 1 
    )
) 
JOIN Professor p ON c.ID_Departamento = p.ID_Departamento
JOIN Usuario u_prof ON p.ID_Usuario = u_prof.ID_Usuario;


-- Consulta de desempenho dos alunos por localidade
SELECT
    vd.nome_aluno,
    vd.nome_disciplina, 
    vd.Nota,     
    ue.Cidade
FROM view_desempenho_aluno AS vd
JOIN Usuario u ON vd.ID_Aluno = u.ID_Usuario
JOIN UnidadeEscola ue ON u.ID_UnidadeEscolar = ue.ID
WHERE ue.Cidade = 'São Carlos'
ORDER BY vd.nome_aluno, vd.Nota DESC;



