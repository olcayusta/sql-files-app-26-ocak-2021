--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: msg_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.msg_type AS ENUM (
    'text',
    'image',
    'hyperlink',
    'emoji',
    'rich text makeup'
);


ALTER TYPE public.msg_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answer_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer_comment (
    id integer NOT NULL,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
);


ALTER TABLE public.answer_comment OWNER TO postgres;

--
-- Name: answer_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answer_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_comment_id_seq OWNER TO postgres;

--
-- Name: answer_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answer_comment_id_seq OWNED BY public.answer_comment.id;


--
-- Name: question_answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_answer (
    id integer NOT NULL,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "questionId" integer,
    "rawContent" text
);


ALTER TABLE public.question_answer OWNER TO postgres;

--
-- Name: answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_id_seq OWNER TO postgres;

--
-- Name: answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answer_id_seq OWNED BY public.question_answer.id;


--
-- Name: chat_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_message (
    id integer NOT NULL,
    "roomId" integer NOT NULL,
    "userId" integer NOT NULL,
    content text NOT NULL,
    "creationTime" timestamp with time zone DEFAULT now(),
    type public.msg_type DEFAULT 'text'::public.msg_type
);


ALTER TABLE public.chat_message OWNER TO postgres;

--
-- Name: chat_mesage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_mesage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_mesage_id_seq OWNER TO postgres;

--
-- Name: chat_mesage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_mesage_id_seq OWNED BY public.chat_message.id;


--
-- Name: chat_room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_room (
    id integer NOT NULL,
    title text NOT NULL,
    type integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
);


ALTER TABLE public.chat_room OWNER TO postgres;

--
-- Name: chat_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_room_id_seq OWNER TO postgres;

--
-- Name: chat_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_room_id_seq OWNED BY public.chat_room.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    "senderId" integer,
    "receiverId" integer,
    text text,
    type integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "isRead" boolean
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_id_seq OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


--
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    content character varying(30000) NOT NULL,
    "creationTime" timestamp with time zone DEFAULT now() NOT NULL,
    "userId" integer NOT NULL,
    "viewCount" integer DEFAULT 0,
    tags integer[],
    tags2 integer[],
    "acceptedAnswerId" integer
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: question_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_comment (
    id integer NOT NULL,
    content text,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "questionId" integer
);


ALTER TABLE public.question_comment OWNER TO postgres;

--
-- Name: question_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_comment_id_seq OWNER TO postgres;

--
-- Name: question_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_comment_id_seq OWNED BY public.question_comment.id;


--
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_id_seq OWNER TO postgres;

--
-- Name: question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_id_seq OWNED BY public.question.id;


--
-- Name: question_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_revision (
    id integer NOT NULL,
    title character varying(128) NOT NULL,
    content text NOT NULL,
    "creationTime" timestamp with time zone DEFAULT now() NOT NULL,
    "questionId" integer NOT NULL,
    "userId" integer NOT NULL,
    tags integer[]
);


ALTER TABLE public.question_revision OWNER TO postgres;

--
-- Name: question_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_revision_id_seq OWNER TO postgres;

--
-- Name: question_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_revision_id_seq OWNED BY public.question_revision.id;


--
-- Name: question_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_tag (
    id integer NOT NULL,
    "questionId" integer,
    "tagId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.question_tag OWNER TO postgres;

--
-- Name: question_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_tag_id_seq OWNER TO postgres;

--
-- Name: question_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_tag_id_seq OWNED BY public.question_tag.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    title character varying(128),
    description text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(128) NOT NULL,
    password character varying(64) NOT NULL,
    "displayName" character varying(128) NOT NULL,
    picture text,
    "signupDate" timestamp with time zone DEFAULT now(),
    "githubUrl" text
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_favorite_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_favorite_answers (
    id integer NOT NULL,
    "answerId" integer NOT NULL,
    "userId" integer NOT NULL,
    "creationTime" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_favorite_answers OWNER TO postgres;

--
-- Name: user_favorite_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_favorite_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_favorite_answers_id_seq OWNER TO postgres;

--
-- Name: user_favorite_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_favorite_answers_id_seq OWNED BY public.user_favorite_answers.id;


--
-- Name: user_favorite_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_favorite_questions (
    id integer NOT NULL,
    "questionId" integer,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_favorite_questions OWNER TO postgres;

--
-- Name: user_favorite_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_favorite_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_favorite_questions_id_seq OWNER TO postgres;

--
-- Name: user_favorite_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_favorite_questions_id_seq OWNED BY public.user_favorite_questions.id;


--
-- Name: user_favorite_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_favorite_tags (
    id integer NOT NULL,
    "tagId" integer,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_favorite_tags OWNER TO postgres;

--
-- Name: user_favorite_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_favorite_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_favorite_tags_id_seq OWNER TO postgres;

--
-- Name: user_favorite_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_favorite_tags_id_seq OWNED BY public.user_favorite_tags.id;


--
-- Name: user_favorite_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_favorite_types (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.user_favorite_types OWNER TO postgres;

--
-- Name: user_favorite_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_favorite_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_favorite_types_id_seq OWNER TO postgres;

--
-- Name: user_favorite_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_favorite_types_id_seq OWNED BY public.user_favorite_types.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: answer_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comment ALTER COLUMN id SET DEFAULT nextval('public.answer_comment_id_seq'::regclass);


--
-- Name: chat_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message ALTER COLUMN id SET DEFAULT nextval('public.chat_mesage_id_seq'::regclass);


--
-- Name: chat_room id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room ALTER COLUMN id SET DEFAULT nextval('public.chat_room_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question ALTER COLUMN id SET DEFAULT nextval('public.question_id_seq'::regclass);


--
-- Name: question_answer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_answer ALTER COLUMN id SET DEFAULT nextval('public.answer_id_seq'::regclass);


--
-- Name: question_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_comment ALTER COLUMN id SET DEFAULT nextval('public.question_comment_id_seq'::regclass);


--
-- Name: question_revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_revision ALTER COLUMN id SET DEFAULT nextval('public.question_revision_id_seq'::regclass);


--
-- Name: question_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag ALTER COLUMN id SET DEFAULT nextval('public.question_tag_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_favorite_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_answers ALTER COLUMN id SET DEFAULT nextval('public.user_favorite_answers_id_seq'::regclass);


--
-- Name: user_favorite_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_questions ALTER COLUMN id SET DEFAULT nextval('public.user_favorite_questions_id_seq'::regclass);


--
-- Name: user_favorite_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_tags ALTER COLUMN id SET DEFAULT nextval('public.user_favorite_tags_id_seq'::regclass);


--
-- Name: user_favorite_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_types ALTER COLUMN id SET DEFAULT nextval('public.user_favorite_types_id_seq'::regclass);


--
-- Data for Name: answer_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answer_comment (id, content, "creationTime", "userId") FROM stdin;
\.


--
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_message (id, "roomId", "userId", content, "creationTime", type) FROM stdin;
1	1	1	Merhaba dunya.	2020-09-01 06:27:08.091904+03	text
2	1	1	Hey yo!	2020-09-09 19:36:55.909359+03	text
13	1	1	Test, ok!	2020-09-09 20:57:20.027385+03	text
14	1	1	I am a person.	2020-09-09 23:19:10.590178+03	text
15	1	1	hello world	2020-09-09 23:47:28.88986+03	text
16	1	1	hello world	2020-09-09 23:47:32.513119+03	text
17	1	1	hello world	2020-09-09 23:47:33.23862+03	text
18	1	1	hello world	2020-09-09 23:47:33.744747+03	text
19	1	1	hello world	2020-09-09 23:47:33.968974+03	text
20	1	1	hello world	2020-09-09 23:47:34.189939+03	text
21	1	1	hello world	2020-09-09 23:47:34.327857+03	text
22	1	1	Uppsss.	2020-09-10 00:09:14.520486+03	text
23	1	1	Ok	2020-09-10 00:09:44.24346+03	text
24	1	1	Uppss.	2020-09-10 00:10:38.82276+03	text
25	1	1	Upps.	2020-09-10 00:13:14.212953+03	text
26	1	1	Upsss.	2020-09-10 00:20:16.401319+03	text
27	1	1	XD	2020-09-10 00:20:23.213905+03	text
28	1	1	Upsss.	2020-09-10 00:21:01.02764+03	text
29	1	1	Upsss!!!	2020-09-10 00:21:27.433408+03	text
30	1	1	Upsss!!	2020-09-10 00:22:51.476294+03	text
31	1	1	Yes	2020-09-10 00:23:17.407647+03	text
32	1	1	Good job!	2020-09-10 00:23:36.059957+03	text
33	1	1	Xd	2020-09-10 00:23:40.111685+03	text
34	1	1	Upsss.	2020-09-10 00:24:05.731926+03	text
35	1	1	Ups!	2020-09-10 00:24:25.137076+03	text
36	1	1	Upsss!	2020-09-10 00:24:38.2941+03	text
37	1	1	Ups!	2020-09-10 00:32:43.562716+03	text
38	1	1	Good	2020-09-10 00:32:54.580503+03	text
39	1	1	Good job!	2020-09-10 00:32:58.541805+03	text
40	1	1	Ups!	2020-09-10 00:33:03.406128+03	text
41	1	1	Upss!	2020-09-10 00:50:47.373749+03	text
42	1	1	Upsss!	2020-09-10 00:52:01.285535+03	text
43	1	1	Good work.	2020-09-10 00:52:05.705385+03	text
44	1	1	Ups!	2020-09-10 00:56:35.314099+03	text
45	1	1	Ups	2020-09-10 02:09:20.271529+03	text
46	1	1	Ups...	2020-09-10 02:27:04.095309+03	text
47	1	1	Ups	2020-09-10 02:27:12.755855+03	text
48	1	1	Ups..	2020-09-10 02:27:40.143341+03	text
49	1	1	Hoodie.	2020-09-10 02:28:00.215535+03	text
50	1	1	Hey, yeah!	2020-09-22 22:14:12.492967+03	text
51	1	1	Heyyo	2020-09-22 22:14:18.332809+03	text
52	1	1	Heyyoh!	2020-09-22 22:21:07.738028+03	text
53	1	1	Ok!	2020-09-22 22:23:23.542486+03	text
54	1	1	Good job!	2020-09-22 22:23:28.105996+03	text
55	1	1	Ok!	2020-09-22 22:33:07.540418+03	text
56	1	1	Heyyoh!	2020-09-22 22:39:01.597669+03	text
57	1	1	op	2020-09-22 22:43:03.872465+03	text
58	1	1	Good job...	2020-09-22 22:43:10.429625+03	text
59	1	1	Good job!	2020-09-22 22:44:16.273109+03	text
60	1	1	hdlkjlkjdh	2020-09-22 22:44:18.022281+03	text
61	1	1	hdrljkhdjkl	2020-09-22 22:44:20.782142+03	text
62	1	1	Heyyoh!	2020-09-22 23:02:17.543094+03	text
63	1	1	Gooding!	2020-09-22 23:10:32.503758+03	text
64	1	1	Hey, yo!	2020-09-22 23:23:21.854946+03	text
65	1	1	Good job bro!	2020-09-22 23:53:50.129022+03	text
66	1	1	Good job.	2020-09-22 23:56:09.650629+03	text
67	1	1	xd	2020-10-17 04:39:10.914293+03	text
\.


--
-- Data for Name: chat_room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_room (id, title, type, "creationTime", "userId") FROM stdin;
1	Genel sohbet.	\N	2020-09-01 05:56:44.035594+03	\N
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, "senderId", "receiverId", text, type, "creationTime", "isRead") FROM stdin;
2	8	21	Merhaba dunya 2	1	2020-09-10 22:23:49.681162+03	f
3	7	21	Merhaba dunya.	1	2020-09-10 22:24:06.637231+03	f
1	2	21	#45, yorum beğenildi	1	2020-09-10 20:14:11.919224+03	f
4	1	7	Test	1	2020-10-29 05:07:21.522748+03	f
5	9	7	Test2	1	2020-10-29 05:07:31.649982+03	f
6	12	7	Test3	1	2020-10-29 05:07:42.296519+03	f
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (id, title, content, "creationTime", "userId", "viewCount", tags, tags2, "acceptedAnswerId") FROM stdin;
4	Toast not showing on screen	I have read the existing ionic 4 documentation but the following code does not show the toast:\n\n```\nasync prosesLogin(){\n  if(this.username != "" && this.password != ""){\n  .\n  . \n  .\n}else{\n  const toast = await this.toastCtrl.create({\n    message: 'Username or Password Invalid.',\n    duration: 2000\n  });\n  toast.present();\n}\n```\n\nFunction prosesLogin() is executed the following way:\n\n```\n<ion-button expand="block" padding color="tertiary" (click)="prosesLogin()">Sign In</ion-button>\n```	2020-08-15 19:26:19.527143+03	3	48	\N	\N	\N
10	Typing an adjust function	<p>I&#39;m looking to setup a function which takes an index, a function, and an array, and returns a clone of the array, except with the item at the index specified adjusted using the function.</p>\n<pre><code class="language-typescript">const adjust = &lt;T, U extends T[], V extends number&gt;(index: V) =&gt;\n  (f: (x: U[V]) =&gt; U[V]) =&gt; (xs: T[]) =&gt;\n    Object.assign([], xs, { [index]: f(xs[index]) });</code></pre>\n<p>I would hope that this would return the type <code>U</code>, but it returns type:</p>\n<pre><code class="language-typescript">never[] &amp; T[] &amp; {\n    [x: number]: U[V];\n}</code></pre>\n<p>Any thoughts on how I can get this to return a more usable type?</p>\n	2020-08-15 22:02:20.355704+03	5	471	\N	\N	\N
26	session ve üyelik adımları sayfaları	<p>merhaba php projemde giriş yapılınca diğer sayfalara gitmeden önce kullanıcının doldurmasını istediğim 3 sayfa var. o sayfalardaki girişleri yapmadan başka hiç bir sayfaya giriş yapmasını istemiyorum.</p>\n<p>mysql user tablosunda onay sütununda bu sayfaların giriş yapıp yapmadığını kontrol ediyorum.</p>\n<p>1.php\n2.php\n3.php</p>\n	2020-09-24 19:45:05.705904+03	3	21	\N	\N	\N
9	How to avoid java script duplicate code in if statement	<p>I have the following function with some stetemsnts inside:</p>\n<pre><code> isFieldVisible(node: any, field: DocumentField): boolean {\n        if (field.tag === &#39;ADDR_KOMU&#39;) {\n            let field = this.dfs_look(node.children, &#39;ADDR_APPLICANTTYPE&#39;);\n            return field.fieldvalue == 1;\n        }\n\n        if (field.tag === &#39;ADDR_SNAME&#39;) {\n            let field = this.dfs_look(node.children, &#39;ADDR_APPLICANTTYPE&#39;);\n            return field.fieldvalue == 1;\n        }\n\n        if (field.tag === &#39;ADDR_FNAME&#39;) {\n            let field = this.dfs_look(node.children, &#39;ADDR_APPLICANTTYPE&#39;);\n              return field.fieldvalue == 1 || field.fieldvalue == 2;\n        }\n}</code></pre>\n<p>How to improve it and avoid duplicates?</p>\n<p>I have tried to use foreach with tuple as iteration value, but I can not return boolean from foreach</p>\n	2020-08-15 22:01:50.198507+03	1	351	\N	\N	\N
19	Extend Express Request object using Typescript	<p>I’m trying to add a property to express request object from a middleware using typescript. However I can’t figure out how to add extra properties to the object. I’d prefer to not use bracket notation if possible. </p>\n<p>I’m looking for a solution that would allow me to write something similar to this (if possible):<br></p>\n<pre><code>app.use((req, res, next) =&gt; {\n    req.property = setProperty(); \n    next();\n});</code></pre>\n	2020-08-28 11:31:42.023354+03	1	225	\N	\N	\N
22	Align vertically using CSS 3	<p>With CSS 3, are there any way to vertically align an block element? Do you have an example?\nThank you.</p>\n	2020-09-17 04:30:09.476086+03	12	502	\N	\N	\N
17	Measuring web performance metrices in TypeScript front end program	<p>My front end is written in Angular9, TypeScript. </p>\n<p>I am interested to annotate my app with different page load time performance metrics (both browser timing as well as DOM handling) as suggested by W3 working group <a href="https://www.w3.org/webperf/">W3 performance working group</a>. </p>\n<p>How can I start importing the Performance object in my TypeScript app such that I can start monitoring the different performance metrics as mentioned <a href="https://web.dev/user-centric-performance-metrics/#important-metrics-to-measure">here</a>.</p>\n<p>Thanks,\nPradip</p>\n	2020-08-22 17:49:46.384471+03	2	145	\N	\N	\N
12	Unblocking clipboard access	<p>Over the past few years, browsers have used document.execCommand() for clipboard interactions. Though widely supported, this method of cutting and pasting came at a cost: clipboard access was synchronous, and could only read and write to the DOM.</p>\n<p>That&#39;s fine for small bits of text, but there are many cases where blocking the page for clipboard transfer is a poor experience. Time consuming sanitization or image decoding might be needed before content can be safely pasted. The browser may need to load or inline linked resources from a pasted document. That would block the page while waiting on the disk or network. Imagine adding permissions into the mix, requiring that the browser block the page while requesting clipboard access. At the same time, the permissions put in place around document.execCommand() for clipboard interaction are loosely defined and vary between browsers.</p>\n<pre><code>async function copyPageUrl() {\n  try {\n    await navigator.clipboard.writeText(location.href);\n    console.log(&#39;Page URL copied to clipboard&#39;);\n  } catch (err) {\n    console.error(&#39;Failed to copy: &#39;, err);\n  }\n}</code></pre>\n	2020-08-19 00:34:09.165593+03	4	116	\N	\N	\N
21	How to programmatically send a 404 response with Express/Node?	<p>I want to simulate a 404 error on my Express/Node server. How can I do that?</p>\n	2020-08-28 13:42:41.582811+03	9	477	\N	\N	\N
13	Yönetim paneli ver işleme kolaylığı Hk.	<p>Arkdaşlar merhaba yapacağım bir proje için yardım almak durumundayım yardımcı olursanız sevinmirm :)</p>\n<p>Web site yönetim paneli yapıyorum panel ve çalışır sistem hazır halde fakat veri işleme de kolaylık için aşağıdakşi sistem aklıma geldi</p>\n<p>Paneli 2 bölmeye ayırırz ve birinde web sitesi birinde veri gireceğimiz alan yer alır\nWeb sitesinde ayırdığımız bölümde siteden bir metinin üerine tıkladığımızda\nİkinci alan da buna denk gelen veri gireceğimiz alan açlır veya konumu gösterilir.</p>\n<p>Javascript ile gerçekleştirilecek bir şey bunun farkındayım fakat çok az derce de bildiğim için yardıma ihtiyacım var</p>\n<p>Şimdiden teşekkür ederim :)</p>\n	2020-08-19 05:03:02.688536+03	1	210	\N	\N	\N
25	Localhost'ta Çalışıyor, Hosting'de Çalışmıyor?	<p>Merhaba PT :)</p>\n<p>Ürün ekleme işlemi yapıyorum, localhostta sorunsuz çalışıyor fakat hostingde çalışmıyor. Görsel dosya izinlerinden olabilir diye görsel yükleme klasörüne 777 izni verdim, sonuç aynı.</p>\n<p><strong>errorInfo()</strong> sonuçları;</p>\n<pre><code class="language-Array">(\n    [0] =&gt; 00000\n    [1] =&gt; \n    [2] =&gt; \n)</code></pre>\n	2020-09-24 19:44:23.555213+03	14	23	\N	\N	\N
54	PHP calling function with parameters by clicking on HTML div	<p>I am trying to make a delete button which I&#39;ll be able to delete some user from my database but main thing how to call PHP function with clicking on some div etc..</p>\n<pre><code>&lt;div class=&quot;cross&quot; onclick=&#39;&lt;?php deleteUser(&quot;Nickname&quot;)?&gt;&#39;&gt;X&lt;/div&gt;\n&lt;?php\nfunction deleteUser($username) {\n  //... code\n}\n?&gt;</code></pre>\n	2020-10-03 14:19:37.000849+03	17	234	{8,1}	\N	\N
32	PHP - error logging through htaccess - Error 500	<p>I&#39;m trying to log all PHP errors by activating the logging in htaccess but for some reason, I always end up with a http 500 error.</p>\n<p>I have stored the .htaccess in a separate directory to avoid messing up with the rest of my site.</p>\n<p>The content of the .htaccess file is the following:</p>\n<pre><code>php_flag display_errors off \nphp_flag log_errors On \nphp_value error_log /home/xxxxx/www/cache/php_logs/errors.log\nThe path exists and permissions are set to 777</code></pre>\n<p>In my PHP file I have only:</p>\n<pre><code>&lt;?PHP\n  echo &quot;hello world&quot;;\n?&gt;</code></pre>\n<p>If I remove the content of the .htaccess file, I can see &quot;hello world&quot; but as soon as I activate logging, it ends up with an internal server error (error 500).</p>\n<p>Is there something I&#39;m missing?</p>\n<p>Thanks</p>\n	2020-09-26 17:14:30.491377+03	19	3	{}	{}	\N
38	Angular 2 Routing based on query params	<p>Is it possible in Angular 2 to define routing based on query parameters? \nI&#39;d like to have the following behaviour:</p>\n<p>If the user enteres the url <code>http:&lt;server-path&gt;/search</code> I&#39;d like to route to a <code>StartPage</code> component. </p>\n<p>If the user enteres the url <code>http:&lt;server-path&gt;/search?query=sometext</code> I&#39;d like to route to <code>ResultList</code> component. </p>\n<p>I know that it&#39;s possible to use <em>path</em> parameters for routing but this is not what I like to do. I want to use <em>query</em> parameters if possible.\nI know how to trigger navigation in angular with query parameters but I don&#39;t know how to configure the Routes. </p>\n	2020-09-30 14:59:19.691451+03	1	19	{2}	{2}	\N
11	Deno - access web apis	<p>I am bundling my Deno code for the web using <code>deno bundle</code> and I know the browser has <code>RTCPeerConnection</code> from the WebRTC API which I would like to use.</p>\n<p>I thought Deno was aiming to have web compatibility, so I don&#39;t see why WebRTC is not planned to be implemented.</p>\n<p>But since it isn&#39;t at the moment, how can I tell Deno to trust that this global variable exists and to compile?</p>\n	2020-08-15 22:05:44.129969+03	1	84	\N	\N	\N
2	curl ile youtube indirme işlemleri	<p>curl ile videoyu mp3 olarak indirmek mümkünmüdür converter siteleri nasıl bunu yapıyor hep merak ediyorum internette sürekli başka birilerin apilerini kullanarak yapmışlar sitelerde kapandığı için çoğu çalışmıyor curl ile yapmak mümkün mü?</p>\n	2020-08-15 05:42:51.345058+03	7	45	\N	\N	\N
33	Trigger on BEFORE INSERT OR UPDATE fired once or twice?	<p>I have created the following trigger;</p>\n<pre><code class="language-sql">CREATE TRIGGER material_trigger\n    BEFORE INSERT OR UPDATE ON materials\n    FOR EACH ROW\n    EXECUTE PROCEDURE my_proc ();</code></pre>\n<p>I&#39;m struggling to understand when <code>my_proc</code> will be run on an upsert query, such as the below:</p>\n<pre><code class="language-sql">--UPSERT\nINSERT INTO materials (id, col)\nVALUES (1, 1)\nON CONFLICT (id) DO UPDATE SET\ncol=&#39;x&#39;</code></pre>\n<p>If I&#39;m running the upsert, am I right to think that:</p>\n<ul>\n<li>in the case of an <code>INSERT</code> it will be run once</li>\n<li>in the case of an <code>UPDATE</code> it will be run twice</li>\n</ul>\n<p>Then logically if I ran this <code>AFTER</code> the upsert I would ensure that the <code>my_proc</code> was triggered only once?</p>\n	2020-09-26 18:20:56.075273+03	7	77	{}	{}	\N
37	How to get the values from a generic type object?	<p>I am trying to create a composite generic type created from the first argument object.</p>\n<pre><code class="language-typescript">const x = {\n      one: (x: {a: boolean; b: boolean}) =&gt; true,\n      two: (x: {c: boolean; d: boolean}) =&gt; true,\n    };\n\n    type VVVV&lt;t&gt; = {\n      [k in keyof t]: t[k] extends (...args: any) =&gt; any ? Parameters&lt;t[k]&gt;[0] : {};\n    };\n\n    type l = VVVV&lt;typeof x&gt;;\n\n    type currentOutput = {\n      one: {\n        a: boolean;\n        b: boolean;\n      };\n      two: {\n        c: boolean;\n        d: boolean;\n      };\n    };\n\n    type desiredOutput = {\n      a: boolean;\n      b: boolean;\n      c: boolean;\n      d: boolean;\n    };</code></pre>\n<p>How do I create a type that looks like <code>desiredOutput</code> from the current output of <code>VVVV</code> which looks like <code>currentOutput</code>?</p>\n	2020-09-30 02:26:29.997413+03	15	75	{}	{}	\N
34	check if an object have all the property of a class in typescript	<p>I have a class abc in typescript</p>\n<pre><code>export class ABC{\n    public a : any;\n    public b : any;\n    public c? : any;\n    public d? : any;\n}</code></pre>\n<p>Now in my function I receive an input lets say <code>data:any</code>\nNow i want to check if that input i.e data have all the required property of class ABC.\nIs there any option to do this without using <code>hasOwnProperty</code> on every key of class ABC and object data.</p>\n	2020-09-26 18:22:17.834286+03	4	63	{}	{}	\N
41	Bileşen Özelliğini Angular2'deki Yönerge'den Değiştirme	<p>I have an Angular 1 app that works with a simple <code>contentEditable</code> directive, which can be used like this in templates:</p>\n<pre><code>&lt;span contenteditable=&quot;true&quot;  ng-model=&quot;model.property&quot; placeholder=&quot;Something&quot;&gt;</code></pre>\n<p>Editing the element would fire <code>$setViewValue(element.html()</code> and it worked as expected.</p>\n<p>I would like to make something in Angular2 with a similarly succinct template syntax. Ideally, I would like the template to look like this:</p>\n<pre><code>&lt;span contentEditable=&quot;true&quot; [(myProperty)]=&quot;name&quot;&gt;&lt;/span&gt;</code></pre>\n<p>where &#39;name&#39; is a property on the component and have the directive update the component when changed. I feel like I&#39;m close with this (<a href="http://plnkr.co/edit/LNg21LqAwHpbjFzI7cMq">Plunker Link</a>):</p>\n<pre><code>//our root app component\nimport {Component, Input, Output Directive, ElementRef, Renderer, OnInit} from &#39;angular2/core&#39;\n\n@Directive({\n    selector: &#39;[contentEditable]&#39;,\n    host: {\n        &#39;(blur)&#39;: &#39;update($event)&#39;\n    }\n})\n\nexport class contentEditableDirective implements OnInit {\n    @Input() myProperty;\n    constructor(private el: ElementRef, private renderer: Renderer){}\n\n    update(event){\n      this.myProperty = this.el.nativeElement.innerText;\n    }\n    ngOnInit(){\n        this.el.nativeElement.innerText =  this.myProperty;    \n    }\n}</code></pre>\n<p> This idea works if I pass an object like <code>{name: &quot;someName&quot;}</code> but if just pass a property it seems like it&#39;s passing the value, but not the reference and so the binding doesn&#39;t flow back to the component. Is there a way to do this that will still allow a template syntax that isn&#39;t verbose but still allows easy reuse of the directive.</p>\n	2020-09-30 17:41:06.782461+03	17	107	{2}	{2}	\N
3	class'a müzik efekti ekleme	<p>Merhaba, tıkladığında anlık olarak çalabilecek şekilde ayarlanmış bir bip sesim var. Bunu ben aşağıda gösterdiğim şekilde kullanmak istiyorum ama henüz CSS&#39;de çok yeni olduğum için bir türlü çözemedim. Çeşitli js kaynaklarını denedim ama istediğim gibi çalıştıramadım ne yazıkki...</p>\n<div class="butonum"></div>\n\n<p>&#39;a tıklanınca belirlediğim bir sound&#39;un çalmasını istiyorum. Butona tıklanınca değil de benim yukarıda belirttiğim divimde çalmasını istiyorum.</p>\n	2020-08-15 06:15:09.603639+03	2	16	\N	\N	\N
50	Have a communicating variable between two files in React	<p>So I have a value that changes in two different functions in two different react files. </p>\n<p>I want this value to be a var that communicates between the two files in a way that both can edit it and see the edits. </p>\n<p>I tried doing something like this in file1: </p>\n<pre><code>export default {\n    value: false,\n};</code></pre>\n<p>And this in file2:</p>\n<pre><code>import myVar from &#39;../file1&#39;;</code></pre>\n<p>And it seems to work well, besides the fact that I wasn&#39;t able to edit the &quot;value&quot; also from file1.</p>\n<p>I tried doing all of these:</p>\n<pre><code>this.value = false;\nvalue: false;\nvalue = false; </code></pre>\n<p>But of course, I get an error in all of them.</p>\n<p>So, is there a way to edit the value also from file1? Or is there another better method two have this common variable that can be read and edited between file1 and file2? </p>\n<p>Thanks</p>\n	2020-10-03 01:28:31.032093+03	14	38	{22}	\N	\N
51	Angular 10 Child Component only be used in Parent Component	<p>I need to configuration on component to be used only inside another component.\nHow can I do that?</p>\n<p>Components:</p>\n<pre><code>@Component({\n    selector: &#39;app-menu[id]&#39;,\n    templateUrl: &#39;./menu.component.html&#39;,\n    styleUrls: [&#39;./menu.component.scss&#39;]\n})\nexport class MenuComponent {\n    ...\n}\n\n@Component({\n    selector: &#39;app-sub-menu[id]&#39;,\n    templateUrl: &#39;./sub-menu.component.html&#39;,\n    styleUrls: [&#39;./sub-menu.component.scss&#39;]\n})\nexport class SubMenuComponent {\n    ...\n}</code></pre>\n<p><strong>HTML</strong></p>\n<p>The correct use MUST be only like that:</p>\n<pre><code>&lt;app-menu&gt;\n    &lt;app-sub-menu&gt;&lt;/app-sub-menu&gt;\n&lt;/app-menu&gt;</code></pre>\n<p>I need to block this kind of use:</p>\n<pre><code>&lt;div&gt;\n    &lt;app-sub-menu&gt;&lt;/app-sub-menu&gt;\n&lt;/div&gt;</code></pre>\n	2020-10-03 01:45:42.807696+03	16	421	{2}	\N	\N
20	TS2307: Cannot find module '~express/lib/express'	<p>I&#39;m converting a working JavaScript file to TypeScript.</p>\n<p>I use Express in this file, so I&#39;ve added the following to the top of the file:</p>\n<pre><code>///&lt;reference path=&quot;./typings/globals/node/index.d.ts&quot; /&gt;\n\nimport {Request} from &quot;~express/lib/express&quot;;</code></pre>\n<p>But the second line produces an error:</p>\n<blockquote>\n<p>TS2307: Cannot fine module &#39;~express/lib/express&#39;</p>\n</blockquote>\n<p>I&#39;ve installed the typings of express, so I actually didn&#39;t wrote those two lines by myself, but WebStorm auto generated them by clicking &quot;alt + enter&quot;, so I would expect it to work. Unfortunately I get that error.</p>\n<p>What am I doing wrong?</p>\n	2020-08-28 13:14:38.722749+03	8	391	\N	\N	\N
27	Sohbetteki Kişilerin Sıralanması	<p>Merhabalar,\nBenim iki tane tablom var biri chat diğeri user. Şimdi ben kullanıcılar listesini çekeceğim fakat bu sıralama benim en son mesajlaştığım kişilere göre sıralansın istiyorum bunun bana sql sorgusu lazım nasıl yapabilirim.\nTablo yapım şöyle:\nUser:\nuser_id user_name user_durum\nChat:\nchat_id gonderen_id alici_id chat_tarih chat_desc\nYardımcı Olursanız sevinirim 3 gündür uğraşıyorum...</p>\n	2020-09-24 23:52:24.755739+03	16	89	\N	\N	\N
56	How to properly handle Navbar color change on Scroll in Angular?	<p>I&#39;m making a project in angular. I would like to add a navbar which have transparent background initially but on scroll it will change its color. I am using bootstrap classes for that</p>\n<p>My Navbar heading is html code:</p>\n<pre><code>&lt;nav class=&quot;navbar navbar-expand-md sticky-top&quot;&gt;\n    ...\n&lt;/nav&gt;</code></pre>\n<p>where can I add my Script to change its color on Scroll</p>\n	2020-10-16 01:26:14.634339+03	9	33	{3,2,24}	\N	\N
6	Common object change in all component when one of them edit it	<p>I have :</p>\n<p><strong>item.ts</strong></p>\n<pre><code>export interface IItem {\n  name: string;\n  isActive?: boolean;\n}\n\nconst data: IItem[] = [\n  {\n    name: &#39;item1&#39;,\n    isActive: true\n  },\n  {\n    name: &#39;item2&#39;,\n    isActive: true\n  },\n  {\n    name: &#39;item3&#39;,\n    isActive: false\n  },\n  {\n    name: &#39;item4&#39;,\n    isActive: true\n  }\n];\nexport default data;</code></pre>\n<p>I use this data in multiple component :</p>\n<p><strong>Component1</strong></p>\n<pre><code>export class C1Component {\n  items: IItem [] = items;\n}</code></pre>\n<p><strong>Component1</strong></p>\n<pre><code>export class C2Component {\n  items: IItem [] = items;\n}</code></pre>\n<p>When I make changes in the items for example delete item in Component1, the items in the other component also changed.\nI can&#39;t understand why.</p>\n<p>Does angular Objects are loosely coupled? and how can solve this issue please.</p>\n<hr>\n<p>I tried also:</p>\n<pre><code>...\nexport class Menu {\n  static get data() {\n    return data;\n  }\n}</code></pre>\n<p>and call <code>Menu.data</code>, but the error persist and it is the same behavior.</p>\n	2020-08-15 20:44:47.105469+03	7	79	\N	\N	\N
8	TypeScript: an interface property dependent on another	<p>is it possible to type an interface property dependent on another?</p>\n<p>For example I have:</p>\n<pre><code>const object = {\n  foo: &#39;hello&#39;,\n  bar: { hello: &#39;123&#39;, },\n}</code></pre>\n<p>And I want to make sure that the key of <strong>bar</strong> must be the value of <strong>foo</strong>.</p>\n<pre><code>interface ObjectType = {\n  foo: string;\n  bar: { hello: string; } // instead of hardcoding have something like this? --&gt; payload: { ValueOfFoo: string; }\n}</code></pre>\n<p>Thanks! :)</p>\n	2020-08-15 20:46:26.019154+03	4	81	\N	\N	\N
29	PostgreSQL: Simplifying a SQL query into a shorter query	<p>I have a table called &#39;daily_prices&#39; where I have &#39;sale_date&#39;, &#39;last_sale_price&#39;, &#39;symbol&#39; as columns.</p>\n<p>I need to calculate how many times &#39;last_sale_price&#39; has gone up compared to previous day&#39;s &#39;last_sale_price&#39; in 10 weeks.</p>\n<p>Currently I have my query like this for 2 weeks:</p>\n<pre><code>select count(*) as &quot;timesUp&quot;, sum(last_sale_price-prev_price) as &quot;dollarsUp&quot;, &#39;wk1&#39; as &quot;week&quot;\nfrom \n(\n    select last_sale_price, LAG(last_sale_price, 1) OVER (ORDER BY sale_date) as prev_price \n from daily_prices \nwhere sale_date &lt;= CAST(&#39;2020-09-18&#39; AS DATE) AND sale_date &gt;= CAST(&#39;2020-09-14&#39; AS DATE)\nand symbol=&#39;AAPL&#39;\n) nest\nwhere last_sale_price &gt; prev_price\n\nUNION\n\nselect count(*) as &quot;timesUp&quot;, sum(last_sale_price-prev_price) as &quot;dollarsUp&quot;, &#39;wk2&#39; as &quot;week&quot;\nfrom \n(\n    select last_sale_price, LAG(last_sale_price, 1) OVER (ORDER BY sale_date) as prev_price \n from daily_prices \nwhere sale_date &lt;= CAST(&#39;2020-09-11&#39; AS DATE) AND sale_date &gt;= CAST(&#39;2020-09-07&#39; AS DATE)\nand symbol=&#39;AAPL&#39;\n) nest\nwhere last_sale_price &gt; prev_price</code></pre>\n<p>I&#39;m using &#39;UNION&#39; to combine the weekly data. But as the number of weeks increase the query is going to be huge. Is there a simpler way to write this query? Any help is much appreciated. Thanks in advance.</p>\n	2020-09-25 15:12:55.85901+03	16	107	\N	\N	\N
28	Başlangıçta javascript problemi	<p>Merhaba bir sistemde sepete ekleme, sepetten çıkarma, ajax post ile sonraki adıma geçme gibi işlevleri olan bir kod yazdım. Jquery mobile kullanıyorum.</p>\n<p>Sepete ekleyince anlık olarak js ile divi yaşil yaktırıyorum. ama bu kodlar sepete ekliyor js ile ama divin backgroundunu değişmiyor. sayfayı bir kere refresh yaptıkytan sonra javascript kodları tıkır tıkır çalışıyor.</p>\n<p>İlk yüklenirken jsler tam işlenmiyor gibi. Nasıl önüne geçebilirim.</p>\n	2020-09-25 15:03:45.783759+03	13	13	\N	\N	\N
55	Eslint throws warning on missing return type for getter	<p>I have a class:  </p>\n<pre><code>export class Page {\n   get page() {\n      return $(&#39;#page&#39;);\n   }\n\n   open(path: string): void {\n      browser.url(path);\n      this.page.waitForDisplayed();\n   }\n}  </code></pre>\n<p>Eslint throws warning: <code> warning  Missing return type on function  @typescript-eslint/explicit-module-boundary-types</code> for getter <code>get page(){...}</code>.<br>I also have other classes like:  </p>\n<pre><code>import { Page } from &#39;src/pages/page&#39;;\n\nclass ProductDetailPage extends Page {\n  get skuLabel() {\n    return $(&#39;#product_reference span&#39;);\n  }\n}\n\nexport const productDetailPage = new ProductDetailPage();  </code></pre>\n<p>And for this getter <code>get skuLabel(){...}</code> eslint doesn&#39;t throw any warnings.  </p>\n<p>Does anybody has an idea why it throws a warning only in the first case?\nThanks!</p>\n	2020-10-06 03:35:54.674826+03	1	206	{5,23}	\N	\N
39	Angular-Material Sidenav cdkScrollable	<p>The Angular Material CDK provides a <code>Directive</code> <code>CdkScrollable</code>, which allows you to listen to <code>ScrollEvent</code>s of a specific container.<br>I am now trying to access the <code>CdkScrollable</code> of the <code>MatSidenavContent</code>, which is added by default.<br>However my <code>@ViewChild(CdkScrollable)</code> and <code>@ContentChild(CdkScrollable)</code> are always undefined.  </p>\n<p>My <code>Component</code> looks something like this:</p>\n<pre><code>&lt;mat-sidenav-container&gt;\n    &lt;mat-sidenav&gt;Sidenav content&lt;/mat-sidenav&gt;\n    &lt;div&gt;Main content&lt;/div&gt;\n&lt;/mat-sidenav-container&gt;</code></pre>\n<p>The resulting DOM looks something like this:</p>\n<pre><code>&lt;mat-sidenav-container&gt;\n    &lt;div class=&quot;mat-drawer-backdrop&quot;&gt;&lt;/div&gt;\n    &lt;div tabindex=&quot;-1&quot; class=&quot;cdk-visually-hidden cdk-focus-trap-anchor&quot;&gt;&lt;/div&gt;\n    &lt;mat-sidenav&gt;Sidenav content&lt;/mat-sidenav&gt;\n    &lt;mat-sidenav-content cdkScrollable&gt;\n          &lt;div&gt;Main content&lt;/div&gt;\n    &lt;/mat-sidenav-content&gt;\n&lt;/mat-sidenav-container&gt;</code></pre>\n<p>The <code>mat-sidenav-content</code> <code>Component</code>, which is generated automatically, uses a <code>CdkScrollable</code>-Directive, which I need to access.<br>My question is now:<br>Is it possible to access that <code>Directive</code> and if so, how?</p>\n	2020-09-30 15:39:32.980986+03	14	206	{}	{}	\N
36	Angular nester ngFor, get value from parent loop?	<p>I have a nested ngFor loop which uses nested json, for example</p>\n<pre><code>&lt;mat-tab *ngFor=&quot;let car of cars&quot;&gt;\n\n    &lt;car-component *ngFor=&quot;let model of car.models&quot; [name]=&quot;model.name&quot; [color]=&quot;model.color&quot;&gt;\n    &lt;/car-component&gt;\n\n&lt;/mat-tab&gt;</code></pre>\n<p>Where the data might be</p>\n<pre><code>  {\n    name: &#39;vw&#39;,\n    models: [\n     {name: &#39;beetle&#39;, color: &#39;red&#39;}\n     {name: &#39;jetta&#39;, color &#39;blue&#39;\n    ]\n  },\n  {\n    name: &#39;bmw&#39;,\n    models: [\n     {name: &#39;x5&#39;, color: &#39;silver&#39;}\n     {name: &#39;m3&#39;, color &#39;blue&#39;\n    ]\n  }</code></pre>\n<p>the car-component shows the car image and company logo.</p>\n<p>I have the images organized my manufacturer, such as</p>\n<pre><code>vw--|\n    |logo.png\n    |jetta.png\n    |beetle.png\nbmw-|\n    |logo.png\n    |x5.png\n    |m3.png</code></pre>\n<p>So, the image path in my nested component is\n<code>/assets/images/{{manufacturer}}/{{name}}.png</code></p>\n<p>So I need to pass the manufacturer, which is in the outside loop as the <code>name</code> property.</p>\n<p>I could repeat the manufacturer in the json for each model, but is there a way to retrieve the <code>name</code> property of the parent <code>ngFor</code> iteration?</p>\n	2020-09-27 00:59:08.716384+03	7	100	{2,4}	{2,4}	\N
7	How to correctly await a promise in TypeScript	<p>I have some code where I <code>continue</code> a loop if a promise rejects or use its result with something that <em>requires</em> it to be of the reolved type, as shown in the following example code:</p>\n<pre><code class="language-typescript">for (const i in bar) {\n    let error = false;\n    const foo = await somePromise(i)\n        .catch(() =&gt; { error = true; });\n    if (error) continue;\n    // Something that requires foo to be resolved here\n}</code></pre>\n<p>My issue is that typescript does not realize that <code>foo</code> is correctly resolved at the end (it still thinks it could be <code>void</code> due to not correctly resolving, and therefore gives a <code>2339</code> error). What is the correct, type-safe way to have typescript realize that this is fine?</p>\n<p>The ways I have found to fix it are by stating that <code>foo</code> is of type <code>any</code>, which is not ideal and my linter doesn&#39;t like that, or using <code>.then</code>, which also sucks since I&#39;d have to start nesting multiple <code>.then</code> statements and functions in my code, leading to massive indentations.</p>\n	2020-08-15 20:45:45.439786+03	2	68	\N	\N	\N
30	Reset auto increment counter in postgres	<p>I would like to force the auto increment field of a table to some value, I tried with this:</p>\n<pre><code>ALTER TABLE product AUTO_INCREMENT = 1453</code></pre>\n<p>AND</p>\n<pre><code>ALTER SEQUENCE product  RESTART WITH 1453;\nERROR:  relation &quot;your_sequence_name&quot; does not exist</code></pre>\n<p>I&#39;m new to postgres :(</p>\n<p>I have a table <code>product</code> with <code>Id</code> and <code>name</code> field</p>\n	2020-09-25 15:47:09.546461+03	14	66	\N	\N	\N
24	javascript değişken php değişkene çevirmek	<p>Arkadaşlar merhaba, tarayıcının çalıştırıldı cihazın koordinatları tespit eden bir javascript var.</p>\n<p>Bu script enlem ve boylamı <div id="Enlem"></div> ve <div id="Boylam"></div> veriyor.</p>\n<p>script aşağıdaki gibi.</p>\n<pre><code class="language-&lt;script">        var map;\n\n        function initialize() {\n            var mapOptions = {\n                zoom: 3,\n                center: new google.maps.LatLng(25, 1)\n            }\n            map = new google.maps.Map(document.getElementById(&#39;map&#39;), mapOptions);\n\n            navigator.geolocation.getCurrentPosition(function (position) {\n                var pos = new google.maps.LatLng(position.coords.latitude,\n                                                 position.coords.longitude);\n                document.getElementById(&quot;Enlem&quot;).innerHTML = position.coords.latitude;\n                document.getElementById(&quot;Boylam&quot;).innerHTML = position.coords.longitude;\n            });\n        }\n\n        google.maps.event.addDomListener(window, &#39;load&#39;, initialize);\n\n    &lt;/script&gt;</code></pre>\n<p>Ben bu enlem boylamı input alanı value içinde hazır göstermek istiyorum. Bu div hali ile konmuyor, php değişkene dönüştürülmesi gerektiğini tahmin ediyorum.</p>\n<p>Nasıl yapabilirim, yardımcı olur musunuz?</p>\n<p>Saygılar, Teşekkürler.</p>\n	2020-09-24 19:12:49.872696+03	15	10	\N	\N	\N
58	websocket client to socket.io	<p>I need a server to be able to accept connections from both websocket and socket.io clients, is that possible? When I&#39;m running just socket.io, also socket.io client works fine, but standard websocket client is unable to connect. On the other hand when I run websocket server alongside socket.io, websocket worsk well, but in browser, which is trying to connect via socket.io, I see error <code>WebSocket connection to ... failed: Invalid frame header</code>. Is it possible to get both connections working on single server instance?</p>\n<p>I&#39;m using <a href="https://github.com/techpines/express.io">express.io</a> and <a href="https://github.com/theturtle32/WebSocket-Node">websocket-node</a> and it would be great to get it working only with express.oi.</p>\n	2020-10-19 18:49:59.501569+03	21	33	{9,21}	\N	\N
31	Chrome 20 websocket handshake	<p>I&#39;am using PHP Websocket server by lemmingzshadow (web). Everything worked just fine till now.</p>\n<p>After update to chrome 20, if I want to do handshake with server it ends with this error</p>\n<pre><code>Error during WebSocket handshake: Sec-WebSocket-Protocol mismatch </code></pre>\n<p>Headers from chrome 20</p>\n<pre><code>GET /demo HTTP/1.1\nUpgrade: websocket\nConnection: Upgrade\nHost: gomokulive.eu:8001\nOrigin: http://www.gomokulive.eu\nSec-WebSocket-Key: s+AMQQu4Q10xH2AKy49byg==\nSec-WebSocket-Version: 13\nSec-WebSocket-Extensions: x-webkit-deflate-frame</code></pre>\n<p>Headers sent back:</p>\n<pre><code>HTTP/1.1 101 Switching Protocols\nUpgrade: websocket\nConnection: Upgrade\nSec-WebSocket-Accept: dMCVYKkF5VRrIouWFW7EYdvfD28=\nSec-WebSocket-Protocol: demo</code></pre>\n<p>I think problem is with &quot;Sec-WebSocket-Extensions: x-webkit-deflate-frame&quot; header from Chrome 20.</p>\n<p>Any idea how to get it working again?</p>\n	2020-09-26 00:23:07.558402+03	17	38	{8,21}	{8,21}	\N
57	Passing boolean in JSON in Angular	<p>I am trying to pass a Boolean property value from Angular6 app to Java backend in JSON.\nSo I am sending to HTTP POST RESTFul API an object type </p>\n<pre><code>MyObj { flag: boolean = true } \n\ncreateObj(obj: MyObj): Observable&lt;WebResponse&gt; {\n  return this.http.post(this.endPoint + &#39;create/&#39; + obj, this.someUrl);\n}</code></pre>\n<p>However, on Java side we get that attribute in double quotes as <code>{ &quot;flag&quot;:&quot;true&quot; }</code>, although there it is also defined as Boolean.</p>\n<p>Is there anything we can do to avoid those double quotes, to receive it as normal Boolean?</p>\n	2020-10-19 16:41:23.796578+03	20	34	{2}	\N	\N
35	React constructor ES6 vs ES7	<p>I read on the React tutorials page that ES6 will use constructor functions to initialize state like this.</p>\n<pre><code>export class Counter extends React.Component {\n  constructor(props) {\n    super(props);\n    this.state = {count: props.initialCount};\n  }\n  tick() {\n    this.setState({count: this.state.count + 1});\n  }\n  render() {\n    return (\n      &lt;div onClick={this.tick.bind(this)}&gt;\n        Clicks: {this.state.count}\n      &lt;/div&gt;\n    );\n  }\n}\nCounter.propTypes = { initialCount: React.PropTypes.number };\nCounter.defaultProps = { initialCount: 0 };</code></pre>\n<p>Then it continues, using ES7 syntax to achieve the same thing.</p>\n<pre><code>// Future Version\nexport class Counter extends React.Component {\n  static propTypes = { initialCount: React.PropTypes.number };\n  static defaultProps = { initialCount: 0 };\n  state = { count: this.props.initialCount };\n  tick() {\n    this.setState({ count: this.state.count + 1 });\n  }\n  render() {\n    return (\n      &lt;div onClick={this.tick.bind(this)}&gt;\n        Clicks: {this.state.count}\n      &lt;/div&gt;\n    );\n  }\n}</code></pre>\n<p>Why is ES7 better then ES6 version or ES5 version.</p>\n<p>Thanks</p>\n	2020-09-26 19:05:28.683288+03	8	156	{}	{}	\N
18	if (!options.algorithms) throw new Error('algorithms should be set'); Error: algorithms should be set	<p>I started learning Nodejs and i am stuck somewhere in the middle. I installed a new library from npm  and that was <strong>express-jwt</strong>, its showing some kind of error after running. Attached the code and the logs of the error, please help me out!</p>\n<pre><code>const jwt = require(&#39;jsonwebtoken&#39;);\nrequire(&#39;dotenv&#39;).config()\nconst expressJwt =  require(&#39;express-jwt&#39;);\nconst User = require(&#39;../models/user&#39;);\n\n\n\n\nexports.requireSignin =  expressJwt({ secret:  process.env.JWT_SECRET});</code></pre>\n<p>The below thing is  the logs of the error.</p>\n<pre><code>[nodemon] starting `node app.js`\nD:\\shubh\\proj\\Nodejs\\nodeapi\\node_modules\\express-jwt\\lib\\index.js:22\n  if (!options.algorithms) throw new Error(&#39;algorithms should be set&#39;);\n                           ^\n\n**Error: algorithms should be set**\n    at module.exports (D:\\shubh\\proj\\Nodejs\\nodeapi\\node_modules\\express-jwt\\lib\\index.js:22:34)\n    at Object.&lt;anonymous&gt; (D:\\shubh\\proj\\Nodejs\\nodeapi\\controllers\\auth.js:64:26)\n    at Module._compile (internal/modules/cjs/loader.js:1138:30)\n    at Object.Module._extensions..js (internal/modules/cjs/loader.js:1158:10)\n</code></pre>\n	2020-08-27 18:40:52.723033+03	4	182	\N	\N	\N
14	System has not been booted with systemd as init system (PID 1). Can't operate	<p>I&#39;m trying to follow the Redis installation process as discuss in this <a href="https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04">article</a> of digital ocean, in WSL. The Ubuntu version installed is Ubuntu 18.04.</p>\n<p>Everything in redis installation is fine but when I tried to run this <code>sudo systemctl start redis</code> I got this message.</p>\n<pre><code>System has not been booted with systemd as init system (PID 1). Can&#39;t operate.</code></pre>\n<p>Any Idea on what should I do with that?</p>\n	2020-08-22 05:28:26.23906+03	7	104	\N	\N	\N
\.


--
-- Data for Name: question_answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_answer (id, content, "creationTime", "userId", "questionId", "rawContent") FROM stdin;
1	Hello world	2020-08-20 16:56:58.138229+03	1	13	\N
2	Tabi kesin oyledir XD	2020-08-23 17:05:33.401625+03	3	17	\N
4	Bos bir cevap atiyorum yine xd :D	2020-08-23 17:12:05.840719+03	1	9	\N
5	Denemeler	2020-08-24 01:23:02.566026+03	2	17	\N
3	Haha	2020-08-23 17:06:27.426474+03	4	17	\N
6	Biraz daha teste devam...	2020-08-27 00:22:07.874574+03	1	17	\N
10	<p>Nowadays there&#39;s a dedicated <a href="http://expressjs.com/en/api.html#res.status"><code>status</code> function</a> for this on the response object. Just chain it in somewhere before you call <code>send</code>.</p>\n<pre><code>res.status(404)        // HTTP status 404: NotFound\n   .send(&#39;Not found&#39;);</code></pre>\n	2020-09-10 22:39:43.803087+03	7	21	\N
11	<p>》 deneme cevap 😁😀😁</p>\n	2020-09-11 07:23:32.509297+03	1	10	\N
25	<h1 id="hello-bruhh">Hello, bruhh!!!</h1>\n	2020-09-16 07:11:38.133178+03	1	21	\N
26	<p>Was looking at this problem recently, and tried:</p>\n<p>HTML:</p>\n<pre><code>&lt;body&gt;\n    &lt;div id=&quot;my-div&quot;&gt;&lt;/div&gt;\n&lt;/body&gt;</code></pre>\n<p>CSS: </p>\n<pre><code>#my-div {                \n    position: absolute;\n    height: 100px;\n    width: 100px;    \n    left: 50%;\n    top: 50%;\n    background: red;\n    transform: translate(-50%, -50%);    \n    -webkit-transform: translate(-50%, -50%);\n    -moz-transform: translate(-50%, -50%);\n    -ms-transform: translate(-50%, -50%);\n}</code></pre>\n<p>Here&#39;s the Fiddle:</p>\n<p><a href="http://jsfiddle.net/sTcp9/6/">http://jsfiddle.net/sTcp9/6/</a></p>\n<p>It even works when using &quot;width/height: auto&quot;, in the place of fixed dimensions.\nTested on the latest versions on Firefox, Chrome, and IE (* gasp *).</p>\n	2020-09-17 04:42:06.562196+03	9	22	\N
27	<p><strong>Note:</strong> This example uses the <a href="http://www.w3.org/TR/2009/WD-css3-flexbox-20090723/">draft version of the Flexible Box Layout Module</a>. It has been superseded by the incompatible <a href="http://www.w3.org/TR/css-flexbox-1/">modern specification.</a></p>\n<p>Center the child elements of a div box by using the box-align and box-pack properties together.</p>\n<p>Example:</p>\n<pre><code>div\n{\nwidth:350px;\nheight:100px;\nborder:1px solid black;\n\n/* Internet Explorer 10 */\ndisplay:-ms-flexbox;\n-ms-flex-pack:center;\n-ms-flex-align:center;\n\n/* Firefox */\ndisplay:-moz-box;\n-moz-box-pack:center;\n-moz-box-align:center;\n\n/* Safari, Opera, and Chrome */\ndisplay:-webkit-box;\n-webkit-box-pack:center;\n-webkit-box-align:center;\n\n/* W3C */\ndisplay:box;\nbox-pack:center;\nbox-align:center;\n} </code></pre>\n	2020-09-17 04:45:04.799405+03	1	22	\N
28	<p>Using Flexbox:</p>\n<pre><code>&lt;style&gt;\n  .container {\n    display: flex;\n    align-items: center; /* Vertical align */\n    justify-content: center; /* Horizontal align */\n  }\n&lt;/style&gt;\n\n&lt;div class=&quot;container&quot;&gt;\n  &lt;div class=&quot;block&quot;&gt;&lt;/div&gt;\n&lt;/div&gt;</code></pre>\n<p>Centers <code>block</code> inside <code>container</code> vertically (and horizontally).</p>\n<p>Browser support: <a href="http://caniuse.com/flexbox">http://caniuse.com/flexbox</a></p>\n	2020-09-17 05:59:07.14953+03	3	22	\N
29	<h1 id="hello-world">Hello world</h1>\n	2020-09-22 18:06:47.673593+03	14	22	\N
30	<p>Good job bro...</p>\n	2020-09-25 00:31:54.661073+03	7	27	\N
31	<p>WebSocket Test.</p>\n	2020-09-25 14:44:34.550259+03	7	27	\N
32	<p>Good job bro.</p>\n	2020-09-25 14:47:04.488242+03	7	27	\N
33	<p>Ok.</p>\n	2020-09-25 14:49:37.25101+03	7	27	\N
34	<p>hhh</p>\n	2020-09-25 14:50:08.176796+03	7	27	\N
35	<p>If you created the table <code>product</code> with an <code>id</code> column, then the sequence is not simply called <code>product</code>, but rather <code>product_id_seq</code> (that is, <code>${table}_${column}_seq</code>).</p>\n<p>This is the <code>ALTER SEQUENCE</code> command you need:</p>\n<pre><code>ALTER SEQUENCE product_id_seq RESTART WITH 1453</code></pre>\n<p>You can see the sequences in your database using the <code>\\ds</code> command in psql. If you do <code>\\d product</code> and look at the default constraint for your column, the <code>nextval(...)</code> call will specify the sequence name too.</p>\n	2020-09-25 16:00:06.876861+03	7	30	\N
37	<p>Instantiate the class to get all properties and use the <strong>every</strong> function to check if all keys are indeed in the passing object.</p>\n<pre><code>function hasAllProperties (data, YourClass) {\n  const yourClass = new YourClass()\n  return Object.keys(yourClass).every((key) =&gt; data[key] !== undefined)\n}</code></pre>\n<p>Usage</p>\n<pre><code>hasAllProperties(data, ABC)</code></pre>\n	2020-09-26 18:31:37.031664+03	6	34	\N
36	<p>TL;DR. Using <code>hasOwnProperty</code> is very likely inevitable, unless you’re absolutely sure about your function usage, input data source to your function is totally under control. </p>\n<p>Longer version:</p>\n<p>You must understand the difference of <em>static type check</em> and <em>runtime check</em>. TS is a static type checker, but it doesn’t have a runtime. Code in TS is transpiled to JS before execution, and run in a JS runtime engine. </p>\n<p>The only way TS can check whether properties of <code>data</code> meet the requirement, is that piece of information must first exist within the type system. But in your case <code>data: any</code> has swallowed all meaningful type information, leaving TS nothing to work on. </p>\n<p>Even if <code>data</code>’s type is more concrete, something like <code>data: { a: any; b: any; }</code> etc. TS can only check that, in your code base, you didn’t explicitly write any code that pass in invalid arguments.</p>\n<p>If somewhere you write <code>validate(anyData)</code>, where <code>anyData: any</code>, then the safe guard is gone. Plus, it cannot guarantee in JS runtime, invalid arguments are never passed in.</p>\n	2020-09-26 18:31:21.089335+03	12	34	\N
38	<p>The directive doesn&#39;t know about its parent <code>name</code> property. You can though emit an event from the directive and catch it in the parent. Check this example</p>\n<!-- language: typescript -->\n\n<pre><code>@Directive({\n    selector: &#39;[contentEditable]&#39;,\n    host: {\n        &#39;(input)&#39;: &#39;update($event)&#39; // I changed it to input to see the changes immediatly\n    }\n})\nexport class contentEditableDirective implements OnInit {\n\n// Output that will emit outside the directive\n@Output() updateProperty: EventEmitter&lt;any&gt; = new EventEmitter();\n\n// When &#39;update&#39; is called we emit the value\nupdate(event){\n  this.updateProperty.emit(this.el.nativeElement.innerText);\n}</code></pre>\n<p>Now that our directive is emitting correctly, we have to catch the value in the component. <em>For brevity only the template</em></p>\n<!-- language: typescript -->\n\n<pre><code>&lt;div contentEditable=&quot;true&quot; [myProperty]=&quot;name&quot; (updateProperty)=&quot;name = $event&quot;&gt;&lt;/div&gt;</code></pre>\n<p><code>updateProperty</code> is the <code>@Output</code> from the directive. When it gets triggered we catch it and the value we emied will be assigned to <code>$event</code>. After that we assign <code>$event</code> to our property <code>name</code> and you got your app working. </p>\n<p>Here&#39;s your <a href="http://plnkr.co/edit/O1gdN64A9O4V6zvcAv1z?p=preview">plnkr</a> working. I hope it helps.</p>\n<h1 id="update">Update</h1>\n<p>Thank to this <a href="https://stackoverflow.com/questions/34736161/how-do-i-create-a-dropdown-component-in-angular-2">answer</a> I saw that it is possible what you asked for.</p>\n<p>You can match the Output to what is called when the syntax <code>[()]</code> is desugared. If you have a syntax like <code>[(myProperty)]=&quot;expr&quot;</code> it is desugared to <code>[myProperty]=&quot;expr&quot; (myPropertyChange)=&quot;expr = $event&quot;</code></p>\n<p>So changing the original answer to as follows</p>\n<!-- language: typescript -->\n\n<pre><code>@Output() myPropertyChange: EventEmitter&lt;any&gt; = new EventEmitter();\nupdate(event){\n  this.myPropertyChange.emit(this.el.nativeElement.innerText);\n}</code></pre>\n<p>It will give you this template, which is what you asked from the beginning.</p>\n<pre><code>&lt;div contentEditable=&quot;true&quot; [(myProperty)]=&quot;name&quot;&gt;&lt;/div&gt;</code></pre>\n<p>Here&#39;s the <a href="http://plnkr.co/edit/Z2T6ZGvkvtqfdKYQObMy?p=preview">plnkr</a> updated to the real correct answer.</p>\n	2020-09-30 17:44:33.356687+03	14	41	\N
42	<p>You cannot call a PHP function that resides on the <em>server</em> by just clicking on a div that exists on the <em>client</em> browser.</p>\n<p>You need to trigger a Javascript event (using e.g. jQuery), that will call a function on the server (e.g. through AJAX), that <strong>after checking the parameters are correct and the user has the right of calling it</strong> will do what you seek.</p>\n<p>There are ready-made frameworks that would allow you to do that.</p>\n<p>Otherwise (after including jQuery in your HTML page) you can do something like,</p>\n<pre><code> &lt;div class=&quot;cross&quot; id=&quot;deleteUserButton&quot; data-user=&quot;nickname&quot;&gt;X&lt;/div&gt;\n\n\n &lt;script type=&quot;text/javascript&quot;&gt;\n     $(&#39;#deleteUserButton&#39;).on(&#39;click&#39;, function() {\n         let nick = $(this).attr(&#39;data-user&#39;);\n         $.post(&#39;/services/delete.php&#39;,\n         {\n              cmd: &#39;delete&#39;,\n              user: nick\n         }).then( reply =&gt; {\n              if (reply.status === &#39;OK&#39;) {\n                  alert(&quot;User deleted&quot;);\n              }\n         });\n\n\n &lt;?php\n       $cmd = $_POST[&#39;cmd&#39;];\n\n       switch($cmd) {\n            case &#39;delete&#39;:\n                 $user = $_POST[&#39;user&#39;];\n                 if (deleteUser($user)) {\n                     $reply = [ &#39;status&#39; =&gt; &#39;OK&#39; ];\n                 } else {\n                     $reply = [ &#39;status&#39; =&gt; &#39;failure&#39;, &#39;message&#39; =&gt; &#39;Doh!&#39; ];\n                 }\n                 break;\n        ...\n\n        header(&#39;Content-Type: application/json;charset=UTF-8&#39;);\n        print json_encode($reply);\n        exit();</code></pre>\n	2020-10-05 18:21:30.369173+03	3	54	\N
41	<p>Html can&#39;t directly call php, it can do a separate call to load the same page, with the action.</p>\n<pre><code>&lt;?php\nfunction deleteUser($username){}\n\nif($_GET[&#39;action&#39;] == &quot;delete&quot;)\n{\n    deleteUser($_GET[&#39;username&#39;]);        \n}\n?&gt;\n&lt;a class=&quot;cross&quot; href=&#39;?action=delete&amp;username=NickName&#39;&gt;X&lt;/a&gt;</code></pre>\n<p>The reason for this is because PHP runs on the server, BEFORE anything is sent to the browser. So it requires another page load to run the function by clicking something. It is possible to use javascript and AJAX calls to send a call to a php script without reloading the main page. Just look into Jquery&#39;s post or ajax features.</p>\n	2020-10-05 18:12:13.014364+03	4	54	\N
43	<p>ES7 is better because it enables the following scenarios:</p>\n<ul>\n<li>Where declarative interpretation of expectations are useful. Some examples include editors so that they can make use of this info for typeaheads/inference, TypeScript/Flow can make use of this to allow their users to express intentions about the shapes of their classes</li>\n<li>Allowing general users to use this for just human-readable documentation about properties separate from potentially complex initialization logic</li>\n<li>Possibly allow VMs to pre-emptively optimize objects created from a class with some of these hints on them.</li>\n</ul>\n<p><em>Note:</em> When you define your state by using ES7, you are using <code>Property initializers</code> feature</p>\n<p>References: <a href="https://github.com/tc39/proposal-class-fields">Class field declarations for JavaScript</a></p>\n	2020-10-05 18:27:18.416573+03	16	35	\N
44	<p>In your child component&#39;s constructor inject parent component. and in html file use child component selector in parent component selector.</p>\n<p>This may help you. <a href="https://stackoverflow.com/questions/42974808/angular-2-restrict-component-to-specific-parent-component">https://stackoverflow.com/questions/42974808/angular-2-restrict-component-to-specific-parent-component</a>.</p>\n<p>If it will help you. please upvote.</p>\n	2020-10-05 18:36:35.704918+03	14	51	\N
46	<p>Test cevaptir. Dikkate almayiniz.</p>\n	2020-10-24 17:12:27.547896+03	1	57	\N
\.


--
-- Data for Name: question_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_comment (id, content, "userId", "creationTime", "questionId") FROM stdin;
1	It isn't a CSS 3 way ...	5	2020-09-19 07:06:20.454747+03	22
2	Ok, you're right, i agree with your affirmation... but does css3 provides something easier? Thank you	12	2020-09-19 07:26:58.668394+03	22
3	Another example of CSS3 being an overhyped buzzword. CSS3 is simply CSS level 3. Any CSS1 and CSS2.x code is also valid CSS3, get over it.	6	2020-09-19 07:27:17.116495+03	22
\.


--
-- Data for Name: question_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_revision (id, title, content, "creationTime", "questionId", "userId", tags) FROM stdin;
3	PHP calling function with parameters by clicking on HTML div	<p>I am trying to make a delete button which I&#39;ll be able to delete some user from my database but main thing how to call PHP function with clicking on some div etc..</p>\n<pre><code>&lt;div class=&quot;cross&quot; onclick=&#39;&lt;?php deleteUser(&quot;Nickname&quot;)?&gt;&#39;&gt;X&lt;/div&gt;\n&lt;?php\nfunction deleteUser($username) {\n  //... code\n}\n?&gt;</code></pre>\n	2020-10-03 14:19:37.000849+03	54	17	{8,1}
4	Eslint throws warning on missing return type for getter	<p>I have a class:  </p>\n<pre><code>export class Page {\n   get page() {\n      return $(&#39;#page&#39;);\n   }\n\n   open(path: string): void {\n      browser.url(path);\n      this.page.waitForDisplayed();\n   }\n}  </code></pre>\n<p>Eslint throws warning: <code> warning  Missing return type on function  @typescript-eslint/explicit-module-boundary-types</code> for getter <code>get page(){...}</code>.<br>I also have other classes like:  </p>\n<pre><code>import { Page } from &#39;src/pages/page&#39;;\n\nclass ProductDetailPage extends Page {\n  get skuLabel() {\n    return $(&#39;#product_reference span&#39;);\n  }\n}\n\nexport const productDetailPage = new ProductDetailPage();  </code></pre>\n<p>And for this getter <code>get skuLabel(){...}</code> eslint doesn&#39;t throw any warnings.  </p>\n<p>Does anybody has an idea why it throws a warning only in the first case?\nThanks!</p>\n	2020-10-06 03:35:54.674826+03	55	1	{5,23}
5	How to properly handle Navbar color change on Scroll in Angular?	<p>I&#39;m making a project in angular. I would like to add a navbar which have transparent background initially but on scroll it will change its color. I am using bootstrap classes for that</p>\n<p>My Navbar heading is html code:</p>\n<pre><code>&lt;nav class=&quot;navbar navbar-expand-md sticky-top&quot;&gt;\n    ...\n&lt;/nav&gt;</code></pre>\n<p>where can I add my Script to change its color on Scroll</p>\n	2020-10-16 01:26:14.634339+03	56	9	{3,2,24}
6	Passing boolean in JSON in Angular	<p>I am trying to pass a Boolean property value from Angular6 app to Java backend in JSON.\nSo I am sending to HTTP POST RESTFul API an object type </p>\n<pre><code>MyObj { flag: boolean = true } \n\ncreateObj(obj: MyObj): Observable&lt;WebResponse&gt; {\n  return this.http.post(this.endPoint + &#39;create/&#39; + obj, this.someUrl);\n}</code></pre>\n<p>However, on Java side we get that attribute in double quotes as <code>{ &quot;flag&quot;:&quot;true&quot; }</code>, although there it is also defined as Boolean.</p>\n<p>Is there anything we can do to avoid those double quotes, to receive it as normal Boolean?</p>\n	2020-10-19 16:41:23.796578+03	57	9	{2}
7	websocket client to socket.io	<p>I need a server to be able to accept connections from both websocket and socket.io clients, is that possible? When I&#39;m running just socket.io, also socket.io client works fine, but standard websocket client is unable to connect. On the other hand when I run websocket server alongside socket.io, websocket worsk well, but in browser, which is trying to connect via socket.io, I see error <code>WebSocket connection to ... failed: Invalid frame header</code>. Is it possible to get both connections working on single server instance?</p>\n<p>I&#39;m using <a href="https://github.com/techpines/express.io">express.io</a> and <a href="https://github.com/theturtle32/WebSocket-Node">websocket-node</a> and it would be great to get it working only with express.oi.</p>\n	2020-10-19 18:49:59.501569+03	58	9	{9,21}
\.


--
-- Data for Name: question_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_tag (id, "questionId", "tagId", "creationTime") FROM stdin;
1	14	6	2020-08-22 05:32:34.821192+03
2	17	5	2020-08-23 00:38:40.401229+03
3	8	5	2020-08-24 03:40:03.129303+03
4	18	4	2020-08-27 18:41:42.755887+03
5	18	9	2020-08-27 18:41:45.699156+03
6	19	5	2020-08-28 11:32:11.742721+03
7	19	9	2020-08-28 11:32:15.710348+03
8	19	10	2020-08-28 11:32:20.158068+03
9	20	4	2020-08-28 13:15:22.533341+03
10	20	5	2020-08-28 13:15:25.492285+03
11	20	9	2020-08-28 13:15:29.996481+03
12	20	10	2020-08-28 13:15:34.180751+03
13	21	4	2020-08-28 13:43:18.762482+03
14	21	9	2020-08-28 13:43:22.406718+03
15	21	10	2020-08-28 13:43:26.119274+03
16	22	1	2020-09-18 23:26:43.454551+03
17	22	3	2020-09-18 23:26:49.416761+03
18	30	19	2020-09-25 15:48:01.724576+03
19	30	20	2020-09-25 15:48:01.724576+03
20	29	19	2020-09-26 00:04:40.570706+03
21	29	20	2020-09-26 00:04:40.570706+03
22	31	8	2020-09-26 00:24:14.605569+03
23	31	21	2020-09-26 00:24:14.605569+03
24	41	2	2020-10-01 18:20:30.823882+03
37	50	22	2020-10-03 01:28:31.032093+03
38	51	2	2020-10-03 01:45:42.807696+03
39	52	8	2020-10-03 14:18:51.149895+03
40	52	1	2020-10-03 14:18:51.149895+03
43	54	8	2020-10-03 14:19:37.000849+03
44	54	1	2020-10-03 14:19:37.000849+03
45	55	5	2020-10-06 03:35:54.674826+03
46	55	23	2020-10-06 03:35:54.674826+03
47	56	3	2020-10-16 01:26:14.634339+03
48	56	2	2020-10-16 01:26:14.634339+03
49	56	24	2020-10-16 01:26:14.634339+03
50	57	2	2020-10-19 16:41:23.796578+03
51	58	9	2020-10-19 18:49:59.501569+03
52	58	21	2020-10-19 18:49:59.501569+03
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, title, description, "creationTime") FROM stdin;
7	Linux	\N	2020-08-22 05:27:54.414373+03
3	CSS	\N	2020-08-19 02:01:29.650449+03
4	Javascript	\N	2020-08-19 02:01:34.60473+03
10	Express	\N	2020-08-28 11:31:53.603226+03
9	Node.js	\N	2020-08-27 18:41:27.986354+03
6	Redis	\N	2020-08-22 05:27:50.321114+03
5	TypeScript	\N	2020-08-19 02:01:41.11841+03
1	HTML	HTML etiketi.	2020-08-16 01:10:31.840614+03
11	Fonts	\N	2020-09-17 04:23:00.072136+03
12	3D	\N	2020-09-17 04:23:02.670695+03
13	Security	\N	2020-09-17 04:23:09.151776+03
14	Layout	\N	2020-09-17 04:23:14.503239+03
15	Progressive Web Apps	\N	2020-09-17 04:23:27.887693+03
16	Service Worker	\N	2020-09-17 04:23:33.78274+03
17	DOM	\N	2020-09-17 04:23:46.264905+03
18	Mobile	\N	2020-09-17 04:24:05.22332+03
19	SQL	\N	2020-09-25 15:47:27.911819+03
20	PostgreSQL	\N	2020-09-25 15:47:45.531703+03
21	WebSocket	\N	2020-09-26 00:23:50.912308+03
22	React	\N	2020-10-03 01:28:25.376945+03
8	PHP	\N	2020-08-22 17:13:51.481438+03
2	Angular	Questions about Angular (not to be confused with AngularJS), the web framework from Google. Use this tag for Angular questions which are not specific to an individual version. For the older AngularJS (1.x) web framework, use the angularjs tag.	2020-08-19 02:01:23.759175+03
23	ESLint	\N	2020-10-06 03:35:49.691109+03
24	Bootstrap	\N	2020-10-16 01:26:08.840803+03
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, "displayName", picture, "signupDate", "githubUrl") FROM stdin;
6	baby@mail.com	eee	Baby Rose	https://resources.tidal.com/images/35f05805/5d01/4752/af23/fc53193aadce/320x320.jpg	2020-08-16 04:44:04.301767+03	\N
17	zubeyde@mail.com	123456	Zübeyde Banu	https://i.pinimg.com/236x/bb/dd/63/bbdd63ca4471428ab3a68aafa50aaed1.jpg	2020-09-26 00:20:04.460815+03	\N
18	katy2@mail.com	123456	Xd 02	https://i.pinimg.com/236x/a0/c6/39/a0c6398b5047c944458df4c83acf9e9b.jpg	2020-09-26 00:20:43.877425+03	\N
2	selena@mail.com	123456	Selena Gomez	https://i.pinimg.com/236x/77/20/90/772090a93d67abeeda8da11dafe6e2dc.jpg	2020-08-15 06:14:07.492467+03	\N
13	vic@mail.com	123456	Zümra Nurgül	https://i.pinimg.com/236x/ec/1d/a2/ec1da2b63f47f7bd5d05dfc28e84cb0a.jpg	2020-09-19 07:36:21.166471+03	\N
1	yonca@mail.com	123456	Yonca Nisanur	https://i.pinimg.com/236x/e4/2e/b2/e42eb24ceba8f92b0a8b4df542061901.jpg	2020-08-15 04:11:24.609176+03	\N
4	tugba@mail.com	123456	Tuğba Nurcan	https://i.pinimg.com/236x/bf/96/64/bf9664f23dd57f4dc5584352e04cf9a9.jpg	2020-08-16 03:46:50.294483+03	\N
19	xd3@mail.com	123456	Aydan Nimet	https://i.pinimg.com/236x/14/f1/01/14f10120318e0dc0f3d7deba20f1b5a7.jpg	2020-09-26 00:20:43.877425+03	\N
12	gamze@mail.com	123456	Smooth Gamze	https://i.pinimg.com/236x/71/80/44/7180447cf23bb50f04c4b5bcff574760.jpg	2020-09-17 02:20:45.106511+03	olcayusta
9	jojo@mail.com	123456	JoJo	https://i.pinimg.com/236x/34/f6/57/34f6575cf73e009b2cf8226d2f98a3d5.jpg	2020-08-28 13:41:00.50064+03	olcayusta
16	jessie@mail.com	123456	Gonca Feray	https://i.pinimg.com/236x/18/1f/c9/181fc93a4fb5f5bf1830555cdb24ebe4.jpg	2020-09-19 07:42:08.155349+03	\N
3	olcay@mail.com	123456	Olcay Usta	https://lh3.googleusercontent.com/I3vPQC49W37GweoHTItPowAlBjTmDAkF_kbkktZZGyCvkRhGGxH-BkQxUQWLQ6McJ_x40EmLX0YLYE3nGV55Q-URkR2D_F71wJtz1Atms2FBIoCBcE3-lwb_byrgQB-tGaWXrW9J7g4QuDtLCTquwm-H8Nn8m0yuckgICyxI5GTChWom1el7WaNQNAFlorrq9J0BKz7kb6AITofxZw_GaxWFIsM1fjIiXFcl21FaInbziGSJWIgibskUwLLpVUPhfnW1WtI_RSg50SX5mlCGLmMPks5i-1Z3fbrl7qCXYqw9tpcNqW6sjujk3jpVbHafEQjmsuM2tsBLfuWXLQIx0hga711VX-_H1Ysxovm4B24kk-kweXJtG-Pd58z75m_mzDPRjPDj1H2aAVRhOwT_oYcSmWguvrDn76rMhPGMFMu6ZBTQfRJetX2WzqvBdaGampg_NluYkCIXys-AcTF5neVr5sV15DdGe9Ng21D7lYoNmScQzeRCJcY4Nbl1KXQX79FpHeniZzF5ApVIIrsSkBqsMQdvhA4-MaOC1YbNpa-Zm2JBITNIwSRoDt5loo6Q8AQEk8USbLgy1mVFrgY7FdtLLKPl1uJcdZvPfTX4kBJyST3G9WC0YQFveODN6bmtXhJ2QRt99fSLfdAfjBFTqQR3-SP3LsuYHV51T9TeO8Z4zhTMC-Ea8hcxnvAj=s320-no?authuser=0	2020-08-15 19:26:45.713453+03	\N
7	jessie1@mail.com	123456	Jessica Parker	https://i.pinimg.com/564x/08/5f/da/085fda7a0e5ed46883b7e1038bd28c5b.jpg	2020-08-21 04:06:31.379266+03	\N
14	arabella@mail.com	123456	Arabella	https://i.pinimg.com/564x/9b/ad/f0/9badf0550a042156b90dfab3bc19a7c2.jpg	2020-09-19 07:37:06.417994+03	\N
15	famosa@mail.com	123456	Funda İrem	https://i.pinimg.com/236x/72/36/97/7236972e015f1398d7726f4e378b8417.jpg	2020-09-19 07:41:45.868564+03	\N
5	sahnaz@mail.com	123456	Şahnaz Selma	https://i.pinimg.com/236x/39/be/b0/39beb00d161fc793a8e2b3cdfd445447.jpg	2020-08-16 04:22:44.970259+03	\N
20	irmak@mail.com	123456	Irmak Sevinç	https://i.pinimg.com/236x/1c/4f/39/1c4f39b02b8f52e85678e193733ae62c.jpg	2020-10-19 16:44:01.791771+03	\N
8	sloh@mail.com	123456	SLOH Pink Cool	https://i.pinimg.com/236x/c4/1e/5b/c41e5b7df59a6a3b3e395d03886eb26c.jpg	2020-08-28 11:30:56.948947+03	\N
21	aysu@mail.com	123456	Aysu Güçin	https://yt3.ggpht.com/ytc/AAUvwnhnPoD5OHIwk_8_PJtRwQNNYiShqj-d8wmtdNDJ4w=s176-c-k-c0x00ffffff-no-rj-mo	2020-10-19 18:45:55.245831+03	\N
\.


--
-- Data for Name: user_favorite_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_favorite_answers (id, "answerId", "userId", "creationTime") FROM stdin;
\.


--
-- Data for Name: user_favorite_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_favorite_questions (id, "questionId", "userId", "creationTime") FROM stdin;
8	54	16	2020-10-04 03:06:14.386619+03
9	50	16	2020-10-04 03:06:19.610317+03
10	37	16	2020-10-04 03:08:25.624833+03
\.


--
-- Data for Name: user_favorite_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_favorite_tags (id, "tagId", "userId", "creationTime") FROM stdin;
1	1	1	2020-10-06 18:29:25.534613+03
3	1	9	2020-10-16 00:43:08.176724+03
4	2	21	2020-10-29 05:04:36.004747+03
\.


--
-- Data for Name: user_favorite_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_favorite_types (id, title) FROM stdin;
3	Question
4	Answer
\.


--
-- Name: answer_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_comment_id_seq', 2, true);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_id_seq', 46, true);


--
-- Name: chat_mesage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_mesage_id_seq', 67, true);


--
-- Name: chat_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_room_id_seq', 1, true);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 6, true);


--
-- Name: question_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_comment_id_seq', 3, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_id_seq', 58, true);


--
-- Name: question_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_revision_id_seq', 7, true);


--
-- Name: question_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_tag_id_seq', 52, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 24, true);


--
-- Name: user_favorite_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_favorite_answers_id_seq', 1, false);


--
-- Name: user_favorite_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_favorite_questions_id_seq', 10, true);


--
-- Name: user_favorite_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_favorite_tags_id_seq', 4, true);


--
-- Name: user_favorite_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_favorite_types_id_seq', 4, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 21, true);


--
-- Name: answer_comment answer_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comment
    ADD CONSTRAINT answer_comment_pk PRIMARY KEY (id);


--
-- Name: question_answer answer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_answer
    ADD CONSTRAINT answer_pk PRIMARY KEY (id);


--
-- Name: chat_message chat_mesage_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_mesage_pk PRIMARY KEY (id);


--
-- Name: chat_room chat_room_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room
    ADD CONSTRAINT chat_room_pk PRIMARY KEY (id);


--
-- Name: notification notification_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pk PRIMARY KEY (id);


--
-- Name: question_comment question_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_comment
    ADD CONSTRAINT question_comment_pk PRIMARY KEY (id);


--
-- Name: question question_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pk PRIMARY KEY (id);


--
-- Name: question_revision question_revision_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_revision
    ADD CONSTRAINT question_revision_pk PRIMARY KEY (id);


--
-- Name: question_tag question_tag_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag
    ADD CONSTRAINT question_tag_pk PRIMARY KEY (id);


--
-- Name: tag tag_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pk PRIMARY KEY (id);


--
-- Name: user_favorite_answers user_favorite_answers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_answers
    ADD CONSTRAINT user_favorite_answers_pk PRIMARY KEY (id);


--
-- Name: user_favorite_questions user_favorite_questions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_questions
    ADD CONSTRAINT user_favorite_questions_pk PRIMARY KEY (id);


--
-- Name: user_favorite_tags user_favorite_tags_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_tags
    ADD CONSTRAINT user_favorite_tags_pk PRIMARY KEY (id);


--
-- Name: user_favorite_types user_favorite_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_types
    ADD CONSTRAINT user_favorite_types_pk PRIMARY KEY (id);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: idx_test; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_test ON public.question USING gin (tags);


--
-- Name: idx_test2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_test2 ON public.question USING gin (tags2);


--
-- Name: user_favorite_answers_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_favorite_answers_id_uindex ON public.user_favorite_answers USING btree (id);


--
-- Name: user_favorite_questions_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_favorite_questions_id_uindex ON public.user_favorite_questions USING btree (id);


--
-- Name: user_favorite_tags_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_favorite_tags_id_uindex ON public.user_favorite_tags USING btree (id);


--
-- Name: user_favorite_types_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_favorite_types_id_uindex ON public.user_favorite_types USING btree (id);


--
-- PostgreSQL database dump complete
--

