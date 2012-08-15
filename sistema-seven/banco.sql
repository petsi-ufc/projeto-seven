--
-- PostgreSQL database dump
--

-- Started on 2012-08-10 11:58:42

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1871 (class 1262 OID 16677)
-- Name: seven; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE seven WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese_Brazil.1252' LC_CTYPE = 'Portuguese_Brazil.1252';


ALTER DATABASE seven OWNER TO postgres;

\connect seven

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 7 (class 2615 OID 16874)
-- Name: evento; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA evento;


ALTER SCHEMA evento OWNER TO postgres;

--
-- TOC entry 336 (class 2612 OID 16681)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = evento, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1523 (class 1259 OID 16875)
-- Dependencies: 7
-- Name: atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE atividade (
    id bigint NOT NULL,
    local character varying(100),
    nome character varying(100),
    evento_id bigint,
    tipo_id bigint,
    vagas integer,
    aceita_insc boolean
);


ALTER TABLE evento.atividade OWNER TO postgres;

--
-- TOC entry 1524 (class 1259 OID 16878)
-- Dependencies: 7
-- Name: atividade_horario; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE atividade_horario (
    atividade_id bigint NOT NULL,
    horario_id bigint NOT NULL
);


ALTER TABLE evento.atividade_horario OWNER TO postgres;

--
-- TOC entry 1525 (class 1259 OID 16881)
-- Dependencies: 7
-- Name: atividade_responsavel; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE atividade_responsavel (
    responsavel_id bigint NOT NULL,
    atividade_id bigint NOT NULL
);


ALTER TABLE evento.atividade_responsavel OWNER TO postgres;

--
-- TOC entry 1526 (class 1259 OID 16884)
-- Dependencies: 7
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
    descricao character varying(2048),
    inicio date,
    fim date
);


ALTER TABLE evento.evento OWNER TO postgres;

--
-- TOC entry 1527 (class 1259 OID 16890)
-- Dependencies: 7
-- Name: horario; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE horario (
    id bigint NOT NULL,
    horainicio integer,
    mininicio integer,
    horafim integer,
    minfim integer,
    dia date,
    evento_id bigint
);


ALTER TABLE evento.horario OWNER TO postgres;

--
-- TOC entry 1528 (class 1259 OID 16893)
-- Dependencies: 1815 7
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
-- TOC entry 1529 (class 1259 OID 16897)
-- Dependencies: 7
-- Name: inscricao_atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE inscricao_atividade (
    inscricao_id bigint NOT NULL,
    atividade_id bigint NOT NULL
);


ALTER TABLE evento.inscricao_atividade OWNER TO postgres;

--
-- TOC entry 1530 (class 1259 OID 16900)
-- Dependencies: 7
-- Name: modalidade_inscricao; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE modalidade_inscricao (
    id bigint NOT NULL,
    tipo character varying(50),
    evento_id bigint
);


ALTER TABLE evento.modalidade_inscricao OWNER TO postgres;

--
-- TOC entry 1531 (class 1259 OID 16903)
-- Dependencies: 7
-- Name: modalidade_tipo_atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE modalidade_tipo_atividade (
    modalidade_id bigint NOT NULL,
    tipo_ativ_id bigint NOT NULL,
    preco double precision
);


ALTER TABLE evento.modalidade_tipo_atividade OWNER TO postgres;

--
-- TOC entry 1532 (class 1259 OID 16906)
-- Dependencies: 7
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
-- TOC entry 1874 (class 0 OID 0)
-- Dependencies: 1532
-- Name: TABLE movimentacao; Type: COMMENT; Schema: evento; Owner: postgres
--

COMMENT ON TABLE movimentacao IS 'Registra as movimentações financeiras de um evento. Que podem referir-se tanto a um débito quanto a um crédito.';


--
-- TOC entry 1533 (class 1259 OID 16909)
-- Dependencies: 1816 1817 7
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
-- TOC entry 1534 (class 1259 OID 16914)
-- Dependencies: 7
-- Name: papel; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE papel (
    id bigint NOT NULL,
    nome character varying,
    descricao character varying(100)
);


ALTER TABLE evento.papel OWNER TO postgres;

--
-- TOC entry 1535 (class 1259 OID 16920)
-- Dependencies: 7
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
-- TOC entry 1536 (class 1259 OID 16923)
-- Dependencies: 7
-- Name: tipo_atividade; Type: TABLE; Schema: evento; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_atividade (
    id bigint NOT NULL,
    nome character varying(50),
    evento_id bigint
);


ALTER TABLE evento.tipo_atividade OWNER TO postgres;

--
-- TOC entry 1537 (class 1259 OID 16926)
-- Dependencies: 7
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
-- TOC entry 1821 (class 2606 OID 16933)
-- Dependencies: 1524 1524 1524
-- Name: ativ_hor_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY atividade_horario
    ADD CONSTRAINT ativ_hor_pk PRIMARY KEY (atividade_id, horario_id);


--
-- TOC entry 1823 (class 2606 OID 16935)
-- Dependencies: 1525 1525 1525
-- Name: ativ_resp_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY atividade_responsavel
    ADD CONSTRAINT ativ_resp_pk PRIMARY KEY (responsavel_id, atividade_id);


--
-- TOC entry 1819 (class 2606 OID 16937)
-- Dependencies: 1523 1523
-- Name: atividade_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY atividade
    ADD CONSTRAINT atividade_pk PRIMARY KEY (id);


--
-- TOC entry 1825 (class 2606 OID 16939)
-- Dependencies: 1526 1526
-- Name: envento_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT envento_pk PRIMARY KEY (id);


--
-- TOC entry 1827 (class 2606 OID 16941)
-- Dependencies: 1527 1527
-- Name: horario_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY horario
    ADD CONSTRAINT horario_pk PRIMARY KEY (id);


--
-- TOC entry 1831 (class 2606 OID 16943)
-- Dependencies: 1529 1529 1529
-- Name: insc_ativ_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inscricao_atividade
    ADD CONSTRAINT insc_ativ_pk PRIMARY KEY (inscricao_id, atividade_id);


--
-- TOC entry 1829 (class 2606 OID 16945)
-- Dependencies: 1528 1528
-- Name: inscricao_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT inscricao_pk PRIMARY KEY (id);


--
-- TOC entry 1835 (class 2606 OID 16947)
-- Dependencies: 1531 1531 1531
-- Name: mod_tipo_ativ_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modalidade_tipo_atividade
    ADD CONSTRAINT mod_tipo_ativ_pk PRIMARY KEY (modalidade_id, tipo_ativ_id);


--
-- TOC entry 1833 (class 2606 OID 16949)
-- Dependencies: 1530 1530
-- Name: modalidade_inscricao_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modalidade_inscricao
    ADD CONSTRAINT modalidade_inscricao_pk PRIMARY KEY (id);


--
-- TOC entry 1837 (class 2606 OID 16951)
-- Dependencies: 1532 1532
-- Name: movimentacao_financeira_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY movimentacao
    ADD CONSTRAINT movimentacao_financeira_pk PRIMARY KEY (id);


--
-- TOC entry 1839 (class 2606 OID 16953)
-- Dependencies: 1533 1533
-- Name: organizacao_fk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organizacao
    ADD CONSTRAINT organizacao_fk PRIMARY KEY (id);


--
-- TOC entry 1841 (class 2606 OID 16955)
-- Dependencies: 1534 1534
-- Name: papel_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY papel
    ADD CONSTRAINT papel_pk PRIMARY KEY (id);


--
-- TOC entry 1843 (class 2606 OID 16957)
-- Dependencies: 1535 1535
-- Name: perfil_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT perfil_pk PRIMARY KEY (id);


--
-- TOC entry 1845 (class 2606 OID 16959)
-- Dependencies: 1536 1536
-- Name: tipo_atividade_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_atividade
    ADD CONSTRAINT tipo_atividade_pk PRIMARY KEY (id);


--
-- TOC entry 1847 (class 2606 OID 16961)
-- Dependencies: 1537 1537
-- Name: usuario_pk; Type: CONSTRAINT; Schema: evento; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id);


--
-- TOC entry 1848 (class 2606 OID 16962)
-- Dependencies: 1824 1526 1523
-- Name: ativ_eve_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade
    ADD CONSTRAINT ativ_eve_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1850 (class 2606 OID 16967)
-- Dependencies: 1524 1818 1523
-- Name: ativ_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_horario
    ADD CONSTRAINT ativ_fk FOREIGN KEY (atividade_id) REFERENCES atividade(id);


--
-- TOC entry 1852 (class 2606 OID 16972)
-- Dependencies: 1525 1818 1523
-- Name: atividade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_responsavel
    ADD CONSTRAINT atividade_fk FOREIGN KEY (atividade_id) REFERENCES atividade(id);


--
-- TOC entry 1864 (class 2606 OID 16977)
-- Dependencies: 1824 1526 1533
-- Name: evento_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY organizacao
    ADD CONSTRAINT evento_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1854 (class 2606 OID 16982)
-- Dependencies: 1526 1842 1535
-- Name: evento_perfil_org_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_perfil_org_fk FOREIGN KEY (admin_id) REFERENCES perfil(id);


--
-- TOC entry 1851 (class 2606 OID 16987)
-- Dependencies: 1826 1524 1527
-- Name: hor_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_horario
    ADD CONSTRAINT hor_fk FOREIGN KEY (horario_id) REFERENCES horario(id);


--
-- TOC entry 1858 (class 2606 OID 16992)
-- Dependencies: 1523 1818 1529
-- Name: insc_ativ_ativ_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao_atividade
    ADD CONSTRAINT insc_ativ_ativ_fk FOREIGN KEY (atividade_id) REFERENCES atividade(id);


--
-- TOC entry 1859 (class 2606 OID 16997)
-- Dependencies: 1828 1528 1529
-- Name: insc_ativ_insc_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao_atividade
    ADD CONSTRAINT insc_ativ_insc_fk FOREIGN KEY (inscricao_id) REFERENCES inscricao(id);


--
-- TOC entry 1855 (class 2606 OID 17002)
-- Dependencies: 1824 1528 1526
-- Name: insc_eve_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT insc_eve_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1860 (class 2606 OID 17007)
-- Dependencies: 1526 1530 1824
-- Name: mi_evento_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY modalidade_inscricao
    ADD CONSTRAINT mi_evento_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1856 (class 2606 OID 17012)
-- Dependencies: 1530 1832 1528
-- Name: modalidade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT modalidade_fk FOREIGN KEY (modalidade_id) REFERENCES modalidade_inscricao(id);


--
-- TOC entry 1861 (class 2606 OID 17017)
-- Dependencies: 1530 1531 1832
-- Name: modalidade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY modalidade_tipo_atividade
    ADD CONSTRAINT modalidade_fk FOREIGN KEY (modalidade_id) REFERENCES modalidade_inscricao(id);


--
-- TOC entry 1863 (class 2606 OID 17022)
-- Dependencies: 1526 1824 1532
-- Name: movimentancao_evento_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY movimentacao
    ADD CONSTRAINT movimentancao_evento_fk FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1866 (class 2606 OID 17027)
-- Dependencies: 1535 1534 1840
-- Name: papel_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT papel_fk FOREIGN KEY (papel_id) REFERENCES papel(id);


--
-- TOC entry 1853 (class 2606 OID 17032)
-- Dependencies: 1525 1535 1842
-- Name: responsavel_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade_responsavel
    ADD CONSTRAINT responsavel_fk FOREIGN KEY (responsavel_id) REFERENCES perfil(id);


--
-- TOC entry 1862 (class 2606 OID 17037)
-- Dependencies: 1531 1844 1536
-- Name: tipo_ativ_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY modalidade_tipo_atividade
    ADD CONSTRAINT tipo_ativ_fk FOREIGN KEY (tipo_ativ_id) REFERENCES tipo_atividade(id);


--
-- TOC entry 1868 (class 2606 OID 17042)
-- Dependencies: 1526 1824 1536
-- Name: tipo_atividade_evento_id_fkey; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY tipo_atividade
    ADD CONSTRAINT tipo_atividade_evento_id_fkey FOREIGN KEY (evento_id) REFERENCES evento(id);


--
-- TOC entry 1849 (class 2606 OID 17047)
-- Dependencies: 1523 1844 1536
-- Name: tipo_atividade_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY atividade
    ADD CONSTRAINT tipo_atividade_fk FOREIGN KEY (tipo_id) REFERENCES tipo_atividade(id);


--
-- TOC entry 1867 (class 2606 OID 17052)
-- Dependencies: 1846 1535 1537
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- TOC entry 1865 (class 2606 OID 17057)
-- Dependencies: 1533 1535 1842
-- Name: usuario_org_pk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY organizacao
    ADD CONSTRAINT usuario_org_pk FOREIGN KEY (organizador_id) REFERENCES perfil(id);


--
-- TOC entry 1857 (class 2606 OID 17062)
-- Dependencies: 1842 1528 1535
-- Name: usuario_part_fk; Type: FK CONSTRAINT; Schema: evento; Owner: postgres
--

ALTER TABLE ONLY inscricao
    ADD CONSTRAINT usuario_part_fk FOREIGN KEY (participante_id) REFERENCES perfil(id);


--
-- TOC entry 1873 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-08-10 11:58:44

--
-- PostgreSQL database dump complete
--

