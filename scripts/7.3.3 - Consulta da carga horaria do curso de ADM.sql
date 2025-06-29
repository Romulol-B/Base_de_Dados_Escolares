-- ==================================================================================
-- 7.3 - Consulta da carga horaria do curso de ADM.sql
-- Objetivo: Consultar a carga horária total de um curso específico.
-- Correções:
-- 1. Trocado 'c.Nome' por 'c.Nome_Curso'.
-- 2. Trocado 'c.Carga_Horaria' por 'c.CargaHorariaTotal'.
-- 3. Trocado 'c.Nivel' por 'c.NivelEnsino'.
-- ==================================================================================
SELECT
    c.Nome_Curso,
    c.CargaHorariaTotal
FROM
    Curso c
JOIN
    Departamento d ON c.ID_Departamento = d.ID
WHERE
    d.Nome = 'Departamento de Administração' AND c.NivelEnsino = 'Graduação';
