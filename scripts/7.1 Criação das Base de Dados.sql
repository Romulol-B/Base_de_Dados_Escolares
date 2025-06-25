CREATE TABLE Unidade_Escola (
    ID_Unidade SERIAL PRIMARY KEY,
    Cidade VARCHAR(100) NOT NULL,
    Estado VARCHAR(100) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    Predio_Bloco VARCHAR(100),
    CONSTRAINT uq_unidade UNIQUE (Cidade, Estado, Pais, Predio_Bloco)
);

CREATE TABLE Usuario (
    ID_Usuario SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Endereco TEXT NOT NULL,
    Sexo CHAR(1) CHECK (Sexo IN ('M', 'F', 'O')),
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL
);

CREATE TABLE Professor (
    ID_Usuario INT PRIMARY KEY,
    Especializacao VARCHAR(255),
    Titulacao VARCHAR(100),
    CONSTRAINT fk_professor_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Aluno (
    ID_Usuario INT PRIMARY KEY,
    CONSTRAINT fk_aluno_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Funcionario (
    ID_Usuario INT PRIMARY KEY,
    CONSTRAINT fk_funcionario_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Departamento (
    ID_Departamento SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Disciplina (
    ID_Disciplina SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL UNIQUE,
    Aulas_Semanais INT NOT NULL,
    Material_Didatico TEXT,
    Capacidade_Sala INT NOT NULL
);

CREATE TABLE Curso (
    ID_Curso SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Nivel VARCHAR(50) NOT NULL,
    Carga_Horaria INT NOT NULL,
    Ementa TEXT,
    Infraestrutura_Necessaria TEXT,
    ID_Departamento INT NOT NULL,
    CONSTRAINT fk_curso_departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento) ON DELETE RESTRICT,
    CONSTRAINT uq_curso UNIQUE (Nome, Nivel, ID_Departamento)
);

CREATE TABLE Prazo_Entrega (
    ID_Disciplina INT,
    Periodo_Letivo VARCHAR(20),
    Data_Limite DATE,
    CONSTRAINT pk_prazo_entrega PRIMARY KEY (ID_Disciplina, Periodo_Letivo),
    CONSTRAINT fk_prazo_entrega_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID_Disciplina) ON DELETE CASCADE
);

CREATE TABLE Matricula (
    ID_Aluno INT,
    ID_Disciplina INT,
    Periodo_Letivo VARCHAR(20),
    Status VARCHAR(50) NOT NULL,
    Bolsa_Estudo TEXT,
    CONSTRAINT pk_matricula PRIMARY KEY (ID_Aluno, ID_Disciplina, Periodo_Letivo),
    CONSTRAINT fk_matricula_aluno FOREIGN KEY (ID_Aluno) REFERENCES Aluno(ID_Usuario) ON DELETE CASCADE,
    CONSTRAINT fk_matricula_prazo FOREIGN KEY (ID_Disciplina, Periodo_Letivo) REFERENCES Prazo_Entrega(ID_Disciplina, Periodo_Letivo) ON DELETE RESTRICT
);

CREATE TABLE Desempenho (
    ID_Aluno INT,
    ID_Disciplina INT,
    Periodo_Letivo VARCHAR(20),
    Nota DECIMAL(4, 2),
    CONSTRAINT pk_desempenho PRIMARY KEY (ID_Aluno, ID_Disciplina, Periodo_Letivo),
    CONSTRAINT fk_desempenho_matricula FOREIGN KEY (ID_Aluno, ID_Disciplina, Periodo_Letivo) REFERENCES Matricula(ID_Aluno, ID_Disciplina, Periodo_Letivo) ON DELETE CASCADE
);

CREATE TABLE Mensagens (
    ID_Mensagem SERIAL PRIMARY KEY,
    Timestamp_Criacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    Texto TEXT NOT NULL,
    ID_Remetente INT NOT NULL,
    CONSTRAINT fk_mensagens_usuario FOREIGN KEY (ID_Remetente) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Avaliacao (
    ID_Avaliacao SERIAL PRIMARY KEY,
    ID_Aluno INT,
    ID_Professor INT,
    ID_Disciplina INT,
    Comentario TEXT,
    CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (ID_Aluno) REFERENCES Aluno(ID_Usuario) ON DELETE SET NULL,
    CONSTRAINT fk_avaliacao_professor FOREIGN KEY (ID_Professor) REFERENCES Professor(ID_Usuario) ON DELETE SET NULL,
    CONSTRAINT fk_avaliacao_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID_Disciplina) ON DELETE CASCADE
);

CREATE TABLE Notas_Avaliacao (
    ID_Avaliacao INT PRIMARY KEY,
    Nota_Didatica INT CHECK (Nota_Didatica BETWEEN 1 AND 5),
    Nota_Material INT CHECK (Nota_Material BETWEEN 1 AND 5),
    Nota_Relevancia INT CHECK (Nota_Relevancia BETWEEN 1 AND 5),
    Nota_Infraestrutura INT CHECK (Nota_Infraestrutura BETWEEN 1 AND 5),
    CONSTRAINT fk_notas_avaliacao FOREIGN KEY (ID_Avaliacao) REFERENCES Avaliacao(ID_Avaliacao) ON DELETE CASCADE
);

CREATE TABLE Chefiar (
    ID_Departamento INT PRIMARY KEY,
    ID_Usuario_Professor INT NOT NULL UNIQUE,
    CONSTRAINT fk_chefiar_departamento FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento) ON DELETE CASCADE,
    CONSTRAINT fk_chefiar_professor FOREIGN KEY (ID_Usuario_Professor) REFERENCES Professor(ID_Usuario) ON DELETE RESTRICT
);

CREATE TABLE Local_Usuario (
    ID_Usuario INT,
    ID_Unidade_Escola INT,
    CONSTRAINT pk_local_usuario PRIMARY KEY (ID_Usuario, ID_Unidade_Escola),
    CONSTRAINT fk_local_usuario_usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE,
    CONSTRAINT fk_local_usuario_unidade FOREIGN KEY (ID_Unidade_Escola) REFERENCES Unidade_Escola(ID_Unidade) ON DELETE CASCADE
);

CREATE TABLE Local_Disciplina (
    ID_Disciplina INT,
    ID_Unidade_Escola INT,
    CONSTRAINT pk_local_disciplina PRIMARY KEY (ID_Disciplina, ID_Unidade_Escola),
    CONSTRAINT fk_local_disciplina_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID_Disciplina) ON DELETE CASCADE,
    CONSTRAINT fk_local_disciplina_unidade FOREIGN KEY (ID_Unidade_Escola) REFERENCES Unidade_Escola(ID_Unidade) ON DELETE CASCADE
);

CREATE TABLE Local_Curso (
    ID_Curso INT,
    ID_Unidade_Escola INT,
    CONSTRAINT pk_local_curso PRIMARY KEY (ID_Curso, ID_Unidade_Escola),
    CONSTRAINT fk_local_curso_curso FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE,
    CONSTRAINT fk_local_curso_unidade FOREIGN KEY (ID_Unidade_Escola) REFERENCES Unidade_Escola(ID_Unidade) ON DELETE CASCADE
);

CREATE TABLE Professor_Disciplina (
    ID_Usuario_Professor INT,
    ID_Disciplina INT,
    Periodo_Letivo VARCHAR(20),
    CONSTRAINT pk_professor_disciplina PRIMARY KEY (ID_Usuario_Professor, ID_Disciplina, Periodo_Letivo),
    CONSTRAINT fk_professor_disciplina_professor FOREIGN KEY (ID_Usuario_Professor) REFERENCES Professor(ID_Usuario) ON DELETE CASCADE,
    CONSTRAINT fk_professor_disciplina_prazo FOREIGN KEY (ID_Disciplina, Periodo_Letivo) REFERENCES Prazo_Entrega(ID_Disciplina, Periodo_Letivo) ON DELETE CASCADE
);

CREATE TABLE Curso_Disciplina (
    ID_Curso INT,
    ID_Disciplina INT,
    CONSTRAINT pk_curso_disciplina PRIMARY KEY (ID_Curso, ID_Disciplina),
    CONSTRAINT fk_curso_disciplina_curso FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE,
    CONSTRAINT fk_curso_disciplina_disciplina FOREIGN KEY (ID_Disciplina) REFERENCES Disciplina(ID_Disciplina) ON DELETE CASCADE
);

CREATE TABLE Recebe_Mensagem (
    ID_Usuario_Destinatario INT,
    ID_Mensagem INT,
    CONSTRAINT pk_recebe_mensagem PRIMARY KEY (ID_Usuario_Destinatario, ID_Mensagem),
    CONSTRAINT fk_recebe_mensagem_usuario FOREIGN KEY (ID_Usuario_Destinatario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE,
    CONSTRAINT fk_recebe_mensagem_mensagem FOREIGN KEY (ID_Mensagem) REFERENCES Mensagens(ID_Mensagem) ON DELETE CASCADE
);

CREATE TABLE Regras_Curso (
    ID_Curso INT,
    Regra TEXT,
    CONSTRAINT pk_regras_curso PRIMARY KEY (ID_Curso, Regra),
    CONSTRAINT fk_regras_curso_curso FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE
);

CREATE TABLE Necessidade_Curso (
    ID_Curso INT,
    Infraestrutura VARCHAR(255),
    CONSTRAINT pk_necessidade_curso PRIMARY KEY (ID_Curso, Infraestrutura),
    CONSTRAINT fk_necessidade_curso_curso FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE
);