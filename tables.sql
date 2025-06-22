CREATE TABLE DepartamentoAcademicoInfo(
    codigoUnicoDepartamento integer primary key,
    nome varchar(120)
);

CREATE TABLE DadosUsuario(
    idUsuario integer primary key,
    nome varchar(120) not null,
    sobrenome varchar(120),
    telefone varchar(20) not null,
    vinculo varchar(120) not null,
    dataNasc date not null,
    enderNumero varchar(10),
    cidade varchar(120) not null,
    bairro varchar(120) not null,
    estado varchar(120) not null,
    pais varchar(120) not null,
    sexo varchar(20),
    email varchar(120) not null,
    senha varchar(120) not null,
    areaEspecializacao varchar(120),
    titulacao varchar(120)
);

CREATE TABLE UnidadeDaEscola(
    idUnidade integer primary key,
    cidade varchar(120),
    estado varchar(120),
    pais varchar(120),
    bloco varchar(120)
);

CREATE TABLE SiglaInfo(
    sigla varchar(10) primary key,
    nAulasSemanais integer,
    materialDidatico varchar(120),
    nome varchar(120) not null
);


CREATE TABLE MensagemGenerica(
    idMensagemGenerica integer primary key,
    texto varchar(600) not null,
    timestamp timestamp not null,
    tipo varchar(120) not null
);

CREATE TABLE UsuarioUnidade(
    idUsuario integer not null,
    idUnidade integer not null,
    primary key (idUsuario, idUnidade),
    foreign key (idUsuario) references DadosUsuario(idUsuario),
    foreign key (idUnidade) references UnidadeDaEscola(idUnidade)
);

CREATE TABLE DepartamentoAcademicoChefes(
    codigoUnicoDepartamento integer not null,
    idUsuario integer not null,
    idUnidade integer not null,
    primary key (codigoUnicoDepartamento, idUsuario, idUnidade),
    foreign key (idUsuario, idUnidade) references UsuarioUnidade(idUsuario, idUnidade)
);

CREATE TABLE Curso(
    codigoUnicoCurso integer primary key,
    codigoUnicoDepartamento integer not null,
    idUsuario integer not null, 
    nome varchar(120) not null,
    nivelEnsino varchar(120) not null,
    cargaTotal integer not null,
    nVagas integer not null,
    ementa varchar(600) not null,
    salaAula varchar(120) not null,
    idUnidade integer not null,
    foreign key (codigoUnicoDepartamento, idUsuario, idUnidade) references DepartamentoAcademicoChefes(codigoUnicoDepartamento, idUsuario, idUnidade)
);

CREATE TABLE CursoUnidade(
    codigoUnicoCurso integer primary key,
    idUnidade integer not null,
    foreign key (codigoUnicoCurso) references Curso(codigoUnicoCurso),
    foreign key (idUnidade) references UnidadeDaEscola(idUnidade)
);

CREATE TABLE DisciplinaCurso(
    sigla varchar(10) not null,
    codigoUnicoCurso integer not null,
    primary key (sigla, codigoUnicoCurso),
    foreign key (sigla) references SiglaInfo(sigla),
    foreign key (codigoUnicoCurso) references Curso(codigoUnicoCurso)
);
CREATE TABLE Matricular(
    idMatricula integer primary key,
    codigoUnicoCurso integer not null,
    dataEfetivacao date not null,
    status varchar(50) not null,
    dataLimiteConfirmacao date not null,
    periodo varchar(20) not null,
    sigla varchar(10) not null,
    idUsuario integer not null,
    idUnidade integer not null,
    bolsaDeEstudo boolean not null,
    foreign key (sigla, codigoUnicoCurso) references DisciplinaCurso(sigla, codigoUnicoCurso),
    foreign key (idUsuario) references DadosUsuario(idUsuario),
    foreign key (idUnidade) references UnidadeDaEscola(idUnidade)
);

CREATE TABLE Ministra(
    periodo varchar(20) not null,
    sigla varchar(10) not null,
    idUsuario integer not null,
    codigoUnicoCurso integer not null,
    idUnidade integer not null,
    primary key (periodo, sigla, idUsuario, idUnidade, codigoUnicoCurso),
    foreign key (sigla, codigoUnicoCurso) references DisciplinaCurso(sigla, codigoUnicoCurso),
    foreign key (idUsuario) references DadosUsuario(idUsuario),
    foreign key (idUnidade) references UnidadeDaEscola(idUnidade)
);

CREATE TABLE MensagemIndividual(
    idMensagemGenerica integer not null,
    professorEnviou boolean not null,
    idMatricula integer not null,
    idUsuario integer not null,
    primary key (idMensagemGenerica),
    foreign key (idMensagemGenerica) references MensagemGenerica(idMensagemGenerica),
    foreign key (idMatricula) references Matricular(idMatricula),
    foreign key (idUsuario) references DadosUsuario(idUsuario)
);

CREATE TABLE MensagemTurma(
    idMensagemGenerica integer not null,
    codigoUnicoCurso integer not null,
    periodo varchar(20) not null,
    sigla varchar(10) not null,
    idUsuario integer not null,
    idUnidade integer not null,
    primary key (idMensagemGenerica, periodo, sigla, idUsuario, idUnidade, codigoUnicoCurso),
    foreign key (idMensagemGenerica) references MensagemGenerica(idMensagemGenerica),
    foreign key (idUsuario, idUnidade) references UsuarioUnidade(idUsuario, idUnidade),
    foreign key (periodo, sigla, idUsuario, idUnidade, codigoUnicoCurso) references Ministra(periodo, sigla, idUsuario, idUnidade, codigoUnicoCurso)
);

CREATE TABLE Aviso(
    idMensagemGenerica integer primary key,
    idUsuario integer not null,
    idUnidade integer not null,
    foreign key (idMensagemGenerica) references MensagemGenerica(idMensagemGenerica),
    foreign key (idUsuario) references DadosUsuario(idUsuario),
    foreign key (idUnidade) references UnidadeDaEscola(idUnidade)
);

CREATE TABLE PreReqCurso(
    codigoUnicoCursoAtual integer not null,
    codigoUnicoCursoRequisito integer not null,
    primary key (codigoUnicoCursoAtual, codigoUnicoCursoRequisito),
    foreign key (codigoUnicoCursoAtual) references Curso(codigoUnicoCurso),
    foreign key (codigoUnicoCursoRequisito) references Curso(codigoUnicoCurso)
);

CREATE TABLE PreReqDiscip(
    sigla varchar(10) not null,
    codigoUnicoCurso integer not null,
    primary key (sigla, codigoUnicoCurso),
    foreign key (sigla) references SiglaInfo(sigla),
    foreign key (codigoUnicoCurso) references Curso(codigoUnicoCurso)
);

CREATE TABLE ResponsavelDisciplina(
    idUsuario integer not null,
    idUnidade integer not null,
    codigoUnicoCurso integer not null,
    sigla varchar(10) not null,
    primary key (idUsuario, idUnidade, sigla, codigoUnicoCurso),
    foreign key (idUsuario, idUnidade) references UsuarioUnidade(idUsuario, idUnidade),
    foreign key (sigla, codigoUnicoCurso) references DisciplinaCurso(sigla, codigoUnicoCurso)
);

CREATE TABLE Avalia(
    idMatricula integer not null,
    codigoUnicoCurso integer not null,
    periodo varchar(20) not null,
    sigla varchar(10) not null,
    idUsuario integer not null,
    idUnidade integer not null,
    comentario varchar(600),
    notaDidaticaProf integer,
    notaMaterial integer,
    notaRelevancia integer,
    notaInfra integer,
    primary key (idMatricula, periodo, sigla, idUsuario, idUnidade, codigoUnicoCurso),
    foreign key (idMatricula) references Matricular(idMatricula),
    foreign key (periodo, sigla, idUsuario, idUnidade, codigoUnicoCurso) references Ministra(periodo, sigla, idUsuario, idUnidade, codigoUnicoCurso)
);

CREATE TABLE Nota(
    idMatricula integer not null,
    nota decimal(4,2) not null,
    primary key (idMatricula, nota),
    foreign key (idMatricula) references Matricular(idMatricula)
);

CREATE TABLE BolsaDeEstudo(
    idMatricula integer not null,
    bolsaDeEstudo varchar(120) not null,
    primary key (idMatricula, bolsaDeEstudo),
    foreign key (idMatricula) references Matricular(idMatricula)
);
