-- Informações gerais sobre os cursos
CREATE OR REPLACE VIEW view_detalhes_curso AS
SELECT
    c.ID_Curso,
    dep.ID_Departamento,
    u.ID_Usuario AS ID_Chefe_Departamento,
    c.Nome AS nome_curso,
    c.Nivel AS nivel_curso,
    dep.Nome AS nome_departamento,
    CONCAT(u.Nome, ' ', u.Sobrenome) AS chefe_departamento,
    COUNT(cd.ID_Disciplina) AS quantidade_disciplinas
FROM
    Curso AS c
JOIN Departamento AS dep 
    ON c.ID_Departamento = dep.ID_Departamento
JOIN Curso_Disciplina AS cd 
    ON c.ID_Curso = cd.ID_Curso
LEFT JOIN Chefiar AS ch 
    ON dep.ID_Departamento = ch.ID_Departamento
LEFT JOIN Usuario AS u 
    ON ch.ID_Usuario_Professor = u.ID_Usuario
GROUP BY
    c.ID_Curso,
    dep.ID_Departamento,
    u.ID_Usuario
ORDER BY
    nome_curso;

-- Consulta para retornar o perfil dos cursos
SELECT
    vdc.nome_curso,
    vdc.chefe_departamento,
    p.Titulacao AS titulacao_chefe,
    SUM(d.Aulas_Semanais) AS total_aulas_semanais
FROM
    view_detalhes_curso AS vdc
LEFT JOIN Professor AS p 
    ON vdc.ID_Chefe_Departamento = p.ID_Usuario
JOIN Curso_Disciplina AS cd 
    ON vdc.ID_Curso = cd.ID_Curso
JOIN Disciplina AS d 
    ON cd.ID_Disciplina = d.ID_Disciplina
GROUP BY
    vdc.ID_Curso, 
    vdc.nome_curso, 
    vdc.chefe_departamento, 
    p.Titulacao
ORDER BY
    vdc.nome_curso;