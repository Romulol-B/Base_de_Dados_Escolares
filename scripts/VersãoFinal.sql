CREATE TABLE UnidadeEscola (
    ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Estado VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
    Pais VARCHAR(100) NOT NULL DEFAULT 'Brasil',
    Bloco VARCHAR(50)
);

CREATE TABLE Departamento (
    ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Nome VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE Usuario (
    ID_Usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100) NOT NULL,
    Sexo VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Senha VARCHAR(100) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    ID_UnidadeEscolar INT NOT NULL,
    ID_Mensagem INT,
    CONSTRAINT fk_usuario_unidade FOREIGN KEY (ID_UnidadeEscolar) REFERENCES UnidadeEscola(ID),
    CONSTRAINT unique_nome_sobrenome_telefone UNIQUE (Nome, Sobrenome, Telefone)
);

CREATE TABLE Professor (
    ID_Usuario INT PRIMARY KEY,
    Especializacao VARCHAR(200) NOT NULL,
    Titulacao VARCHAR(100) NOT NULL,
    ID_Departamento INT NOT NULL,
    CONSTRAINT fk_professor_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE,
    CONSTRAINT fk_professor_departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID)
);

CREATE TABLE Aluno (
    ID_Usuario INT PRIMARY KEY,
    CONSTRAINT fk_aluno_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Funcionario (
    ID_Usuario INT PRIMARY KEY,
    CONSTRAINT fk_funcionario_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Curso (
    ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Nome_Curso VARCHAR(200) NOT NULL UNIQUE,
    NivelEnsino VARCHAR(100) NOT NULL,
    NumeroVagas INT NOT NULL CHECK (NumeroVagas > 0),
    Ementa TEXT,
    CargaHorariaTotal INT NOT NULL CHECK (CargaHorariaTotal > 0),
    ID_UnidadeEscolar INT NOT NULL,
    ID_Departamento INT NOT NULL,
    CONSTRAINT fk_curso_unidade FOREIGN KEY (ID_UnidadeEscolar) REFERENCES UnidadeEscola(ID),
    CONSTRAINT fk_curso_departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID)
);

CREATE TABLE Disciplina (
    ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Nome VARCHAR(200) NOT NULL,
    CapacidadeSala INT NOT NULL CHECK (CapacidadeSala > 0),
    QtdAulasSemanais INT NOT NULL CHECK (QtdAulasSemanais > 0),
    MaterialDidatica TEXT,
    ID_UnidadeEscolar INT NOT NULL,
    CONSTRAINT fk_disciplina_unidade FOREIGN KEY (ID_UnidadeEscolar) REFERENCES UnidadeEscola(ID)
);

CREATE TABLE Turmas (
    ID_Turma INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ID_Disciplina INT NOT NULL,
    PeriodoLetivo VARCHAR(20) NOT NULL,
    CONSTRAINT fk_turmas_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID)
);

CREATE TABLE Matriculas (
    ID_Aluno INT NOT NULL,
    ID_Turma INT NOT NULL,
    BolsaEstudos VARCHAR(100),
    StatusMatricula VARCHAR(100) NOT NULL,
    Nota NUMERIC(4,2) CHECK (Nota >= 0 AND Nota <= 10),
    DataMatricula DATE NOT NULL,
    DataLimite DATE NOT NULL,
    PRIMARY KEY (ID_Aluno, ID_Turma),
    CONSTRAINT fk_matriculas_aluno FOREIGN KEY (ID_Aluno) REFERENCES Aluno(ID_Usuario),
    CONSTRAINT fk_matriculas_turma FOREIGN KEY (ID_Turma) REFERENCES Turmas(ID_Turma)
);

CREATE TABLE Disciplina_Curso (
    ID_Disciplina INT NOT NULL,
    ID_Curso INT NOT NULL,
    PRIMARY KEY (ID_Disciplina, ID_Curso),
    CONSTRAINT fk_disccurso_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID),
    CONSTRAINT fk_disccurso_curso FOREIGN KEY (ID_Curso) REFERENCES Curso(ID)
);

CREATE TABLE Usuario_Mensagens (
    ID_Mensagem INT NOT NULL,
    ID_Usuario INT NOT NULL,
    PRIMARY KEY (ID_Mensagem, ID_Usuario),
    CONSTRAINT fk_usuariomensagens_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

CREATE TABLE Avaliacao (
    ID_Avaliacao INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Texto TEXT,
    TimeStamp TIMESTAMP WITHOUT TIME ZONE,
    ID_Aluno INT NOT NULL,
    CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (ID_Aluno) REFERENCES Aluno(ID_Usuario)
);

CREATE TABLE AvaliacaoProfessor (
    ID_Avaliacao INT NOT NULL,
    NotaDidatica NUMERIC(3,1) NOT NULL CHECK (NotaDidatica >= 0 AND NotaDidatica <= 10),
    ID_Usuario INT NOT NULL,
    PRIMARY KEY (ID_Avaliacao, ID_Usuario),
    CONSTRAINT fk_avaliacaoprof_avaliacao FOREIGN KEY (ID_Avaliacao) REFERENCES Avaliacao(ID_Avaliacao) ON DELETE CASCADE,
    CONSTRAINT fk_avaliacaoprof_usuario FOREIGN KEY (ID_Usuario) REFERENCES Professor(ID_Usuario)
);

CREATE TABLE AvaliacaoDisciplina (
    ID_Avaliacao INT NOT NULL,
    NotaInfraestrutura NUMERIC(3,1) NOT NULL CHECK (NotaInfraestrutura >= 0 AND NotaInfraestrutura <= 10),
    NotaRelevancia NUMERIC(3,1) NOT NULL CHECK (NotaRelevancia >= 0 AND NotaRelevancia <= 10),
    NotadoMaterial NUMERIC(3,1) NOT NULL CHECK (NotadoMaterial >= 0 AND NotadoMaterial <= 10),
    ID_Disciplina INT NOT NULL,
    PRIMARY KEY (ID_Avaliacao, ID_Disciplina),
    CONSTRAINT fk_avaldisc_avaliacao FOREIGN KEY (ID_Avaliacao) REFERENCES Avaliacao(ID_Avaliacao) ON DELETE CASCADE,
    CONSTRAINT fk_avaldisc_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID)
);

CREATE TABLE Regras_Curso (
    ID_Curso INT PRIMARY KEY,
    Regras TEXT NOT NULL,
    CONSTRAINT fk_regras_curso FOREIGN KEY (ID_Curso) REFERENCES Curso(ID) ON DELETE CASCADE
);

CREATE TABLE Infra_Curso (
    ID_Curso INT PRIMARY KEY,
    Infraestrutura TEXT NOT NULL,
    CONSTRAINT fk_infra_curso FOREIGN KEY (ID_Curso) REFERENCES Curso(ID) ON DELETE CASCADE
);

CREATE TABLE Material_Disciplina (
    ID_Disciplina INT PRIMARY KEY,
    MaterialDidatico TEXT NOT NULL,
    CONSTRAINT fk_material_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID) ON DELETE CASCADE
);
