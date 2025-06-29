-- Informações gerais sobre os cursos
CREATE OR REPLACE VIEW view_detalhes_curso AS
SELECT
    c.ID AS ID_Curso,
    dep.ID AS ID_Departamento,
    u.ID_Usuario AS ID_Chefe_Departamento,
    c.Nome_Curso AS nome_curso,
    c.NivelEnsino AS nivel_curso,
    dep.Nome AS nome_departamento,
    CONCAT(u.Nome, ' ', u.Sobrenome) AS chefe_departamento,
    COUNT(dc.ID_Disciplina) AS quantidade_disciplinas
FROM Curso AS c
JOIN Departamento AS dep ON c.ID_Departamento = dep.ID
JOIN Disciplina_Curso AS dc ON c.ID = dc.ID_Curso
LEFT JOIN Professor AS p ON p.ID_Departamento = dep.ID
LEFT JOIN Usuario AS u ON u.ID_Usuario = p.ID_Usuario
GROUP BY
    c.ID, dep.ID, u.ID_Usuario
ORDER BY
    nome_curso;


-- Consulta para retornar o perfil dos cursos
SELECT
    vdc.nome_curso,
    vdc.chefe_departamento,
    p.Titulacao AS titulacao_chefe,
    SUM(d.QtdAulasSemanais) AS total_aulas_semanais
FROM view_detalhes_curso AS vdc
LEFT JOIN Professor AS p ON vdc.ID_Chefe_Departamento = p.ID_Usuario
JOIN Disciplina_Curso AS dc ON vdc.ID_Curso = dc.ID_Curso
JOIN Disciplina AS d ON dc.ID_Disciplina = d.ID
GROUP BY
    vdc.ID_Curso,
    vdc.nome_curso,
    vdc.chefe_departamento,
    p.Titulacao
ORDER BY
    vdc.nome_curso;
