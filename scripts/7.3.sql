CREATE INDEX idx_desempenho ON Desempenho(ID_Aluno) WHERE Nota > 4.9;

COMMENT ON INDEX idx_desempenho IS
  'Uma busca para verificar quais alunos foram aprovados de forma mais rápida';
