--
-- PostgreSQL database dump
--

\restrict o5DtgmVKoFBE3YqlrWcyWeWRs4XIFBunGFF7GcvVJ8f6ud99h4vD7X95EvD0NIw

-- Dumped from database version 17.8 (Debian 17.8-1.pgdg13+1)
-- Dumped by pg_dump version 17.8 (Debian 17.8-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: user_status; Type: TYPE; Schema: public; Owner: Fredrick_Miller
--

CREATE TYPE public.user_status AS ENUM (
    'active',
    'inactive',
    'locked',
    'suspended'
);


ALTER TYPE public.user_status OWNER TO "Fredrick_Miller";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: class; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.class (
    class_id integer NOT NULL,
    name text NOT NULL,
    date date,
    created_at timestamp without time zone DEFAULT now(),
    workshop_id integer NOT NULL
);


ALTER TABLE public.class OWNER TO "Fredrick_Miller";

--
-- Name: class_class_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.class_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.class_class_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: class_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.class_class_id_seq OWNED BY public.class.class_id;


--
-- Name: degree_level; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.degree_level (
    degree_level_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.degree_level OWNER TO "Fredrick_Miller";

--
-- Name: degree_level_degree_level_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.degree_level_degree_level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.degree_level_degree_level_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: degree_level_degree_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.degree_level_degree_level_id_seq OWNED BY public.degree_level.degree_level_id;


--
-- Name: level; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.level (
    level_id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    degree_level_id integer NOT NULL
);


ALTER TABLE public.level OWNER TO "Fredrick_Miller";

--
-- Name: level_level_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.level_level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.level_level_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: level_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.level_level_id_seq OWNED BY public.level.level_id;


--
-- Name: level_specialization; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.level_specialization (
    level_id integer NOT NULL,
    specialization_id integer NOT NULL
);


ALTER TABLE public.level_specialization OWNER TO "Fredrick_Miller";

--
-- Name: login_history; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.login_history (
    login_history_id integer NOT NULL,
    user_id integer NOT NULL,
    login_at timestamp without time zone DEFAULT now(),
    logout_at timestamp without time zone,
    ip_address text,
    user_agent text
);


ALTER TABLE public.login_history OWNER TO "Fredrick_Miller";

--
-- Name: login_history_login_history_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.login_history_login_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_history_login_history_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: login_history_login_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.login_history_login_history_id_seq OWNED BY public.login_history.login_history_id;


--
-- Name: permission; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.permission (
    permission_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.permission OWNER TO "Fredrick_Miller";

--
-- Name: permission_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.permission_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permission_permission_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: permission_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.permission_permission_id_seq OWNED BY public.permission.permission_id;


--
-- Name: profile; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.profile (
    user_id integer NOT NULL,
    first_name text,
    last_name text,
    date_birth date,
    address text,
    level_id integer,
    specialization_id integer
);


ALTER TABLE public.profile OWNER TO "Fredrick_Miller";

--
-- Name: properties; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.properties (
    class_id integer NOT NULL,
    room_number text,
    capacity integer,
    equipment text
);


ALTER TABLE public.properties OWNER TO "Fredrick_Miller";

--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.refresh_tokens (
    refresh_token_id integer NOT NULL,
    user_id integer NOT NULL,
    token text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    revoked boolean DEFAULT false
);


ALTER TABLE public.refresh_tokens OWNER TO "Fredrick_Miller";

--
-- Name: refresh_tokens_refresh_token_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.refresh_tokens_refresh_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_tokens_refresh_token_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: refresh_tokens_refresh_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.refresh_tokens_refresh_token_id_seq OWNED BY public.refresh_tokens.refresh_token_id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.role OWNER TO "Fredrick_Miller";

--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.role_permission (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.role_permission OWNER TO "Fredrick_Miller";

--
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_role_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- Name: specialization; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.specialization (
    specialization_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.specialization OWNER TO "Fredrick_Miller";

--
-- Name: specialization_specialization_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.specialization_specialization_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specialization_specialization_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: specialization_specialization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.specialization_specialization_id_seq OWNED BY public.specialization.specialization_id;


--
-- Name: user_class; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.user_class (
    user_class_id integer NOT NULL,
    user_id integer NOT NULL,
    class_id integer NOT NULL
);


ALTER TABLE public.user_class OWNER TO "Fredrick_Miller";

--
-- Name: user_class_user_class_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.user_class_user_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_class_user_class_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: user_class_user_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.user_class_user_class_id_seq OWNED BY public.user_class.user_class_id;


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.user_role (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.user_role OWNER TO "Fredrick_Miller";

--
-- Name: user_workshop; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.user_workshop (
    user_id integer NOT NULL,
    workshop_id integer NOT NULL
);


ALTER TABLE public.user_workshop OWNER TO "Fredrick_Miller";

--
-- Name: users; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    status public.user_status DEFAULT 'active'::public.user_status NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO "Fredrick_Miller";

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: workshop; Type: TABLE; Schema: public; Owner: Fredrick_Miller
--

CREATE TABLE public.workshop (
    workshop_id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    leader_user_id integer
);


ALTER TABLE public.workshop OWNER TO "Fredrick_Miller";

--
-- Name: workshop_workshop_id_seq; Type: SEQUENCE; Schema: public; Owner: Fredrick_Miller
--

CREATE SEQUENCE public.workshop_workshop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workshop_workshop_id_seq OWNER TO "Fredrick_Miller";

--
-- Name: workshop_workshop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Fredrick_Miller
--

ALTER SEQUENCE public.workshop_workshop_id_seq OWNED BY public.workshop.workshop_id;


--
-- Name: class class_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.class ALTER COLUMN class_id SET DEFAULT nextval('public.class_class_id_seq'::regclass);


--
-- Name: degree_level degree_level_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.degree_level ALTER COLUMN degree_level_id SET DEFAULT nextval('public.degree_level_degree_level_id_seq'::regclass);


--
-- Name: level level_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.level ALTER COLUMN level_id SET DEFAULT nextval('public.level_level_id_seq'::regclass);


--
-- Name: login_history login_history_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.login_history ALTER COLUMN login_history_id SET DEFAULT nextval('public.login_history_login_history_id_seq'::regclass);


--
-- Name: permission permission_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.permission ALTER COLUMN permission_id SET DEFAULT nextval('public.permission_permission_id_seq'::regclass);


--
-- Name: refresh_tokens refresh_token_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN refresh_token_id SET DEFAULT nextval('public.refresh_tokens_refresh_token_id_seq'::regclass);


--
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- Name: specialization specialization_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.specialization ALTER COLUMN specialization_id SET DEFAULT nextval('public.specialization_specialization_id_seq'::regclass);


--
-- Name: user_class user_class_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_class ALTER COLUMN user_class_id SET DEFAULT nextval('public.user_class_user_class_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: workshop workshop_id; Type: DEFAULT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.workshop ALTER COLUMN workshop_id SET DEFAULT nextval('public.workshop_workshop_id_seq'::regclass);


--
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.class (class_id, name, date, created_at, workshop_id) FROM stdin;
\.


--
-- Data for Name: degree_level; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.degree_level (degree_level_id, name) FROM stdin;
\.


--
-- Data for Name: level; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.level (level_id, name, created_at, degree_level_id) FROM stdin;
\.


--
-- Data for Name: level_specialization; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.level_specialization (level_id, specialization_id) FROM stdin;
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.login_history (login_history_id, user_id, login_at, logout_at, ip_address, user_agent) FROM stdin;
1	1	2026-02-23 17:27:37.367	\N	127.0.0.1	PostmanRuntime/7.51.1
2	1	2026-02-23 17:28:11.791	\N	127.0.0.1	PostmanRuntime/7.51.1
3	1	2026-02-23 17:28:16.608	\N	127.0.0.1	PostmanRuntime/7.51.1
4	1	2026-02-23 17:28:20.986	\N	127.0.0.1	PostmanRuntime/7.51.1
5	1	2026-02-23 17:35:17.027	\N	127.0.0.1	PostmanRuntime/7.51.1
6	1	2026-02-23 17:36:41.901	\N	127.0.0.1	PostmanRuntime/7.51.1
7	1	2026-02-23 17:36:49.959	\N	127.0.0.1	PostmanRuntime/7.51.1
8	2	2026-02-23 17:40:23.173	\N	127.0.0.1	PostmanRuntime/7.51.1
9	2	2026-02-23 17:45:53.273	\N	127.0.0.1	PostmanRuntime/7.51.1
10	2	2026-02-23 17:47:32.578	\N	127.0.0.1	PostmanRuntime/7.51.1
11	2	2026-02-23 17:48:35.132	\N	127.0.0.1	PostmanRuntime/7.51.1
12	2	2026-02-23 18:20:18.429	\N	127.0.0.1	PostmanRuntime/7.51.1
13	2	2026-02-23 18:22:44.516	\N	127.0.0.1	PostmanRuntime/7.51.1
14	2	2026-02-23 18:24:03.762	\N	127.0.0.1	PostmanRuntime/7.51.1
15	2	2026-02-23 18:26:30.519	\N	127.0.0.1	PostmanRuntime/7.51.1
16	2	2026-02-23 18:26:37.029	\N	127.0.0.1	PostmanRuntime/7.51.1
17	2	2026-02-23 18:33:26.909	\N	127.0.0.1	PostmanRuntime/7.51.1
18	2	2026-02-23 18:33:32.03	\N	127.0.0.1	PostmanRuntime/7.51.1
19	2	2026-02-23 18:33:35.101	\N	127.0.0.1	PostmanRuntime/7.51.1
20	2	2026-02-23 18:33:37.105	\N	127.0.0.1	PostmanRuntime/7.51.1
21	2	2026-02-23 18:37:18.347	\N	127.0.0.1	PostmanRuntime/7.51.1
22	2	2026-02-23 18:38:15.704	\N	127.0.0.1	PostmanRuntime/7.51.1
23	2	2026-02-23 18:38:37.066	\N	127.0.0.1	PostmanRuntime/7.51.1
24	2	2026-02-23 21:09:17.101	\N	127.0.0.1	PostmanRuntime/7.51.1
25	2	2026-02-23 21:09:21.026	\N	127.0.0.1	PostmanRuntime/7.51.1
26	2	2026-02-23 21:09:25.043	\N	127.0.0.1	PostmanRuntime/7.51.1
27	2	2026-02-23 21:19:11.221	\N	127.0.0.1	python-requests/2.32.5
28	2	2026-02-23 21:19:12.399	\N	127.0.0.1	python-requests/2.32.5
29	2	2026-02-23 21:19:13.603	\N	127.0.0.1	python-requests/2.32.5
30	2	2026-02-23 21:19:14.787	\N	127.0.0.1	python-requests/2.32.5
31	2	2026-02-23 21:19:15.99	\N	127.0.0.1	python-requests/2.32.5
32	2	2026-02-23 21:19:17.299	\N	127.0.0.1	python-requests/2.32.5
33	2	2026-02-23 21:19:18.502	\N	127.0.0.1	python-requests/2.32.5
34	2	2026-02-23 21:19:19.669	\N	127.0.0.1	python-requests/2.32.5
35	2	2026-02-23 21:19:20.86	\N	127.0.0.1	python-requests/2.32.5
36	2	2026-02-23 21:19:22.059	\N	127.0.0.1	python-requests/2.32.5
37	2	2026-02-23 21:20:11.62	\N	127.0.0.1	python-requests/2.32.5
38	2	2026-02-23 21:20:12.795	\N	127.0.0.1	python-requests/2.32.5
39	2	2026-02-23 21:20:14.174	\N	127.0.0.1	python-requests/2.32.5
40	2	2026-02-23 21:20:15.351	\N	127.0.0.1	python-requests/2.32.5
41	2	2026-02-23 21:20:16.546	\N	127.0.0.1	python-requests/2.32.5
42	2	2026-02-23 21:20:17.707	\N	127.0.0.1	python-requests/2.32.5
43	2	2026-02-23 21:20:18.874	\N	127.0.0.1	python-requests/2.32.5
44	2	2026-02-23 21:20:20.041	\N	127.0.0.1	python-requests/2.32.5
45	2	2026-02-23 21:20:21.212	\N	127.0.0.1	python-requests/2.32.5
46	2	2026-02-23 21:20:22.382	\N	127.0.0.1	python-requests/2.32.5
47	2	2026-02-23 21:21:55.956	\N	127.0.0.1	python-requests/2.32.5
48	2	2026-02-23 21:21:58.286	\N	127.0.0.1	python-requests/2.32.5
49	2	2026-02-23 21:22:00.248	\N	127.0.0.1	python-requests/2.32.5
50	2	2026-02-23 21:22:02.26	\N	127.0.0.1	python-requests/2.32.5
51	2	2026-02-23 21:22:04.34	\N	127.0.0.1	python-requests/2.32.5
52	2	2026-02-23 21:22:06.312	\N	127.0.0.1	python-requests/2.32.5
53	2	2026-02-23 21:22:08.326	\N	127.0.0.1	python-requests/2.32.5
54	2	2026-02-23 21:22:10.182	\N	127.0.0.1	python-requests/2.32.5
55	2	2026-02-23 21:22:12.424	\N	127.0.0.1	python-requests/2.32.5
56	2	2026-02-23 21:22:14.543	\N	127.0.0.1	python-requests/2.32.5
57	2	2026-02-23 21:24:42.019	\N	127.0.0.1	python-requests/2.32.5
58	2	2026-02-23 21:24:43.948	\N	127.0.0.1	python-requests/2.32.5
59	2	2026-02-23 21:24:46.081	\N	127.0.0.1	python-requests/2.32.5
60	2	2026-02-23 21:24:47.965	\N	127.0.0.1	python-requests/2.32.5
61	2	2026-02-23 21:24:50.271	\N	127.0.0.1	python-requests/2.32.5
62	2	2026-02-23 21:24:52.469	\N	127.0.0.1	python-requests/2.32.5
63	2	2026-02-23 21:24:54.531	\N	127.0.0.1	python-requests/2.32.5
64	2	2026-02-23 21:24:56.628	\N	127.0.0.1	python-requests/2.32.5
65	2	2026-02-23 21:24:58.866	\N	127.0.0.1	python-requests/2.32.5
66	2	2026-02-23 21:25:00.787	\N	127.0.0.1	python-requests/2.32.5
67	2	2026-02-23 21:25:09.028	\N	127.0.0.1	python-requests/2.32.5
68	2	2026-02-23 21:25:11.141	\N	127.0.0.1	python-requests/2.32.5
69	2	2026-02-23 21:25:13.525	\N	127.0.0.1	python-requests/2.32.5
70	2	2026-02-23 21:25:21.011	\N	127.0.0.1	python-requests/2.32.5
71	2	2026-02-23 21:25:23.004	\N	127.0.0.1	python-requests/2.32.5
72	2	2026-02-23 21:25:25.437	\N	127.0.0.1	python-requests/2.32.5
73	2	2026-02-23 21:25:27.607	\N	127.0.0.1	python-requests/2.32.5
74	2	2026-02-23 21:25:29.909	\N	127.0.0.1	python-requests/2.32.5
75	2	2026-02-23 21:25:31.912	\N	127.0.0.1	python-requests/2.32.5
76	2	2026-02-23 21:25:34.429	\N	127.0.0.1	python-requests/2.32.5
77	2	2026-02-23 21:30:19.758	\N	127.0.0.1	PostmanRuntime/7.51.1
78	2	2026-02-23 21:34:50.193	\N	127.0.0.1	PostmanRuntime/7.51.1
79	2	2026-02-23 21:35:00.968	\N	127.0.0.1	PostmanRuntime/7.51.1
80	2	2026-02-23 21:35:24.536	\N	127.0.0.1	PostmanRuntime/7.51.1
81	2	2026-02-23 21:36:13.511	\N	127.0.0.1	PostmanRuntime/7.51.1
82	2	2026-02-23 21:36:25.819	\N	127.0.0.1	PostmanRuntime/7.51.1
83	2	2026-02-23 21:36:34.098	\N	127.0.0.1	PostmanRuntime/7.51.1
84	2	2026-02-23 21:38:14.131	\N	127.0.0.1	PostmanRuntime/7.51.1
85	2	2026-02-23 21:39:07.196	\N	127.0.0.1	PostmanRuntime/7.51.1
86	2	2026-02-23 21:39:13.16	\N	127.0.0.1	PostmanRuntime/7.51.1
87	2	2026-02-23 21:43:11.591	\N	127.0.0.1	PostmanRuntime/7.51.1
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.permission (permission_id, name) FROM stdin;
1	Add User
2	Update User
3	Delete User
4	Add WorkShop
5	Update WorkShop
6	Delete WorkShop
7	Add Class
8	Update Class
9	Delete Class
10	View Class Members
11	View Classes
12	add_member_to_workshop
13	view_workshop_members
14	remove_member_from_workshop
15	View_Profile
16	Edit Profile
17	mark_attendance
18	view_attendance
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.profile (user_id, first_name, last_name, date_birth, address, level_id, specialization_id) FROM stdin;
\.


--
-- Data for Name: properties; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.properties (class_id, room_number, capacity, equipment) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.refresh_tokens (refresh_token_id, user_id, token, expires_at, created_at, revoked) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.role (role_id, name) FROM stdin;
1	Super_Admin
2	Club_Leader
3	WorkShop_Leader
4	Student
\.


--
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.role_permission (role_id, permission_id) FROM stdin;
3	7
3	8
3	9
3	10
3	15
3	16
4	15
4	16
4	17
\.


--
-- Data for Name: specialization; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.specialization (specialization_id, name) FROM stdin;
\.


--
-- Data for Name: user_class; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.user_class (user_class_id, user_id, class_id) FROM stdin;
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.user_role (user_id, role_id) FROM stdin;
1	3
1	4
2	4
\.


--
-- Data for Name: user_workshop; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.user_workshop (user_id, workshop_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.users (user_id, email, password_hash, status, created_at) FROM stdin;
1	azizbenallou14@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$wNR38ssXFMN9dNx2U/U3uw$BIyBGF/4OCbFZQF2klAyWbbBCCZAUIXzrLHauY0dl8s	active	2026-02-23 09:55:26.298229
2	ahmed142@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$9cio7EOCLk6yqxvocOtq5A$DIUm9Lk3AbhtJIsp9rqgXZd4VJh47Cq80Mk9pmfq3+A	active	2026-02-23 17:12:22.448608
\.


--
-- Data for Name: workshop; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.workshop (workshop_id, name, created_at, leader_user_id) FROM stdin;
\.


--
-- Name: class_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.class_class_id_seq', 1, false);


--
-- Name: degree_level_degree_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.degree_level_degree_level_id_seq', 1, false);


--
-- Name: level_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.level_level_id_seq', 1, false);


--
-- Name: login_history_login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.login_history_login_history_id_seq', 87, true);


--
-- Name: permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.permission_permission_id_seq', 18, true);


--
-- Name: refresh_tokens_refresh_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.refresh_tokens_refresh_token_id_seq', 1, false);


--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.role_role_id_seq', 4, true);


--
-- Name: specialization_specialization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.specialization_specialization_id_seq', 1, false);


--
-- Name: user_class_user_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.user_class_user_class_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.users_user_id_seq', 2, true);


--
-- Name: workshop_workshop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.workshop_workshop_id_seq', 1, false);


--
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_pkey PRIMARY KEY (class_id);


--
-- Name: degree_level degree_level_name_key; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.degree_level
    ADD CONSTRAINT degree_level_name_key UNIQUE (name);


--
-- Name: degree_level degree_level_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.degree_level
    ADD CONSTRAINT degree_level_pkey PRIMARY KEY (degree_level_id);


--
-- Name: level level_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_pkey PRIMARY KEY (level_id);


--
-- Name: level_specialization level_specialization_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.level_specialization
    ADD CONSTRAINT level_specialization_pkey PRIMARY KEY (level_id, specialization_id);


--
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (login_history_id);


--
-- Name: permission permission_name_key; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_name_key UNIQUE (name);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (user_id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (class_id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (refresh_token_id);


--
-- Name: refresh_tokens refresh_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_key UNIQUE (token);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_permission role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- Name: specialization specialization_name_key; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.specialization
    ADD CONSTRAINT specialization_name_key UNIQUE (name);


--
-- Name: specialization specialization_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.specialization
    ADD CONSTRAINT specialization_pkey PRIMARY KEY (specialization_id);


--
-- Name: user_class user_class_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_class
    ADD CONSTRAINT user_class_pkey PRIMARY KEY (user_class_id);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: user_workshop user_workshop_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_workshop
    ADD CONSTRAINT user_workshop_pkey PRIMARY KEY (user_id, workshop_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: workshop workshop_pkey; Type: CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.workshop
    ADD CONSTRAINT workshop_pkey PRIMARY KEY (workshop_id);


--
-- Name: idx_class_workshop; Type: INDEX; Schema: public; Owner: Fredrick_Miller
--

CREATE INDEX idx_class_workshop ON public.class USING btree (workshop_id);


--
-- Name: idx_login_history_user; Type: INDEX; Schema: public; Owner: Fredrick_Miller
--

CREATE INDEX idx_login_history_user ON public.login_history USING btree (user_id);


--
-- Name: idx_refresh_tokens_user; Type: INDEX; Schema: public; Owner: Fredrick_Miller
--

CREATE INDEX idx_refresh_tokens_user ON public.refresh_tokens USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: Fredrick_Miller
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: class class_workshop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_workshop_id_fkey FOREIGN KEY (workshop_id) REFERENCES public.workshop(workshop_id) ON DELETE CASCADE;


--
-- Name: level level_degree_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.level
    ADD CONSTRAINT level_degree_level_id_fkey FOREIGN KEY (degree_level_id) REFERENCES public.degree_level(degree_level_id) ON DELETE CASCADE;


--
-- Name: level_specialization level_specialization_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.level_specialization
    ADD CONSTRAINT level_specialization_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.level(level_id) ON DELETE CASCADE;


--
-- Name: level_specialization level_specialization_specialization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.level_specialization
    ADD CONSTRAINT level_specialization_specialization_id_fkey FOREIGN KEY (specialization_id) REFERENCES public.specialization(specialization_id) ON DELETE CASCADE;


--
-- Name: login_history login_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: profile profile_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.level(level_id);


--
-- Name: profile profile_specialization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_specialization_id_fkey FOREIGN KEY (specialization_id) REFERENCES public.specialization(specialization_id);


--
-- Name: profile profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: properties properties_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.class(class_id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: role_permission role_permission_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permission(permission_id) ON DELETE CASCADE;


--
-- Name: role_permission role_permission_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;


--
-- Name: user_class user_class_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_class
    ADD CONSTRAINT user_class_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.class(class_id) ON DELETE CASCADE;


--
-- Name: user_class user_class_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_class
    ADD CONSTRAINT user_class_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_role user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON DELETE CASCADE;


--
-- Name: user_role user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_workshop user_workshop_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_workshop
    ADD CONSTRAINT user_workshop_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_workshop user_workshop_workshop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.user_workshop
    ADD CONSTRAINT user_workshop_workshop_id_fkey FOREIGN KEY (workshop_id) REFERENCES public.workshop(workshop_id) ON DELETE CASCADE;


--
-- Name: workshop workshop_leader_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Fredrick_Miller
--

ALTER TABLE ONLY public.workshop
    ADD CONSTRAINT workshop_leader_user_id_fkey FOREIGN KEY (leader_user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

\unrestrict o5DtgmVKoFBE3YqlrWcyWeWRs4XIFBunGFF7GcvVJ8f6ud99h4vD7X95EvD0NIw

