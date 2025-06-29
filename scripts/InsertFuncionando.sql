/* ==========================================================
   CARGA DE DADOS (≈ 100 000+)  —   COMPATÍVEL COM O ESQUEMA FORNECIDO
   Revisão: 2025-06-27 (Rev-2)
   ========================================================== */
SET client_encoding = 'UTF8';
SET timezone = 'America/Sao_Paulo';

/* ———— Desativa validações pesadas para insert massivo ———— */
SET session_replication_role = replica;

/* ----------------------------------------------------------
   1. UNIDADES ESCOLARES (10)
   ---------------------------------------------------------- */
INSERT INTO UnidadeEscola (Estado,Cidade,Pais,Bloco) VALUES
 ('São Paulo','São Carlos','Brasil','EESC - Área 1'),
 ('São Paulo','São Carlos','Brasil','EESC - Área 2'),
 ('São Paulo','São Carlos','Brasil','ICMC'),
 ('São Paulo','São Carlos','Brasil','IFSC'),
 ('São Paulo','São Carlos','Brasil','IQSC'),
 ('São Paulo','São Carlos','Brasil','IAU'),
 ('São Paulo','São Carlos','Brasil','Campus Central'),
 ('São Paulo','São Carlos','Brasil','Campus Norte'),
 ('São Paulo','São Carlos','Brasil','Campus Sul'),
 ('São Paulo','São Carlos','Brasil','Reitoria');

/* ----------------------------------------------------------
   2. DEPARTAMENTOS (25)
   ---------------------------------------------------------- */
INSERT INTO Departamento (Nome) VALUES
 ('Engenharia Aeronáutica'), ('Engenharia Civil'),
 ('Engenharia de Estruturas'), ('Engenharia de Materiais'),
 ('Engenharia de Transportes'), ('Engenharia Elétrica e de Computação'),
 ('Engenharia Hidráulica e Saneamento'), ('Engenharia Mecânica'),
 ('Engenharia de Produção'), ('Ciências de Computação'),
 ('Matemática'), ('Matemática Aplicada e Estatística'),
 ('Sistemas de Computação'), ('Física'), ('Física Aplicada'),
 ('Química'), ('Físico-Química'), ('Química Analítica'),
 ('Arquitetura e Urbanismo'), ('Geotecnia'),
 ('Ciências Biomédicas'), ('Bioengenharia'),
 ('Economia'), ('Administração'), ('Engenharia Ambiental');

/* ----------------------------------------------------------
   3. CURSOS (≈ 50)
   ---------------------------------------------------------- */
WITH base AS (
  SELECT * FROM (VALUES
   ('Engenharia Aeronáutica','Graduação',50,3600),
   ('Engenharia Civil','Graduação',60,3600),
   ('Engenharia de Materiais','Graduação',40,3600),
   ('Engenharia de Transportes','Graduação',35,3600),
   ('Engenharia Elétrica','Graduação',50,3600),
   ('Engenharia Mecânica','Graduação',50,3600),
   ('Engenharia de Produção','Graduação',45,3600),
   ('Ciências da Computação','Graduação',85,2400),
   ('Matemática','Graduação',40,2400),
   ('Estatística','Graduação',30,2400),
   ('Física','Graduação',50,2880),
   ('Química','Graduação',40,2880),
   ('Arquitetura e Urbanismo','Graduação',45,3600),
   ('Engenharia Ambiental','Graduação',40,3600),
   ('Engenharia de Software','Graduação',30,2400),
   ('Biotecnologia','Graduação',25,3200),
   ('Especialização em Estruturas','Especialização',30,360),
   ('MBA em Gestão de Projetos','MBA',40,480),
   ('Tecnólogo em Sistemas de Informação','Tecnólogo',50,2000),
   ('Mestrado em Ciências da Computação','Pós-Graduação',40,1440)
 ) AS t(nome,nivel,vagas,carga)
)
INSERT INTO Curso
      (Nome_Curso,NivelEnsino,NumeroVagas,Ementa,CargaHorariaTotal,
       ID_UnidadeEscolar,ID_Departamento)
SELECT nome,
       nivel,
       vagas,
       'Curso de '||nome||' – formação de excelência.',
       carga,
       floor(random()*10 + 1)::int,
       floor(random()*25 + 1)::int
FROM base;

/* ----------------------------------------------------------
   4. DISCIPLINAS (≈ 200)
   ---------------------------------------------------------- */
WITH nomes AS (
 SELECT unnest(ARRAY[
   'Cálculo I','Cálculo II','Álgebra Linear','Física I','Física II',
   'Química Geral','Programação I','Programação II','Estruturas de Dados',
   'Banco de Dados','Engenharia de Software','Sistemas Operacionais',
   'Redes de Computadores','Inteligência Artificial','Compiladores',
   'Algoritmos Avançados','Resistência dos Materiais','Hidráulica',
   'Saneamento','Topografia','Controle','Eletrônica','Circuitos Elétricos',
   'Aerodinâmica','Propulsão','Logística','Gestão de Projetos','Probabilidade',
   'Estatística','Métodos Numéricos','Projeto Integrador','Ética Profissional',
   'Comunicação','Metodologia Científica','TCC I','TCC II',
   'Laboratório de Física','Laboratório de Química','Laboratório de Computação',
   'Termodinâmica','Mecânica dos Fluidos','Transferência de Calor',
   'Processos de Fabricação','Nanotecnologia','Materiais Compósitos',
   'Machine Learning','Data Science','Cloud Computing','Blockchain',
   'Internet das Coisas','Big Data','Bioengenharia','Química Orgânica',
   'Química Analítica','Mecânica Quântica','Relatividade','Pesquisa Operacional',
   'Otimização','Análise Numérica','Equações Diferenciais','Genética',
   'Microbiologia','Bioquímica','Engenharia Clínica','Biomecânica',
   'Reatores Químicos','Catálise','Destilação','Operações Logísticas',
   'Computação Gráfica','Jogos Digitais','Interface Humano-Computador',
   'Arquitetura de Software','Desenvolvimento Web','Sistemas Distribuídos',
   'Eletrônica de Potência'
 ]) AS nome
)
INSERT INTO Disciplina
      (Nome,CapacidadeSala,QtdAulasSemanais,MaterialDidatica,ID_UnidadeEscolar)
SELECT nome,
       floor(random()*70 + 30)::int,
       floor(random()*3 + 2)::int,
       'Conteúdo teórico-prático com apoio de livros e vídeos.',
       floor(random()*10 + 1)::int
FROM nomes;

/* ----------------------------------------------------------
   5. TURMAS (4 períodos por disciplina)
   ---------------------------------------------------------- */
INSERT INTO Turmas (ID_Disciplina,PeriodoLetivo)
SELECT d.id, p.periodo
FROM Disciplina d,
     (VALUES('2024-1'),('2024-2'),('2025-1'),('2025-2')) AS p(periodo);

/* ----------------------------------------------------------
   6. USUÁRIOS (100 000) + perfis
   ---------------------------------------------------------- */
WITH g AS (
  SELECT gs                                     AS idx,
         CASE WHEN gs<=3000  THEN 'Prof'||gs
              WHEN gs<=5000  THEN 'Func'||gs
              ELSE 'Aluno'||gs END             AS nome,
         CASE WHEN gs<=3000  THEN 'Professor'
              WHEN gs<=5000  THEN 'Funcionario'
              ELSE 'Aluno' END                 AS tipo
  FROM generate_series(1,100000) gs
)
INSERT INTO Usuario
      (Nome,Sobrenome,Sexo,Telefone,Email,Senha,
       Data_Nascimento,ID_UnidadeEscolar)
SELECT g.nome,
       'USP',
       (ARRAY['Masculino','Feminino'])[floor(random()*2)+1],
       '(16)9'||lpad( (floor(random()*90000000)+10000000)::text ,8,'0'),
       lower(g.nome)||'@usp.br',
       md5('senha'||g.idx),
       CURRENT_DATE - ((floor(random()*10000)::int) + 6570),  -- CORRIGIDO
       floor(random()*10 + 1)::int
FROM g;

/* ---- 6.1 PROFESSORES (1-3000) ---- */
INSERT INTO Professor
      (ID_Usuario,Especializacao,Titulacao,ID_Departamento)
SELECT u.ID_Usuario,
       'Área '||floor(random()*20+1),
       (ARRAY['Doutor','Mestre','Pós-Doutor','Livre-Docente','Titular'])
       [floor(random()*5)+1],
       floor(random()*25 + 1)::int
FROM Usuario u
WHERE u.ID_Usuario<=3000;

/* ---- 6.2 FUNCIONÁRIOS (3001-5000) ---- */
INSERT INTO Funcionario (ID_Usuario)
SELECT ID_Usuario FROM Usuario WHERE ID_Usuario BETWEEN 3001 AND 5000;

/* ---- 6.3 ALUNOS (5001-100000) ---- */
INSERT INTO Aluno (ID_Usuario)
SELECT ID_Usuario FROM Usuario WHERE ID_Usuario>5000;

/* ----------------------------------------------------------
   7. MATRÍCULAS  (~ 285 000)  —  sem colisões
   ---------------------------------------------------------- */
WITH alunos AS (
  SELECT ID_Usuario AS id_aluno FROM Aluno
)
INSERT INTO Matriculas
       (ID_Aluno,ID_Turma,BolsaEstudos,StatusMatricula,
        Nota,DataMatricula,DataLimite)
SELECT  a.id_aluno,
        t.ID_Turma,
        CASE WHEN random()<0.10 THEN 'Integral'
             WHEN random()<0.20 THEN 'Parcial' END,
        (ARRAY['Ativa','Concluída','Trancada'])[floor(random()*3)+1],
        (random()*10)::numeric(4,2),
        CURRENT_DATE - (floor(random()*400))::int,            -- CORRIGIDO
        CURRENT_DATE + 120
FROM alunos a
CROSS JOIN LATERAL (
     /* 1-3 turmas distintas por aluno */
     SELECT ID_Turma
     FROM   Turmas
     ORDER  BY random()
     LIMIT  floor(random()*3 + 1)
) t
ON CONFLICT (ID_Aluno,ID_Turma) DO NOTHING;

/* ----------------------------------------------------------
   8. DISCIPLINA × CURSO (1-3 cursos por disciplina)
   ---------------------------------------------------------- */
INSERT INTO Disciplina_Curso (ID_Disciplina,ID_Curso)
SELECT d.ID, c.ID
FROM Disciplina d
CROSS JOIN LATERAL (
  SELECT ID
  FROM   Curso
  ORDER  BY random()
  LIMIT  floor(random()*3 + 1)
) c;

/* ----------------------------------------------------------
   9. USUARIO_MENSAGENS (demo 1-1000)
   ---------------------------------------------------------- */
INSERT INTO Usuario_Mensagens (ID_Mensagem,ID_Usuario)
SELECT gs, gs FROM generate_series(1,1000) gs;

/* ----------------------------------------------------------
   10. AVALIAÇÕES (Disciplina + Professor)
   ---------------------------------------------------------- */
-- 10.1 Avaliação de disciplinas (10 000)
WITH aval AS (
  INSERT INTO Avaliacao (Texto,TimeStamp,ID_Aluno)
  SELECT 'Avaliação automática '||gs,
         CURRENT_TIMESTAMP - (gs||' hours')::interval,
         (SELECT ID_Usuario FROM Aluno ORDER BY random() LIMIT 1)
  FROM generate_series(1,10000) gs
  RETURNING ID_Avaliacao
)
INSERT INTO AvaliacaoDisciplina
       (ID_Avaliacao,NotaInfraestrutura,NotaRelevancia,NotadoMaterial,ID_Disciplina)
SELECT a.ID_Avaliacao,
       (random()*10)::numeric(3,1),
       (random()*10)::numeric(3,1),
       (random()*10)::numeric(3,1),
       (SELECT ID FROM Disciplina ORDER BY random() LIMIT 1)
FROM aval a;

-- 10.2 Avaliação de professores (5 000)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM Professor) THEN
     RAISE EXCEPTION 'Professor vazio – verifique bloco 6.1';
  END IF;
END$$;

WITH avalp AS (
  INSERT INTO Avaliacao (Texto,TimeStamp,ID_Aluno)
  SELECT 'Feedback docente '||gs,
         CURRENT_TIMESTAMP - (gs||' hours')::interval,
         (SELECT ID_Usuario FROM Aluno ORDER BY random() LIMIT 1)
  FROM generate_series(10001,15000) gs
  RETURNING ID_Avaliacao
)
INSERT INTO AvaliacaoProfessor
       (ID_Avaliacao,NotaDidatica,ID_Usuario)
SELECT a.ID_Avaliacao,
       (random()*10)::numeric(3,1),
       p.ID_Usuario
FROM avalp a
CROSS JOIN LATERAL (
  SELECT ID_Usuario
  FROM   Professor
  ORDER  BY random()
  LIMIT  1
) p;

/* ----------------------------------------------------------
   11. REGRAS / INFRA / MATERIAL (1-1)
   ---------------------------------------------------------- */
INSERT INTO Regras_Curso (ID_Curso,Regras)
SELECT ID,'Frequência mínima 75 % + nota ≥ 5,0' FROM Curso;

INSERT INTO Infra_Curso (ID_Curso,Infraestrutura)
SELECT ID,'Salas equipadas com projetor e ar-condicionado' FROM Curso;

INSERT INTO Material_Disciplina (ID_Disciplina,MaterialDidatico)
SELECT ID,'Lista de livros recomendados + artigos científicos' FROM Disciplina;

/* ———— Restaura validações ———— */
SET session_replication_role = DEFAULT;

/* ----------------------------------------------------------
   Resumo final
   ---------------------------------------------------------- */
SELECT 'Carga concluída: '||
       (SELECT to_char(count(*),'FM999,999,999') FROM Usuario)||' usuários, '||
       (SELECT to_char(count(*),'FM999,999,999') FROM Matriculas)||' matrículas.' AS resumo;
