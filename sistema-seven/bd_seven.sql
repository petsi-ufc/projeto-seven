--
-- PostgreSQL database dump
--

-- Started on 2010-07-21 16:22:25 BRT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 5 (class 2615 OID 17195)
-- Name: evento; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA evento;


ALTER SCHEMA evento OWNER TO postgres;

--
-- TOC entry 336 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = evento, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1523 (class 1259 OID 17196)
-- Dependencies: 5
-- Name: atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE atividade (
    id bigint NOT NULL,
    local character varying(100),
    nome character varying(100),
    evento_id bigint,
    tipo_id bigint,
    vagas integer
);


ALTER TABLE evento.atividade OWNER TO postgres;

--
-- TOC entry 1524 (class 1259 OID 17199)
-- Dependencies: 5
-- Name: atividade_horario; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE atividade_horario (
    atividade_id bigint NOT NULL,
    horario_id bigint NOT NULL
);


ALTER TABLE evento.atividade_horario OWNER TO postgres;

--
-- TOC entry 1536 (class 1259 OID 25431)
-- Dependencies: 5
-- Name: atividade_responsavel; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE atividade_responsavel (
    responsavel_id bigint,
    atividade_id bigint
);


ALTER TABLE evento.atividade_responsavel OWNER TO postgres;

--
-- TOC entry 1525 (class 1259 OID 17202)
-- Dependencies: 5
-- Name: evento; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE evento (
    id bigint NOT NULL,
    nome character varying(100),
    sigla character varying(20),
    tema character varying(100),
    inicio_inscricao date,
    fim_inscricao date,
    ativo boolean,
    admin_id bigint,
    descricao character varying(2048)
);


ALTER TABLE evento.evento OWNER TO postgres;

--
-- TOC entry 1526 (class 1259 OID 17205)
-- Dependencies: 5
-- Name: horario; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE horario (
    id bigint NOT NULL,
    horainicio integer,
    mininicio integer,
    horafim integer,
    minfim integer,
    dia date
);


ALTER TABLE evento.horario OWNER TO postgres;

--
-- TOC entry 1527 (class 1259 OID 17208)
-- Dependencies: 1815 5
-- Name: inscricao; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE inscricao (
    id bigint NOT NULL,
    data_realizacao date,
    confirmada boolean DEFAULT false,
    data_pagamento date,
    participante_id bigint,
    evento_id bigint,
    modalidade_id bigint
);


ALTER TABLE evento.inscricao OWNER TO postgres;

--
-- TOC entry 1528 (class 1259 OID 17212)
-- Dependencies: 5
-- Name: inscricao_atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE inscricao_atividade (
    inscricao_id bigint NOT NULL,
    atividade_id bigint NOT NULL
);


ALTER TABLE evento.inscricao_atividade OWNER TO postgres;

--
-- TOC entry 1529 (class 1259 OID 17215)
-- Dependencies: 5
-- Name: modalidade_inscricao; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE modalidade_inscricao (
    id bigint NOT NULL,
    tipo character varying(50)
);


ALTER TABLE evento.modalidade_inscricao OWNER TO postgres;

--
-- TOC entry 1537 (class 1259 OID 33623)
-- Dependencies: 5
-- Name: modalidade_tipo_atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE modalidade_tipo_atividade (
    modalidade_id bigint NOT NULL,
    tipo_ativ_id bigint NOT NULL,
    preco real
);


ALTER TABLE evento.modalidade_tipo_atividade OWNER TO postgres;

--
-- TOC entry 1530 (class 1259 OID 17221)
-- Dependencies: 5
-- Name: movimentacao; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE movimentacao (
    id bigint NOT NULL,
    data date,
    valor double precision,
    tipo character varying(20),
    descricao character varying(100),
    evento_id bigint
);


ALTER TABLE evento.movimentacao OWNER TO postgres;

--
-- TOC entry 1870 (class 0 OID 0)
-- Dependencies: 1530
-- Name: TABLE movimentacao; Type: COMMENT; Schema: evento; Owner: postgres
--

COMMENT ON TABLE movimentacao IS 'Registra as movimentações financeiras de um evento. Que podem referir-se tanto a um débito quanto a um crédito.';


--
-- TOC entry 1531 (class 1259 OID 17224)
-- Dependencies: 1816 1817 5
-- Name: organizacao; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE organizacao (
    id bigint NOT NULL,
    organizador_id bigint NOT NULL,
    evento_id bigint NOT NULL,
    manter_mod_financeiro boolean DEFAULT false,
    manter_atividade boolean DEFAULT false
);


ALTER TABLE evento.organizacao OWNER TO postgres;

--
-- TOC entry 1532 (class 1259 OID 17229)
-- Dependencies: 5
-- Name: papel; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE papel (
    id bigint NOT NULL,
    nome character varying,
    descricao character varying(100)
);


ALTER TABLE evento.papel OWNER TO postgres;

--
-- TOC entry 1533 (class 1259 OID 17235)
-- Dependencies: 5
-- Name: perfil; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE perfil (
    id bigint NOT NULL,
    usuario_id bigint,
    papel_id bigint,
    data_criacao date,
    status boolean
);


ALTER TABLE evento.perfil OWNER TO postgres;

--
-- TOC entry 1534 (class 1259 OID 17238)
-- Dependencies: 5
-- Name: tipo_atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_atividade (
    id bigint NOT NULL,
    nome character varying(50)
);


ALTER TABLE evento.tipo_atividade OWNER TO postgres;

--
-- TOC entry 1535 (class 1259 OID 17241)
-- Dependencies: 5
-- Name: usuario; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    id bigint NOT NULL,
    nome character varying(100),
    senha character varying(50),
    fone character varying(12),
    data_nasc date,
    email character varying(50),
    sexo character varying(20),
    instituicao character(50),
    rua character varying(50),
    bairro character varying(50),
    num_casa character varying(20),
    cidade character varying(50),
    uf character varying(50)
);


ALTER TABLE evento.usuario OWNER TO postgres;

--
-- TOC entry 1821 (class 2606 OID 25445)
-- Dependencies: 1524 1524 1524
-- Name: ativ_hor_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY atividade_horario
    ADD CONSTRAINT ativ_hor_pk PRIMARY KEY (atividade_id, horario_id);


--
-- TOC entry 1819 (class 2606 OID 17248)
-- Dependencies: 1523 1523
-- Name: atividade_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY atividade
    ADD CONSTRAINT atividade_pk PRIMARY KEY (id);


--
-- TOC entry 1823 (class 2606 OID 17250)
-- Dependencies: 1525 1525
-- Name: envento_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT envento_pk PRIMARY KEY (id);


--
-- TOC entry 1825 (class 2606 OID 17252)
-- Dependencies: 1526 1526
-- Name: horario_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY horario
    ADD CONSTRAINT horario_pk PRIMARY KEY (id);


--
-- TOC entry 1829 (class 2606 OID 25447)
-- Dependencies: 1528 1528 1528
-- Name: insc_ativ_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inscricao_atividade
    ADD CONSTRAINT insc_ativ_pk PRIMARY KEY (inscricao_id, atividade_id);


--
-- TOC entry 1827 (class 2606 OID 17254)
-- Dependencies: 1527 1527
-- Name: inscricao_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT inscricao_pk PRIMARY KEY (id);


--
-- TOC entry 1845 (class 2606 OID 33627)
-- Dependencies: 1537 1537 1537
-- Name: mod_tipo_ativ_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modalidade_tipo_atividade
    ADD CONSTRAINT mod_tipo_ativ_pk PRIMARY KEY (modalidade_id, tipo_ativ_id);


--
-- TOC entry 1831 (class 2606 OID 17256)
-- Dependencies: 1529 1529
-- Name: modalidade_inscricao_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modalidade_inscricao
    ADD CONSTRAINT modalidade_inscricao_pk PRIMARY KEY (id);


--
-- TOC entry 1833 (class 2606 OID 17258)
-- Dependencies: 1530 1530
-- Name: movimentacao_financeira_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY movimentacao
    ADD CONSTRAINT movimentacao_financeira_pk PRIMARY KEY (id);


--
-- TOC entry 1835 (class 2606 OID 17260)
-- Dependencies: 1531 1531
-- Name: organizacao_fk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organizacao
    ADD CONSTRAINT organizacao_fk PRIMARY KEY (id);


--
-- TOC entry 1837 (class 2606 OID 17262)
-- Dependencies: 1532 1532
-- Name: papel_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY papel
    ADD CONSTRAINT papel_pk PRIMARY KEY (id);


--
-- TOC entry 1839 (class 2606 OID 17264)
-- Dependencies: 1533 1533
-- Name: perfil_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT perfil_pk PRIMARY KEY (id);


--
-- TOC entry 1841 (class 2606 OID 17266)
-- Dependencies: 1534 1534
-- Name: tipo_atividade_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_atividade
    ADD CONSTRAINT tipo_atividade_pk PRIMARY KEY (id);


--
-- TOC entry 1843 (class 2606 OID 17268)
-- Dependencies: 1535 1535
-- Name: usuario_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id);


--
-- TOC entry 1846 (class 2606 OID 17269)
-- Dependencies: 1525 1822 1523
-- Name: ativ_eve_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade
    ADD CONSTRAINT ativ_eve_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1848 (class 2606 OID 17274)
-- Dependencies: 1523 1524 1818
-- Name: ativ_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_horario
    ADD CONSTRAINT ativ_fk FOREIGN KEY (atividade_id) REFERENCES atividade(id);


--
-- TOC entry 1861 (class 2606 OID 25434)
-- Dependencies: 1818 1523 1536
-- Name: atividade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_responsavel
    ADD CONSTRAINT atividade_fk FOREIGN KEY (atividade_id) REFERENCES atividade(id);


--
-- TOC entry 1850 (class 2606 OID 17284)
-- Dependencies: 1535 1525 1842
-- Name: eve_usu_id; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT eve_usu_id FOREIGN KEY (admin_id) REFERENCES usuario(id);


--
-- TOC entry 1857 (class 2606 OID 17289)
-- Dependencies: 1525 1531 1822
-- Name: evento_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY organizacao
    ADD CONSTRAINT evento_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1849 (class 2606 OID 17294)
-- Dependencies: 1524 1824 1526
-- Name: hor_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_horario
    ADD CONSTRAINT hor_fk FOREIGN KEY (horario_id) REFERENCES horario(id);


--
-- TOC entry 1854 (class 2606 OID 17299)
-- Dependencies: 1818 1523 1528
-- Name: insc_ativ_ativ_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao_atividade
    ADD CONSTRAINT insc_ativ_ativ_fk FOREIGN KEY (atividade_id) REFERENCES atividade(id);


--
-- TOC entry 1855 (class 2606 OID 17304)
-- Dependencies: 1826 1527 1528
-- Name: insc_ativ_insc_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao_atividade
    ADD CONSTRAINT insc_ativ_insc_fk FOREIGN KEY (inscricao_id) REFERENCES inscricao(id);


--
-- TOC entry 1851 (class 2606 OID 17309)
-- Dependencies: 1527 1525 1822
-- Name: insc_eve_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT insc_eve_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1852 (class 2606 OID 17314)
-- Dependencies: 1529 1830 1527
-- Name: modalidade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT modalidade_fk FOREIGN KEY (modalidade_id) REFERENCES modalidade_inscricao(id);


--
-- TOC entry 1863 (class 2606 OID 33628)
-- Dependencies: 1537 1830 1529
-- Name: modalidade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY modalidade_tipo_atividade
    ADD CONSTRAINT modalidade_fk FOREIGN KEY (modalidade_id) REFERENCES modalidade_inscricao(id);


--
-- TOC entry 1856 (class 2606 OID 17324)
-- Dependencies: 1530 1822 1525
-- Name: movimentancao_evento_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY movimentacao
    ADD CONSTRAINT movimentancao_evento_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1859 (class 2606 OID 17329)
-- Dependencies: 1533 1532 1836
-- Name: papel_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT papel_fk FOREIGN KEY (papel_id) REFERENCES papel(id);


--
-- TOC entry 1862 (class 2606 OID 25439)
-- Dependencies: 1842 1535 1536
-- Name: responsavel_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_responsavel
    ADD CONSTRAINT responsavel_fk FOREIGN KEY (responsavel_id) REFERENCES usuario(id);


--
-- TOC entry 1864 (class 2606 OID 33633)
-- Dependencies: 1840 1534 1537
-- Name: tipo_ativ_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY modalidade_tipo_atividade
    ADD CONSTRAINT tipo_ativ_fk FOREIGN KEY (tipo_ativ_id) REFERENCES tipo_atividade(id);


--
-- TOC entry 1847 (class 2606 OID 17339)
-- Dependencies: 1534 1840 1523
-- Name: tipo_atividade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade
    ADD CONSTRAINT tipo_atividade_fk FOREIGN KEY (tipo_id) REFERENCES tipo_atividade(id);


--
-- TOC entry 1860 (class 2606 OID 17344)
-- Dependencies: 1535 1842 1533
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- TOC entry 1858 (class 2606 OID 17349)
-- Dependencies: 1531 1535 1842
-- Name: usuario_org_pk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY organizacao
    ADD CONSTRAINT usuario_org_pk FOREIGN KEY (organizador_id) REFERENCES usuario(id);


--
-- TOC entry 1853 (class 2606 OID 17354)
-- Dependencies: 1842 1527 1535
-- Name: usuario_part_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT usuario_part_fk FOREIGN KEY (participante_id) REFERENCES usuario(id);


--
-- TOC entry 1869 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-07-21 16:22:25 BRT

--
-- PostgreSQL database dump complete
--


INSERT INTO usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (1, 'Ismaily', 'a', '43', '2010-10-10', 'lucas', 'masculino', 'ufc                                               ', 'adsf', 'adf', '4', 'itapiuna', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (2, 'priscila freitas', 'a', '2434123', NULL, 'pri', 'femenino', 'FCRS                                              ', 'ana almeida', 'centro', '08998', 'Quixada', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (3, 'ismaily', 'a', '245', '2009-12-12', 'a', 'masculino', 'FCRS                                              ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (4, 'Lucas Ismaily', 'a', '98', '1987-07-04', 'b', 'Masculino', 'ufc                                               ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (5, 'fdf', 'a', '09', NULL, '989hjhjhhjjhjk', 'masculino', 'FCRS                                              ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (6, 'maria gorette', 'a', '3431-13-45', '1987-07-04', 'maria', 'Feminino', 'FCRS                                              ', 'ana almeida', 'centro', '01', 'Itapiuna', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (7, 'evandro', 'a', '123423', '1987-07-04', 'evandro', 'Masculino', 'FCRS                                              ', 'ana almeida', 'centro', '08998', 'hhkjhjh', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (8, 'andre', 'a', '233', '1987-07-04', 'andre', 'Masculino', 'FCRS                                              ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (9, 'egberto', 'a', '09', '1987-07-04', 'egberto', 'Masculino', 'ufc                                               ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (10, 'virginia', 'v', '09', '1987-07-04', 'v', 'Feminino', 'ufc                                               ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (11, 'dodo', 'a', '09', '1987-07-04', 'dodo', 'Masculino', 'FCRS                                              ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');
INSERT INTO evento.usuario (id, nome, senha, fone, data_nasc, email, sexo, instituicao, rua, bairro, num_casa, cidade, uf) VALUES (12, 'tata', 'a', '09', '1987-07-04', 'tata', 'Feminino', 'FCRS                                              ', 'ana almeida', 'centro', '01', 'ahfjdshj', 'ce');


--
-- TOC entry 1867 (class 0 OID 17202)
-- Dependencies: 1525 1877
-- Data for Name: evento; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.evento (id, nome, sigla, tema, inicio_inscricao, fim_inscricao, ativo, admin_id, descricao) VALUES (2, 'WorShop', 'WS', 'Uma abordagem de orientação a objetos', '2010-12-12', '2010-12-13', true, NULL, 'Essfoas asdfsadioasdf asdfasdfasdiofaisdfioasd ');
INSERT INTO evento.evento (id, nome, sigla, tema, inicio_inscricao, fim_inscricao, ativo, admin_id, descricao) VALUES (1, 'maratona 2010', 'CC++', 'asdfadsfiadsio', '2010-12-12', '2010-12-13', true, NULL, 'kfjalskjflkdsjslkdfjfksdjfklasdjfadlks jjdsjdjkSADSAJDJASD
ASDjASJDJASKDhjKASDHKJASDhkjASDKJA
                        
                        ');


--
-- TOC entry 1876 (class 0 OID 17238)
-- Dependencies: 1534
-- Data for Name: tipo_atividade; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.tipo_atividade (id, nome) VALUES (1, 'curso');
INSERT INTO evento.tipo_atividade (id, nome) VALUES (2, 'palestra');


--
-- TOC entry 1865 (class 0 OID 17196)
-- Dependencies: 1523 1867 1876
-- Data for Name: atividade; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.atividade (id, local, nome, evento_id, tipo_id, vagas) VALUES (5, 'ufc', 'c', 1, 1, 23);
INSERT INTO evento.atividade (id, local, nome, evento_id, tipo_id, vagas) VALUES (1, 'itans', 'jsf', 1, 1, 30);
INSERT INTO evento.atividade (id, local, nome, evento_id, tipo_id, vagas) VALUES (2, 'yuyui', 'java', 1, 1, 76);
INSERT INTO evento.atividade (id, local, nome, evento_id, tipo_id, vagas) VALUES (3, 'ioi', 'python', 1, 1, 7);
INSERT INTO evento.atividade (id, local, nome, evento_id, tipo_id, vagas) VALUES (6, 'ufc', 'pascal', 1, 1, 23);
INSERT INTO evento.atividade (id, local, nome, evento_id, tipo_id, vagas) VALUES (7, 'ufc', 'tata', 2, 1, 12);


--
-- TOC entry 1868 (class 0 OID 17205)
-- Dependencies: 1526
-- Data for Name: horario; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.horario (id, horainicio, mininicio, horafim, minfim, dia) VALUES (1, 2, 2, 3, 3, '2010-03-03');
INSERT INTO evento.horario (id, horainicio, mininicio, horafim, minfim, dia) VALUES (2, 3, 2, 3, 4, '2010-03-03');
INSERT INTO evento.horario (id, horainicio, mininicio, horafim, minfim, dia) VALUES (3, 4, 4, 5, 5, '2010-03-03');


--
-- TOC entry 1866 (class 0 OID 17199)
-- Dependencies: 1524 1865 1868
-- Data for Name: atividade_horario; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (1, 3);
INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (2, 1);
INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (3, 2);
INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (5, 1);
INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (5, 2);
INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (7, 1);
INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (7, 2);
INSERT INTO evento.atividade_horario (atividade_id, horario_id) VALUES (7, 3);


--
-- TOC entry 1878 (class 0 OID 25431)
-- Dependencies: 1536 1865 1877
-- Data for Name: atividade_responsavel; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.atividade_responsavel (responsavel_id, atividade_id) VALUES (6, 7);


--
-- TOC entry 1871 (class 0 OID 17215)
-- Dependencies: 1529
-- Data for Name: modalidade_inscricao; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.modalidade_inscricao (id, tipo) VALUES (1, 'Estudante');
INSERT INTO evento.modalidade_inscricao (id, tipo) VALUES (2, 'Profissional');


--
-- TOC entry 1869 (class 0 OID 17208)
-- Dependencies: 1527 1867 1871 1877
-- Data for Name: inscricao; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.inscricao (id, data_realizacao, confirmada, data_pagamento, participante_id, evento_id, modalidade_id) VALUES (1, '2010-03-03', true, '2010-03-03', 6, 1, 1);
INSERT INTO evento.inscricao (id, data_realizacao, confirmada, data_pagamento, participante_id, evento_id, modalidade_id) VALUES (2, '2010-07-20', true, '2010-12-13', 8, 1, 1);
INSERT INTO evento.inscricao (id, data_realizacao, confirmada, data_pagamento, participante_id, evento_id, modalidade_id) VALUES (3, '2010-07-20', true, '2010-12-13', 9, 2, 1);
INSERT INTO evento.inscricao (id, data_realizacao, confirmada, data_pagamento, participante_id, evento_id, modalidade_id) VALUES (4, '2010-07-20', true, '2010-12-13', 9, 1, 1);
INSERT INTO evento.inscricao (id, data_realizacao, confirmada, data_pagamento, participante_id, evento_id, modalidade_id) VALUES (5, '2010-07-20', true, '2010-12-13', 10, 1, 1);


--
-- TOC entry 1870 (class 0 OID 17212)
-- Dependencies: 1528 1865 1869
-- Data for Name: inscricao_atividade; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (1, 2);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (1, 3);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (2, 5);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (2, 6);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (3, 7);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (4, 1);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (4, 2);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (5, 5);
INSERT INTO evento.inscricao_atividade (inscricao_id, atividade_id) VALUES (5, 1);


--
-- TOC entry 1879 (class 0 OID 33623)
-- Dependencies: 1537 1871 1876
-- Data for Name: modalidade_tipo_atividade; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.modalidade_tipo_atividade (modalidade_id, tipo_ativ_id, preco) VALUES (1, 2, 20);
INSERT INTO evento.modalidade_tipo_atividade (modalidade_id, tipo_ativ_id, preco) VALUES (2, 2, 20);
INSERT INTO evento.modalidade_tipo_atividade (modalidade_id, tipo_ativ_id, preco) VALUES (1, 1, 10);
INSERT INTO evento.modalidade_tipo_atividade (modalidade_id, tipo_ativ_id, preco) VALUES (2, 1, 10);


--
-- TOC entry 1872 (class 0 OID 17221)
-- Dependencies: 1530 1867
-- Data for Name: movimentacao; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.movimentacao (id, data, valor, tipo, descricao, evento_id) VALUES (1, '1997-07-04', 12, 'credito', 'fdsfjasd', 1);


--
-- TOC entry 1873 (class 0 OID 17224)
-- Dependencies: 1531 1867 1877
-- Data for Name: organizacao; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.organizacao (id, organizador_id, evento_id, manter_mod_financeiro, manter_atividade) VALUES (1, 2, 1, true, true);
INSERT INTO evento.organizacao (id, organizador_id, evento_id, manter_mod_financeiro, manter_atividade) VALUES (2, 3, 1, true, true);
INSERT INTO evento.organizacao (id, organizador_id, evento_id, manter_mod_financeiro, manter_atividade) VALUES (3, 2, 2, true, true);
INSERT INTO evento.organizacao (id, organizador_id, evento_id, manter_mod_financeiro, manter_atividade) VALUES (4, 3, 2, true, true);


--
-- TOC entry 1874 (class 0 OID 17229)
-- Dependencies: 1532
-- Data for Name: papel; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.papel (id, nome, descricao) VALUES (1, 'PARTICIPANTE', 'Tem permissao para inscrever- se em eventos');
INSERT INTO evento.papel (id, nome, descricao) VALUES (2, 'ORGANIZADOR', 'Tem permissao para alterar dados de um evento cadastrado');
INSERT INTO evento.papel (id, nome, descricao) VALUES (3, 'ADMINISTRADOR', 'Tem permissao para criar um novo evento no sistema e alocar organizadores para este.');


--
-- TOC entry 1875 (class 0 OID 17235)
-- Dependencies: 1533 1874 1877
-- Data for Name: perfil; Type: TABLE DATA; Schema: evento; Owner: postgres
--

INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (1, 1, 3, '2010-06-14', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (2, 2, 2, '2010-07-15', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (3, 3, 2, '2010-07-15', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (4, 4, 1, '2010-07-15', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (5, 5, 2, '2010-07-16', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (6, 6, 1, '2010-07-17', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (7, 7, 1, '2010-07-17', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (8, 8, 1, '2010-07-20', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (9, 9, 1, '2010-07-20', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (10, 10, 1, '2010-07-20', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (11, 11, 1, '2010-07-20', true);
INSERT INTO evento.perfil (id, usuario_id, papel_id, data_criacao, status) VALUES (12, 12, 1, '2010-07-20', true);


-- Completed on 2010-07-21 16:21:34 BRT

--
-- PostgreSQL database dump complete
--

