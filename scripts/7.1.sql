CREATE INDEX idx_usuario_email ON Usuario(Email);

COMMENT ON INDEX idx_usuario_email IS
  'Índice B-tree sobre a coluna Email, uma busca comum de ser feita, em especial para questões de login';
