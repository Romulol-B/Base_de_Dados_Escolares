CREATE INDEX idx_mensagens_texto ON Mensagens
USING GIN(to_tsvector('portuguese', Texto));

COMMENT ON INDEX idx_usuario_email IS
 'Criação de mecanismo para buscar o conteúdo textual das mensagens'
