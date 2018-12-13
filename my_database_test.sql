--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: projects_tb; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.projects_tb (
    id integer NOT NULL,
    title character varying,
    specialty_id integer,
    detail character varying
);


ALTER TABLE public.projects_tb OWNER TO "Guest";

--
-- Name: projects_tb_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.projects_tb_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_tb_id_seq OWNER TO "Guest";

--
-- Name: projects_tb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.projects_tb_id_seq OWNED BY public.projects_tb.id;


--
-- Name: volunteers_tb; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.volunteers_tb (
    id integer NOT NULL,
    name character varying,
    project_id boolean
);


ALTER TABLE public.volunteers_tb OWNER TO "Guest";

--
-- Name: volunteers_tb_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.volunteers_tb_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_tb_id_seq OWNER TO "Guest";

--
-- Name: volunteers_tb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.volunteers_tb_id_seq OWNED BY public.volunteers_tb.id;


--
-- Name: projects_tb id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.projects_tb ALTER COLUMN id SET DEFAULT nextval('public.projects_tb_id_seq'::regclass);


--
-- Name: volunteers_tb id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.volunteers_tb ALTER COLUMN id SET DEFAULT nextval('public.volunteers_tb_id_seq'::regclass);


--
-- Data for Name: projects_tb; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.projects_tb (id, title, specialty_id, detail) FROM stdin;
\.


--
-- Data for Name: volunteers_tb; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.volunteers_tb (id, name, project_id) FROM stdin;
\.


--
-- Name: projects_tb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.projects_tb_id_seq', 1, false);


--
-- Name: volunteers_tb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.volunteers_tb_id_seq', 1, false);


--
-- Name: projects_tb projects_tb_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.projects_tb
    ADD CONSTRAINT projects_tb_pkey PRIMARY KEY (id);


--
-- Name: volunteers_tb volunteers_tb_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.volunteers_tb
    ADD CONSTRAINT volunteers_tb_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

