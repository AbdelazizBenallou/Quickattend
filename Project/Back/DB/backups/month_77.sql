--
-- PostgreSQL database dump
--

\restrict y4td0Gu8YJokvrZ0lU7WJa5UzPHM1drxnBuLKengDOqKZgxAShCc7hxfWfHCnOZ

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
1	Licence
2	Master
\.


--
-- Data for Name: level; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.level (level_id, name, created_at, degree_level_id) FROM stdin;
1	L1	2026-03-07 16:04:43.23604	1
2	L2	2026-03-07 16:04:48.220394	1
3	L3	2026-03-07 16:04:52.300519	1
4	M1	2026-03-07 16:05:06.753331	2
5	M2	2026-03-07 16:05:11.058071	2
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
222	41	2026-03-12 08:09:35.194	\N	127.0.0.1	curl/8.19.0-rc2
223	23	2026-03-12 08:14:29.059	\N	127.0.0.1	curl/8.19.0-rc2
224	42	2026-03-12 08:42:59.706	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
225	41	2026-03-12 08:44:30.005	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
226	41	2026-03-12 22:18:52.568	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
227	43	2026-03-12 22:42:40.619	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
228	43	2026-03-12 22:44:31.974	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
229	41	2026-03-12 22:50:16.996	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
230	41	2026-03-12 22:51:03.704	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
231	41	2026-03-12 23:19:33.319	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
232	41	2026-03-12 23:28:41.594	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
233	41	2026-03-12 23:28:42.883	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
234	41	2026-03-12 23:30:55.333	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
235	41	2026-03-12 23:58:27.359	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
236	41	2026-03-12 23:58:28.767	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
237	41	2026-03-12 23:58:51.651	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
238	44	2026-03-13 12:07:45.282	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
239	46	2026-03-13 12:08:12.165	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
240	47	2026-03-13 12:09:11.731	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
241	57	2026-03-13 13:02:00.388	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
242	57	2026-03-13 13:17:25.903	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
243	57	2026-03-13 13:17:28.462	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
244	57	2026-03-13 13:47:47.444	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
245	57	2026-03-13 15:52:50.184	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
246	57	2026-03-13 16:09:45.27	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
247	58	2026-03-14 10:55:28.842	\N	127.0.0.1	curl/8.19.0-rc2
248	59	2026-03-14 10:57:55.861	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
249	60	2026-03-14 11:10:41.043	\N	127.0.0.1	curl/8.19.0-rc2
250	61	2026-03-14 11:16:07.956	\N	127.0.0.1	curl/8.19.0-rc2
251	61	2026-03-14 11:17:42.13	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
252	62	2026-03-14 11:41:08.693	\N	127.0.0.1	curl/8.19.0-rc2
253	63	2026-03-14 11:41:49.911	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
254	64	2026-03-14 11:42:18.376	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
255	65	2026-03-14 11:42:58.702	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
256	65	2026-03-14 11:44:52.705	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
257	65	2026-03-14 11:56:59.715	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
258	65	2026-03-14 11:58:06.553	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
259	65	2026-03-14 12:30:54.514	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
260	65	2026-03-14 12:30:56.419	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
261	65	2026-03-14 12:53:25.142	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
262	65	2026-03-15 10:04:22.851	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
295	65	2026-03-15 19:18:23.527	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
296	65	2026-03-15 19:40:11.227	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
297	65	2026-03-15 19:40:59.952	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
298	65	2026-03-15 19:45:08.794	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
299	65	2026-03-15 19:46:16.559	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
300	65	2026-03-15 19:46:19.435	\N	127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36
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
19	view_users
20	delete_user
21	view_roles
22	view_role
23	create_role
24	update_role
25	delete_role
26	view_role_permissions
27	assign_role_permissions
29	view_workshops
30	create_workshop
31	view_workshop
32	update_workshop
33	delete_workshop
35	view_workshop_leaders
36	view_workshop_classes
37	view_degrees
38	update_profile
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.profile (user_id, first_name, last_name, date_birth, address, level_id, specialization_id) FROM stdin;
41	black	aziz	\N	\N	\N	\N
42	mohamed	mohamed	\N	\N	\N	\N
43	abdou	laclass	\N	\N	\N	\N
44	user	ones	\N	\N	\N	\N
46	user	ones	\N	\N	\N	\N
47	user	ones	\N	\N	\N	\N
48	user	ones	\N	\N	\N	\N
49	user	ones	\N	\N	\N	\N
50	user	ones	\N	\N	\N	\N
51	user	ones	\N	\N	\N	\N
52	user	ones	\N	\N	\N	\N
53	user	ones	\N	\N	\N	\N
54	user	ones	\N	\N	\N	\N
55	user	ones	\N	\N	\N	\N
56	user	ones	\N	\N	\N	\N
57	aziz	aziz	2004-03-13	Sidi Ali Mellal	3	1
58	ghost	ghost	\N	\N	\N	\N
59	alem	alem	\N	\N	\N	\N
60	ghost	ghost	\N	\N	\N	\N
61	ahmed	ahmed	2026-03-14	Tiaret	3	1
62	ghot	ghost	\N	\N	\N	\N
63	alem	alem	\N	\N	\N	\N
64	alem	alem	\N	\N	\N	\N
65	ahmed	ahmed	2026-03-14	Tiaret	4	4
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
1	19
1	20
1	21
1	22
1	23
1	24
1	25
1	26
1	27
1	29
1	30
1	31
1	32
1	33
1	35
1	36
1	37
4	38
\.


--
-- Data for Name: specialization; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.specialization (specialization_id, name) FROM stdin;
1	ISIL
2	SI
3	AI
4	RT
5	GL
6	GI
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
41	4
41	1
42	4
43	4
42	3
42	2
44	4
46	4
47	4
48	4
49	4
50	4
51	4
52	4
53	4
54	4
55	4
56	4
57	4
57	1
58	4
59	4
60	4
61	4
62	4
63	4
64	4
65	4
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
2	ahmed142@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$9cio7EOCLk6yqxvocOtq5A$DIUm9Lk3AbhtJIsp9rqgXZd4VJh47Cq80Mk9pmfq3+A	active	2026-02-23 17:12:22.448608
6	stud878ent1@test.com	$argon2id$v=19$m=65536,t=3,p=4$zOEEFe58bkOi0TdG7aCFIg$oynwIL/KmJWX2gfttNWAtQWVMXzJjib66kT0AaTTxe4	active	2026-03-01 18:35:58.85
8	stud878e78nt1@test.com	$argon2id$v=19$m=65536,t=3,p=4$0xKrM/5uU1IOyLkS3Qpplg$es+Xa8K29jDhtBRsAsAoGFymNLxx5U+XpgnjBQHO/Zo	active	2026-03-01 18:43:32.299
10	azizben@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$63HgZWcN3CZy1nqBeUCaqQ$PsHD1H+Q6sUvZG/k7wSdZxCPwGoPFpbN55Adv7jq8Nw	active	2026-03-02 10:03:15.259
11	azizaziz@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$C3/11G/dM07X0B6xyuanGA$nDNcFjVydb8qo6aa4Q3ZYjNMwpND9h3ljz64hnC3gMs	active	2026-03-03 21:26:17.275
16	azizaziz14@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$egozdGjViod6hc2R3vKWBg$FLWEC0gLsBxmkmwiBAAKOa3m98AtNUwjGM19eIJpji0	active	2026-03-03 21:34:23.969
17	azizggaziz14@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$XXCoZEQQ7Y7cmc5ZPCcTOQ$wLO2PD9ze1n8dSSYug33UHu3JiNex7GvIzth1GQqLNI	active	2026-03-03 22:19:52.71
18	azizggazi44z14@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$ljTE9qcO2iJZI5LV9FowIw$4TdJ59B1YgJ9TL06kG4olv9YKJF6o0RT9szEX7+Wsr8	active	2026-03-03 22:20:03.275
20	azizggazi44z1114@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$rzZXf+bTjCKXEmCPkVlD9Q$n21tNYomDLU5Z7ddSBlg+zflKP6oumnVIzwASLKDas8	active	2026-03-03 22:23:30.126
22	azizggazi44z1111114@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$f7u7Ajth1wSddPNRYLb9LA$vMU7+6nEVvlv70CcSNZpULxDdEARxL0ufYxjF84OPMs	active	2026-03-03 22:23:58.89
23	user@example.com	$argon2id$v=19$m=65536,t=3,p=4$IzyAFhY9glWOBJXxYLsZeA$3LB2Qb+2XIHcGDpMKek5OWEqucFrTzDz5jUlNpTJSZ0	active	2026-03-03 23:09:06.311
27	user@112example.com	$argon2id$v=19$m=65536,t=3,p=4$6vSSWpNf0lD/6vIJv0gxMQ$XuNwA1j+6EM8zdLQi3byJbjsp9X6HKyCrsYMhUq51us	active	2026-03-04 09:28:32.14
29	user@11212example.com	$argon2id$v=19$m=65536,t=3,p=4$Vbbiu4N8tVQDw6NNh5CWJQ$azGweEvba4Mx6XKAC9oLBLY1seZ6xa2md8puze0rGJk	active	2026-03-04 09:53:13.356
32	ghost@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$YYi4pUR/MFCeuvQgHqNOYQ$q8RB1oywuddg2gEA11B4ytkEU30Ls5CI5OmGwCY0DHo	active	2026-03-07 16:54:53.507
34	ghos12t@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$ceCEdc0GqiGvgY9QXCAbxw$dqcIGpkb4T8GsnhyHJZHR6om1N2yDYDIhoTcX0xsMSg	active	2026-03-07 16:55:25.778
35	ghos12t8@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$qL1PDIBLs5vIi3TV9M8S9w$HJPOTXJ2Pa1Cb7MVVRNQ6bviutOd39bwcp+vihSDG3g	active	2026-03-07 17:14:14.056
36	sidou1212@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$PyDdm/XekzgbgHYPK/fryw$voLthXNR+6tyngYk3lyFTuGa88q5NqxrZGVwj9w2xn0	active	2026-03-07 17:29:59.02
38	ahmed123@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$cSW1PF9ApBNw2VkNzlaH5Q$AkOTTgVDjw1S0PZgf1HObWMiFOEHCzTTMN/C6Pa8B6Y	active	2026-03-08 11:14:58.079
40	ahmed7878@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$d5PKxkqCUvw32WGVX7I2kQ$JlW2vQkLMNW8Yb8Nj+hsCpBxLa9imW7epGA6W0aLBvQ	active	2026-03-08 11:21:52.785
41	azizblack1414@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$tXxqIKwGwmye+/kWjcFFMg$6SuY6h5wcmvtAnOCG+82ycrByok/xy4/2pZy/0/iQHQ	active	2026-03-12 08:09:35.158
42	mohamed@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$lFbusDSusZf9PcBwV56+yA$kyIlj9MSmz98MTXkj1XZqPsb/QNv30TAMnqkJWa4qXU	active	2026-03-12 08:42:59.667
43	abdouaziz@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$bT4+DeAjiWgAIE/WYOPNeg$+vbUjbdIb9pPkmufqauHpRV61gnnCgzavzrpxRbLpUQ	active	2026-03-12 22:42:40.584
44	userone@gmailk.com	$argon2id$v=19$m=65536,t=3,p=4$p0A/xwXIMRbPaGI4X7CZHw$yfw0jdGab0igLev+WSCrnhj1uvJBhc18NLq0kdkiWqA	active	2026-03-13 12:07:45.198
46	userone1@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$AqzQhNsywW6zBP5zeW1zZg$HiTgE1cF/jKL+BqtfCqGIsUBGQOGUT9sWhfjdU6URas	active	2026-03-13 12:08:12.144
47	userone2@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$cvwnyGgY0bMirx1eQAv3NQ$wYvnjtQi+6ItEwYeeaf/ChOSYjCFqNq6Nu5iJgstNmo	active	2026-03-13 12:09:11.71
48	userone33@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$F8spYmQOXLdHpYcADYx1Og$+6VtF/XWxGQNKd1EN6cAyZCTAGZf9lp7t4h+kmi4FvA	active	2026-03-13 12:36:56.17
49	userone332@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$h/CUNHrSA1Kuurnhn22diA$SQ75u8eEl+ZgMARcgZQNkd3DXrRNAB6mfjd2hTIg6eo	active	2026-03-13 12:37:08.85
50	userone335552@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$bvCzJL4Y7F9R3W2dPLKYRQ$qV5S6RA9H3pityD2fVAgwAZswpSbsi0/YrmyaiYWo+0	active	2026-03-13 12:39:52.073
51	userone335552aa@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$O5mErCSvPrOe/y/gXNIPMw$JF7REu2S2Hd7HFcfT6cmAEYdZa3EPGTT0ter3/cl4Kg	active	2026-03-13 12:44:26.947
52	userone33aa2aa@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$GjGKBw10yFryVcg9yOAZQw$O4lnyiKssiqJUyU/KLSzBA/eMb3YLN28e/pM7umFEmk	active	2026-03-13 12:47:58.845
53	useronfe33aa2aa@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$7F3bGrd61fJE3LSt0hkjkg$Pvrn+EtCu8YN7c+EKXg25S0dDhZAOxkkP+OgevhYYPg	active	2026-03-13 12:51:16.389
54	useronfe33aa2aa@11gmail.com	$argon2id$v=19$m=65536,t=3,p=4$94ln7d5mNd8CMH1jqV27JA$yS5qDPl1GFasrzAwDjwrYZ7DVSxpnE6gxucf9b67cLw	active	2026-03-13 12:54:46.847
55	useronfe33aa2faa@11gmail.com	$argon2id$v=19$m=65536,t=3,p=4$Zqv/+CGvw3iIW0B/svnzLA$92BiVxubCL5jq2sqqH8OqS/lUkWZeYSd/uiZiirZ0wc	active	2026-03-13 12:57:16.516
56	useronfe33aa2faaff@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$3bMYTquQ7/WUDCISEjr6sg$zd6CkGdPoX/gKTxMwJ6SaGfnC8QJc4pastoe5I1Y1cg	active	2026-03-13 12:59:14.438
57	useronfe3d3aa2faaff@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$2mDxneUwW7XKTmoCRcodrA$DCtePLr6nEiFSXBr57aR2FY1IQhqeS9IXbvE5sF6YXs	active	2026-03-13 13:02:00.358
58	ghost11@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$1pDRU6YdW1f6vG1dFAFYjA$IuBFNXRxht40Nj6KIwDxzEXBYFM8kW/D8kq+KplbPMw	active	2026-03-14 10:55:28.81
59	alem@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$ER3dWWH0x2TA2gr0Hi4dNg$ED7QFIg9WzokjSC/zmPTbjD9sctFtw+igF/XoVVGKg0	active	2026-03-14 10:57:55.83
60	ghost111@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$OwZ6Oj7Ws2y+R0r5rsdI2g$DjIG5RlmZiVuAOSw2VdwdgqqEjRj6cQD99OZnz9w9pI	active	2026-03-14 11:10:41.019
61	ghost1111@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$IbRDmRGoPNPZKfSdg6jUgA$MPfbon+cXEeevS7b2YPxjnTVwG16CQ25vCjYO86f8Lg	active	2026-03-14 11:16:07.934
62	ghost11111œ@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$xj833Zi15Hy2zosfL6kKrg$O3rNSc6QpYuvY2ZuwSBvnyf6bEGmE5UHk4iFMGbohfk	active	2026-03-14 11:41:08.663
63	alem123@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$GQuHyLvDnxsaa1KclFCTEA$Y5xJ5GfqUUOffOwXSf/0XXPIxhHgc4/7FGyVbVXueB0	active	2026-03-14 11:41:49.888
64	alem123a@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$T8BixkLA4LdlAPb5ROtGiA$WPPEioFNV+1wdu+04yB3lxk2kDRZlw2JCIuUoOxwKJU	active	2026-03-14 11:42:18.342
65	ahmed14a@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$KXU5litJvOapJvKV/e4T8w$PUfkEIAJ3taJAX6QknWXY02w0dyvenCQ8uW8kZtcVmI	active	2026-03-14 11:42:58.676
\.


--
-- Data for Name: workshop; Type: TABLE DATA; Schema: public; Owner: Fredrick_Miller
--

COPY public.workshop (workshop_id, name, created_at, leader_user_id) FROM stdin;
1	Networks & CS	2026-03-12 23:24:42.254256	41
2	UI/UX	2026-03-13 00:06:18.647	42
\.


--
-- Name: class_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.class_class_id_seq', 1, false);


--
-- Name: degree_level_degree_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.degree_level_degree_level_id_seq', 2, true);


--
-- Name: level_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.level_level_id_seq', 5, true);


--
-- Name: login_history_login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.login_history_login_history_id_seq', 300, true);


--
-- Name: permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.permission_permission_id_seq', 38, true);


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

SELECT pg_catalog.setval('public.specialization_specialization_id_seq', 6, true);


--
-- Name: user_class_user_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.user_class_user_class_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.users_user_id_seq', 65, true);


--
-- Name: workshop_workshop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Fredrick_Miller
--

SELECT pg_catalog.setval('public.workshop_workshop_id_seq', 2, true);


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

\unrestrict y4td0Gu8YJokvrZ0lU7WJa5UzPHM1drxnBuLKengDOqKZgxAShCc7hxfWfHCnOZ

