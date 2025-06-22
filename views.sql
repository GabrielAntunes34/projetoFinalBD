CREATE VIEW MatriculasPorCurso as
SELECT c.nome as curso_nome, c.nivelEnsino, c.cargaTotal, c.nVagas, count(m.idMatricula) AS matriculas_efetivadas
FROM curso c
LEFT JOIN matricular m ON c.codigoUnicoCurso = m.codigoUnicoCurso
GROUP BY c.nome, c.nivelEnsino, c.cargaTotal, c.nVagas;

CREATE VIEW avaliacoes AS
SELECT c.nome as curso_nome, count(a.idMatricula) AS total_avaliacoes, AVG(a.notaDidaticaProf) AS media_nota_didatica, AVG(a.notaMaterial) AS media_nota_material, AVG(a.notaRelevancia) AS media_nota_relevancia, AVG(a.notaInfra) AS media_nota_infraestrutura
FROM avalia a
JOIN CURSO c ON a.codigoUnicoCurso = c.codigoUnicoCurso
GROUP BY c.nome;

CREATE VIEW bolsas AS
SELECT du.nome as aluno_nome, du.sobrenome AS aluno_sobrenome, b.bolsaDeEstudo AS tipo_bolsa
FROM bolsaDeEstudo b
JOIN matricular m 
ON b.idMatricula = m.idMatricula
JOIN dadosusuario du 
ON m.idUsuario = du.idUsuario;
