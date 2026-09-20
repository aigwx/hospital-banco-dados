-- ============================================================
-- BANCO DE DADOS: HOSPITAL
-- Script completo para criação, população e consultas
-- ============================================================

CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

-- ============================================================
-- 1. CRIAÇÃO DAS TABELAS
-- ============================================================

CREATE TABLE profissional (
    id_profissional INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    data_admissao DATE NOT NULL,
    PRIMARY KEY (id_profissional)
);

CREATE TABLE medico (
    id_profissional INT NOT NULL,
    crm VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_profissional),
    FOREIGN KEY (id_profissional)
        REFERENCES profissional(id_profissional)
);

CREATE TABLE enfermeiro (
    id_profissional INT NOT NULL,
    coren VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_profissional),
    FOREIGN KEY (id_profissional)
        REFERENCES profissional(id_profissional)
);

CREATE TABLE especialidade (
    id_especialidade INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    PRIMARY KEY (id_especialidade)
);

CREATE TABLE possui (
    id_profissional INT NOT NULL,
    id_especialidade INT NOT NULL,
    PRIMARY KEY (id_profissional, id_especialidade),
    FOREIGN KEY (id_profissional)
        REFERENCES medico(id_profissional),
    FOREIGN KEY (id_especialidade)
        REFERENCES especialidade(id_especialidade)
);

CREATE TABLE medicamento (
    id_medicamento INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(150) NOT NULL,
    fabricante VARCHAR(100),
    PRIMARY KEY (id_medicamento)
);

CREATE TABLE prescricao (
    id_prescricao INT NOT NULL,
    data_prescricao DATE NOT NULL,
    observacoes VARCHAR(500),
    PRIMARY KEY (id_prescricao)
);

CREATE TABLE item_prescricao (
    numero_item INT NOT NULL,
    dosagem VARCHAR(50) NOT NULL,
    frequencia VARCHAR(50) NOT NULL,
    duracao VARCHAR(50) NOT NULL,
    PRIMARY KEY (numero_item)
);

CREATE TABLE telefone (
    id_telefone INT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_telefone)
);

CREATE TABLE prontuario_paciente (
    id_prontuario INT NOT NULL,
    data_criacao DATE NOT NULL,
    observacoes_gerais VARCHAR(500),
    id_paciente INT NOT NULL,
    numero_carteirinha VARCHAR(30),
    nome VARCHAR(100) NOT NULL,
    data_nasc DATE NOT NULL,
    logradouro VARCHAR(150),
    cidade VARCHAR(100),
    numero INT,
    id_telefone INT,
    cpf CHAR(11),
    PRIMARY KEY (id_prontuario, id_paciente),
    FOREIGN KEY (id_telefone)
        REFERENCES telefone(id_telefone)
);

CREATE TABLE agendamento (
    id_agendamento INT NOT NULL,
    data_hora DATETIME NOT NULL,
    status VARCHAR(30) NOT NULL,
    motivo VARCHAR(255),
    PRIMARY KEY (id_agendamento)
);

CREATE TABLE atendimento (
    id_atendimento INT NOT NULL,
    data_hora DATETIME NOT NULL,
    observacoes VARCHAR(500),
    diagnostico VARCHAR(500),
    PRIMARY KEY (id_atendimento)
);

CREATE TABLE exame (
    id_exame INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    data_solicitacao DATE NOT NULL,
    data_realizacao DATE,
    resultado VARCHAR(500),
    PRIMARY KEY (id_exame)
);

CREATE TABLE realiza (
    id_prontuario INT NOT NULL,
    id_paciente INT NOT NULL,
    id_agendamento INT NOT NULL,
    FOREIGN KEY (id_prontuario, id_paciente)
        REFERENCES prontuario_paciente(id_prontuario, id_paciente),
    FOREIGN KEY (id_agendamento)
        REFERENCES agendamento(id_agendamento)
);

CREATE TABLE atende (
    id_profissional INT NOT NULL,
    id_agendamento INT NOT NULL,
    FOREIGN KEY (id_profissional)
        REFERENCES profissional(id_profissional),
    FOREIGN KEY (id_agendamento)
        REFERENCES agendamento(id_agendamento)
);

CREATE TABLE resulta_em (
    id_agendamento INT NOT NULL,
    id_atendimento INT NOT NULL,
    FOREIGN KEY (id_agendamento)
        REFERENCES agendamento(id_agendamento),
    FOREIGN KEY (id_atendimento)
        REFERENCES atendimento(id_atendimento)
);

CREATE TABLE gera (
    id_atendimento INT NOT NULL,
    id_prescricao INT NOT NULL,
    FOREIGN KEY (id_atendimento)
        REFERENCES atendimento(id_atendimento),
    FOREIGN KEY (id_prescricao)
        REFERENCES prescricao(id_prescricao)
);

CREATE TABLE possui_item (
    id_prescricao INT NOT NULL,
    numero_item INT NOT NULL,
    FOREIGN KEY (id_prescricao)
        REFERENCES prescricao(id_prescricao),
    FOREIGN KEY (numero_item)
        REFERENCES item_prescricao(numero_item)
);

CREATE TABLE refere_se_a (
    numero_item INT NOT NULL,
    id_medicamento INT NOT NULL,
    FOREIGN KEY (numero_item)
        REFERENCES item_prescricao(numero_item),
    FOREIGN KEY (id_medicamento)
        REFERENCES medicamento(id_medicamento)
);

CREATE TABLE solicita (
    id_atendimento INT NOT NULL,
    id_exame INT NOT NULL,
    FOREIGN KEY (id_atendimento)
        REFERENCES atendimento(id_atendimento),
    FOREIGN KEY (id_exame)
        REFERENCES exame(id_exame)
);


-- ============================================================
-- 2. INSERÇÃO DOS DADOS
-- ============================================================

INSERT INTO profissional
    (id_profissional, nome, cpf, data_admissao)
VALUES
    (1, 'Carlos Eduardo Silva', '11111111101', '2022-03-15'),
    (2, 'Mariana Oliveira Santos', '22222222202', '2023-07-10'),
    (3, 'Rafael Almeida Costa', '33333333303', '2021-11-20'),
    (4, 'Juliana Martins Souza', '44444444404', '2024-01-08'),
    (5, 'Fernando Pereira Lima', '55555555505', '2020-05-18');

INSERT INTO medico
    (id_profissional, crm)
VALUES
    (1, 'CRM-DF-12345'),
    (2, 'CRM-DF-23456'),
    (3, 'CRM-DF-34567');

INSERT INTO enfermeiro
    (id_profissional, coren)
VALUES
    (4, 'COREN-DF-45678'),
    (5, 'COREN-DF-56789');

INSERT INTO especialidade
    (id_especialidade, nome, descricao)
VALUES
    (1, 'Cardiologia', 'Especialidade voltada ao sistema cardiovascular'),
    (2, 'Pediatria', 'Atendimento médico de crianças e adolescentes'),
    (3, 'Ortopedia', 'Especialidade voltada ao sistema musculoesquelético'),
    (4, 'Neurologia', 'Especialidade voltada ao sistema nervoso'),
    (5, 'Dermatologia', 'Especialidade voltada à pele e seus anexos');

INSERT INTO possui
    (id_profissional, id_especialidade)
VALUES
    (1, 1),
    (1, 4),
    (2, 2),
    (2, 5),
    (3, 3);

INSERT INTO medicamento
    (id_medicamento, nome, principio_ativo, fabricante)
VALUES
    (1, 'Dipirona 500mg', 'Dipirona Sódica', 'Medley'),
    (2, 'Paracetamol 750mg', 'Paracetamol', 'Eurofarma'),
    (3, 'Amoxicilina 500mg', 'Amoxicilina', 'EMS'),
    (4, 'Ibuprofeno 600mg', 'Ibuprofeno', 'Aché'),
    (5, 'Omeprazol 20mg', 'Omeprazol', 'Neo Química');

INSERT INTO prescricao
    (id_prescricao, data_prescricao, observacoes)
VALUES
    (1, '2026-09-01', 'Paciente deve manter repouso e hidratação.'),
    (2, '2026-09-03', 'Retorno recomendado após o término da medicação.'),
    (3, '2026-09-05', 'Administrar medicamentos conforme orientação médica.'),
    (4, '2026-09-08', 'Paciente deve evitar esforço físico durante o tratamento.'),
    (5, '2026-09-10', 'Acompanhar evolução dos sintomas.');

INSERT INTO item_prescricao
    (numero_item, dosagem, frequencia, duracao)
VALUES
    (1, '500 mg', 'A cada 6 horas', '3 dias'),
    (2, '750 mg', 'A cada 8 horas', '5 dias'),
    (3, '500 mg', 'A cada 8 horas', '7 dias'),
    (4, '600 mg', 'A cada 8 horas', '5 dias'),
    (5, '20 mg', 'Uma vez ao dia', '14 dias');

INSERT INTO possui_item
    (id_prescricao, numero_item)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO refere_se_a
    (numero_item, id_medicamento)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO telefone
    (id_telefone, telefone)
VALUES
    (1, '(61) 99999-1001'),
    (2, '(61) 99999-1002'),
    (3, '(61) 99999-1003'),
    (4, '(61) 99999-1004'),
    (5, '(61) 99999-1005');

INSERT INTO prontuario_paciente
    (id_prontuario, data_criacao, observacoes_gerais,
     id_paciente, numero_carteirinha, nome, data_nasc,
     logradouro, cidade, numero, id_telefone, cpf)
VALUES
    (1, '2026-01-10', 'Sem observações relevantes.', 1, 'CAR001', 'João Pedro Martins', '1990-05-12', 'Rua das Acácias', 'Brasília', 120, 1, '11111111111'),
    (2, '2026-02-15', 'Alergia a penicilina.', 2, 'CAR002', 'Ana Beatriz Oliveira', '1985-09-23', 'Rua das Palmeiras', 'Brasília', 245, 2, '22222222222'),
    (3, '2026-03-20', 'Histórico de hipertensão.', 3, 'CAR003', 'Lucas Henrique Souza', '1978-11-08', 'Avenida Central', 'Brasília', 350, 3, '33333333333'),
    (4, '2026-04-05', 'Sem observações relevantes.', 4, 'CAR004', 'Mariana Costa Lima', '2001-03-17', 'Rua do Sol', 'Brasília', 87, 4, '44444444444'),
    (5, '2026-05-18', 'Acompanhamento médico regular.', 5, 'CAR005', 'Pedro Augusto Ferreira', '1995-07-29', 'Avenida Brasil', 510, 5, '55555555555');

INSERT INTO agendamento
    (id_agendamento, data_hora, status, motivo)
VALUES
    (1, '2026-09-15 08:00:00', 'Realizado', 'Consulta de rotina'),
    (2, '2026-09-15 09:30:00', 'Realizado', 'Dor de cabeça frequente'),
    (3, '2026-09-16 10:00:00', 'Realizado', 'Dor no joelho'),
    (4, '2026-09-17 14:00:00', 'Agendado', 'Avaliação dermatológica'),
    (5, '2026-09-18 15:30:00', 'Agendado', 'Acompanhamento clínico');

INSERT INTO atendimento
    (id_atendimento, data_hora, observacoes, diagnostico)
VALUES
    (1, '2026-09-15 08:15:00', 'Paciente relatou cansaço e palpitações ocasionais.', 'Avaliação cardiológica sem alterações significativas.'),
    (2, '2026-09-15 09:45:00', 'Paciente relatou dores de cabeça recorrentes.', 'Cefaleia tensional.'),
    (3, '2026-09-16 10:20:00', 'Paciente apresentou dor no joelho direito após atividade física.', 'Suspeita de lesão ligamentar leve.'),
    (4, '2026-09-17 14:20:00', 'Paciente apresentou manchas avermelhadas na pele.', 'Dermatite de contato.'),
    (5, '2026-09-18 15:50:00', 'Paciente compareceu para acompanhamento clínico.', 'Acompanhamento de rotina.');

INSERT INTO exame
    (id_exame, tipo, data_solicitacao, data_realizacao, resultado)
VALUES
    (1, 'Eletrocardiograma', '2026-09-15', '2026-09-15', 'Ritmo cardíaco dentro dos parâmetros esperados.'),
    (2, 'Hemograma', '2026-09-15', '2026-09-15', 'Resultados dentro dos valores de referência.'),
    (3, 'Ressonância magnética do joelho', '2026-09-16', '2026-09-17', 'Sem evidências de lesões graves.'),
    (4, 'Exame dermatológico', '2026-09-17', '2026-09-17', 'Alterações compatíveis com dermatite.'),
    (5, 'Ultrassonografia abdominal', '2026-09-18', NULL, NULL);

INSERT INTO realiza
    (id_prontuario, id_paciente, id_agendamento)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5);

INSERT INTO atende
    (id_profissional, id_agendamento)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (1, 4),
    (2, 5);

INSERT INTO resulta_em
    (id_agendamento, id_atendimento)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO gera
    (id_atendimento, id_prescricao)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO solicita
    (id_atendimento, id_exame)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);


    -- ============================================================
-- 3. SELECTS
-- ============================================================

SELECT id_profissional, nome, cpf, data_admissao
FROM profissional;

SELECT p.nome AS medico, e.nome AS especialidade
FROM profissional p
JOIN possui po ON p.id_profissional = po.id_profissional
JOIN especialidade e ON po.id_especialidade = e.id_especialidade;

SELECT pp.nome AS paciente, a.data_hora, a.status, a.motivo
FROM prontuario_paciente pp
JOIN realiza r
  ON pp.id_prontuario = r.id_prontuario
 AND pp.id_paciente = r.id_paciente
JOIN agendamento a ON r.id_agendamento = a.id_agendamento;

SELECT pp.nome AS paciente, p.nome AS profissional,
       a.data_hora, a.status, a.motivo
FROM prontuario_paciente pp
JOIN realiza r
  ON pp.id_prontuario = r.id_prontuario
 AND pp.id_paciente = r.id_paciente
JOIN agendamento a ON r.id_agendamento = a.id_agendamento
JOIN atende at ON a.id_agendamento = at.id_agendamento
JOIN profissional p ON at.id_profissional = p.id_profissional
ORDER BY a.data_hora;

SELECT id_agendamento, data_hora, status, motivo
FROM agendamento
WHERE status = 'Realizado';

SELECT status, COUNT(*) AS quantidade
FROM agendamento
GROUP BY status;

SELECT pp.nome AS paciente, p.nome AS profissional,
       a.data_hora, a.motivo
FROM prontuario_paciente pp
JOIN realiza r
  ON pp.id_prontuario = r.id_prontuario
 AND pp.id_paciente = r.id_paciente
JOIN agendamento a ON r.id_agendamento = a.id_agendamento
JOIN atende at ON a.id_agendamento = at.id_agendamento
JOIN profissional p ON at.id_profissional = p.id_profissional
WHERE a.status = 'Realizado'
ORDER BY a.data_hora;

SELECT pr.id_prescricao, m.nome AS medicamento,
       ip.dosagem, ip.frequencia, ip.duracao
FROM prescricao pr
JOIN possui_item pi ON pr.id_prescricao = pi.id_prescricao
JOIN item_prescricao ip ON pi.numero_item = ip.numero_item
JOIN refere_se_a rsa ON ip.numero_item = rsa.numero_item
JOIN medicamento m ON rsa.id_medicamento = m.id_medicamento
ORDER BY pr.id_prescricao;

SELECT id_exame, tipo, data_solicitacao
FROM exame
WHERE data_realizacao IS NULL;

SELECT p.nome AS medico,
       COUNT(po.id_especialidade) AS quantidade_especialidades
FROM profissional p
JOIN possui po ON p.id_profissional = po.id_profissional
GROUP BY p.id_profissional, p.nome;

-- ============================================================
-- 4. UPDATES
-- ============================================================

UPDATE telefone
SET telefone = '(61) 98888-1001'
WHERE id_telefone = 1;

UPDATE prescricao
SET observacoes = 'Paciente deve tomar a medicação após as refeições.'
WHERE id_prescricao = 3;

UPDATE agendamento
SET status = 'Realizado'
WHERE id_agendamento = 4;

-- ============================================================
-- 5. VERIFICAÇÃO FINAL
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM profissional) AS profissionais,
    (SELECT COUNT(*) FROM medico) AS medicos,
    (SELECT COUNT(*) FROM enfermeiro) AS enfermeiros,
    (SELECT COUNT(*) FROM especialidade) AS especialidades,
    (SELECT COUNT(*) FROM medicamento) AS medicamentos,
    (SELECT COUNT(*) FROM prescricao) AS prescricoes,
    (SELECT COUNT(*) FROM prontuario_paciente) AS pacientes,
    (SELECT COUNT(*) FROM agendamento) AS agendamentos,
    (SELECT COUNT(*) FROM atendimento) AS atendimentos,
    (SELECT COUNT(*) FROM exame) AS exames;
