# Sistema de Gerenciamento Hospitalar

Projeto desenvolvido para a disciplina de  Labortório Banco de Dados do curso de Engenharia de Software.

# Aluno: Arthur Almeida Bastos UC25100852 

## Sobre o projeto

O projeto consiste no desenvolvimento de um banco de dados relacional para um Sistema de Gerenciamento Hospitalar.

O banco de dados permite organizar informações relacionadas a pacientes, prontuários, profissionais de saúde, médicos, enfermeiros, especialidades, agendamentos, atendimentos, prescrições, medicamentos e exames.

## Modelagem

O projeto foi desenvolvido em três etapas:

* **Modelo Conceitual:** desenvolvido no BRModelo;
* **Modelo Lógico:** desenvolvido no BRModelo;
* **Modelo Físico:** implementado e representado no MySQL Workbench.

## Tecnologias utilizadas

* MySQL
* MySQL Workbench
* BRModelo
* SQL

## Estrutura do projeto

```text
hospital-banco-dados/
├── modelos/
│   ├── README.md
│   ├── modelo_conceitual.png
│   ├── modelo_logico.png
│   └── modelo_fisico.png
│
├── sql/
│   └── hospital.sql
│
└── README.md
```

## Conteúdo do banco

O banco possui tabelas relacionadas a:

* Profissionais;
* Médicos e enfermeiros;
* Especialidades;
* Pacientes e prontuários;
* Agendamentos;
* Atendimentos;
* Prescrições;
* Medicamentos;
* Exames.

## Script SQL

O arquivo `hospital.sql` contém os comandos utilizados para criação das tabelas, inserção dos dados, consultas e atualizações do banco de dados.
