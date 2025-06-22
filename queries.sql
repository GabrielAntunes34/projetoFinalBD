SELECT d.nome, d.sobrenome from Matricular m
LEFT JOIN DadosUsuario d
ON m.idUsuario = d.idUsuario
WHERE m.periodo = '2025-1'
AND (m.codigoUnicoCurso, m.sigla) = (101, 'MAT101');

SELECT AVG(n.nota) FROM nota n
LEFT JOIN matricular m 
ON m.idMatricula = n.idMatricula
WHERE idUsuario = 13;

SELECT d.nome, du.nome, du.sobrenome, dc.sigla FROM disciplinacurso dc
LEFT JOIN curso c
ON c.codigoUnicoCurso = dc.codigoUnicoCurso
LEFT JOIN DepartamentoAcademicoInfo d
ON d.codigoUnicoDepartamento = c.codigoUnicoDepartamento
RIGHT JOIN Ministra m 
ON (m.sigla, m.codigoUnicoCurso) = (dc.sigla, dc.codigoUnicoCurso)
LEFT JOIN DadosUsuario du
ON (m.idUsuario) = (du.idUsuario)
GROUP BY d.nome, du.nome, du.sobrenome, dc.sigla;

SELECT dc.sigla, COALESCE(aux.quantidade, 0) AS quantidade
FROM disciplinacurso dc
LEFT JOIN (
SELECT dc.sigla, COUNT(m.idmatricula) AS quantidade
FROM disciplinacurso dc
LEFT JOIN matricular m 
ON m.sigla = dc.sigla 
AND m.codigounicocurso = dc.codigounicocurso
WHERE m.periodo = '2024-2'
GROUP BY dc.sigla
) AS aux
ON aux.sigla = dc.sigla
WHERE COALESCE(aux.quantidade, 0) = 0;

SELECT d.nome, d.sobrenome, AVG(n.nota) AS media FROM nota n
LEFT JOIN matricular m 
ON m.idMatricula = n.idMatricula
LEFT JOIN dadosusuario d
ON d.idUsuario = m.idUsuario
WHERE m.periodo = '2025-1'
GROUP BY d.nome, d.sobrenome
HAVING AVG(n.nota) < 7;

SELECT d.nome, d.sobrenome, m.periodo FROM dadosusuario d
LEFT JOIN ministra m
ON m.idUsuario = d.idUsuario
WHERE d.vinculo = 'Professor' AND
m.sigla = 'FIS101';

SELECT mg.texto, mg.timestamp FROM mensagemindividual mi
LEFT JOIN mensagemgenerica mg
ON mg.idMensagemGenerica = mi.idMensagemGenerica
LEFT JOIN matricular m
ON m.idMatricula = mi.idMatricula
LEFT JOIN dadosusuario d
ON d.idUsuario = m.idUsuario
WHERE d.idUsuario = 1 AND
mg.timestamp BETWEEN '2025-01-01' AND '2026-01-01';
