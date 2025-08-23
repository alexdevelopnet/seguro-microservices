-- Script para criar os bancos de dados necessários para SeguroPlatform
-- Execute este script conectado ao PostgreSQL como usuário postgres

-- Criar banco para PropostaService
CREATE DATABASE propostadb;

-- Criar banco para ContratacaoService  
CREATE DATABASE contratacaodb;

-- Verificar se foram criados
\l

-- Conectar ao banco propostadb e criar tabelas (opcional)
\c propostadb;

-- Conectar ao banco contratacaodb e criar tabelas (opcional)
\c contratacaodb;
