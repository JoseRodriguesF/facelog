USE facelog;

CREATE TABLE pendentes (
    id_pendente INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao_erro VARCHAR(500) NOT NULL,
    inicio_incidente DATETIME NOT NULL,
    setor ENUM('Segurança da Informação', 'Engenharia de Software', 'Análise de Dados e IA', 'Interface Web') NOT NULL,
    urgencia ENUM('baixa', 'média', 'alta') NOT NULL
);

-- Adicionar índices para as colunas que serão usadas como chaves estrangeiras
CREATE INDEX idx_titulo ON pendentes(titulo);
CREATE INDEX idx_descricao_erro ON pendentes(descricao_erro);
CREATE INDEX idx_inicio_incidente ON pendentes(inicio_incidente);
CREATE INDEX idx_setor ON pendentes(setor);
CREATE INDEX idx_urgencia ON pendentes(urgencia);

CREATE TABLE resolvidos (
    id_pendente INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao_erro VARCHAR(500) NOT NULL,
    inicio_incidente DATETIME NOT NULL,
    setor ENUM('Segurança da Informação', 'Engenharia de Software', 'Análise de Dados e IA', 'Interface Web') NOT NULL,
    urgencia ENUM('baixa', 'média', 'alta') NOT NULL,
    descricao_resolucao VARCHAR(500) NOT NULL,
    mtta_inicio DATETIME NOT NULL,
    mtta_fim DATETIME NOT NULL,
    mttd_inicio DATETIME NOT NULL,
    mttd_fim DATETIME NOT NULL,
    fim_incidente DATETIME NOT NULL,
    FOREIGN KEY (id_pendente) REFERENCES pendentes(id_pendente) ON DELETE CASCADE,
    FOREIGN KEY (titulo) REFERENCES pendentes(titulo) ON DELETE CASCADE,
    FOREIGN KEY (descricao_erro) REFERENCES pendentes(descricao_erro) ON DELETE CASCADE,
    FOREIGN KEY (inicio_incidente) REFERENCES pendentes(inicio_incidente) ON DELETE CASCADE,
    FOREIGN KEY (setor) REFERENCES pendentes(setor) ON DELETE CASCADE,
    FOREIGN KEY (urgencia) REFERENCES pendentes(urgencia) ON DELETE CASCADE
);
