/*
1. Exibir lista de alunos e seus cursos
Crie uma view que mostre o nome dos alunos e as disciplinas em que estão matriculados, incluindo o nome do curso.
*/
CREATE VIEW vw_alunos_disciplinas AS
SELECT 
    a.nome AS nome_aluno,
    d.nome AS nome_disciplina,
    c.nome AS nome_curso
FROM 
    aluno a
JOIN 
    matricula m ON a.id_aluno = m.id_aluno
JOIN 
    disciplina d ON m.id_disciplina = d.id_disciplina
JOIN 
    curso c ON d.id_curso = c.id_curso;

/*
2. Exibir total de alunos por disciplina
Crie uma view que mostre o nome das disciplinas e a quantidade de alunos matriculados em cada uma.
*/
CREATE VIEW vw_total_alunos_por_disciplina AS
SELECT 
    d.nome AS nome_disciplina,
    COUNT(m.id_aluno) AS total_alunos
FROM 
    disciplina d
LEFT JOIN 
    matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY 
    d.nome;

/*
3. Exibir alunos e status das suas matrículas
Crie uma view que mostre o nome dos alunos, suas disciplinas e o status da matrícula (Ativo, Concluído, Trancado).
*/
CREATE VIEW vw_alunos_status_matricula AS
SELECT 
    a.nome AS nome_aluno,
    d.nome AS nome_disciplina,
    CASE 
        WHEN m.status = 'A' THEN 'Ativo'
        WHEN m.status = 'C' THEN 'Concluído'
        WHEN m.status = 'T' THEN 'Trancado'
        ELSE 'Desconhecido'
    END AS status_matricula
FROM 
    aluno a
JOIN 
    matricula m ON a.id_aluno = m.id_aluno
JOIN 
    disciplina d ON m.id_disciplina = d.id_disciplina;

/*
4. Exibir professores e suas turmas
Crie uma view que mostre o nome dos professores e as disciplinas que eles lecionam, com os horários das turmas.
*/
CREATE VIEW vw_professores_turmas AS
SELECT 
    p.nome AS nome_professor,
    d.nome AS nome_disciplina,
    t.horario AS horario_turma
FROM 
    professor p
JOIN 
    disciplina d ON p.id_professor = d.id_professor
JOIN 
    turma t ON d.id_disciplina = t.id_disciplina;

/*
5. Exibir alunos maiores de 20 anos
Crie uma view que exiba o nome e a data de nascimento dos alunos que têm mais de 20 anos.
*/
CREATE VIEW vw_alunos_maiores_20 AS
SELECT 
    nome,
    data_nascimento
FROM 
    aluno
WHERE 
    DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) > 20
    OR (DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) = 20 AND DATE_PART('dayofyear', CURRENT_DATE) > DATE_PART('dayofyear', data_nascimento));

/*
6. Exibir disciplinas e carga horária total por curso
Crie uma view que exiba o nome dos cursos, a quantidade de disciplinas associadas e a carga horária total de cada curso.
*/
CREATE VIEW vw_disciplinas_por_curso AS
SELECT 
    c.nome AS curso_nome,
    COUNT(d.id) AS quantidade_disciplinas,
    SUM(d.carga_horaria) AS carga_horaria_total
FROM 
    curso c
LEFT JOIN 
    disciplina d ON c.id = d.curso_id
GROUP BY 
    c.nome;

/*
7. Exibir professores e suas especialidades
Crie uma view que exiba o nome dos professores e suas especialidades.
*/
CREATE VIEW vw_professores_especialidades AS
SELECT 
    p.nome AS professor_nome,
    e.nome AS especialidade_nome
FROM 
    professor p
JOIN 
    especialidade e ON p.especialidade_id = e.id;

/*
8. Exibir alunos matriculados em mais de uma disciplina
Crie uma view que mostre os alunos que estão matriculados em mais de uma disciplina.
*/
CREATE VIEW vw_alunos_multidisciplina AS
SELECT 
    a.nome AS aluno_nome,
    COUNT(m.disciplina_id) AS total_disciplinas
FROM 
    aluno a
JOIN 
    matricula m ON a.id = m.aluno_id
GROUP BY 
    a.id, a.nome
HAVING 
    COUNT(m.disciplina_id) > 1;

/*
9. Exibir alunos e o número de disciplinas que concluíram
Crie uma view que exiba o nome dos alunos e o número de disciplinas que eles concluíram.
*/
CREATE VIEW vw_alunos_disciplinas_concluidas AS
SELECT 
    a.nome AS aluno_nome,
    COUNT(m.disciplina_id) AS disciplinas_concluidas
FROM 
    aluno a
JOIN 
    matricula m ON a.id = m.aluno_id
WHERE 
    m.status = 'Concluído' 
GROUP BY 
    a.id, a.nome;

/*
10. Exibir todas as turmas de um semestre específico
Crie uma view que exiba todas as turmas que ocorrem em um determinado semestre (ex.: 2024.1).
*/
CREATE VIEW vw_turmas_por_semestre AS
SELECT 
    t.id AS turma_id,
    d.nome AS disciplina_nome,
    p.nome AS professor_nome,
    t.horario,
    t.semestre
FROM 
    turma t
JOIN 
    disciplina d ON t.disciplina_id = d.id
JOIN 
    professor p ON t.professor_id = p.id
WHERE 
    t.semestre = '2024.1';  

/*
11. Exibir alunos com matrículas trancadas
Crie uma view que exiba o nome dos alunos que têm matrículas no status "Trancado".
*/
CREATE VIEW vw_alunos_matriculas_trancadas AS
SELECT 
    a.nome AS aluno_nome,
    m.status AS matricula_status
FROM 
    aluno a
JOIN 
    matricula m ON a.id = m.aluno_id
WHERE 
    m.status = 'Trancado';

/*
12. Exibir disciplinas que não têm alunos matriculados
Crie uma view que exiba as disciplinas que não possuem alunos matriculados.
*/
CREATE VIEW vw_disciplinas_sem_alunos AS
SELECT 
    d.nome AS disciplina_nome
FROM 
    disciplina d
LEFT JOIN 
    matricula m ON d.id = m.disciplina_id
WHERE 
    m.aluno_id IS NULL;

/*
13. Exibir a quantidade de alunos por status de matrícula
Crie uma view que exiba a quantidade de alunos para cada status de matrícula (Ativo, Concluído, Trancado).
*/
CREATE VIEW vw_quantidade_alunos_por_status AS
SELECT 
    m.status AS status_matricula,
    COUNT(*) AS quantidade_alunos
FROM 
    matricula m
GROUP BY 
    m.status;

/*
14. Exibir o total de professores por especialidade
Crie uma view que exiba a quantidade de professores por especialidade (ex.: Engenharia de Software, Ciência da Computação).
*/
CREATE VIEW vw_total_professores_por_especialidade AS
SELECT 
    p.especialidade AS especialidade,
    COUNT(*) AS quantidade_professores
FROM 
    professor p
GROUP BY 
    p.especialidade;

/*
15. Exibir lista de alunos e suas idades
Crie uma view que exiba o nome dos alunos e suas idades com base na data de nascimento.
*/
CREATE VIEW vw_alunos_idade AS
SELECT 
    a.nome AS nome_aluno,
    FLOOR(DATEDIFF(CURDATE(), a.data_nascimento) / 365.25) AS idade
FROM 
    aluno a;

/*
16. Exibir alunos e suas últimas matrículas
Crie uma view que exiba o nome dos alunos e a data de suas últimas matrículas.
*/
CREATE VIEW vw_alunos_ultimas_matriculas AS
SELECT 
    a.nome AS nome_aluno,
    MAX(m.data_matricula) AS ultima_matricula
FROM 
    aluno a
JOIN 
    matricula m ON a.id = m.aluno_id
GROUP BY 
    a.id, a.nome;

/*
17. Exibir todas as disciplinas de um curso específico
Crie uma view que exiba todas as disciplinas pertencentes a um curso específico, como "Engenharia de Software".
*/
CREATE VIEW vw_disciplinas_curso_engenharia AS
SELECT 
    d.nome AS nome_disciplina,
    c.nome AS nome_curso
FROM 
    disciplina d
JOIN 
    curso c ON d.curso_id = c.id
WHERE 
    c.nome = 'Engenharia de Software';

/*
18. Exibir os professores que não têm turmas
Crie uma view que exiba os professores que não estão lecionando em nenhuma turma.
*/
CREATE VIEW vw_professores_sem_turmas AS
SELECT 
    p.nome AS nome_professor
FROM 
    professor p
LEFT JOIN 
    turma t ON p.id = t.professor_id
WHERE 
    t.id IS NULL;

/*
19. Exibir lista de alunos com CPF e email
Crie uma view que exiba o nome dos alunos, CPF e email.
*/
CREATE VIEW vw_alunos_cpf_email AS
SELECT nome, cpf, email
FROM aluno;

/*
20. Exibir o total de disciplinas por professor
Crie uma view que exiba o nome dos professores e o número de disciplinas que cada um leciona.
*/
CREATE VIEW vw_total_disciplinas_por_professor AS
SELECT p.nome AS nome_professor, COUNT(d.id) AS total_disciplinas
FROM professor p
LEFT JOIN disciplina d ON p.id = d.professor_id
GROUP BY p.nome;
