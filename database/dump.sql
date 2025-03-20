--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-20 21:16:16

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
-- TOC entry 882 (class 1247 OID 16618)
-- Name: ExerciseType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ExerciseType" AS ENUM (
    'MULTIPLE_CHOICE',
    'TRANSLATION',
    'TRUE_FALSE',
    'TALK'
);


--
-- TOC entry 885 (class 1247 OID 16628)
-- Name: ExercisesSerieType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ExercisesSerieType" AS ENUM (
    'DEFAULT',
    'TALK'
);


--
-- TOC entry 873 (class 1247 OID 16583)
-- Name: FrequencyNotification; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."FrequencyNotification" AS ENUM (
    'TODAY',
    'ONE_DAY',
    'TWO_DAYS',
    'THREE_DAYS',
    'FOUR_DAYS',
    'FIVE_DAYS',
    'SIX_DAYS',
    'SEVEN_DAYS'
);


--
-- TOC entry 879 (class 1247 OID 16606)
-- Name: LevelEnum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."LevelEnum" AS ENUM (
    'A1',
    'A2',
    'B1',
    'B2',
    'C1'
);


--
-- TOC entry 876 (class 1247 OID 16600)
-- Name: Role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Role" AS ENUM (
    'USER',
    'ADMIN'
);


--
-- TOC entry 247 (class 1255 OID 16847)
-- Name: add_completedseries_in_user_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_completedseries_in_user_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "UserStats"
    SET "completedSeries" = "completedSeries" + 1
    WHERE "userId" = NEW."userId";
    RETURN NULL;
END;
$$;


--
-- TOC entry 234 (class 1255 OID 16821)
-- Name: add_points_in_user_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_points_in_user_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = NEW."serieId" LIMIT 1;

    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "UserStats"
    SET "points" = "points" + "points_per_exo"
    WHERE "userId" = NEW."userId";
    RETURN NULL;
END;
$$;


--
-- TOC entry 233 (class 1255 OID 16819)
-- Name: add_successfullexercises_in_user_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_successfullexercises_in_user_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "UserStats"
    SET "successfullExercises" = "successfullExercises" + 1
    WHERE "userId" = NEW."userId";
    RETURN NULL;
END;
$$;


--
-- TOC entry 236 (class 1255 OID 16825)
-- Name: add_totalexercises_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_totalexercises_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalExercises" = "totalExercises" + 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 237 (class 1255 OID 16827)
-- Name: add_totalpoints_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_totalpoints_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = NEW."serieId" LIMIT 1;

    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "SiteStats"
    SET "totalPoints" = "totalPoints" + "points_per_exo"
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 238 (class 1255 OID 16829)
-- Name: add_totalseries_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_totalseries_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalSeries" = "totalSeries" + 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 235 (class 1255 OID 16823)
-- Name: add_totalusers_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_totalusers_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalUsers" = "totalUsers" + 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 239 (class 1255 OID 16831)
-- Name: add_winablepoints_in_level(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_winablepoints_in_level() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = NEW."serieId" LIMIT 1;

    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "Level"
    SET "winablePoints" = "winablePoints" + "points_per_exo"
    WHERE id = "level_id";
    RETURN NULL;
END;
$$;


--
-- TOC entry 248 (class 1255 OID 16849)
-- Name: check_user_level(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.check_user_level() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    levelUser "LevelEnum";
BEGIN
    SELECT "title" INTO levelUser FROM "Level" WHERE "winablePoints" >= NEW."points" ORDER BY "winablePoints" ASC LIMIT 1;

    IF levelUser != NEW."level" THEN
        UPDATE "UserStats"
        SET "level" = levelUser
        WHERE "userId" = NEW."userId";
    END IF;
    RETURN NULL;
END;
$$;


--
-- TOC entry 245 (class 1255 OID 16843)
-- Name: subtract_points_in_user_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.subtract_points_in_user_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = OLD."serieId" LIMIT 1;
    
    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "UserStats"
    SET "points" = "points" - "points_per_exo"
    WHERE "userId" = OLD."userId";
    RETURN NULL;
END;
$$;


--
-- TOC entry 246 (class 1255 OID 16845)
-- Name: subtract_successfullexercises_in_user_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.subtract_successfullexercises_in_user_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "UserStats"
    SET "successfullExercises" = "successfullExercises" - 1
    WHERE "userId" = OLD."userId";
    RETURN NULL;
END;
$$;


--
-- TOC entry 243 (class 1255 OID 16839)
-- Name: subtract_totalexercises_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.subtract_totalexercises_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalExercises" = "totalExercises" - 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 241 (class 1255 OID 16835)
-- Name: subtract_totalpoints_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.subtract_totalpoints_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = OLD."serieId" LIMIT 1;
    
    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "SiteStats"
    SET "totalPoints" = "totalPoints" - "points_per_exo"
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 240 (class 1255 OID 16833)
-- Name: subtract_totalseries_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.subtract_totalseries_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalSeries" = "totalSeries" - 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 244 (class 1255 OID 16841)
-- Name: subtract_totalusers_in_site_stats(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.subtract_totalusers_in_site_stats() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "SiteStats"
    SET "totalUsers" = "totalUsers" - 1
    WHERE id = 1;
    RETURN NULL;
END;
$$;


--
-- TOC entry 242 (class 1255 OID 16837)
-- Name: subtract_winablepoints_in_level(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.subtract_winablepoints_in_level() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    level_id INTEGER;
    points_per_exo INTEGER;
BEGIN
    SELECT "levelId" INTO "level_id" FROM "ExercisesSerie" WHERE id = OLD."serieId" LIMIT 1;
    
    SELECT "pointsPerExo" INTO "points_per_exo" FROM "Level" WHERE id = "level_id" LIMIT 1;

    UPDATE "Level"
    SET "winablePoints" = "winablePoints" - "points_per_exo"
    WHERE id = "level_id";
    RETURN NULL;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16656)
-- Name: Avatar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Avatar" (
    id integer NOT NULL,
    svg text NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16655)
-- Name: Avatar_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Avatar_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 218
-- Name: Avatar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Avatar_id_seq" OWNED BY public."Avatar".id;


--
-- TOC entry 229 (class 1259 OID 16720)
-- Name: Exercise; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Exercise" (
    id integer NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    choices jsonb NOT NULL,
    type public."ExerciseType" NOT NULL,
    "serieId" integer NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 16719)
-- Name: Exercise_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Exercise_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 228
-- Name: Exercise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Exercise_id_seq" OWNED BY public."Exercise".id;


--
-- TOC entry 227 (class 1259 OID 16709)
-- Name: ExercisesSerie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ExercisesSerie" (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "levelId" integer NOT NULL,
    type public."ExercisesSerieType" DEFAULT 'DEFAULT'::public."ExercisesSerieType" NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16708)
-- Name: ExercisesSerie_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."ExercisesSerie_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 226
-- Name: ExercisesSerie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."ExercisesSerie_id_seq" OWNED BY public."ExercisesSerie".id;


--
-- TOC entry 225 (class 1259 OID 16698)
-- Name: Level; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Level" (
    id integer NOT NULL,
    title public."LevelEnum" NOT NULL,
    subtitle text NOT NULL,
    description text,
    "winablePoints" integer DEFAULT 0 NOT NULL,
    "pointsPerExo" integer DEFAULT 1 NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16697)
-- Name: Level_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Level_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 224
-- Name: Level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Level_id_seq" OWNED BY public."Level".id;


--
-- TOC entry 217 (class 1259 OID 16644)
-- Name: Notification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Notification" (
    id integer NOT NULL,
    "userId" text NOT NULL,
    "isActivate" boolean DEFAULT true NOT NULL,
    subscription text NOT NULL,
    frequency public."FrequencyNotification" DEFAULT 'ONE_DAY'::public."FrequencyNotification" NOT NULL,
    "notificationTime" text DEFAULT '17:00'::text NOT NULL,
    "nextNotifyAt" timestamp(3) without time zone NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16643)
-- Name: Notification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Notification_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 216
-- Name: Notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Notification_id_seq" OWNED BY public."Notification".id;


--
-- TOC entry 223 (class 1259 OID 16689)
-- Name: RefreshToken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RefreshToken" (
    id text NOT NULL,
    token text NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16664)
-- Name: SiteStats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SiteStats" (
    id integer DEFAULT 1 NOT NULL,
    "totalUsers" integer DEFAULT 0 NOT NULL,
    "totalExercises" integer DEFAULT 0 NOT NULL,
    "totalSeries" integer DEFAULT 0 NOT NULL,
    "totalPoints" integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16633)
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id text NOT NULL,
    pseudo text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role public."Role" DEFAULT 'USER'::public."Role" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "avatarId" integer,
    "firstTimeConnection" boolean DEFAULT true NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 16728)
-- Name: UserCompletedExercise; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserCompletedExercise" (
    "userId" text NOT NULL,
    "exerciseId" integer NOT NULL,
    "completedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "serieId" integer NOT NULL,
    "pointsWon" integer DEFAULT 1 NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 16745)
-- Name: UserCompletedExercisesSerie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserCompletedExercisesSerie" (
    "userId" text NOT NULL,
    "serieId" integer NOT NULL,
    "completedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 16737)
-- Name: UserFavoriteSerie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserFavoriteSerie" (
    "userId" text NOT NULL,
    "serieId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16675)
-- Name: UserStats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserStats" (
    id integer NOT NULL,
    "userId" text NOT NULL,
    points integer DEFAULT 0 NOT NULL,
    "successfullExercises" integer DEFAULT 0 NOT NULL,
    "failedExercises" integer DEFAULT 0 NOT NULL,
    "completedSeries" integer DEFAULT 0 NOT NULL,
    "timeSpentOnExercises" integer DEFAULT 0 NOT NULL,
    level public."LevelEnum" DEFAULT 'A1'::public."LevelEnum" NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16674)
-- Name: UserStats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."UserStats_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 221
-- Name: UserStats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."UserStats_id_seq" OWNED BY public."UserStats".id;


--
-- TOC entry 3258 (class 2604 OID 16659)
-- Name: Avatar id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Avatar" ALTER COLUMN id SET DEFAULT nextval('public."Avatar_id_seq"'::regclass);


--
-- TOC entry 3278 (class 2604 OID 16723)
-- Name: Exercise id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Exercise" ALTER COLUMN id SET DEFAULT nextval('public."Exercise_id_seq"'::regclass);


--
-- TOC entry 3275 (class 2604 OID 16712)
-- Name: ExercisesSerie id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ExercisesSerie" ALTER COLUMN id SET DEFAULT nextval('public."ExercisesSerie_id_seq"'::regclass);


--
-- TOC entry 3272 (class 2604 OID 16701)
-- Name: Level id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Level" ALTER COLUMN id SET DEFAULT nextval('public."Level_id_seq"'::regclass);


--
-- TOC entry 3254 (class 2604 OID 16647)
-- Name: Notification id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Notification" ALTER COLUMN id SET DEFAULT nextval('public."Notification_id_seq"'::regclass);


--
-- TOC entry 3264 (class 2604 OID 16678)
-- Name: UserStats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserStats" ALTER COLUMN id SET DEFAULT nextval('public."UserStats_id_seq"'::regclass);


--
-- TOC entry 3486 (class 0 OID 16656)
-- Dependencies: 219
-- Data for Name: Avatar; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Avatar" VALUES (1, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80" fill="none" shape-rendering="auto" width="512" height="512"><metadata xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type="dcterms:URI">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type="dcterms:URI">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of ÔÇ×Dylan! The Avatar GeneratorÔÇØ (https://www.figma.com/community/file/1356575240759683500) by ÔÇ×Natalia SpivakÔÇØ, licensed under ÔÇ×CC BY 4.0ÔÇØ (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id="viewboxMask"><rect width="80" height="80" rx="0" ry="0" x="0" y="0" fill="#fff" /></mask><g mask="url(#viewboxMask)"><rect fill="#29e051" width="80" height="80" x="0" y="0" /><path d="M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64" fill="#ffd6c0"/><path d="m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1" fill="black"/><path d="M30.36 48.8c.6-.5 2.22-2.29 2.9-2.12.41.1 1.03 1.1 1.3 1.41l1.57 1.74c.48.53 1.2.28 1.57-.2.88-1.15 2.48-2 3.68-2.78l-1.21-.16c1.02 1.08 2.36 2.66 3.9 3.06 1.34.34 2.28-.9 3.12-1.7q.44-.47.87-.88.3-.28.58-.58.1-.2.28.28c.72.5 1.33 1.4 1.92 2.04.89.94 2.3-.48 1.4-1.4l-1.91-2.05c-.45-.47-.9-.97-1.62-1-.6 0-1.08.35-1.5.73-.7.65-1.35 1.36-2.02 2-.05.07-.52.63-.66.64-.08 0-.24-.16-.33-.2-.42-.17-.8-.58-1.13-.88q-.78-.72-1.5-1.5a1 1 0 0 0-1.2-.17c-1.52 1-3.28 2.04-4.4 3.5l1.57-.2-2.3-2.53c-.51-.57-1.04-1.17-1.84-1.3s-1.45.3-2.06.8l-2.41 2c-1 .82.43 2.23 1.4 1.4z" fill="black"/><path d="M19.51 30.42c16.36-4.9 20.13-15.57 20.13-15.57S51.18 29.46 60.6 30.5c0-.01.85-.03 2.57.15 0 0-3.22-21.28-23.36-20.56S18.19 30.61 18.19 30.61l1.32-.2z" fill="#ffffff"/></g></svg>');
INSERT INTO public."Avatar" VALUES (2, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80" fill="none" shape-rendering="auto" width="512" height="512"><metadata xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type="dcterms:URI">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type="dcterms:URI">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of ÔÇ×Dylan! The Avatar GeneratorÔÇØ (https://www.figma.com/community/file/1356575240759683500) by ÔÇ×Natalia SpivakÔÇØ, licensed under ÔÇ×CC BY 4.0ÔÇØ (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id="viewboxMask"><rect width="80" height="80" rx="0" ry="0" x="0" y="0" fill="#fff" /></mask><g mask="url(#viewboxMask)"><rect fill="#ffa6e6" width="80" height="80" x="0" y="0" /><path d="M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64" fill="#ffd6c0"/><path d="m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1" fill="black"/><path d="M35.7 42.4c-1.18 1.26-2.17 2.74-2.36 4.5a4.4 4.4 0 0 0 1.78 4.02c1.26.9 2.88.8 4.07-.13a5.5 5.5 0 0 0 1.87-3.88c.1-.97-1.46-1.38-1.86-.5-.75 1.63.16 3.26 1.34 4.42a3.9 3.9 0 0 0 4.13.98 4.6 4.6 0 0 0 2.93-3.14 6.6 6.6 0 0 0-.82-4.87c-.64-1.11-2.37-.11-1.73 1 .92 1.6 1.18 4-.7 5.02-.7.35-1.5.36-2.12-.12-.49-.39-1.63-1.55-1.3-2.26l-1.86-.5c-.14 1.34-1.44 3.63-2.97 2.23-1.74-1.59-.22-4 1.03-5.33.88-.94-.53-2.36-1.4-1.4z" fill="black"/><path d="M19.07 30.47s1.63 6 2.49 5.81c2.1-.36 4.15-17.25 4.15-17.25l30.03-.32s1.64 17.06 3.18 17.06 3.37-5.22 3.37-5.22 1.22-19.9-.27-21.9C59.7 5.58 20.28 5.12 19 9.9s.06 20.58.06 20.58z" fill="#fff500"/></g></svg>');
INSERT INTO public."Avatar" VALUES (3, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80" fill="none" shape-rendering="auto" width="512" height="512"><metadata xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type="dcterms:URI">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type="dcterms:URI">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of ÔÇ×Dylan! The Avatar GeneratorÔÇØ (https://www.figma.com/community/file/1356575240759683500) by ÔÇ×Natalia SpivakÔÇØ, licensed under ÔÇ×CC BY 4.0ÔÇØ (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id="viewboxMask"><rect width="80" height="80" rx="0" ry="0" x="0" y="0" fill="#fff" /></mask><g mask="url(#viewboxMask)"><rect fill="#29e051" width="80" height="80" x="0" y="0" /><path d="M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64" fill="#ffd6c0"/><path d="m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1" fill="black"/><path d="M30.5 32.66q.36-.4.77-.76l.09-.08.04-.03c-.12.09 0 0 .02 0l.12-.1.45-.3.44-.25.24-.12.14-.06c.03-.01.16-.07.02 0l.05-.02.1-.04.26-.1.55-.15c.5-.12.86-.73.7-1.23s-.7-.83-1.23-.7a8 8 0 0 0-4.17 2.52c-.34.4-.42 1.03 0 1.4.38.36 1.05.43 1.41 0m18.4-1.87q.9.15 1.8.43l.4.15.25.09.06.02-.06-.03c.02.04.19.08.23.1l.17.08.46.23c.46.25 1.1.13 1.37-.36.26-.5.13-1.1-.36-1.37a12 12 0 0 0-3.8-1.3c-.28-.03-.52-.04-.77.1a1 1 0 0 0-.46.6c-.1.49.15 1.15.7 1.24zM36.4 47.12a17 17 0 0 1 11.35-.1c1.22.4 1.74-1.52.53-1.94a18.8 18.8 0 0 0-12.4.1c-.5.19-.86.69-.7 1.24.12.49.71.88 1.22.7" fill="black"/><path d="M26.74 18.86s9.68 6.45 29.03 4.64c0 0-3.58 42.43 6.9 42.63s13.77-27.55 5.19-45.05C57.99.92 21.5-1.3 12.03 22.29c-9.47 23.6-.7 44.46 5.93 44.9 12.3.8 8.78-48.33 8.78-48.33" fill="#fff500"/></g></svg>');
INSERT INTO public."Avatar" VALUES (4, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80" fill="none" shape-rendering="auto" width="512" height="512"><metadata xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type="dcterms:URI">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type="dcterms:URI">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of ÔÇ×Dylan! The Avatar GeneratorÔÇØ (https://www.figma.com/community/file/1356575240759683500) by ÔÇ×Natalia SpivakÔÇØ, licensed under ÔÇ×CC BY 4.0ÔÇØ (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id="viewboxMask"><rect width="80" height="80" rx="0" ry="0" x="0" y="0" fill="#fff" /></mask><g mask="url(#viewboxMask)"><rect fill="#619eff" width="80" height="80" x="0" y="0" /><path d="M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64" fill="#ffd6c0"/><path d="m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1" fill="black"/><path d="m35.05 46.19-.5.03c-1.29.07-1.3 2.04 0 2l13.82-.4c1.28-.03 1.29-2.03 0-2l-13.83.4v2l.5-.03c1.29-.07 1.3-2.07 0-2" fill="black"/><path d="M26.74 18.86s9.68 6.45 29.03 4.64c0 0-3.58 42.43 6.9 42.63s13.77-27.55 5.19-45.05C57.99.92 21.5-1.3 12.03 22.29c-9.47 23.6-.7 44.46 5.93 44.9 12.3.8 8.78-48.33 8.78-48.33" fill="#ffffff"/></g></svg>');
INSERT INTO public."Avatar" VALUES (5, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80" fill="none" shape-rendering="auto" width="512" height="512"><metadata xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type="dcterms:URI">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type="dcterms:URI">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of ÔÇ×Dylan! The Avatar GeneratorÔÇØ (https://www.figma.com/community/file/1356575240759683500) by ÔÇ×Natalia SpivakÔÇØ, licensed under ÔÇ×CC BY 4.0ÔÇØ (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id="viewboxMask"><rect width="80" height="80" rx="0" ry="0" x="0" y="0" fill="#fff" /></mask><g mask="url(#viewboxMask)"><rect fill="#29e051" width="80" height="80" x="0" y="0" /><path d="M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64" fill="#ffd6c0"/><path d="m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1" fill="black"/><path d="M30.5 32.66q.36-.4.77-.76l.09-.08.04-.03c-.12.09 0 0 .02 0l.12-.1.45-.3.44-.25.24-.12.14-.06c.03-.01.16-.07.02 0l.05-.02.1-.04.26-.1.55-.15c.5-.12.86-.73.7-1.23s-.7-.83-1.23-.7a8 8 0 0 0-4.17 2.52c-.34.4-.42 1.03 0 1.4.38.36 1.05.43 1.41 0m18.4-1.87q.9.15 1.8.43l.4.15.25.09.06.02-.06-.03c.02.04.19.08.23.1l.17.08.46.23c.46.25 1.1.13 1.37-.36.26-.5.13-1.1-.36-1.37a12 12 0 0 0-3.8-1.3c-.28-.03-.52-.04-.77.1a1 1 0 0 0-.46.6c-.1.49.15 1.15.7 1.24zM36.4 47.12a17 17 0 0 1 11.35-.1c1.22.4 1.74-1.52.53-1.94a18.8 18.8 0 0 0-12.4.1c-.5.19-.86.69-.7 1.24.12.49.71.88 1.22.7" fill="black"/><path d="M18.49 30.45s.13 3.91 1.44 3.8c1.3-.1 3.05-12.59 3.05-12.59s18.07 4.66 33.19-.65c0 0 1.72 13.2 3.34 13.07 1.38-.12 2.4-3.57 2.4-3.57 0 .02 4.47-8.58-.62-17.85-7.93-14.45-29.74-11.22-35.44-.21 0 0-5.9-.94-8.3 6.35-2.38 7.29.94 11.67.94 11.67" fill="#1d5dff"/></g></svg>');
INSERT INTO public."Avatar" VALUES (6, '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80" fill="none" shape-rendering="auto" width="512" height="512"><metadata xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type="dcterms:URI">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type="dcterms:URI">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of ÔÇ×Dylan! The Avatar GeneratorÔÇØ (https://www.figma.com/community/file/1356575240759683500) by ÔÇ×Natalia SpivakÔÇØ, licensed under ÔÇ×CC BY 4.0ÔÇØ (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id="viewboxMask"><rect width="80" height="80" rx="0" ry="0" x="0" y="0" fill="#fff" /></mask><g mask="url(#viewboxMask)"><rect fill="#ffa6e6" width="80" height="80" x="0" y="0" /><path d="M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64" fill="#ffd6c0"/><path d="m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1" fill="black"/><path d="M32.92 49.45c1.24-2.82 4.75-4.07 7.63-4.27 3.08-.2 6.1.67 8.56 2.52 1.03.77 2.03-.96 1-1.73a14.5 14.5 0 0 0-10.1-2.75c-3.36.36-7.37 1.9-8.82 5.21-.5 1.17 1.2 2.2 1.73 1zm15.8-19.37q.15-.33.36-.6l-.16.2q.25-.34.58-.6l-.2.17q.33-.25.71-.41l-.24.1q.37-.15.75-.21l-.27.04s.1 0 .15-.02q.4-.02.7-.3a1 1 0 0 0 .3-.7c-.01-.25-.1-.53-.3-.71s-.44-.32-.7-.3a4.1 4.1 0 0 0-3.42 2.3c-.1.27-.18.5-.1.79.06.23.24.48.46.6q.36.2.77.1c.23-.08.5-.23.6-.46zM31.65 28.9l.18.03-.27-.04q.57.08 1.09.3l-.24-.1q.53.22.98.57l-.2-.16q.34.27.63.59c.16.2.47.29.7.29s.55-.1.72-.29c.4-.42.37-.99 0-1.41q-.65-.73-1.52-1.2a6 6 0 0 0-2.07-.59 1 1 0 0 0-1 1c0 .25.1.53.3.71q.3.27.7.29z" fill="black"/><path d="M25.51 20.1c-.23.95-.21 2.72 0 3.67s1.46 1.17 2.44 1.15c1.01-.01 1.75-.93 2.22-1.83q.87-1.7 1.16-3.59c-.09 1.82.42 4.03 2.15 4.6 1.2.37 2.53-.25 3.34-1.2a10 10 0 0 0 1.6-3.39c-.1 1.13-.2 2.3.16 3.36.35 1.07 1.27 2.05 2.4 2.1.92.03 1.76-.53 2.4-1.2a7 7 0 0 0 1.8-3.93c-.54 2 1.15 4.27 3.21 4.34s3.9-2.1 3.48-4.13c.31 1.57 1.44 3.04 3 3.43 1.54.41 3.41-.58 3.68-2.16a16 16 0 0 0-.79 8.68c.17.92.5 1.91 1.32 2.33s2.1-.36 1.76-1.2a16.8 16.8 0 0 0-3.86 10.6c0 1.3.2 2.7 1.12 3.6.92.91 2.78.9 3.29-.3-1.68 1.32-2.76 6.96-2.81 9.1-.04 1.95 0 4 .94 5.7s2.98 2.98 4.83 2.37c2.1-.7 3.73-6.6 3.35-8.79-.32.2-.21.75.1.95.33.2.75.14 1.12.03a5.1 5.1 0 0 0 3.5-3.88 5.1 5.1 0 0 0-1.87-4.88c.06.62 1.02.5 1.5.1A7.2 7.2 0 0 0 74.39 38c-.33-.95-1.13-1.97-2.12-1.79 1.32-.17 1.98-1.72 2-3.05.06-3.83-2.17-8.5-6-8.3.96-2.2.86-5.1-.71-6.93-2.54-2.96-4.1-2.55-6.48-2.19A6.5 6.5 0 0 0 59.1 9.2a6.5 6.5 0 0 0-6.74-1C51.3 6 48.84 4.77 46.42 4.4a6 6 0 0 0-3.17.2c-1 .41-1.83 1.33-1.88 2.4a8.56 8.56 0 0 0-11.19-.16c-.55.5-.97 1.5-.3 1.84 0 0-6.66-1.62-9.49 2.62s-1.13 5.79-1.13 5.79-6.92.28-6.78 3.95 1.27 4.24 1.27 4.24-6.01-1.72-7.29 1.79c-1.04 2.82 1.79 4.42 1.79 4.42 0-.05-5.4 2.22-4.24 7.6.75 3.5 3.4 4.1 3.4 4.1s-2.41 6.6-.15 9 5.22.42 5.22.42-1.41 7.2 1.84 8.33 5.36-2.12 5.36-2.12-2.12 6.07 2.54 5.5c4.66-.55 7.46-9.6 3.4-13.68-.01 0 2.1-3.96 1.4-7.35s-3.25-5.79-3.25-5.79 1.98-1.12 1.7-3.94c-.3-2.82-3.26-4.38-3.26-4.38s3.4-3.1 3.53-9.18" fill="#fff500"/></g></svg>');


--
-- TOC entry 3496 (class 0 OID 16720)
-- Dependencies: 229
-- Data for Name: Exercise; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Exercise" VALUES (7, 'How do you say ''Bonjour'' in English?', 'hello', '["Hello", "Goodbye", "Thank you", "Sorry"]', 'MULTIPLE_CHOICE', 96);
INSERT INTO public."Exercise" VALUES (8, 'Traduisez : ''Je m''appelle Paul.''', 'my name is paul', '{}', 'TRANSLATION', 96);
INSERT INTO public."Exercise" VALUES (9, 'Is the following statement true or false? ''The English word for ''merci'' is ''Sorry''''.', 'false', '{}', 'TRUE_FALSE', 96);
INSERT INTO public."Exercise" VALUES (10, 'How do you say ''Merci'' in English?', 'thank you', '["Please", "Thank you", "You''re welcome", "Sorry"]', 'MULTIPLE_CHOICE', 96);
INSERT INTO public."Exercise" VALUES (11, 'Traduisez : ''J''habite à Paris.''', 'i live in paris', '{}', 'TRANSLATION', 96);
INSERT INTO public."Exercise" VALUES (12, 'Is the following statement true or false? ''In English, ‘Good morning’ means ‘Bonsoir’.''', 'false', '{}', 'TRUE_FALSE', 96);
INSERT INTO public."Exercise" VALUES (13, 'How do you say ''10'' in English?', 'ten', '["Ten", "Twenty", "Thirty", "Five"]', 'MULTIPLE_CHOICE', 97);
INSERT INTO public."Exercise" VALUES (14, 'Traduisez : ''Il est trois heures.''', 'it is three oclock', '{}', 'TRANSLATION', 97);
INSERT INTO public."Exercise" VALUES (15, 'Is the following statement true or false? ''The number 15 in English is ''Fifty''''.', 'false', '{}', 'TRUE_FALSE', 97);
INSERT INTO public."Exercise" VALUES (16, 'How do you say ''Mercredi'' in English?', 'wednesday', '["Monday", "Tuesday", "Wednesday", "Thursday"]', 'MULTIPLE_CHOICE', 97);
INSERT INTO public."Exercise" VALUES (17, 'Traduisez : ''Nous sommes le 5 avril.''', 'it is april 5th', '{}', 'TRANSLATION', 97);
INSERT INTO public."Exercise" VALUES (18, 'Is the following statement true or false? ''In English, ''December'' is a summer month.''', 'false', '{}', 'TRUE_FALSE', 97);
INSERT INTO public."Exercise" VALUES (19, 'How do you say ''Rouge'' in English?', 'red', '["Red", "Blue", "Green", "Yellow"]', 'MULTIPLE_CHOICE', 98);
INSERT INTO public."Exercise" VALUES (20, 'Traduisez : ''La table est marron.''', 'the table is brown', '{}', 'TRANSLATION', 98);
INSERT INTO public."Exercise" VALUES (21, 'Is the following statement true or false? ''The English word for ''bleu'' is ''Green''''.', 'false', '{}', 'TRUE_FALSE', 98);
INSERT INTO public."Exercise" VALUES (22, 'How do you say ''Chaise'' in English?', 'chair', '["Table", "Chair", "Door", "Window"]', 'MULTIPLE_CHOICE', 98);
INSERT INTO public."Exercise" VALUES (23, 'Traduisez : ''Le ciel est bleu.''', 'the sky is blue', '{}', 'TRANSLATION', 98);
INSERT INTO public."Exercise" VALUES (24, 'Is the following statement true or false? ''In English, ''black'' means ''noir''''.', 'true', '{}', 'TRUE_FALSE', 98);
INSERT INTO public."Exercise" VALUES (25, 'How do you say ''Manger'' in English?', 'eat', '["Eat", "Sleep", "Run", "Drink"]', 'MULTIPLE_CHOICE', 99);
INSERT INTO public."Exercise" VALUES (26, 'Traduisez : ''Je bois de l''eau.''', 'i drink water', '{}', 'TRANSLATION', 99);
INSERT INTO public."Exercise" VALUES (27, 'Is the following statement true or false? ''The verb ''to sleep'' means ''dormir'' in French.''', 'true', '{}', 'TRUE_FALSE', 99);
INSERT INTO public."Exercise" VALUES (28, 'How do you say ''Courir'' in English?', 'run', '["Jump", "Walk", "Run", "Sing"]', 'MULTIPLE_CHOICE', 99);
INSERT INTO public."Exercise" VALUES (29, 'Traduisez : ''Il lit un livre.''', 'he reads a book', '{}', 'TRANSLATION', 99);
INSERT INTO public."Exercise" VALUES (30, 'Is the following statement true or false? ''In English, ‘to write’ means ‘écrire’.''', 'true', '{}', 'TRUE_FALSE', 99);
INSERT INTO public."Exercise" VALUES (31, 'How do you say ''Je m''appelle'' in English?', 'my name is', '["My name is", "I have", "I live in", "I am"]', 'MULTIPLE_CHOICE', 100);
INSERT INTO public."Exercise" VALUES (32, 'Traduisez : ''J''ai 25 ans.''', 'i am 25 years old', '{}', 'TRANSLATION', 100);
INSERT INTO public."Exercise" VALUES (33, 'Is the following statement true or false? ''In English, ‘I am from France’ means ‘Je viens de France’.''', 'true', '{}', 'TRUE_FALSE', 100);
INSERT INTO public."Exercise" VALUES (34, 'How do you say ''J''habite à Londres'' in English?', 'i live in london', '["I live in London", "I am from London", "I go to London", "I stay in London"]', 'MULTIPLE_CHOICE', 100);
INSERT INTO public."Exercise" VALUES (35, 'Traduisez : ''Je suis étudiant.''', 'i am a student', '{}', 'TRANSLATION', 100);
INSERT INTO public."Exercise" VALUES (36, 'Is the following statement true or false? ''In English, ‘I have 20 years’ is correct to say your age.''', 'false', '{}', 'TRUE_FALSE', 100);
INSERT INTO public."Exercise" VALUES (37, 'How do you say ''Bonjour'' in English?', 'hello', '["Hello", "Goodbye", "Please", "Thank you"]', 'MULTIPLE_CHOICE', 101);
INSERT INTO public."Exercise" VALUES (38, 'Traduisez : ''Merci beaucoup.''', 'thank you very much', '{}', 'TRANSLATION', 101);
INSERT INTO public."Exercise" VALUES (39, 'Is the following statement true or false? ''In English, ‘Good night’ is used to greet someone in the morning.''', 'false', '{}', 'TRUE_FALSE', 101);
INSERT INTO public."Exercise" VALUES (40, 'How do you say ''Au revoir'' in English?', 'goodbye', '["Hello", "Goodbye", "Thanks", "Sorry"]', 'MULTIPLE_CHOICE', 101);
INSERT INTO public."Exercise" VALUES (41, 'Traduisez : ''Excusez-moi, où sont les toilettes ?''', 'excuse me where are the restrooms', '{}', 'TRANSLATION', 101);
INSERT INTO public."Exercise" VALUES (42, 'Is the following statement true or false? ''In English, ‘Please’ is used to make a request more polite.''', 'true', '{}', 'TRUE_FALSE', 101);
INSERT INTO public."Exercise" VALUES (43, 'How do you say ''Mère'' in English?', 'mother', '["Mother", "Father", "Brother", "Sister"]', 'MULTIPLE_CHOICE', 102);
INSERT INTO public."Exercise" VALUES (44, 'Traduisez : ''Mon père s''appelle Jean.''', 'my father’s name is jean', '{}', 'TRANSLATION', 102);
INSERT INTO public."Exercise" VALUES (45, 'Is the following statement true or false? ''The English word for ''frère'' is ''Brother''''.', 'true', '{}', 'TRUE_FALSE', 102);
INSERT INTO public."Exercise" VALUES (46, 'How do you say ''Soeur'' in English?', 'sister', '["Mother", "Father", "Sister", "Uncle"]', 'MULTIPLE_CHOICE', 102);
INSERT INTO public."Exercise" VALUES (47, 'Traduisez : ''J’ai un oncle et une tante.''', 'i have an uncle and an aunt', '{}', 'TRANSLATION', 102);
INSERT INTO public."Exercise" VALUES (48, 'Is the following statement true or false? ''In English, ‘uncle’ means ‘cousin’.''', 'false', '{}', 'TRUE_FALSE', 102);
INSERT INTO public."Exercise" VALUES (49, 'How do you say ''Chat'' in English?', 'cat', '["Cat", "Dog", "Horse", "Rabbit"]', 'MULTIPLE_CHOICE', 103);
INSERT INTO public."Exercise" VALUES (50, 'Traduisez : ''Un lion est un animal sauvage.''', 'a lion is a wild animal', '{}', 'TRANSLATION', 103);
INSERT INTO public."Exercise" VALUES (51, 'Is the following statement true or false? ''The English word for ''chien'' is ''Cat''''.', 'false', '{}', 'TRUE_FALSE', 103);
INSERT INTO public."Exercise" VALUES (52, 'How do you say ''Cheval'' in English?', 'horse', '["Horse", "Duck", "Cow", "Elephant"]', 'MULTIPLE_CHOICE', 103);
INSERT INTO public."Exercise" VALUES (53, 'Traduisez : ''J’ai un poisson rouge.''', 'i have a goldfish', '{}', 'TRANSLATION', 103);
INSERT INTO public."Exercise" VALUES (54, 'Is the following statement true or false? ''In English, ‘Tiger’ is a type of bird.''', 'false', '{}', 'TRUE_FALSE', 103);
INSERT INTO public."Exercise" VALUES (55, 'How do you say ''Pain'' in English?', 'bread', '["Bread", "Cheese", "Fruit", "Meat"]', 'MULTIPLE_CHOICE', 104);
INSERT INTO public."Exercise" VALUES (56, 'Traduisez : ''Je voudrais un café.''', 'i would like a coffee', '{}', 'TRANSLATION', 104);
INSERT INTO public."Exercise" VALUES (57, 'Is the following statement true or false? ''In English, ''water'' means ''eau''.''', 'true', '{}', 'TRUE_FALSE', 104);
INSERT INTO public."Exercise" VALUES (58, 'How do you say ''Jus d’orange'' in English?', 'orange juice', '["Orange juice", "Apple juice", "Lemonade", "Milk"]', 'MULTIPLE_CHOICE', 104);
INSERT INTO public."Exercise" VALUES (59, 'Traduisez : ''Je mange une pomme.''', 'i am eating an apple', '{}', 'TRANSLATION', 104);
INSERT INTO public."Exercise" VALUES (60, 'Is the following statement true or false? ''In English, ‘wine’ means ‘vin’.''', 'true', '{}', 'TRUE_FALSE', 104);
INSERT INTO public."Exercise" VALUES (61, 'How do you say ''École'' in English?', 'school', '["School", "Hospital", "Shop", "Restaurant"]', 'MULTIPLE_CHOICE', 105);
INSERT INTO public."Exercise" VALUES (62, 'Traduisez : ''Où est la gare ?''', 'where is the train station', '{}', 'TRANSLATION', 105);
INSERT INTO public."Exercise" VALUES (63, 'Is the following statement true or false? ''In English, ‘library’ means ‘bibliothèque’.''', 'true', '{}', 'TRUE_FALSE', 105);
INSERT INTO public."Exercise" VALUES (324, 'green', 'green', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (64, 'How do you say ''Boulangerie'' in English?', 'bakery', '["Bakery", "Supermarket", "Pharmacy", "Cafe"]', 'MULTIPLE_CHOICE', 105);
INSERT INTO public."Exercise" VALUES (65, 'Traduisez : ''Je cherche la poste.''', 'i am looking for the post office', '{}', 'TRANSLATION', 105);
INSERT INTO public."Exercise" VALUES (66, 'Is the following statement true or false? ''In English, ‘museum’ means ‘musée’.''', 'true', '{}', 'TRUE_FALSE', 105);
INSERT INTO public."Exercise" VALUES (67, 'How do you say ''Se réveiller'' in English?', 'wake up', '["Wake up", "Go to sleep", "Take a shower", "Eat breakfast"]', 'MULTIPLE_CHOICE', 106);
INSERT INTO public."Exercise" VALUES (68, 'Traduisez : ''Je vais au travail à 8h.''', 'i go to work at 8 o’clock', '{}', 'TRANSLATION', 106);
INSERT INTO public."Exercise" VALUES (69, 'Is the following statement true or false? ''In English, ‘take a shower’ means ‘prendre une douche’.''', 'true', '{}', 'TRUE_FALSE', 106);
INSERT INTO public."Exercise" VALUES (70, 'How do you say ''Dîner'' in English?', 'dinner', '["Lunch", "Dinner", "Snack", "Breakfast"]', 'MULTIPLE_CHOICE', 106);
INSERT INTO public."Exercise" VALUES (71, 'Traduisez : ''Je fais du sport après le travail.''', 'i exercise after work', '{}', 'TRANSLATION', 106);
INSERT INTO public."Exercise" VALUES (72, 'Is the following statement true or false? ''In English, ‘I get up’ means ‘je m’habille’.''', 'false', '{}', 'TRUE_FALSE', 106);
INSERT INTO public."Exercise" VALUES (73, 'How do you say ''Combien ça coûte ?'' in English?', 'how much is it', '["How much is it?", "What is the price?", "How much are they?", "Where is the shop?"]', 'MULTIPLE_CHOICE', 107);
INSERT INTO public."Exercise" VALUES (74, 'Traduisez : ''Je voudrais acheter ce t-shirt.''', 'i would like to buy this t-shirt', '{}', 'TRANSLATION', 107);
INSERT INTO public."Exercise" VALUES (75, 'Is the following statement true or false? ''In English, ‘expensive’ means ‘bon marché’.''', 'false', '{}', 'TRUE_FALSE', 107);
INSERT INTO public."Exercise" VALUES (76, 'How do you say ''C''est trop cher'' in English?', 'it’s too expensive', '["It’s too expensive", "It’s too cheap", "It’s not expensive", "It’s very cheap"]', 'MULTIPLE_CHOICE', 107);
INSERT INTO public."Exercise" VALUES (77, 'Traduisez : ''Est-ce que vous avez des réductions ?''', 'do you have any discounts', '{}', 'TRANSLATION', 107);
INSERT INTO public."Exercise" VALUES (78, 'Is the following statement true or false? ''In English, ‘bargain’ means ‘affaire’.''', 'true', '{}', 'TRUE_FALSE', 107);
INSERT INTO public."Exercise" VALUES (79, 'How do you say ''Où est l’aéroport ?'' in English?', 'where is the airport', '["Where is the airport?", "Where is the hotel?", "Where is the train station?", "How much is the flight?"]', 'MULTIPLE_CHOICE', 108);
INSERT INTO public."Exercise" VALUES (80, 'Traduisez : ''Je voudrais une chambre pour deux nuits.''', 'i would like a room for two nights', '{}', 'TRANSLATION', 108);
INSERT INTO public."Exercise" VALUES (81, 'Is the following statement true or false? ''In English, ‘taxi’ means ‘avion’.''', 'false', '{}', 'TRUE_FALSE', 108);
INSERT INTO public."Exercise" VALUES (82, 'How do you say ''Billet de train'' in English?', 'train ticket', '["Train ticket", "Flight ticket", "Bus ticket", "Hotel reservation"]', 'MULTIPLE_CHOICE', 108);
INSERT INTO public."Exercise" VALUES (83, 'Traduisez : ''Comment puis-je me rendre à la gare ?''', 'how can i get to the train station', '{}', 'TRANSLATION', 108);
INSERT INTO public."Exercise" VALUES (84, 'Is the following statement true or false? ''In English, ‘boarding pass’ means ‘carte d''embarquement’.''', 'true', '{}', 'TRUE_FALSE', 108);
INSERT INTO public."Exercise" VALUES (85, 'How do you say ''Jouer au foot'' in English?', 'play soccer', '["Play soccer", "Play tennis", "Do yoga", "Go swimming"]', 'MULTIPLE_CHOICE', 109);
INSERT INTO public."Exercise" VALUES (86, 'Traduisez : ''J''aime lire des livres.''', 'i like to read books', '{}', 'TRANSLATION', 109);
INSERT INTO public."Exercise" VALUES (87, 'Is the following statement true or false? ''In English, ‘watch a movie’ means ‘regarder un film’.''', 'true', '{}', 'TRUE_FALSE', 109);
INSERT INTO public."Exercise" VALUES (88, 'How do you say ''Faire du shopping'' in English?', 'go shopping', '["Go shopping", "Do gardening", "Go hiking", "Play chess"]', 'MULTIPLE_CHOICE', 109);
INSERT INTO public."Exercise" VALUES (89, 'Traduisez : ''Je fais de la randonnée le week-end.''', 'i go hiking on the weekend', '{}', 'TRANSLATION', 109);
INSERT INTO public."Exercise" VALUES (90, 'Is the following statement true or false? ''In English, ‘cook dinner’ means ‘préparer le dîner’.''', 'true', '{}', 'TRUE_FALSE', 109);
INSERT INTO public."Exercise" VALUES (91, 'How do you say ''Il pleut'' in English?', 'it is raining', '["It is raining", "It is snowing", "It is sunny", "It is windy"]', 'MULTIPLE_CHOICE', 110);
INSERT INTO public."Exercise" VALUES (92, 'Traduisez : ''En été, il fait chaud.''', 'in summer it is hot', '{}', 'TRANSLATION', 110);
INSERT INTO public."Exercise" VALUES (93, 'Is the following statement true or false? ''In English, ‘snow’ means ‘neige’.''', 'true', '{}', 'TRUE_FALSE', 110);
INSERT INTO public."Exercise" VALUES (94, 'How do you say ''Le temps est nuageux'' in English?', 'the weather is cloudy', '["The weather is cloudy", "The weather is rainy", "The weather is sunny", "The weather is windy"]', 'MULTIPLE_CHOICE', 110);
INSERT INTO public."Exercise" VALUES (95, 'Traduisez : ''Au printemps, les fleurs commencent à pousser.''', 'in spring the flowers start to grow', '{}', 'TRANSLATION', 110);
INSERT INTO public."Exercise" VALUES (96, 'Is the following statement true or false? ''In English, ‘autumn’ means ‘été’.''', 'false', '{}', 'TRUE_FALSE', 110);
INSERT INTO public."Exercise" VALUES (97, 'How do you say ''Elle porte une robe rouge'' in English?', 'she is wearing a red dress', '["She is wearing a red dress", "She wears a red dress", "She is in a red dress", "She has a red dress"]', 'MULTIPLE_CHOICE', 111);
INSERT INTO public."Exercise" VALUES (98, 'Traduisez : ''Il a les cheveux courts et bruns.''', 'he has short brown hair', '{}', 'TRANSLATION', 111);
INSERT INTO public."Exercise" VALUES (99, 'Is the following statement true or false? ''In English, ‘tall’ means ‘grand’.''', 'true', '{}', 'TRUE_FALSE', 111);
INSERT INTO public."Exercise" VALUES (100, 'How do you say ''Il porte un jean bleu'' in English?', 'he is wearing blue jeans', '["He is wearing blue jeans", "He wears blue jeans", "He has blue jeans on", "He is in blue jeans"]', 'MULTIPLE_CHOICE', 111);
INSERT INTO public."Exercise" VALUES (101, 'Traduisez : ''Elle est grande et a les yeux verts.''', 'she is tall and has green eyes', '{}', 'TRANSLATION', 111);
INSERT INTO public."Exercise" VALUES (102, 'Is the following statement true or false? ''In English, ‘short’ means ‘court’.''', 'true', '{}', 'TRUE_FALSE', 111);
INSERT INTO public."Exercise" VALUES (103, 'How do you say ''Je me sens triste'' in English?', 'i feel sad', '["I feel sad", "I am happy", "I feel angry", "I am tired"]', 'MULTIPLE_CHOICE', 112);
INSERT INTO public."Exercise" VALUES (104, 'Traduisez : ''Elle est très excitée pour le voyage.''', 'she is very excited for the trip', '{}', 'TRANSLATION', 112);
INSERT INTO public."Exercise" VALUES (105, 'Is the following statement true or false? ''In English, ‘nervous’ means ‘calme’.''', 'false', '{}', 'TRUE_FALSE', 112);
INSERT INTO public."Exercise" VALUES (106, 'How do you say ''Je suis fatigué'' in English?', 'i am tired', '["I am tired", "I feel happy", "I am sad", "I feel nervous"]', 'MULTIPLE_CHOICE', 112);
INSERT INTO public."Exercise" VALUES (107, 'Traduisez : ''Il a peur des araignées.''', 'he is afraid of spiders', '{}', 'TRANSLATION', 112);
INSERT INTO public."Exercise" VALUES (108, 'Is the following statement true or false? ''In English, ‘joyful’ means ‘joyeux’.''', 'true', '{}', 'TRUE_FALSE', 112);
INSERT INTO public."Exercise" VALUES (109, 'How do you say ''Je voudrais une table pour deux, s''il vous plaît.'' in English?', 'i would like a table for two please', '["I would like a table for two, please.", "I would like a menu, please.", "Can I have the bill, please?", "I want a table for two."]', 'MULTIPLE_CHOICE', 113);
INSERT INTO public."Exercise" VALUES (110, 'Traduisez : ''Pouvez-vous me donner l''addition, s''il vous plaît ?''', 'can you give me the bill please', '{}', 'TRANSLATION', 113);
INSERT INTO public."Exercise" VALUES (111, 'Is the following statement true or false? ''In English, ‘menu’ means ‘carte’.''', 'true', '{}', 'TRUE_FALSE', 113);
INSERT INTO public."Exercise" VALUES (112, 'How do you say ''Je voudrais de l''eau, s''il vous plaît.'' in English?', 'i would like some water please', '["I would like some water, please.", "I want some water.", "Can I have some water, please?", "I would like a drink, please."]', 'MULTIPLE_CHOICE', 113);
INSERT INTO public."Exercise" VALUES (113, 'Traduisez : ''Est-ce que vous avez des desserts ?''', 'do you have any desserts', '{}', 'TRANSLATION', 113);
INSERT INTO public."Exercise" VALUES (114, 'Is the following statement true or false? ''In English, ‘waiter’ means ‘serveur’.''', 'true', '{}', 'TRUE_FALSE', 113);
INSERT INTO public."Exercise" VALUES (115, 'How do you say ''Où est la gare ?'' in English?', 'where is the train station', '["Where is the train station?", "Where is the bus stop?", "Where is the airport?", "Where is the subway?"]', 'MULTIPLE_CHOICE', 114);
INSERT INTO public."Exercise" VALUES (116, 'Traduisez : ''Je voudrais un ticket pour Paris.''', 'i would like a ticket to paris', '{}', 'TRANSLATION', 114);
INSERT INTO public."Exercise" VALUES (117, 'Is the following statement true or false? ''In English, ‘subway’ means ‘métro’.''', 'true', '{}', 'TRUE_FALSE', 114);
INSERT INTO public."Exercise" VALUES (118, 'How do you say ''Prendre le bus'' in English?', 'take the bus', '["Take the bus", "Take the train", "Take the taxi", "Take the metro"]', 'MULTIPLE_CHOICE', 114);
INSERT INTO public."Exercise" VALUES (119, 'Traduisez : ''Comment puis-je me rendre à la station de métro ?''', 'how can i get to the subway station', '{}', 'TRANSLATION', 114);
INSERT INTO public."Exercise" VALUES (120, 'Is the following statement true or false? ''In English, ‘taxi’ means ‘voiture’.''', 'false', '{}', 'TRUE_FALSE', 114);
INSERT INTO public."Exercise" VALUES (121, 'How do you say ''J''ai mangé une pizza hier soir.'' in English?', 'i ate a pizza last night', '["I ate a pizza last night.", "I eat a pizza last night.", "I have eaten a pizza last night.", "I will eat a pizza last night."]', 'MULTIPLE_CHOICE', 115);
INSERT INTO public."Exercise" VALUES (122, 'Traduisez : ''Il a visité le musée la semaine dernière.''', 'he visited the museum last week', '{}', 'TRANSLATION', 115);
INSERT INTO public."Exercise" VALUES (123, 'Is the following statement true or false? ''In English, ‘watched’ is the past simple form of ‘watch’.''', 'true', '{}', 'TRUE_FALSE', 115);
INSERT INTO public."Exercise" VALUES (124, 'How do you say ''Nous avons joué au football hier.'' in English?', 'we played football yesterday', '["We played football yesterday.", "We play football yesterday.", "We have played football yesterday.", "We will play football yesterday."]', 'MULTIPLE_CHOICE', 115);
INSERT INTO public."Exercise" VALUES (125, 'Traduisez : ''Elle a étudié toute la journée.''', 'she studied all day', '{}', 'TRANSLATION', 115);
INSERT INTO public."Exercise" VALUES (126, 'Is the following statement true or false? ''In English, ‘went’ is the past simple form of ‘go’.''', 'true', '{}', 'TRUE_FALSE', 115);
INSERT INTO public."Exercise" VALUES (127, 'How do you say ''L''année dernière, je suis allé en Espagne pendant les vacances.'' in English?', 'last year i went to spain during the holidays', '["Last year, I went to Spain during the holidays.", "Last year, I go to Spain during the holidays.", "I went to Spain last year during the holidays.", "I am going to Spain last year during the holidays."]', 'MULTIPLE_CHOICE', 116);
INSERT INTO public."Exercise" VALUES (128, 'Traduisez : ''Nous avons passé une excellente journée à la plage.''', 'we had a great day at the beach', '{}', 'TRANSLATION', 116);
INSERT INTO public."Exercise" VALUES (129, 'Is the following statement true or false? ''In English, ‘visited’ is the past simple form of ‘visit’.''', 'true', '{}', 'TRUE_FALSE', 116);
INSERT INTO public."Exercise" VALUES (130, 'How do you say ''Je me souviens du moment où j''ai appris à faire du ski.'' in English?', 'i remember the moment when i learned how to ski', '["I remember the moment when I learned how to ski.", "I remember the moment I learned how to ski.", "I remembered the moment when I learned how to ski.", "I am remembering the moment when I learned how to ski."]', 'MULTIPLE_CHOICE', 116);
INSERT INTO public."Exercise" VALUES (131, 'Traduisez : ''Il a raconté son expérience de voyage en détail.''', 'he told his travel experience in detail', '{}', 'TRANSLATION', 116);
INSERT INTO public."Exercise" VALUES (132, 'Is the following statement true or false? ''In English, ‘did’ is the past simple form of ‘do’.''', 'true', '{}', 'TRUE_FALSE', 116);
INSERT INTO public."Exercise" VALUES (133, 'How do you say ''Je pense que les films sont importants dans notre culture.'' in English?', 'i think movies are important in our culture', '["I think movies are important in our culture.", "I think the movies are important in our culture.", "I think film is important in our culture.", "I think movies are important of our culture."]', 'MULTIPLE_CHOICE', 117);
INSERT INTO public."Exercise" VALUES (134, 'Traduisez : ''À mon avis, c''est une mauvaise idée.''', 'in my opinion its a bad idea', '{}', 'TRANSLATION', 117);
INSERT INTO public."Exercise" VALUES (135, 'Is the following statement true or false? ''In English, ‘I believe’ and ‘I think’ can be used to express an opinion.''', 'true', '{}', 'TRUE_FALSE', 117);
INSERT INTO public."Exercise" VALUES (136, 'How do you say ''Je suis d''accord avec toi sur ce point.'' in English?', 'i agree with you on this point', '["I agree with you on this point.", "I am agree with you on this point.", "I agree with you on this topic.", "I agree on you with this point."]', 'MULTIPLE_CHOICE', 117);
INSERT INTO public."Exercise" VALUES (137, 'Traduisez : ''Je ne suis pas d''accord avec cette décision.''', 'i disagree with this decision', '{}', 'TRANSLATION', 117);
INSERT INTO public."Exercise" VALUES (138, 'Is the following statement true or false? ''In English, ‘opinion’ means ‘idée’ in French.''', 'true', '{}', 'TRUE_FALSE', 117);
INSERT INTO public."Exercise" VALUES (139, 'How do you say ''Je vous écris pour demander des informations sur votre programme.'' in English?', 'i am writing to ask for information about your program', '["I write you to ask for information about your program.", "I am writing to ask for information about your program.", "I write to ask you for information about your program.", "I write you asking for information about your program."]', 'MULTIPLE_CHOICE', 118);
INSERT INTO public."Exercise" VALUES (140, 'Traduisez : ''Je vous prie d''agréer, Madame, l''expression de mes salutations distinguées.''', 'yours sincerely madam', '{}', 'TRANSLATION', 118);
INSERT INTO public."Exercise" VALUES (141, 'Is the following statement true or false? ''In English, “Dear Sir” is used at the beginning of a formal email.''', 'true', '{}', 'TRUE_FALSE', 118);
INSERT INTO public."Exercise" VALUES (142, 'How do you say ''Je vous remercie de votre réponse.'' in English?', 'thank you for your answer', '["Thank you for your answer.", "I thank you for your answer.", "I thank you for your response.", "Thanks for your answer."]', 'MULTIPLE_CHOICE', 118);
INSERT INTO public."Exercise" VALUES (143, 'Traduisez : ''Je suis à votre disposition pour toute information complémentaire.''', 'i am available for any further information', '{}', 'TRANSLATION', 118);
INSERT INTO public."Exercise" VALUES (144, 'Is the following statement true or false? ''In a formal email, you should avoid using contractions like ''I''m'' or ''can''t.''', 'true', '{}', 'TRUE_FALSE', 118);
INSERT INTO public."Exercise" VALUES (145, 'How do you say ''C''est la goutte d''eau qui fait déborder le vase.'' in English?', 'its the straw that broke the camels back', '["It''s the straw that broke the camel''s back.", "It''s the last drop.", "It''s the last straw that broke the camel''s back.", "It''s the last drop that broke the cup."]', 'MULTIPLE_CHOICE', 119);
INSERT INTO public."Exercise" VALUES (146, 'Traduisez : ''Il pleut des cordes.''', 'its raining cats and dogs', '{}', 'TRANSLATION', 119);
INSERT INTO public."Exercise" VALUES (147, 'Is the following statement true or false? ''In English, ''break the ice'' means to make people feel more comfortable in a social situation.''', 'true', '{}', 'TRUE_FALSE', 119);
INSERT INTO public."Exercise" VALUES (148, 'How do you say ''C''est du gâteau.'' in English?', 'its a piece of cake', '["It''s a piece of cake.", "It''s a cake.", "It''s easy as pie.", "It''s a piece of pie."]', 'MULTIPLE_CHOICE', 119);
INSERT INTO public."Exercise" VALUES (149, 'Traduisez : ''Quand les poules auront des dents.''', 'when pigs fly', '{}', 'TRANSLATION', 119);
INSERT INTO public."Exercise" VALUES (150, 'Is the following statement true or false? ''In English, ‘to kill two birds with one stone’ means to achieve two things at the same time.''', 'true', '{}', 'TRUE_FALSE', 119);
INSERT INTO public."Exercise" VALUES (151, 'How do you say ''Les Anglais prennent souvent le thé l''après-midi.'' in English?', 'the english often have tea in the afternoon', '["The English often have tea in the afternoon.", "The English often take tea in the afternoon.", "English people often drink tea in the afternoon.", "English people often have tea in the afternoon."]', 'MULTIPLE_CHOICE', 120);
INSERT INTO public."Exercise" VALUES (152, 'Traduisez : ''Aux États-Unis, les repas sont souvent plus copieux qu''en Europe.''', 'in the united states meals are often bigger than in europe', '{}', 'TRANSLATION', 120);
INSERT INTO public."Exercise" VALUES (153, 'Is the following statement true or false? ''In many English-speaking countries, tipping in restaurants is customary.''', 'true', '{}', 'TRUE_FALSE', 120);
INSERT INTO public."Exercise" VALUES (186, 'Is the following statement true or false? ''In a formal debate, it is important to remain respectful and avoid personal attacks.''', 'true', '{}', 'TRUE_FALSE', 125);
INSERT INTO public."Exercise" VALUES (325, 'yellow', 'yellow', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (326, 'black', 'black', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (154, 'How do you say ''Les Canadiens célèbrent le Jour de la Confédération le 1er juillet.'' in English?', 'canadians celebrate confederation day on july 1st', '["Canadians celebrate Confederation Day on July 1st.", "Canadians celebrate the Day of Confederation on July 1st.", "Canadians celebrate the Day of Confederation on July 1.", "Canadians celebrate the Confederation Day on July 1st."]', 'MULTIPLE_CHOICE', 120);
INSERT INTO public."Exercise" VALUES (155, 'Traduisez : ''En Australie, le Noël se célèbre pendant l''été.''', 'in australia christmas is celebrated during the summer', '{}', 'TRANSLATION', 120);
INSERT INTO public."Exercise" VALUES (156, 'Is the following statement true or false? ''In many English-speaking countries, Halloween is celebrated on October 31st.''', 'true', '{}', 'TRUE_FALSE', 120);
INSERT INTO public."Exercise" VALUES (157, 'How do you say ''Je suis ingénieur et je travaille dans une entreprise de technologie.'' in English?', 'i am an engineer and i work in a technology company', '["I am an engineer and I work in a technology company.", "I am an engineer and I work in a company of technology.", "I am engineer and I work in a technology company.", "I am an engineer and I work at a technology company."]', 'MULTIPLE_CHOICE', 121);
INSERT INTO public."Exercise" VALUES (158, 'Traduisez : ''Elle est médecin et travaille dans un hôpital.''', 'she is a doctor and works in a hospital', '{}', 'TRANSLATION', 121);
INSERT INTO public."Exercise" VALUES (159, 'Is the following statement true or false? ''In many English-speaking countries, people say ‘job’ when referring to an occupation or profession.''', 'true', '{}', 'TRUE_FALSE', 121);
INSERT INTO public."Exercise" VALUES (160, 'How do you say ''Il cherche un emploi dans la finance.'' in English?', 'he is looking for a job in finance', '["He is looking for a job in finance.", "He is looking for a job in the finance.", "He is searching a job in finance.", "He is looking for a work in finance."]', 'MULTIPLE_CHOICE', 121);
INSERT INTO public."Exercise" VALUES (161, 'Traduisez : ''Je travaille à temps plein dans une banque.''', 'i work full-time in a bank', '{}', 'TRANSLATION', 121);
INSERT INTO public."Exercise" VALUES (162, 'Is the following statement true or false? ''In the UK, people often say ‘CV’ to refer to a résumé.''', 'true', '{}', 'TRUE_FALSE', 121);
INSERT INTO public."Exercise" VALUES (163, 'How do you say ''Les informations sont diffusées à la télévision chaque soir.'' in English?', 'the news is broadcasted on tv every evening', '["The news are broadcasted on TV every evening.", "The news is broadcasted on TV every evening.", "The news is aired on TV every evening.", "The news is shown on TV every evening."]', 'MULTIPLE_CHOICE', 122);
INSERT INTO public."Exercise" VALUES (164, 'Traduisez : ''J''écoute souvent la radio pour connaître les dernières nouvelles.''', 'i often listen to the radio to hear the latest news', '{}', 'TRANSLATION', 122);
INSERT INTO public."Exercise" VALUES (165, 'Is the following statement true or false? ''In English, “headline” refers to the most important story in the news.''', 'true', '{}', 'TRUE_FALSE', 122);
INSERT INTO public."Exercise" VALUES (166, 'How do you say ''Le journaliste a interviewé le président.'' in English?', 'the journalist interviewed the president', '["The journalist interviewed the president.", "The journalist has interviewed the president.", "The journalist is interviewing the president.", "The journalist interviewed the president at last."]', 'MULTIPLE_CHOICE', 122);
INSERT INTO public."Exercise" VALUES (167, 'Traduisez : ''Les réseaux sociaux sont devenus très influents dans le monde moderne.''', 'social media has become very influential in the modern world', '{}', 'TRANSLATION', 122);
INSERT INTO public."Exercise" VALUES (168, 'Is the following statement true or false? ''A ‘reporter’ is someone who writes and reports the news.''', 'true', '{}', 'TRUE_FALSE', 122);
INSERT INTO public."Exercise" VALUES (169, 'How do you say ''Allô, ici John. Je vous appelle concernant notre rendez-vous.'' in English?', 'hello this is john im calling about our meeting', '["Hello, this is John. I''m calling about our meeting.", "Hello, John here. I am calling regarding our meeting.", "Hi, this is John. I''m calling about our meeting.", "Hello, this is John. I call about our meeting."]', 'MULTIPLE_CHOICE', 123);
INSERT INTO public."Exercise" VALUES (170, 'Traduisez : ''Puis-je parler à M. Smith, s''il vous plaît ?''', 'can i speak to mr smith please', '{}', 'TRANSLATION', 123);
INSERT INTO public."Exercise" VALUES (171, 'Is the following statement true or false? ''In English, when leaving a voicemail, it’s common to leave your name and phone number.''', 'true', '{}', 'TRUE_FALSE', 123);
INSERT INTO public."Exercise" VALUES (172, 'How do you say ''Je vous appelle pour confirmer notre réunion de demain.'' in English?', 'im calling to confirm our meeting tomorrow', '["I''m calling to confirm our meeting tomorrow.", "I call to confirm our meeting tomorrow.", "I''m calling for confirm our meeting tomorrow.", "I am calling to confirm our meeting tomorrow."]', 'MULTIPLE_CHOICE', 123);
INSERT INTO public."Exercise" VALUES (173, 'Traduisez : ''Je suis désolé, il est en réunion en ce moment.''', 'im sorry he is in a meeting right now', '{}', 'TRANSLATION', 123);
INSERT INTO public."Exercise" VALUES (174, 'Is the following statement true or false? ''When answering the phone, people in English-speaking countries usually start with a greeting followed by their name.''', 'true', '{}', 'TRUE_FALSE', 123);
INSERT INTO public."Exercise" VALUES (175, 'How do you say ''J''ai voyagé à Paris l''année dernière et c''était incroyable.'' in English?', 'i traveled to paris last year and it was amazing', '["I traveled to Paris last year and it was amazing.", "I have traveled to Paris last year and it was amazing.", "I have traveled to Paris last year and it was incredible.", "I traveled to Paris last year and it was incredible."]', 'MULTIPLE_CHOICE', 124);
INSERT INTO public."Exercise" VALUES (176, 'Traduisez : ''Je voudrais visiter l''Australie un jour.''', 'i would like to visit australia one day', '{}', 'TRANSLATION', 124);
INSERT INTO public."Exercise" VALUES (177, 'Is the following statement true or false? ''In English, the word ‘adventure’ refers to an exciting or unusual experience, often involving travel.''', 'true', '{}', 'TRUE_FALSE', 124);
INSERT INTO public."Exercise" VALUES (178, 'How do you say ''Nous avons fait un voyage en train à travers l''Europe.'' in English?', 'we took a train trip across europe', '["We took a train trip across Europe.", "We made a train journey across Europe.", "We did a train trip across Europe.", "We made a train trip across Europe."]', 'MULTIPLE_CHOICE', 124);
INSERT INTO public."Exercise" VALUES (179, 'Traduisez : ''Mon rêve est de faire un safari en Afrique.''', 'my dream is to go on a safari in africa', '{}', 'TRANSLATION', 124);
INSERT INTO public."Exercise" VALUES (180, 'Is the following statement true or false? ''When talking about a trip, the word ‘journey’ refers to the entire travel experience.''', 'true', '{}', 'TRUE_FALSE', 124);
INSERT INTO public."Exercise" VALUES (181, 'How do you say ''Je pense que l''éducation est la clé du succès.'' in English?', 'i think education is the key to success', '["I think education is the key to success.", "I believe education is the key of success.", "I think the education is the key to success.", "I think the education is the key of success."]', 'MULTIPLE_CHOICE', 125);
INSERT INTO public."Exercise" VALUES (182, 'Traduisez : ''Je ne suis pas d''accord avec cette opinion.''', 'i disagree with this opinion', '{}', 'TRANSLATION', 125);
INSERT INTO public."Exercise" VALUES (183, 'Is the following statement true or false? ''In a debate, a counterargument is used to challenge the opposing side’s point of view.''', 'true', '{}', 'TRUE_FALSE', 125);
INSERT INTO public."Exercise" VALUES (184, 'How do you say ''Pourtant, il y a des preuves qui montrent que l''éducation n''est pas toujours la clé du succès.'' in English?', 'however there is evidence showing that education is not always the key to success', '["However, there are evidence showing that education is not always the key to success.", "However, there is evidence showing that education is not always the key to success.", "However, there is proof that shows education is not always the key to success.", "However, there are proofs showing that education is not always the key to success."]', 'MULTIPLE_CHOICE', 125);
INSERT INTO public."Exercise" VALUES (185, 'Traduisez : ''Je comprends ton point de vue, mais je pense qu''il y a des exceptions.''', 'i understand your point of view but i think there are exceptions', '{}', 'TRANSLATION', 125);
INSERT INTO public."Exercise" VALUES (316, 'Thank you.', 'thank you', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (317, 'You’re welcome.', 'you’re welcome', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (187, 'How do you say ''Je suis responsable de la gestion des projets au sein de l''équipe.'' in English?', 'i am responsible for managing projects within the team', '["I am in charge of managing projects within the team.", "I am responsible for managing projects within the team.", "I manage projects within the team.", "I am responsible to manage projects within the team."]', 'MULTIPLE_CHOICE', 126);
INSERT INTO public."Exercise" VALUES (188, 'Traduisez : ''J''ai besoin de plus d''informations avant de prendre une décision.''', 'i need more information before making a decision', '{}', 'TRANSLATION', 126);
INSERT INTO public."Exercise" VALUES (189, 'Is the following statement true or false? ''In business English, ''ASAP'' stands for ''as soon as possible'' and is commonly used to request urgent action.''', 'true', '{}', 'TRUE_FALSE', 126);
INSERT INTO public."Exercise" VALUES (190, 'How do you say ''Nous avons prévu une réunion pour discuter des objectifs du projet.'' in English?', 'we have scheduled a meeting to discuss the project goals', '["We have scheduled a meeting to discuss the project goals.", "We have planned a meeting to discuss the project goals.", "We scheduled a meeting to discuss the project objectives.", "We have arranged a meeting to discuss the goals of the project."]', 'MULTIPLE_CHOICE', 126);
INSERT INTO public."Exercise" VALUES (191, 'Traduisez : ''Le rapport doit être envoyé avant la fin de la journée.''', 'the report must be sent by the end of the day', '{}', 'TRANSLATION', 126);
INSERT INTO public."Exercise" VALUES (192, 'Is the following statement true or false? ''In a professional email, it is common to start with a formal greeting and end with a polite closing phrase.''', 'true', '{}', 'TRUE_FALSE', 126);
INSERT INTO public."Exercise" VALUES (193, 'How do you say ''Il a expliqué clairement les enjeux du projet lors de la conférence.'' in English?', 'he clearly explained the issues of the project during the conference', '["He clearly explained the issues of the project during the conference.", "He explained clearly the issues of the project during the conference.", "He clearly explained the project issues at the conference.", "He explained the issues clearly of the project at the conference."]', 'MULTIPLE_CHOICE', 127);
INSERT INTO public."Exercise" VALUES (194, 'Traduisez : ''Il est important de bien structurer son discours pour captiver l''attention de l''audience.''', 'it is important to structure your speech well to capture the audiences attention', '{}', 'TRANSLATION', 127);
INSERT INTO public."Exercise" VALUES (195, 'Is the following statement true or false? ''When analyzing a speech, it is crucial to focus on the speaker’s tone and body language to fully understand the message.''', 'true', '{}', 'TRUE_FALSE', 127);
INSERT INTO public."Exercise" VALUES (196, 'How do you say ''Lors de la conférence, le conférencier a utilisé des exemples concrets pour illustrer ses propos.'' in English?', 'during the conference the speaker used concrete examples to illustrate his points', '["During the conference, the speaker used concrete examples to illustrate his points.", "At the conference, the speaker used concrete examples to illustrate his ideas.", "During the conference, the speaker used real-life examples to illustrate his points.", "At the conference, the speaker used real-life examples to illustrate his ideas."]', 'MULTIPLE_CHOICE', 127);
INSERT INTO public."Exercise" VALUES (197, 'Traduisez : ''Le discours était très inspirant et a motivé l''audience à agir.''', 'the speech was very inspiring and motivated the audience to take action', '{}', 'TRANSLATION', 127);
INSERT INTO public."Exercise" VALUES (198, 'Is the following statement true or false? ''In a professional speech, it’s common to include statistics and data to support your arguments.''', 'true', '{}', 'TRUE_FALSE', 127);
INSERT INTO public."Exercise" VALUES (199, 'How do you say ''Il est actuellement en train de travailler sur le projet.'' in English? (Attention à ne pas confondre ''actuellement'' et ''actually'')', 'he is currently working on the project', '["He is actually working on the project.", "He is currently working on the project.", "He is at present working on the project.", "He is presently working on the project."]', 'MULTIPLE_CHOICE', 128);
INSERT INTO public."Exercise" VALUES (200, 'Traduisez : ''La bibliothèque de l''université est ouverte tous les jours.'' (Attention à ''library'' et ''librairie'')', 'the university library is open every day', '{}', 'TRANSLATION', 128);
INSERT INTO public."Exercise" VALUES (201, 'Is the following statement true or false? ''In English, ''sympathy'' refers to feeling sorry for someone, while ''empathy'' refers to understanding their feelings.''', 'true', '{}', 'TRUE_FALSE', 128);
INSERT INTO public."Exercise" VALUES (202, 'How do you say ''Il a fait une proposition intéressante lors de la réunion.'' in English? (Attention à ne pas confondre ''proposition'' et ''proposal'')', 'he made an interesting proposal at the meeting', '["He made an interesting proposal at the meeting.", "He made an interesting proposition at the meeting.", "He made an interesting suggestion at the meeting.", "He made an interesting offer at the meeting."]', 'MULTIPLE_CHOICE', 128);
INSERT INTO public."Exercise" VALUES (203, 'Traduisez : ''Elle a une attitude positive.'' (Attention à ''attitude'' et ''aptitude'')', 'she has a positive attitude', '{}', 'TRANSLATION', 128);
INSERT INTO public."Exercise" VALUES (204, 'Is the following statement true or false? ''In English, the word ‘eventually’ means ''finalement'' in French, not ‘actuellement’.''', 'true', '{}', 'TRUE_FALSE', 128);
INSERT INTO public."Exercise" VALUES (205, 'How do you say ''Il est essentiel d''avoir une introduction claire dans un essai.'' in English?', 'it is essential to have a clear introduction in an essay', '["It is essential to have a clear introduction in an essay.", "It is essential having a clear introduction in an essay.", "A clear introduction is essential in an essay.", "It is essential of having a clear introduction in an essay."]', 'MULTIPLE_CHOICE', 129);
INSERT INTO public."Exercise" VALUES (206, 'Traduisez : ''Il faut toujours conclure son essai en récapitulant les points clés.''', 'you should always conclude your essay by summarizing the key points', '{}', 'TRANSLATION', 129);
INSERT INTO public."Exercise" VALUES (207, 'Is the following statement true or false? ''In an essay, it is important to provide clear arguments supported by evidence in each body paragraph.''', 'true', '{}', 'TRUE_FALSE', 129);
INSERT INTO public."Exercise" VALUES (208, 'How do you say ''Dans le corps de l’essai, chaque paragraphe doit développer un argument différent.'' in English?', 'in the body of the essay each paragraph must develop a different argument', '["In the body of the essay, each paragraph must develop a different argument.", "In the body of the essay, each paragraph should develop a different argument.", "In the body of the essay, every paragraph must develop a different argument.", "In the body of the essay, each paragraph has to develop a different argument."]', 'MULTIPLE_CHOICE', 129);
INSERT INTO public."Exercise" VALUES (209, 'Traduisez : ''Il est important d''introduire les contre-arguments pour renforcer votre position.''', 'it is important to introduce counterarguments to strengthen your position', '{}', 'TRANSLATION', 129);
INSERT INTO public."Exercise" VALUES (210, 'Is the following statement true or false? ''In an essay conclusion, you should introduce new ideas or arguments.''', 'false', '{}', 'TRUE_FALSE', 129);
INSERT INTO public."Exercise" VALUES (211, 'How do you say ''Il est important de résumer les points principaux d''un article de presse.'' in English?', 'it is important to summarize the main points of a newspaper article', '["It is important to summarize the main points of a newspaper article.", "It is important summarizing the main points of a newspaper article.", "It is important to summarize the main points in a newspaper article.", "It is important summarizing the main points in a newspaper article."]', 'MULTIPLE_CHOICE', 130);
INSERT INTO public."Exercise" VALUES (212, 'Traduisez : ''L''article aborde les causes de la crise économique actuelle.''', 'the article discusses the causes of the current economic crisis', '{}', 'TRANSLATION', 130);
INSERT INTO public."Exercise" VALUES (213, 'Is the following statement true or false? ''When analyzing a newspaper article, it is important to focus on the title, the introduction, and the conclusion to understand the main message.''', 'true', '{}', 'TRUE_FALSE', 130);
INSERT INTO public."Exercise" VALUES (318, 'Excuse me.', 'excuse me', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (214, 'How do you say ''L''auteur présente des arguments solides pour étayer ses propos.'' in English?', 'the author presents strong arguments to support his claims', '["The author presents strong arguments to support his claims.", "The author presents solid arguments to support his points.", "The author provides strong arguments to back up his views.", "The author presents solid arguments to back up his statements."]', 'MULTIPLE_CHOICE', 130);
INSERT INTO public."Exercise" VALUES (215, 'Traduisez : ''Il est crucial de comprendre le contexte pour bien interpréter l''article.''', 'it is crucial to understand the context in order to properly interpret the article', '{}', 'TRANSLATION', 130);
INSERT INTO public."Exercise" VALUES (216, 'Is the following statement true or false? ''When analyzing a complex article, it is useful to take notes and highlight key information to aid understanding.''', 'true', '{}', 'TRUE_FALSE', 130);
INSERT INTO public."Exercise" VALUES (217, 'How do you say ''Si j''avais su, j''aurais agi différemment.'' in English? (Attention aux structures conditionnelles !) ', 'if i had known i would have acted differently', '["If I had known, I would act differently.", "If I knew, I would have acted differently.", "If I had known, I would have acted differently.", "If I have known, I would have acted differently."]', 'MULTIPLE_CHOICE', 131);
INSERT INTO public."Exercise" VALUES (218, 'Traduisez : ''Elle se serait bien préparée si elle avait eu plus de temps.'' (Utilisation du conditionnel passé)', 'she would have prepared well if she had had more time', '{}', 'TRANSLATION', 131);
INSERT INTO public."Exercise" VALUES (219, 'Is the following statement true or false? ''The past perfect is used to talk about an action that happened before another action in the past.''', 'true', '{}', 'TRUE_FALSE', 131);
INSERT INTO public."Exercise" VALUES (220, 'How do you say ''Nous avions déjà mangé quand il est arrivé.'' in English? (Attention à l''utilisation du past perfect !) ', 'we had already eaten when he arrived', '["We already ate when he arrived.", "We had already eaten when he arrived.", "We were already eating when he arrived.", "We had already eat when he arrived."]', 'MULTIPLE_CHOICE', 131);
INSERT INTO public."Exercise" VALUES (221, 'Traduisez : ''Il aurait pu réussir s''il avait étudié davantage.'' (Attention à l''utilisation du conditionnel passé)', 'he could have succeeded if he had studied more', '{}', 'TRANSLATION', 131);
INSERT INTO public."Exercise" VALUES (222, 'Is the following statement true or false? ''In English, the future perfect tense is used to describe actions that will be completed before a specific point in the future.''', 'true', '{}', 'TRUE_FALSE', 131);
INSERT INTO public."Exercise" VALUES (223, 'How do you say ''C''est une blague typiquement anglaise, il faut connaître la culture pour la comprendre.'' in English?', 'it’s a typically english joke you need to know the culture to understand it', '["It’s a typically English joke, you need to know the culture to understand it.", "It’s a typical English joke, you need to know the culture to understand it.", "It’s a typically English joke, you must know the culture to understand it.", "It’s an English joke, you need to know the culture to understand it."]', 'MULTIPLE_CHOICE', 132);
INSERT INTO public."Exercise" VALUES (224, 'Traduisez : ''Il a dit qu''il ne pleuvait pas alors que le temps était complètement gris. C''était une blague sur le temps typiquement britannique.''', 'he said it wasn’t raining even though the weather was completely grey it was a typically british joke about the weather', '{}', 'TRANSLATION', 132);
INSERT INTO public."Exercise" VALUES (225, 'Is the following statement true or false? ''In British humor, wordplay often involves puns or double meanings, and is usually not meant to be taken seriously.''', 'true', '{}', 'TRUE_FALSE', 132);
INSERT INTO public."Exercise" VALUES (226, 'Which of these sentences is an example of a pun? ''Time flies like an arrow; fruit flies like a banana.''', 'it’s an example of a wordplay using flies and fruit', '["It’s a joke about time and fruit.", "It’s an example of a wordplay using ''flies'' and ''fruit''.", "It’s a metaphor for how time passes.", "It’s a sentence that makes no sense."]', 'MULTIPLE_CHOICE', 132);
INSERT INTO public."Exercise" VALUES (227, 'Traduisez : ''Les Anglais aiment faire des jeux de mots autour de la langue, souvent à des fins humoristiques.''', 'the british love to play with words often for humorous purposes', '{}', 'TRANSLATION', 132);
INSERT INTO public."Exercise" VALUES (228, 'Is the following statement true or false? ''A joke that involves irony can be understood the same way by everyone, regardless of their background.''', 'false', '{}', 'TRUE_FALSE', 132);
INSERT INTO public."Exercise" VALUES (229, 'How do you say ''L’auteur utilise des métaphores pour exprimer des émotions complexes dans ce passage.'' in English?', 'the author uses metaphors to express complex emotions in this passage', '["The author uses metaphors to express complex emotions in this passage.", "The author used metaphors to express complex emotions in this passage.", "The author is using metaphors to express complex emotions in this passage.", "The author was using metaphors to express complex emotions in this passage."]', 'MULTIPLE_CHOICE', 133);
INSERT INTO public."Exercise" VALUES (230, 'Traduisez : ''Ce passage illustre la lutte intérieure du personnage principal entre le désir et la responsabilité.''', 'this passage illustrates the main character’s inner struggle between desire and responsibility', '{}', 'TRANSLATION', 133);
INSERT INTO public."Exercise" VALUES (231, 'Is the following statement true or false? ''When analyzing a literary text, it''s essential to consider the historical context to fully understand the author’s intentions.''', 'true', '{}', 'TRUE_FALSE', 133);
INSERT INTO public."Exercise" VALUES (232, 'How do you interpret the following passage from Shakespeare’s Hamlet: ''To be, or not to be, that is the question''? What does it symbolize?', 'a moral dilemma about life and death', '["A moral dilemma about life and death.", "A simple rhetorical question.", "An expression of Shakespeare''s view on life.", "A trivial thought about existence."]', 'MULTIPLE_CHOICE', 133);
INSERT INTO public."Exercise" VALUES (233, 'Traduisez : ''L’ambiguïté du personnage reflète les contradictions de la société dans laquelle il évolue.''', 'the ambiguity of the character reflects the contradictions of the society in which he evolves', '{}', 'TRANSLATION', 133);
INSERT INTO public."Exercise" VALUES (234, 'Is the following statement true or false? ''In literary analysis, identifying themes and motifs helps in understanding the deeper meanings of a text.''', 'true', '{}', 'TRUE_FALSE', 133);
INSERT INTO public."Exercise" VALUES (235, 'How do you say ''L''argumentation dans cet essai repose sur une analyse détaillée des données.'' in English?', 'the argument in this essay relies on a detailed analysis of the data', '["The argument in this essay relies on a detailed analysis of the data.", "The argument in this essay is based on a detailed analysis of the data.", "The argumentation in this essay depends on a detailed analysis of the data.", "The argumentation in this essay is based on detailed data analysis."]', 'MULTIPLE_CHOICE', 134);
INSERT INTO public."Exercise" VALUES (236, 'Traduisez : ''La méthodologie utilisée dans cette recherche est rigoureuse et bien définie.''', 'the methodology used in this research is rigorous and well-defined', '{}', 'TRANSLATION', 134);
INSERT INTO public."Exercise" VALUES (237, 'Is the following statement true or false? ''In academic writing, it is important to use formal language and avoid contractions.''', 'true', '{}', 'TRUE_FALSE', 134);
INSERT INTO public."Exercise" VALUES (238, 'Which of the following sentences best exemplifies a formal tone used in academic writing?', 'the subject under discussion has significant implications for various groups', '["I think this topic is important because it impacts a lot of people.", "The subject under discussion has significant implications for various groups.", "This issue is really important for everyone.", "This problem needs to be dealt with immediately."]', 'MULTIPLE_CHOICE', 134);
INSERT INTO public."Exercise" VALUES (239, 'Traduisez : ''Les résultats de cette étude corroborent les hypothèses formulées au début de la recherche.''', 'the results of this study corroborate the hypotheses formulated at the beginning of the research', '{}', 'TRANSLATION', 134);
INSERT INTO public."Exercise" VALUES (322, 'red', 'red', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (240, 'Is the following statement true or false? ''In academic papers, citations and references are crucial for supporting your arguments and giving credit to original sources.''', 'true', '{}', 'TRUE_FALSE', 134);
INSERT INTO public."Exercise" VALUES (241, 'How do you say ''Il est essentiel de structurer un essai de manière logique et fluide.'' in English?', 'it is essential to structure an essay logically and fluently', '["It is essential to structure an essay logically and fluently.", "It is essential to structure an essay in a logical and fluid manner.", "It is essential to structure an essay in a logical and fluent way.", "It is essential to structure an essay logically and fluently."]', 'MULTIPLE_CHOICE', 135);
INSERT INTO public."Exercise" VALUES (242, 'Traduisez : ''L''introduction doit présenter clairement le sujet et la thèse de l''essai.''', 'the introduction should clearly present the topic and the thesis of the essay', '{}', 'TRANSLATION', 135);
INSERT INTO public."Exercise" VALUES (243, 'Is the following statement true or false? ''In advanced essay writing, it is important to support your arguments with relevant evidence and examples.''', 'true', '{}', 'TRUE_FALSE', 135);
INSERT INTO public."Exercise" VALUES (244, 'Which of the following sentences best shows a counterargument in an essay?', 'while some argue that economic growth leads to environmental degradation others believe that it is possible to achieve both simultaneously', '["While some argue that economic growth leads to environmental degradation, others believe that it is possible to achieve both simultaneously.", "Economic growth has undoubtedly caused harm to the environment, but there are ways to address these issues.", "The economic growth of a nation should be prioritized above all other concerns.", "Despite the challenges, many experts argue that it is essential to focus on sustainable development."]', 'MULTIPLE_CHOICE', 135);
INSERT INTO public."Exercise" VALUES (245, 'Traduisez : ''L''argumentation de cet essai repose sur une analyse critique des données et des perspectives opposées.''', 'the argument of this essay relies on a critical analysis of data and opposing perspectives', '{}', 'TRANSLATION', 135);
INSERT INTO public."Exercise" VALUES (246, 'Is the following statement true or false? ''In advanced academic writing, the conclusion should summarize the main points without introducing new arguments.''', 'true', '{}', 'TRUE_FALSE', 135);
INSERT INTO public."Exercise" VALUES (247, 'How do you say ''Un bon discours doit capter l''attention de l''audience dès le début.'' in English?', 'a good speech should capture the audiences attention from the start', '["A good speech should capture the audience''s attention from the start.", "A good speech must grab the audience''s attention from the beginning.", "A good speech should seize the audience’s attention from the beginning.", "A good speech must capture the attention of the audience from the start."]', 'MULTIPLE_CHOICE', 136);
INSERT INTO public."Exercise" VALUES (248, 'Traduisez : ''Il est crucial d''utiliser des exemples pertinents pour soutenir tes arguments lors d''une présentation.''', 'it is crucial to use relevant examples to support your arguments during a presentation', '{}', 'TRANSLATION', 136);
INSERT INTO public."Exercise" VALUES (249, 'Is the following statement true or false? ''In public speaking, the conclusion should summarize the main points and leave the audience with something to think about.''', 'true', '{}', 'TRUE_FALSE', 136);
INSERT INTO public."Exercise" VALUES (250, 'Which of the following strategies is most effective for engaging your audience during a presentation?', 'starting with a compelling story or an interesting fact', '["Reading from the slides throughout the entire presentation.", "Starting with a compelling story or an interesting fact.", "Avoiding any interaction with the audience.", "Speaking in a monotone voice to maintain professionalism."]', 'MULTIPLE_CHOICE', 136);
INSERT INTO public."Exercise" VALUES (251, 'Traduisez : ''Un bon orateur utilise un langage corporel adapté pour renforcer ses propos.''', 'a good speaker uses appropriate body language to reinforce their message', '{}', 'TRANSLATION', 136);
INSERT INTO public."Exercise" VALUES (252, 'Is the following statement true or false? ''In an effective presentation, it is important to maintain eye contact with the audience to establish connection and credibility.''', 'true', '{}', 'TRUE_FALSE', 136);
INSERT INTO public."Exercise" VALUES (253, 'How do you say ''Oh, great, another Monday!'' in a sarcastic tone in English?', 'oh great another monday', '["Oh, fantastic, another Monday!", "Oh, wonderful, another Monday!", "Oh, great, another Monday!", "Oh, perfect, another Monday!"]', 'MULTIPLE_CHOICE', 137);
INSERT INTO public."Exercise" VALUES (254, 'Traduisez : ''Bien sûr, j''adore attendre sous la pluie pendant des heures.''', 'of course i love waiting in the rain for hours', '{}', 'TRANSLATION', 137);
INSERT INTO public."Exercise" VALUES (255, 'Is the following statement sarcastic? ''Oh, I’m sure you’ll do a great job with that project, just like last time.''', 'true', '{}', 'TRUE_FALSE', 137);
INSERT INTO public."Exercise" VALUES (256, 'Which of the following sentences best expresses sarcasm?', 'i’m so excited for this meeting i’ve been waiting all day', '["I’m so excited for this meeting, I’ve been waiting all day!", "I can''t wait for this meeting, it''s going to be so much fun.", "This meeting is the best part of my day, obviously.", "I am thrilled for this meeting, it’s going to be amazing!"]', 'MULTIPLE_CHOICE', 137);
INSERT INTO public."Exercise" VALUES (257, 'Traduisez : ''Oh, bien sûr, c’est exactement ce dont j''avais besoin.''', 'oh of course that’s exactly what i needed', '{}', 'TRANSLATION', 137);
INSERT INTO public."Exercise" VALUES (258, 'Is the following statement sarcastic? ''Oh, you did such a wonderful job, I couldn''t have done it better myself.''', 'true', '{}', 'TRUE_FALSE', 137);
INSERT INTO public."Exercise" VALUES (259, 'How do you say ''L''entreprise a connu une croissance significative au cours des dernières années.'' in English?', 'the company has experienced significant growth over the last few years', '["The company has experienced significant growth over the last few years.", "The business has seen significant growth during the past years.", "The company has grown significantly over the last years.", "The firm experienced a significant increase over the last few years."]', 'MULTIPLE_CHOICE', 138);
INSERT INTO public."Exercise" VALUES (260, 'Traduisez : ''Les fluctuations du marché peuvent avoir un impact direct sur les décisions d''investissement.''', 'market fluctuations can have a direct impact on investment decisions', '{}', 'TRANSLATION', 138);
INSERT INTO public."Exercise" VALUES (261, 'Is the following statement true or false? ''In business, ROI stands for Return on Investment, which is used to measure the profitability of an investment.''', 'true', '{}', 'TRUE_FALSE', 138);
INSERT INTO public."Exercise" VALUES (262, 'Which of the following terms refers to the process of evaluating the financial health of a company?', 'financial auditing', '["Market analysis", "Financial auditing", "Business forecasting", "Risk management"]', 'MULTIPLE_CHOICE', 138);
INSERT INTO public."Exercise" VALUES (263, 'Traduisez : ''Les décisions stratégiques doivent être basées sur des données financières précises.''', 'strategic decisions must be based on accurate financial data', '{}', 'TRANSLATION', 138);
INSERT INTO public."Exercise" VALUES (264, 'Is the following statement true or false? ''In finance, a hedge fund is an investment fund that uses advanced strategies to generate returns for its investors.''', 'true', '{}', 'TRUE_FALSE', 138);
INSERT INTO public."Exercise" VALUES (265, 'How do you say ''L’interprète doit être capable de traduire rapidement et de manière fluide.'' in English?', 'the interpreter must be able to translate quickly and smoothly', '["The interpreter must be able to translate quickly and smoothly.", "The translator must be able to interpret quickly and fluently.", "The interpreter must translate swiftly and smoothly.", "The translator must be capable of interpreting quickly and smoothly."]', 'MULTIPLE_CHOICE', 139);
INSERT INTO public."Exercise" VALUES (266, 'Traduisez : ''La traduction littérale n''est pas toujours la meilleure solution.''', 'literal translation is not always the best solution', '{}', 'TRANSLATION', 139);
INSERT INTO public."Exercise" VALUES (267, 'Is the following statement true or false? ''In interpretation, it is crucial to convey the speaker''s tone and intention, not just the words.''', 'true', '{}', 'TRUE_FALSE', 139);
INSERT INTO public."Exercise" VALUES (323, 'blue', 'blue', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (268, 'Which of the following is an essential skill for a translator?', 'fluency in both the source and target languages', '["Fluency in both the source and target languages.", "The ability to speak several languages fluently.", "Knowledge of the technical jargon in all fields.", "Speed and accuracy in speaking."]', 'MULTIPLE_CHOICE', 139);
INSERT INTO public."Exercise" VALUES (269, 'Traduisez : ''L''interprétation simultanée nécessite une grande concentration et des compétences linguistiques avancées.''', 'simultaneous interpretation requires high concentration and advanced linguistic skills', '{}', 'TRANSLATION', 139);
INSERT INTO public."Exercise" VALUES (270, 'Is the following statement true or false? ''A translator should always try to maintain the same word order as the original text.''', 'false', '{}', 'TRUE_FALSE', 139);
INSERT INTO public."Exercise" VALUES (271, 'Which of the following sentences is in a formal register?', 'would you be so kind as to send me the report', '["Hey, can you send me that report?", "Would you be so kind as to send me the report?", "Could you please send me that report?", "Send me that report now!"]', 'MULTIPLE_CHOICE', 140);
INSERT INTO public."Exercise" VALUES (272, 'Traduisez : ''Ce n’est pas possible, tu vois bien qu’on a un problème ici.'' (registre familier)', 'this isn’t possible you can clearly see we have a problem here', '{}', 'TRANSLATION', 140);
INSERT INTO public."Exercise" VALUES (273, 'Is the following sentence in a formal or informal register? ''Could you provide me with further details about the matter at hand?''', 'formal', '{}', 'TRUE_FALSE', 140);
INSERT INTO public."Exercise" VALUES (274, 'Which of the following sentences is in a more informal register?', 'could you help me out with this please', '["I would appreciate it if you could help me with this matter.", "Could you help me out with this, please?", "Would you mind assisting me with this?", "I require your help with this matter."]', 'MULTIPLE_CHOICE', 140);
INSERT INTO public."Exercise" VALUES (275, 'Traduisez : ''Je suis ravi que vous soyez d''accord avec cette proposition.'' (registre soutenu)', 'i am delighted that you agree with this proposal', '{}', 'TRANSLATION', 140);
INSERT INTO public."Exercise" VALUES (276, 'Is the following sentence formal or informal? ''Can you send me the files by the end of the day?''', 'informal', '{}', 'TRUE_FALSE', 140);
INSERT INTO public."Exercise" VALUES (277, 'In the film ''The Social Network'', how does Mark Zuckerberg’s language reflect his character?', 'his language is fast-paced sharp and often dismissive showing his ambition and social disconnect', '["He uses formal and polite language to maintain professionalism.", "His language is fast-paced, sharp, and often dismissive, showing his ambition and social disconnect.", "He speaks with a lot of humor, which shows his friendliness and openness.", "His language is casual and relaxed, highlighting his easy-going nature."]', 'MULTIPLE_CHOICE', 141);
INSERT INTO public."Exercise" VALUES (278, 'Traduisez : ''This is a classic case of irony in sitcoms. The more they try to solve the problem, the worse it gets.'' (Référence à des séries comiques)', 'cest un cas classique dironie dans les sitcoms plus ils essaient de résoudre le problème plus ça empire', '{}', 'TRANSLATION', 141);
INSERT INTO public."Exercise" VALUES (279, 'Is the following statement true or false? ''In ''Friends'', Chandler’s humor is often used to mask his insecurities and discomfort in social situations.''', 'true', '{}', 'TRUE_FALSE', 141);
INSERT INTO public."Exercise" VALUES (280, 'Which of the following phrases from ''Game of Thrones'' best reflects the themes of power and politics in the series?', 'when you play the game of thrones you win or you die', '["''When you play the game of thrones, you win or you die.''", "''Winter is coming.''", "''Valar Morghulis.''", "''I drink and I know things.''"]', 'MULTIPLE_CHOICE', 141);
INSERT INTO public."Exercise" VALUES (281, 'Traduisez : ''The use of sarcasm in ''The Office'' highlights the awkwardness of everyday office life.''', 'lutilisation du sarcasme dans the office met en évidence lawkwardness de la vie quotidienne au bureau', '{}', 'TRANSLATION', 141);
INSERT INTO public."Exercise" VALUES (282, 'Is the following statement true or false? ''In ''Sherlock'', the character of Sherlock Holmes often uses language to assert his intelligence and superiority over others.''', 'true', '{}', 'TRUE_FALSE', 141);
INSERT INTO public."Exercise" VALUES (283, 'In a political debate, what is the main purpose of using rhetorical questions?', 'to strengthen an argument by encouraging the audience to think about the issue critically', '["To confuse the audience by introducing complex concepts.", "To strengthen an argument by encouraging the audience to think about the issue critically.", "To summarize the main points of the debate.", "To undermine the credibility of the opposing speaker."]', 'MULTIPLE_CHOICE', 142);
INSERT INTO public."Exercise" VALUES (284, 'Traduisez : ''Lors d’un débat politique, il est important de comprendre les sous-entendus derrière chaque argument.''', 'in a political debate it is important to understand the implications behind each argument', '{}', 'TRANSLATION', 142);
INSERT INTO public."Exercise" VALUES (285, 'Is the following statement true or false? ''In a television debate, candidates often use emotional appeals (pathos) to connect with the audience rather than focusing solely on logic.''', 'true', '{}', 'TRUE_FALSE', 142);
INSERT INTO public."Exercise" VALUES (286, 'Which of the following strategies is commonly used in political debates to discredit an opponent?', 'using the ad hominem attack where the focus shifts to personal characteristics rather than the argument', '["Presenting irrefutable facts.", "Using the ad hominem attack, where the focus shifts to personal characteristics rather than the argument.", "Acknowledging and addressing the opponent’s argument with respect.", "Building consensus by agreeing on points of common interest."]', 'MULTIPLE_CHOICE', 142);
INSERT INTO public."Exercise" VALUES (287, 'Traduisez : ''Les politiciens doivent être capables de répondre aux critiques de manière stratégique pour maintenir leur image.''', 'politicians must be able to respond to criticism strategically in order to maintain their image', '{}', 'TRANSLATION', 142);
INSERT INTO public."Exercise" VALUES (288, 'Is the following statement true or false? ''In televised political debates, candidates often rely on logical reasoning and factual evidence to win the audience''s trust.''', 'false', '{}', 'TRUE_FALSE', 142);
INSERT INTO public."Exercise" VALUES (289, 'cow', 'cow', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (290, 'dog', 'dog', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (291, 'cat', 'cat', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (292, 'house', 'house', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (293, 'car', 'car', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (294, 'apple', 'apple', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (295, 'book', 'book', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (296, 'pen', 'pen', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (297, 'table', 'table', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (298, 'friend', 'friend', '[]', 'TALK', 143);
INSERT INTO public."Exercise" VALUES (299, 'My name is John', 'my name is john', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (300, 'I am twenty years old', 'i am twenty years old', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (301, 'I am from Paris', 'i am from paris', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (302, 'I live in London', 'i live in london', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (303, 'I have a brother', 'i have a brother', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (304, 'I like music', 'i like music', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (305, 'I am a student', 'i am a student', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (306, 'I work in a shop', 'i work in a shop', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (307, 'My favorite color is blue', 'my favorite color is blue', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (308, 'I speak French and English', 'i speak french and english', '[]', 'TALK', 144);
INSERT INTO public."Exercise" VALUES (309, 'Hello', 'hello', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (310, 'Good morning', 'good morning', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (311, 'Good afternoon', 'good afternoon', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (312, 'Good evening', 'good evening', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (313, 'How are you ?', 'how are you', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (314, 'I’m fine, thank you.', 'i’m fine thank you', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (315, 'Please', 'please', '[]', 'TALK', 145);
INSERT INTO public."Exercise" VALUES (327, 'white', 'white', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (328, 'orange', 'orange', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (329, 'pink', 'pink', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (330, 'purple', 'purple', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (331, 'brown', 'brown', '[]', 'TALK', 146);
INSERT INTO public."Exercise" VALUES (332, 'table', 'table', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (333, 'chair', 'chair', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (334, 'bed', 'bed', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (335, 'lamp', 'lamp', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (336, 'sofa', 'sofa', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (337, 'kitchen', 'kitchen', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (338, 'door', 'door', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (339, 'window', 'window', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (340, 'mirror', 'mirror', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (341, 'television', 'television', '[]', 'TALK', 147);
INSERT INTO public."Exercise" VALUES (342, 'It’s sunny.', 'it’s sunny', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (343, 'It’s cloudy.', 'it’s cloudy', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (344, 'It’s raining.', 'it’s raining', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (345, 'It’s windy.', 'it’s windy', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (346, 'It’s snowing.', 'it’s snowing', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (347, 'It’s hot today.', 'it’s hot today', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (348, 'It’s cold outside.', 'it’s cold outside', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (349, 'The weather is nice.', 'the weather is nice', '[]', 'TALK', 148);
INSERT INTO public."Exercise" VALUES (352, 'I go to work by bus.', 'i go to work by bus', '[]', 'TALK', 149);
INSERT INTO public."Exercise" VALUES (353, 'I take the train to the office.', 'i take the train to the office', '[]', 'TALK', 149);
INSERT INTO public."Exercise" VALUES (355, 'I go to the gym after work.', 'i go to the gym after work', '[]', 'TALK', 149);
INSERT INTO public."Exercise" VALUES (356, 'Where is the train station ?', 'where is the train station', '[]', 'TALK', 150);
INSERT INTO public."Exercise" VALUES (357, 'How much is a ticket to Paris ?', 'how much is a ticket to paris', '[]', 'TALK', 150);
INSERT INTO public."Exercise" VALUES (358, 'I would like a single ticket, please ?', 'i would like a single ticket please', '[]', 'TALK', 150);
INSERT INTO public."Exercise" VALUES (359, 'What time does the bus leave ?', 'what time does the bus leave', '[]', 'TALK', 150);
INSERT INTO public."Exercise" VALUES (360, 'Can you help me find my way ?', 'can you help me find my way', '[]', 'TALK', 150);
INSERT INTO public."Exercise" VALUES (361, 'I am going to the airport.', 'i am going to the airport', '[]', 'TALK', 150);
INSERT INTO public."Exercise" VALUES (362, 'Is there a hotel nearby ?', 'is there a hotel nearby', '[]', 'TALK', 150);
INSERT INTO public."Exercise" VALUES (363, 'I prefer tea to coffee.', 'i prefer tea to coffee', '[]', 'TALK', 151);
INSERT INTO public."Exercise" VALUES (364, 'My favorite hobby is playing football.', 'my favorite hobby is playing football', '[]', 'TALK', 151);
INSERT INTO public."Exercise" VALUES (365, 'I like to read books in my free time.', 'i like to read books in my free time', '[]', 'TALK', 151);
INSERT INTO public."Exercise" VALUES (366, 'I don’t enjoy watching horror films.', 'i don’t enjoy watching horror films', '[]', 'TALK', 151);
INSERT INTO public."Exercise" VALUES (367, 'Last weekend, I went to the cinema.', 'last weekend i went to the cinema', '[]', 'TALK', 152);
INSERT INTO public."Exercise" VALUES (368, 'I visited London last summer.', 'i visited london last summer', '[]', 'TALK', 152);
INSERT INTO public."Exercise" VALUES (369, 'I met my friends at the park yesterday.', 'i met my friends at the park yesterday', '[]', 'TALK', 152);
INSERT INTO public."Exercise" VALUES (370, 'I travelled to Italy last year.', 'i travelled to italy last year', '[]', 'TALK', 152);
INSERT INTO public."Exercise" VALUES (371, 'I was really happy to see my family last week.', 'i was really happy to see my family last week', '[]', 'TALK', 152);
INSERT INTO public."Exercise" VALUES (372, 'We had a great time at the concert.', 'we had a great time at the concert', '[]', 'TALK', 152);
INSERT INTO public."Exercise" VALUES (373, 'Next summer, I will travel to Japan.', 'next summer i will travel to japan', '[]', 'TALK', 153);
INSERT INTO public."Exercise" VALUES (374, 'I am going to start a new job next month.', 'i am going to start a new job next month', '[]', 'TALK', 153);
INSERT INTO public."Exercise" VALUES (375, 'I plan to study abroad next year.', 'i plan to study abroad next year', '[]', 'TALK', 153);
INSERT INTO public."Exercise" VALUES (376, 'I am visiting my grandparents next weekend.', 'i am visiting my grandparents next weekend', '[]', 'TALK', 153);
INSERT INTO public."Exercise" VALUES (377, 'I will see my friends tomorrow evening.', 'i will see my friends tomorrow evening', '[]', 'TALK', 153);
INSERT INTO public."Exercise" VALUES (378, 'I’m thinking about learning a new language.', 'i’m thinking about learning a new language', '[]', 'TALK', 153);
INSERT INTO public."Exercise" VALUES (379, 'I think this movie is really interesting.', 'i think this movie is really interesting', '[]', 'TALK', 154);
INSERT INTO public."Exercise" VALUES (380, 'In my opinion, it’s important to exercise every day.', 'in my opinion it’s important to exercise every day', '[]', 'TALK', 154);
INSERT INTO public."Exercise" VALUES (381, 'I believe we should protect the environment.', 'i believe we should protect the environment', '[]', 'TALK', 154);
INSERT INTO public."Exercise" VALUES (382, 'I agree with you on this topic.', 'i agree with you on this topic', '[]', 'TALK', 154);
INSERT INTO public."Exercise" VALUES (383, 'I don’t think that’s a good idea.', 'i don’t think that’s a good idea', '[]', 'TALK', 154);
INSERT INTO public."Exercise" VALUES (384, 'We are facing a serious environmental issue.', 'we are facing a serious environmental issue', '[]', 'TALK', 155);
INSERT INTO public."Exercise" VALUES (385, 'The main problem is the lack of resources.', 'the main problem is the lack of resources', '[]', 'TALK', 155);
INSERT INTO public."Exercise" VALUES (386, 'One possible solution could be to reduce waste.', 'one possible solution could be to reduce waste', '[]', 'TALK', 155);
INSERT INTO public."Exercise" VALUES (387, 'I think we should invest more in renewable energy.', 'i think we should invest more in renewable energy', '[]', 'TALK', 155);
INSERT INTO public."Exercise" VALUES (388, 'We could start recycling more in our community.', 'we could start recycling more in our community', '[]', 'TALK', 155);
INSERT INTO public."Exercise" VALUES (389, 'The government should do more to protect wildlife.', 'the government should do more to protect wildlife', '[]', 'TALK', 155);
INSERT INTO public."Exercise" VALUES (390, 'Another solution might be to promote public transportation.', 'another solution might be to promote public transportation', '[]', 'TALK', 155);
INSERT INTO public."Exercise" VALUES (391, 'I don’t agree with this approach.', 'i don’t agree with this approach', '[]', 'TALK', 156);
INSERT INTO public."Exercise" VALUES (392, 'I think there’s a better way to solve this issue.', 'i think there’s a better way to solve this issue', '[]', 'TALK', 156);
INSERT INTO public."Exercise" VALUES (393, 'In my opinion, we should look for a different solution.', 'in my opinion we should look for a different solution', '[]', 'TALK', 156);
INSERT INTO public."Exercise" VALUES (394, 'I’m not convinced that this is the best option.', 'i’m not convinced that this is the best option', '[]', 'TALK', 156);
INSERT INTO public."Exercise" VALUES (395, 'I disagree because it doesn’t take all factors into account.', 'i disagree because it doesn’t take all factors into account', '[]', 'TALK', 156);
INSERT INTO public."Exercise" VALUES (396, 'In this situation, we must weigh the consequences of each action.', 'in this situation we must weigh the consequences of each action', '[]', 'TALK', 157);
INSERT INTO public."Exercise" VALUES (397, 'On one hand, we could argue that the benefits outweigh the risks.', 'on one hand we could argue that the benefits outweigh the risks', '[]', 'TALK', 157);
INSERT INTO public."Exercise" VALUES (398, 'However, there is a moral responsibility to consider the rights of others.', 'however there is a moral responsibility to consider the rights of others', '[]', 'TALK', 157);
INSERT INTO public."Exercise" VALUES (399, 'I believe that the ethical implications should be carefully examined before making a decision.', 'i believe that the ethical implications should be carefully examined before making a decision', '[]', 'TALK', 157);
INSERT INTO public."Exercise" VALUES (350, 'I wake up at 7 o''clock.', 'i wake up at seven oclock', '[]', 'TALK', 149);
INSERT INTO public."Exercise" VALUES (354, 'I have lunch at 12 p.m.', 'i have lunch at twelve pm', '[]', 'TALK', 149);
INSERT INTO public."Exercise" VALUES (400, 'It is essential to consider all perspectives before forming an opinion on this matter.', 'it is essential to consider all perspectives before forming an opinion on this matter', '[]', 'TALK', 157);
INSERT INTO public."Exercise" VALUES (401, 'The dilemma here is whether we prioritize individual rights or the greater good.', 'the dilemma here is whether we prioritize individual rights or the greater good', '[]', 'TALK', 157);
INSERT INTO public."Exercise" VALUES (402, 'The government’s decision to implement this policy has far-reaching consequences.', 'the government’s decision to implement this policy has far-reaching consequences', '[]', 'TALK', 158);
INSERT INTO public."Exercise" VALUES (403, 'While the policy aims to address economic inequality, it could also lead to unintended side effects.', 'while the policy aims to address economic inequality it could also lead to unintended side effects', '[]', 'TALK', 158);
INSERT INTO public."Exercise" VALUES (404, 'One possible outcome of this decision is a shift in public opinion.', 'one possible outcome of this decision is a shift in public opinion', '[]', 'TALK', 158);
INSERT INTO public."Exercise" VALUES (405, 'It’s important to consider both the immediate and long-term effects of such a move.', 'it’s important to consider both the immediate and long-term effects of such a move', '[]', 'TALK', 158);
INSERT INTO public."Exercise" VALUES (406, 'I think the government is overlooking some of the potential risks involved.', 'i think the government is overlooking some of the potential risks involved', '[]', 'TALK', 158);
INSERT INTO public."Exercise" VALUES (408, 'Globalization has had a profound impact on cultural identity.', 'globalization has had a profound impact on cultural identity', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (409, 'On the one hand, it has promoted cultural exchange, but on the other hand, it has led to cultural homogenization.', 'on the one hand it has promoted cultural exchange but on the other hand it has led to cultural homogenization', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (410, 'In many ways, this phenomenon has both positive and negative implications for local traditions.', 'in many ways this phenomenon has both positive and negative implications for local traditions', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (411, 'The rise of social media has accelerated the spread of global culture, but it also threatens local customs.', 'the rise of social media has accelerated the spread of global culture but it also threatens local customs', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (412, 'One of the key issues here is whether global culture is replacing local cultures.', 'one of the key issues here is whether global culture is replacing local cultures', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (413, 'While some argue that globalization enriches our cultural landscape, others believe it dilutes it.', 'while some argue that globalization enriches our cultural landscape others believe it dilutes it', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (414, 'This has sparked a debate over whether cultural diversity can be preserved in a globalized world.', 'this has sparked a debate over whether cultural diversity can be preserved in a globalized world', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (415, 'It’s important to strike a balance between embracing global trends and maintaining cultural heritage.', 'it’s important to strike a balance between embracing global trends and maintaining cultural heritage', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (416, 'The influence of global culture is evident in fashion, music, and even language.', 'the influence of global culture is evident in fashion music and even language', '[]', 'TALK', 159);
INSERT INTO public."Exercise" VALUES (351, 'I have breakfast at 8 a.m.', 'i have breakfast at eight am', '[]', 'TALK', 149);


--
-- TOC entry 3494 (class 0 OID 16709)
-- Dependencies: 227
-- Data for Name: ExercisesSerie; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."ExercisesSerie" VALUES (96, 'Premiers mots en anglais', 'Apprends le vocabulaire de base pour te présenter et parler de ton quotidien.', '2025-03-18 08:00:13.172', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (97, 'Les chiffres et les dates', 'Maîtrise les nombres, les heures et les dates en anglais pour parler du temps.', '2025-03-18 08:00:13.202', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (98, 'Les couleurs et les objets', 'Identifie et nomme les couleurs et objets courants de ton environnement.', '2025-03-18 08:00:13.23', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (99, 'Les verbes essentiels', 'Apprends les verbes de base pour exprimer des actions simples.', '2025-03-18 08:00:13.261', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (100, 'Se présenter en anglais', 'Savoir dire son nom, son âge, et parler de soi-même.', '2025-03-18 08:00:13.292', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (101, 'Les salutations et formules de politesse', 'Savoir dire bonjour, merci, et formuler des demandes polies.', '2025-03-18 08:00:13.316', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (102, 'Les membres de la famille', 'Apprends à parler de ta famille et des liens de parenté.', '2025-03-18 08:00:13.339', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (103, 'Les animaux courants', 'Apprends à nommer les animaux domestiques et sauvages.', '2025-03-18 08:00:13.36', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (104, 'La nourriture et les boissons', 'Découvre le vocabulaire des aliments et comment commander au restaurant.', '2025-03-18 08:00:13.384', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (105, 'Les lieux de la ville', 'Apprends à demander ton chemin et à nommer les endroits courants.', '2025-03-18 08:00:13.405', 1, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (106, 'La vie quotidienne', 'Décris ta routine et tes activités habituelles.', '2025-03-18 08:00:13.433', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (107, 'Faire des achats', 'Savoir demander des prix, comparer des produits et acheter des objets.', '2025-03-18 08:00:13.489', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (108, 'Voyager à l’étranger', 'Apprends les phrases essentielles pour l’aéroport, l’hôtel et les transports.', '2025-03-18 08:00:13.511', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (109, 'Les loisirs et passe-temps', 'Parle de ce que tu aimes faire pendant ton temps libre.', '2025-03-18 08:00:13.533', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (110, 'La météo et les saisons', 'Décris le temps qu’il fait et les changements de saison.', '2025-03-18 08:00:13.554', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (111, 'Les descriptions physiques et vestimentaires', 'Apprends à décrire une personne et ses vêtements.', '2025-03-18 08:00:13.575', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (112, 'Les émotions et sentiments', 'Exprime comment tu te sens et décris les émotions des autres.', '2025-03-18 08:00:13.595', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (113, 'Commander au restaurant', 'Apprends à lire un menu, commander et payer l’addition.', '2025-03-18 08:00:13.618', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (114, 'Les transports et déplacements', 'Savoir demander son chemin et utiliser les transports en commun.', '2025-03-18 08:00:13.642', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (115, 'Les verbes au passé simple', 'Apprends à raconter ce que tu as fait hier ou la semaine dernière.', '2025-03-18 08:00:13.664', 2, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (116, 'Raconter un souvenir ou une expérience', 'Apprends à parler d’un événement passé en détail.', '2025-03-18 08:00:13.691', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (117, 'Exprimer son opinion', 'Apprends à donner ton avis sur des sujets variés.', '2025-03-18 08:00:13.72', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (118, 'Comprendre et écrire un email formel', 'Apprends les bases des courriers professionnels et académiques.', '2025-03-18 08:00:13.744', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (119, 'Les expressions idiomatiques courantes', 'Découvre des expressions anglaises utilisées au quotidien.', '2025-03-18 08:00:13.767', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (120, 'Les différences culturelles', 'Parle des habitudes et traditions des pays anglophones.', '2025-03-18 08:00:13.79', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (121, 'Le travail et les métiers', 'Apprends à parler de ton emploi et du monde professionnel.', '2025-03-18 08:00:13.812', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (122, 'Les médias et les nouvelles', 'Apprends à comprendre et discuter des actualités.', '2025-03-18 08:00:13.834', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (123, 'Les conversations téléphoniques', 'Entraîne-toi à répondre et passer des appels en anglais.', '2025-03-18 08:00:13.872', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (124, 'Les voyages et aventures', 'Décris un voyage que tu as fait ou que tu aimerais faire.', '2025-03-18 08:00:13.892', 3, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (125, 'Débats et argumentation', 'Apprends à défendre une opinion et contre-argumenter.', '2025-03-18 08:00:13.912', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (126, 'L’anglais dans le monde professionnel', 'Utilise l’anglais dans des situations de bureau et d’affaires.', '2025-03-18 08:00:13.946', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (127, 'Comprendre les discours et conférences', 'Analyse des vidéos et discours en anglais.', '2025-03-18 08:00:13.968', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (128, 'Les faux amis et pièges du vocabulaire', 'Identifie et évite les erreurs fréquentes en anglais.', '2025-03-18 08:00:13.991', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (129, 'Écrire un essai structuré', 'Apprends à rédiger un texte argumentatif bien organisé.', '2025-03-18 08:00:14.014', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (130, 'Analyser un article de presse', 'Comprends et résume un article complexe en anglais.', '2025-03-18 08:00:14.035', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (131, 'Les subtilités grammaticales avancées', 'Travaille sur les temps et structures grammaticales avancées.', '2025-03-18 08:00:14.08', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (132, 'Comprendre l’humour et les jeux de mots', 'Découvre l’humour anglais et ses subtilités.', '2025-03-18 08:00:14.111', 4, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (133, 'Analyse de textes littéraires', 'Étudie des extraits d’œuvres en anglais.', '2025-03-18 08:00:14.132', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (134, 'L’anglais académique', 'Apprends le vocabulaire et les structures utilisées dans les études supérieures.', '2025-03-18 08:00:14.154', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (135, 'Rédaction et argumentation avancées', 'Maîtrise les nuances de la rédaction d’essais et de rapports.', '2025-03-18 08:00:14.175', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (136, 'Discours et présentations en anglais', 'Développe tes compétences en prise de parole.', '2025-03-18 08:00:14.2', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (137, 'Comprendre et utiliser le sarcasme', 'Découvre les nuances de l’humour et du ton en anglais.', '2025-03-18 08:00:14.234', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (138, 'L’anglais des affaires et de la finance', 'Apprends le vocabulaire de l’économie et des entreprises.', '2025-03-18 08:00:14.259', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (139, 'Traduction et interprétation', 'Exerce-toi à traduire des textes et à interpréter des discours.', '2025-03-18 08:00:14.288', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (140, 'Les registres de langue', 'Adapte ton langage en fonction du contexte (familier, formel, soutenu).', '2025-03-18 08:00:14.309', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (141, 'Analyse de films et séries en anglais', 'Étudie des dialogues et leur sous-texte culturel.', '2025-03-18 08:00:14.332', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (142, 'Comprendre un débat télévisé ou politique', 'Analyse des discussions complexes et des arguments avancés.', '2025-03-18 08:00:14.354', 5, 'DEFAULT');
INSERT INTO public."ExercisesSerie" VALUES (143, 'Vocabulaire de base', 'Entraînez-vous à répéter des mots de vocabulaire courants en anglais.', '2025-03-18 08:07:23.573', 1, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (144, 'Se présenter', 'Répétez des phrases simples pour vous présenter en anglais.', '2025-03-18 08:08:02.593', 1, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (145, 'Salutations et formules de politesse', 'Répétez des expressions de salutation et de politesse utilisées au quotidien.', '2025-03-18 08:08:19.213', 1, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (146, 'Les couleurs', 'Apprenez à répéter les noms des couleurs.', '2025-03-18 08:08:30.017', 1, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (147, 'Les objets de la maison', 'Répétez les noms des objets courants que l''on trouve dans la maison.', '2025-03-18 08:08:40.81', 1, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (148, 'Parler de la météo', 'Répétez des phrases et des mots pour décrire la météo.', '2025-03-18 08:09:20.858', 2, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (149, 'Activités quotidiennes', 'Répétez des phrases qui décrivent des actions courantes dans la vie de tous les jours.', '2025-03-18 08:09:37.194', 2, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (150, 'Expressions pour les voyages', 'Répétez des phrases utiles pour les voyages et les déplacements.', '2025-03-18 08:09:47.364', 2, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (151, 'Parler de ses préférences', 'Répétez des phrases pour exprimer vos préférences et choix personnels.', '2025-03-18 08:10:19.463', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (152, 'Parler d''un événement passé', 'Répétez des phrases pour décrire un événement ou une expérience passée.', '2025-03-18 08:10:29.561', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (153, 'Parler de ses projets futurs', 'Répétez des phrases pour parler de vos projets à venir.', '2025-03-18 08:10:39.027', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (154, 'Donner son avis', 'Répétez des phrases pour donner et justifier votre opinion sur divers sujets.', '2025-03-18 08:10:50.905', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (155, 'Décrire un problème et proposer des solutions', 'Répétez des phrases pour exprimer un problème et proposer des solutions possibles.', '2025-03-18 08:11:16.29', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (156, 'Exprimer un désaccord et proposer une alternative', 'Répétez des phrases pour exprimer un désaccord et suggérer une autre solution ou opinion.', '2025-03-18 08:11:25.692', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (157, 'Analyser un dilemme éthique', 'Répétez des phrases pour discuter d''un dilemme éthique et présenter vos arguments de manière nuancée.', '2025-03-18 08:13:11.678', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (158, 'Discuter des implications d''une décision politique', 'Répétez des phrases pour exprimer des opinions sur les décisions politiques et analyser leurs conséquences.', '2025-03-18 08:13:23.222', 3, 'TALK');
INSERT INTO public."ExercisesSerie" VALUES (159, 'Discuter d''un phénomène culturel global', 'Répétez des phrases pour exprimer des opinions sur l''impact des phénomènes culturels mondiaux.', '2025-03-18 08:13:34.209', 3, 'TALK');


--
-- TOC entry 3492 (class 0 OID 16698)
-- Dependencies: 225
-- Data for Name: Level; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Level" VALUES (4, 'B2', 'Avancé', 'Les apprenants à ce niveau peuvent comprendre et produire des textes et discours plus complexes. On travaille ici sur l’argumentation, les idiomes, l’anglais des médias et les discussions approfondies. L’objectif est d’avoir une communication fluide et nuancée.', 192, 4);
INSERT INTO public."Level" VALUES (1, 'A1', 'Débutant', 'Ce niveau est destiné aux personnes qui commencent tout juste à apprendre l’anglais. L’accent est mis sur le vocabulaire de base, la grammaire élémentaire et la compréhension de phrases simples. L’objectif est de pouvoir se présenter, poser des questions courantes et comprendre des conversations très basiques.', 110, 1);
INSERT INTO public."Level" VALUES (5, 'C1', 'Autonome', 'Ce niveau s’adresse aux personnes qui maîtrisent déjà bien l’anglais et souhaitent affiner leur compréhension et leur expression. On y travaille la subtilité de la langue, l’anglais académique et professionnel, ainsi que l’analyse de contenus authentiques comme des conférences ou des articles spécialisés.', 300, 5);
INSERT INTO public."Level" VALUES (2, 'A2', 'Élémentaire', 'À ce niveau, les apprenants peuvent déjà comprendre et utiliser des expressions courantes de la vie quotidienne. Les exercices aident à construire des phrases plus complexes, à parler de ses expériences et à interagir dans des situations courantes (restaurant, voyages, achats).', 162, 2);
INSERT INTO public."Level" VALUES (3, 'B1', 'Intermédiaire', 'Ce niveau permet de s’exprimer avec plus d’aisance sur des sujets variés. On y apprend à raconter des événements passés, exprimer son opinion et comprendre des textes et des dialogues plus élaborés. Idéal pour ceux qui veulent devenir autonomes dans des conversations du quotidien.', 321, 3);


--
-- TOC entry 3484 (class 0 OID 16644)
-- Dependencies: 217
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."Notification" VALUES (1, 'd62434c4-c4b7-402c-accf-bd7f76fcae2e', true, '{"endpoint":"https://fcm.googleapis.com/fcm/send/fziMdwOy_EM:APA91bGag-TvG6O4Ojw7gLiag4a0uvj_ooYQo4rix1AQos9LZG22YCSqfs6Rb1BswlZpR3IvWLmaGcwWH5W5KNrSu8-MGcAp21wcifk4cUP_Zjaj_vwS3fK8men_4yNaSZqNkl4H-lSH","expirationTime":null,"keys":{"p256dh":"BM4E-f7XLA-Ac0QL93SDlc0HDzlxfGXSCDwCjl8JQ-v1cEI1VqkxpRRbGzd27PVKjJP5N7v0Xve83vGR_biUw8w","auth":"BfKdFE5vJjgow9uzOTafww"}}', 'ONE_DAY', '17:00', '2025-03-19 17:23:44.55');
INSERT INTO public."Notification" VALUES (3, '19b12782-d9f5-4fd6-8f6c-91532b6c88e8', true, '{"endpoint":"https://fcm.googleapis.com/fcm/send/cRtURDHW2XQ:APA91bGCZYpCQHipFtcabIEAdWwx7qT1ojg35kehkU0z7Az8gtuiR3YSYGVgYkRMq6qMj8qZxTdlYyuVobpZjqN6WVfwvwGHRjAaCEH2SUVp52eRE2n0xmYZugBFffm_LTcg7bi1cmIm","expirationTime":null,"keys":{"p256dh":"BGSd8m5fh4df0hBrDq5K9wB6BzS4XFuYeVh6KbGtmgexdZ4N540sqAKh2-n_bWnC7ORkjaJVHSGd58TCV-ZAqao","auth":"MEL6Uomaa99z0qwVW9YNZA"}}', 'TODAY', '10:10', '2025-03-18 11:10:00');
INSERT INTO public."Notification" VALUES (6, 'f60f675b-0420-4fe4-90e6-23683672f720', true, '{"endpoint":"https://fcm.googleapis.com/fcm/send/eLvl2MEdgFk:APA91bEw-L2jCYLNRiScPD0cJJjRwNlLI0P73nYukRb8jPWm0TQvTESSilEQBYymSNr_Ts5r63HbdCR3rghOdlETCwHHG6pFKACoFraQIhwiIP6MSVVOnQ3p8yJgMtbmllibskzwuB_Z","expirationTime":null,"keys":{"p256dh":"BGrG7lZBwGL9IlfYBD2DUQvMeW0MO6I0_xiBjQIcgAXj7WNQMHwpNDAfHVgMsms-OLG3ae2IrLtOm7oLaI-FsJ4","auth":"T5BiIGrpWOUGix731eYyxA"}}', 'TODAY', '15:49', '2025-03-20 15:49:00');


--
-- TOC entry 3490 (class 0 OID 16689)
-- Dependencies: 223
-- Data for Name: RefreshToken; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."RefreshToken" VALUES ('22d442eb-df64-43b0-b49e-43a7ecae4174', 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE0MTYxM2ZhLTQxYjEtNGJmZi05OGEzLWM3YmE1ZTM2NmM3YyIsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJyb2xlIjoiQURNSU4iLCJwc2V1ZG8iOiJ1c2VyMTIzIiwiZmlyc3RUaW1lQ29ubmVjdGlvbiI6dHJ1ZSwiYXZhdGFySWQiOjMsImlhdCI6MTc0MjI4MzAxMywiZXhwIjoxNzQyMzY5NDEzLCJhdWQiOiJMaW5ndWFHby1jbGllbnQiLCJpc3MiOiJMaW5ndWFHbyJ9.f5Hqnu5jqKCrsf0l0XWg6aWTtHveV-XvXZ4_PflQourheQnNYdre8Mfk06HeauMMaWQE0tWO9oEFnSWuvjlHDg', 'a41613fa-41b1-4bff-98a3-c7ba5e366c7c', '2025-03-18 07:30:13.026', '2025-03-19 07:30:13.025');
INSERT INTO public."RefreshToken" VALUES ('855e313f-474f-4c47-8dcb-4cf2a89c379e', 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImQ2MjQzNGM0LWM0YjctNDAyYy1hY2NmLWJkN2Y3NmZjYWUyZSIsImVtYWlsIjoiZ3VucmlkZTU2QGdtYWlsLmNvbSIsInJvbGUiOiJVU0VSIiwicHNldWRvIjoiZ3VucmlkZTU2IiwiZmlyc3RUaW1lQ29ubmVjdGlvbiI6ZmFsc2UsImF2YXRhcklkIjo0LCJpYXQiOjE3NDI0ODQyMTQsImV4cCI6MTc0MjU3MDYxNCwiYXVkIjoiTGluZ3VhR28tY2xpZW50IiwiaXNzIjoiTGluZ3VhR28ifQ.tD-Z_1fVts06GtFeBsKjSb50a4BDAHFApo8dCGQhvGgKRdmHfzJU2MmqOfaxt5LjK0ceS0Qo9WtK4dVjbm-ABw', 'd62434c4-c4b7-402c-accf-bd7f76fcae2e', '2025-03-20 15:23:34.839', '2025-03-21 15:23:34.838');
INSERT INTO public."RefreshToken" VALUES ('a7b7d7fb-0d32-4915-9643-1aebf2c4541e', 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE5YjEyNzgyLWQ5ZjUtNGZkNi04ZjZjLTkxNTMyYjZjODhlOCIsImVtYWlsIjoibC5iZXJ0YXVkQGhvdG1haWwuY29tIiwicm9sZSI6IlVTRVIiLCJwc2V1ZG8iOiJSZWRTdW5TaGluZSIsImZpcnN0VGltZUNvbm5lY3Rpb24iOmZhbHNlLCJhdmF0YXJJZCI6NiwiaWF0IjoxNzQyNDk0MzI0LCJleHAiOjE3NDI1ODA3MjQsImF1ZCI6Ikxpbmd1YUdvLWNsaWVudCIsImlzcyI6Ikxpbmd1YUdvIn0.LT1jmT5ScN3cIrmPc1MT_k7IWS15-ZZ8Qu3ApIytXQ9t0DF_39ReMYMnO_6M2imUzZlexj8tg6itM6db19yQRg', '19b12782-d9f5-4fd6-8f6c-91532b6c88e8', '2025-03-20 18:12:04.579', '2025-03-21 18:12:04.578');
INSERT INTO public."RefreshToken" VALUES ('1ff1b99f-e550-4953-89cb-01a0cd9dbf16', 'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY2MGY2NzViLTA0MjAtNGZlNC05MGU2LTIzNjgzNjcyZjcyMCIsImVtYWlsIjoibC5iZXJ0YXVkMTVAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJwc2V1ZG8iOiJMdWNhcyIsImZpcnN0VGltZUNvbm5lY3Rpb24iOmZhbHNlLCJhdmF0YXJJZCI6NSwiaWF0IjoxNzQyNDk0NTQxLCJleHAiOjE3NDI1ODA5NDEsImF1ZCI6Ikxpbmd1YUdvLWNsaWVudCIsImlzcyI6Ikxpbmd1YUdvIn0.wj_PpktUX-hMJHQMtbFLQSTcwCeymstLIAfn9ioG95uUmJNT91xgLq_5No-Sc1jL8Tr-gTtLjFhYjsERrdPSiw', 'f60f675b-0420-4fe4-90e6-23683672f720', '2025-03-20 18:15:41.915', '2025-03-21 18:15:41.915');


--
-- TOC entry 3487 (class 0 OID 16664)
-- Dependencies: 220
-- Data for Name: SiteStats; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."SiteStats" VALUES (1, 4, 406, 64, 1085);


--
-- TOC entry 3482 (class 0 OID 16633)
-- Dependencies: 215
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."User" VALUES ('a41613fa-41b1-4bff-98a3-c7ba5e366c7c', 'user123', 'test@gmail.com', '$2b$10$Fa/deuIcfFF2/8WLNwqvmOvqtEPSCpNL0DrcmYiLvoMpWyeUBM4Lu', 'ADMIN', '2025-03-17 17:59:51.752', 3, true);
INSERT INTO public."User" VALUES ('d62434c4-c4b7-402c-accf-bd7f76fcae2e', 'gunride56', 'gunride56@gmail.com', '$2b$10$J8lev/2OAXHjiGflKb8bneyhlekux7sG.2dXuiBsDJS.FQlcqX02W', 'USER', '2025-03-18 08:42:44.685', 4, false);
INSERT INTO public."User" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 'Lucas', 'l.bertaud15@gmail.com', '$2b$10$OZM1eGqCLCwVYNUo4dlhl.UJqvh7/ylMNZ44BLx7J0S3i5ruPa9jW', 'USER', '2025-03-19 21:06:47.135', 5, false);
INSERT INTO public."User" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 'RedSunShine', 'l.bertaud@hotmail.com', '$2b$10$DKXv9yp34RUEffZS3yj82uEEgtPDBxXJfzk.Z/CJ5dJivX0dvgfAW', 'USER', '2025-03-17 18:08:00.767', 6, false);


--
-- TOC entry 3497 (class 0 OID 16728)
-- Dependencies: 230
-- Data for Name: UserCompletedExercise; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 289, '2025-03-19 21:12:41.624', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 290, '2025-03-19 21:12:46.173', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 291, '2025-03-19 21:12:50.047', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 292, '2025-03-19 21:12:52.981', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 293, '2025-03-19 21:12:55.829', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 294, '2025-03-19 21:12:59.569', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 295, '2025-03-19 21:13:03', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 296, '2025-03-19 21:13:11.708', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 297, '2025-03-19 21:13:15.469', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 298, '2025-03-19 21:13:18.112', 143, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 299, '2025-03-20 15:44:55.974', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 300, '2025-03-20 15:45:01.395', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 301, '2025-03-20 15:45:05.432', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 302, '2025-03-20 15:45:09.096', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 303, '2025-03-20 15:45:13.109', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 304, '2025-03-20 15:45:16.741', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 305, '2025-03-20 15:45:25.762', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 306, '2025-03-20 15:45:29.816', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 307, '2025-03-20 15:45:39.956', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 308, '2025-03-20 15:46:16.257', 144, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 316, '2025-03-20 15:46:33.862', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 317, '2025-03-20 15:46:52.782', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 318, '2025-03-20 15:47:03.836', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 309, '2025-03-20 15:47:06.423', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 310, '2025-03-20 15:47:14.252', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 311, '2025-03-20 15:47:20.559', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 312, '2025-03-20 15:47:23.737', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 313, '2025-03-20 15:47:28.077', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 314, '2025-03-20 15:47:49.456', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 315, '2025-03-20 15:48:02.458', 145, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 324, '2025-03-20 18:15:55.129', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 325, '2025-03-20 18:15:58.593', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 326, '2025-03-20 18:16:02.005', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 322, '2025-03-20 18:16:10.618', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 323, '2025-03-20 18:16:17.779', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 327, '2025-03-20 18:16:39.031', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 328, '2025-03-20 18:16:44.183', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 329, '2025-03-20 18:16:53.789', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 330, '2025-03-20 18:17:01.173', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 331, '2025-03-20 18:17:04.884', 146, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 332, '2025-03-20 18:17:11.923', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 333, '2025-03-20 18:17:15.759', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 334, '2025-03-20 18:17:19.534', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 335, '2025-03-20 18:17:33.006', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 336, '2025-03-20 18:17:37.684', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 337, '2025-03-20 18:17:42.631', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 338, '2025-03-20 18:17:46.724', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 339, '2025-03-20 18:17:50.864', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 340, '2025-03-20 18:17:55.33', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 341, '2025-03-20 18:17:59.496', 147, 1);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 342, '2025-03-20 18:18:06.633', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 343, '2025-03-20 18:18:10.064', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 344, '2025-03-20 18:18:13.94', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 345, '2025-03-20 18:18:17.757', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 346, '2025-03-20 18:18:21.083', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 347, '2025-03-20 18:18:28.968', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 348, '2025-03-20 18:18:32.394', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 349, '2025-03-20 18:18:36.782', 148, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 356, '2025-03-20 18:19:16.147', 150, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 357, '2025-03-20 18:19:20.867', 150, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 358, '2025-03-20 18:19:25.859', 150, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 359, '2025-03-20 18:19:30.558', 150, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 360, '2025-03-20 18:19:34.537', 150, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 361, '2025-03-20 18:19:38.849', 150, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 362, '2025-03-20 18:19:44.143', 150, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 355, '2025-03-20 19:16:46.615', 149, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 352, '2025-03-20 19:32:06.451', 149, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 353, '2025-03-20 19:32:18.424', 149, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 350, '2025-03-20 19:32:28.136', 149, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 354, '2025-03-20 19:32:34.367', 149, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 351, '2025-03-20 19:32:49.823', 149, 2);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 363, '2025-03-20 19:32:58.671', 151, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 364, '2025-03-20 19:33:04.385', 151, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 365, '2025-03-20 19:34:00.801', 151, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 366, '2025-03-20 19:34:44.314', 151, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 384, '2025-03-20 19:35:47.774', 155, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 385, '2025-03-20 19:35:53.649', 155, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 386, '2025-03-20 19:36:03.167', 155, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 387, '2025-03-20 19:36:09.459', 155, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 388, '2025-03-20 19:36:16.051', 155, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 389, '2025-03-20 19:36:22.338', 155, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 390, '2025-03-20 19:36:50.727', 155, 3);
INSERT INTO public."UserCompletedExercise" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 367, '2025-03-20 19:37:14.967', 152, 3);


--
-- TOC entry 3499 (class 0 OID 16745)
-- Dependencies: 232
-- Data for Name: UserCompletedExercisesSerie; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 143, '2025-03-19 21:13:18.564');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 144, '2025-03-20 15:46:16.375');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 145, '2025-03-20 15:48:02.618');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 146, '2025-03-20 18:17:04.991');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 147, '2025-03-20 18:17:59.587');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 148, '2025-03-20 18:18:36.909');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 150, '2025-03-20 18:19:44.259');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 149, '2025-03-20 19:32:49.937');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 151, '2025-03-20 19:34:44.481');
INSERT INTO public."UserCompletedExercisesSerie" VALUES ('f60f675b-0420-4fe4-90e6-23683672f720', 155, '2025-03-20 19:36:50.87');


--
-- TOC entry 3498 (class 0 OID 16737)
-- Dependencies: 231
-- Data for Name: UserFavoriteSerie; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."UserFavoriteSerie" VALUES ('d62434c4-c4b7-402c-accf-bd7f76fcae2e', 96, '2025-03-18 09:08:55.212');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 96, '2025-03-20 13:57:07.397');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 97, '2025-03-20 13:57:09.402');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 98, '2025-03-20 13:57:13.78');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 99, '2025-03-20 13:57:15.062');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 106, '2025-03-20 15:37:44.475');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 107, '2025-03-20 15:37:45.415');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 116, '2025-03-20 15:37:47.442');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 125, '2025-03-20 15:37:49.457');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 126, '2025-03-20 15:37:50.011');
INSERT INTO public."UserFavoriteSerie" VALUES ('19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 127, '2025-03-20 15:37:51.093');


--
-- TOC entry 3489 (class 0 OID 16675)
-- Dependencies: 222
-- Data for Name: UserStats; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."UserStats" VALUES (1, 'a41613fa-41b1-4bff-98a3-c7ba5e366c7c', 0, 0, 0, 0, 0, 'A1');
INSERT INTO public."UserStats" VALUES (2, '19b12782-d9f5-4fd6-8f6c-91532b6c88e8', 0, 0, 0, 0, 64, 'A1');
INSERT INTO public."UserStats" VALUES (3, 'd62434c4-c4b7-402c-accf-bd7f76fcae2e', 0, 0, 0, 0, 0, 'A1');
INSERT INTO public."UserStats" VALUES (4, 'f60f675b-0420-4fe4-90e6-23683672f720', 128, 83, 91, 10, 1175, 'A2');


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 218
-- Name: Avatar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Avatar_id_seq"', 1, false);


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 228
-- Name: Exercise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Exercise_id_seq"', 416, true);


--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 226
-- Name: ExercisesSerie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."ExercisesSerie_id_seq"', 159, true);


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 224
-- Name: Level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Level_id_seq"', 5, true);


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 216
-- Name: Notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Notification_id_seq"', 6, true);


--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 221
-- Name: UserStats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."UserStats_id_seq"', 4, true);


--
-- TOC entry 3290 (class 2606 OID 16663)
-- Name: Avatar Avatar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Avatar"
    ADD CONSTRAINT "Avatar_pkey" PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 16727)
-- Name: Exercise Exercise_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Exercise"
    ADD CONSTRAINT "Exercise_pkey" PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 16718)
-- Name: ExercisesSerie ExercisesSerie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ExercisesSerie"
    ADD CONSTRAINT "ExercisesSerie_pkey" PRIMARY KEY (id);


--
-- TOC entry 3299 (class 2606 OID 16707)
-- Name: Level Level_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Level"
    ADD CONSTRAINT "Level_pkey" PRIMARY KEY (id);


--
-- TOC entry 3287 (class 2606 OID 16654)
-- Name: Notification Notification_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_pkey" PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 16696)
-- Name: RefreshToken RefreshToken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RefreshToken"
    ADD CONSTRAINT "RefreshToken_pkey" PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 16673)
-- Name: SiteStats SiteStats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SiteStats"
    ADD CONSTRAINT "SiteStats_pkey" PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 16736)
-- Name: UserCompletedExercise UserCompletedExercise_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCompletedExercise"
    ADD CONSTRAINT "UserCompletedExercise_pkey" PRIMARY KEY ("userId", "exerciseId");


--
-- TOC entry 3310 (class 2606 OID 16752)
-- Name: UserCompletedExercisesSerie UserCompletedExercisesSerie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCompletedExercisesSerie"
    ADD CONSTRAINT "UserCompletedExercisesSerie_pkey" PRIMARY KEY ("userId", "serieId");


--
-- TOC entry 3308 (class 2606 OID 16744)
-- Name: UserFavoriteSerie UserFavoriteSerie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFavoriteSerie"
    ADD CONSTRAINT "UserFavoriteSerie_pkey" PRIMARY KEY ("userId", "serieId");


--
-- TOC entry 3294 (class 2606 OID 16688)
-- Name: UserStats UserStats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserStats"
    ADD CONSTRAINT "UserStats_pkey" PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 16642)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3300 (class 1259 OID 16756)
-- Name: Level_title_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Level_title_key" ON public."Level" USING btree (title);


--
-- TOC entry 3288 (class 1259 OID 16754)
-- Name: Notification_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Notification_userId_key" ON public."Notification" USING btree ("userId");


--
-- TOC entry 3295 (class 1259 OID 16755)
-- Name: UserStats_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "UserStats_userId_key" ON public."UserStats" USING btree ("userId");


--
-- TOC entry 3283 (class 1259 OID 16753)
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- TOC entry 3328 (class 2620 OID 16826)
-- Name: Exercise on_create_exercise_add_totalexercises_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_exercise_add_totalexercises_in_site_stats AFTER INSERT ON public."Exercise" FOR EACH ROW EXECUTE FUNCTION public.add_totalexercises_in_site_stats();


--
-- TOC entry 3329 (class 2620 OID 16828)
-- Name: Exercise on_create_exercise_add_totalpoints_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_exercise_add_totalpoints_in_site_stats AFTER INSERT ON public."Exercise" FOR EACH ROW EXECUTE FUNCTION public.add_totalpoints_in_site_stats();


--
-- TOC entry 3330 (class 2620 OID 16832)
-- Name: Exercise on_create_exercise_add_winablepoints_in_level; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_exercise_add_winablepoints_in_level AFTER INSERT ON public."Exercise" FOR EACH ROW EXECUTE FUNCTION public.add_winablepoints_in_level();


--
-- TOC entry 3326 (class 2620 OID 16830)
-- Name: ExercisesSerie on_create_exercisesserie_add_totalseries_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_exercisesserie_add_totalseries_in_site_stats AFTER INSERT ON public."ExercisesSerie" FOR EACH ROW EXECUTE FUNCTION public.add_totalseries_in_site_stats();


--
-- TOC entry 3323 (class 2620 OID 16824)
-- Name: User on_create_user_add_totalusers_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_user_add_totalusers_in_site_stats AFTER INSERT ON public."User" FOR EACH ROW EXECUTE FUNCTION public.add_totalusers_in_site_stats();


--
-- TOC entry 3334 (class 2620 OID 16822)
-- Name: UserCompletedExercise on_create_usercompletedexercise_add_points_in_user_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_usercompletedexercise_add_points_in_user_stats AFTER INSERT ON public."UserCompletedExercise" FOR EACH ROW EXECUTE FUNCTION public.add_points_in_user_stats();


--
-- TOC entry 3335 (class 2620 OID 16820)
-- Name: UserCompletedExercise on_create_usercompletedexercise_add_successfullexercises_in_use; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_usercompletedexercise_add_successfullexercises_in_use AFTER INSERT ON public."UserCompletedExercise" FOR EACH ROW EXECUTE FUNCTION public.add_successfullexercises_in_user_stats();


--
-- TOC entry 3338 (class 2620 OID 16848)
-- Name: UserCompletedExercisesSerie on_create_usercompletedexercisesserie_add_completedseries_in_us; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_create_usercompletedexercisesserie_add_completedseries_in_us AFTER INSERT ON public."UserCompletedExercisesSerie" FOR EACH ROW EXECUTE FUNCTION public.add_completedseries_in_user_stats();


--
-- TOC entry 3331 (class 2620 OID 16840)
-- Name: Exercise on_delete_exercise_subtract_totalexercises_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_delete_exercise_subtract_totalexercises_in_site_stats AFTER DELETE ON public."Exercise" FOR EACH ROW EXECUTE FUNCTION public.subtract_totalexercises_in_site_stats();


--
-- TOC entry 3332 (class 2620 OID 16836)
-- Name: Exercise on_delete_exercise_subtract_totalpoints_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_delete_exercise_subtract_totalpoints_in_site_stats AFTER DELETE ON public."Exercise" FOR EACH ROW EXECUTE FUNCTION public.subtract_totalpoints_in_site_stats();


--
-- TOC entry 3333 (class 2620 OID 16838)
-- Name: Exercise on_delete_exercise_subtract_winablepoints_in_level; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_delete_exercise_subtract_winablepoints_in_level AFTER DELETE ON public."Exercise" FOR EACH ROW EXECUTE FUNCTION public.subtract_winablepoints_in_level();


--
-- TOC entry 3327 (class 2620 OID 16834)
-- Name: ExercisesSerie on_delete_exercisesserie_subtract_totalseries_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_delete_exercisesserie_subtract_totalseries_in_site_stats AFTER DELETE ON public."ExercisesSerie" FOR EACH ROW EXECUTE FUNCTION public.subtract_totalseries_in_site_stats();


--
-- TOC entry 3324 (class 2620 OID 16842)
-- Name: User on_delete_user_subtract_totalusers_in_site_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_delete_user_subtract_totalusers_in_site_stats AFTER DELETE ON public."User" FOR EACH ROW EXECUTE FUNCTION public.subtract_totalusers_in_site_stats();


--
-- TOC entry 3336 (class 2620 OID 16844)
-- Name: UserCompletedExercise on_delete_usercompletedexercise_subtract_points_in_user_stats; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_delete_usercompletedexercise_subtract_points_in_user_stats AFTER DELETE ON public."UserCompletedExercise" FOR EACH ROW EXECUTE FUNCTION public.subtract_points_in_user_stats();


--
-- TOC entry 3337 (class 2620 OID 16846)
-- Name: UserCompletedExercise on_delete_usercompletedexercise_subtract_successfullexercises_i; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_delete_usercompletedexercise_subtract_successfullexercises_i AFTER DELETE ON public."UserCompletedExercise" FOR EACH ROW EXECUTE FUNCTION public.subtract_successfullexercises_in_user_stats();


--
-- TOC entry 3325 (class 2620 OID 16850)
-- Name: UserStats on_update_userstats_check_user_level; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_update_userstats_check_user_level AFTER UPDATE OF points ON public."UserStats" FOR EACH ROW EXECUTE FUNCTION public.check_user_level();


--
-- TOC entry 3316 (class 2606 OID 16782)
-- Name: Exercise Exercise_serieId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Exercise"
    ADD CONSTRAINT "Exercise_serieId_fkey" FOREIGN KEY ("serieId") REFERENCES public."ExercisesSerie"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3315 (class 2606 OID 16777)
-- Name: ExercisesSerie ExercisesSerie_levelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ExercisesSerie"
    ADD CONSTRAINT "ExercisesSerie_levelId_fkey" FOREIGN KEY ("levelId") REFERENCES public."Level"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3312 (class 2606 OID 16762)
-- Name: Notification Notification_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3314 (class 2606 OID 16772)
-- Name: RefreshToken RefreshToken_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RefreshToken"
    ADD CONSTRAINT "RefreshToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3317 (class 2606 OID 16787)
-- Name: UserCompletedExercise UserCompletedExercise_exerciseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCompletedExercise"
    ADD CONSTRAINT "UserCompletedExercise_exerciseId_fkey" FOREIGN KEY ("exerciseId") REFERENCES public."Exercise"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3318 (class 2606 OID 16792)
-- Name: UserCompletedExercise UserCompletedExercise_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCompletedExercise"
    ADD CONSTRAINT "UserCompletedExercise_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3321 (class 2606 OID 16807)
-- Name: UserCompletedExercisesSerie UserCompletedExercisesSerie_serieId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCompletedExercisesSerie"
    ADD CONSTRAINT "UserCompletedExercisesSerie_serieId_fkey" FOREIGN KEY ("serieId") REFERENCES public."ExercisesSerie"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3322 (class 2606 OID 16812)
-- Name: UserCompletedExercisesSerie UserCompletedExercisesSerie_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserCompletedExercisesSerie"
    ADD CONSTRAINT "UserCompletedExercisesSerie_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3319 (class 2606 OID 16797)
-- Name: UserFavoriteSerie UserFavoriteSerie_serieId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFavoriteSerie"
    ADD CONSTRAINT "UserFavoriteSerie_serieId_fkey" FOREIGN KEY ("serieId") REFERENCES public."ExercisesSerie"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3320 (class 2606 OID 16802)
-- Name: UserFavoriteSerie UserFavoriteSerie_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserFavoriteSerie"
    ADD CONSTRAINT "UserFavoriteSerie_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3313 (class 2606 OID 16767)
-- Name: UserStats UserStats_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserStats"
    ADD CONSTRAINT "UserStats_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3311 (class 2606 OID 16757)
-- Name: User User_avatarId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_avatarId_fkey" FOREIGN KEY ("avatarId") REFERENCES public."Avatar"(id) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2025-03-20 21:16:19

--
-- PostgreSQL database dump complete
--

