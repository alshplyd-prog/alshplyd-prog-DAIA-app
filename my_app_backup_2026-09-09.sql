--
-- PostgreSQL database dump
--

\restrict 5yUivNxI2suQjkbirFKJ2WsZTZ6pTURMbsUDktvtaOsYmy4b24jcruSP5QEBFaL

-- Dumped from database version 14.24 (Ubuntu 14.24-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 17.11 (Ubuntu 17.11-1.pgdg22.04+2)

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
-- Name: auth; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO app_user;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO app_user;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO app_user;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO app_user;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO app_user;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO app_user;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO app_user;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: app_user
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO app_user;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO app_user;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO app_user;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO app_user;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO app_user;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO app_user;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO app_user;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO app_user;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO app_user;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: app_user
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO app_user;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: app_user
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO app_user;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: app_user
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in',
    'like',
    'ilike',
    'is',
    'match',
    'imatch',
    'isdistinct'
);


ALTER TYPE realtime.equality_op OWNER TO app_user;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: app_user
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text,
	negate boolean
);


ALTER TYPE realtime.user_defined_filter OWNER TO app_user;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: app_user
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO app_user;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: app_user
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO app_user;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: app_user
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO app_user;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: app_user
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO app_user;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: app_user
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO app_user;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: app_user
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO app_user;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: app_user
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO app_user;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: app_user
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
    revoke trigger on cron.job_run_details from postgres;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO app_user;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: app_user
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: app_user
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $_$
begin
    if not exists (
        select 1
        from pg_catalog.pg_event_trigger_ddl_commands() ev
        join pg_catalog.pg_extension e on ev.objid = e.oid
        where e.extname = 'pg_graphql'
    ) then
        return;
    end if;

    drop function if exists graphql_public.graphql;
    create or replace function graphql_public.graphql(
        "operationName" text default null,
        query text default null,
        variables jsonb default null,
        extensions jsonb default null
    )
        returns jsonb
        language sql
    as $$
        select graphql.resolve(
            query := query,
            variables := coalesce(variables, '{}'),
            "operationName" := "operationName",
            extensions := extensions
        );
    $$;

    -- Attach the wrapper to the extension so DROP EXTENSION cascades to it,
    -- which in turn triggers set_graphql_placeholder to reinstall the "not enabled" stub.
    alter extension pg_graphql add function graphql_public.graphql(text, text, jsonb, jsonb);

    grant usage on schema graphql to postgres, anon, authenticated, service_role;
    grant execute on function graphql.resolve to postgres, anon, authenticated, service_role;
    grant usage on schema graphql to postgres with grant option;
    grant usage on schema graphql_public to postgres with grant option;
end;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO app_user;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: app_user
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: app_user
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8.0', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO app_user;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: app_user
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: app_user
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO app_user;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: app_user
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO app_user;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: app_user
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
            set search_path to ''
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO app_user;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: app_user
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: app_user
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;


ALTER FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) OWNER TO app_user;

--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: app_user
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO app_user;

--
-- Name: recalc_contract_balance_on_payment_change(); Type: FUNCTION; Schema: public; Owner: app_user
--

CREATE FUNCTION public.recalc_contract_balance_on_payment_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        DECLARE
          v_cid_old TEXT := NULL;
          v_cname_old TEXT := NULL;
          v_cid_new TEXT := NULL;
          v_cname_new TEXT := NULL;
        BEGIN
          IF TG_OP = 'DELETE' THEN
            v_cid_old := OLD.contract_id;
            v_cname_old := OLD.customer_name;
          ELSIF TG_OP = 'UPDATE' THEN
            v_cid_old := OLD.contract_id;
            v_cname_old := OLD.customer_name;
            v_cid_new := NEW.contract_id;
            v_cname_new := NEW.customer_name;
          ELSE
            v_cid_new := NEW.contract_id;
            v_cname_new := NEW.customer_name;
          END IF;

          -- Update sales for all affected sales
          UPDATE sales c
          SET 
            total_paid = CASE
              WHEN EXISTS (SELECT 1 FROM payments p WHERE p.contract_id = c.id OR ((p.contract_id IS NULL OR p.contract_id = '') AND (TRIM(LOWER(p.customer_name)) = TRIM(LOWER(c.customer_name)) OR p.customer_name = c.customer_name)))
              THEN COALESCE((
                SELECT SUM(COALESCE(p.amount_paid, p.amount, 0))
                FROM payments p
                WHERE (p.contract_id = c.id) OR ((p.contract_id IS NULL OR p.contract_id = '') AND (TRIM(LOWER(p.customer_name)) = TRIM(LOWER(c.customer_name)) OR p.customer_name = c.customer_name))
              ), 0)
              ELSE COALESCE(c.total_paid, 0)
            END,
            remaining_balance = GREATEST(0, (COALESCE(c.total_price, 0) - COALESCE(c.advance_payment, 0)) - CASE
              WHEN EXISTS (SELECT 1 FROM payments p WHERE p.contract_id = c.id OR ((p.contract_id IS NULL OR p.contract_id = '') AND (TRIM(LOWER(p.customer_name)) = TRIM(LOWER(c.customer_name)) OR p.customer_name = c.customer_name)))
              THEN COALESCE((
                SELECT SUM(COALESCE(p.amount_paid, p.amount, 0))
                FROM payments p
                WHERE (p.contract_id = c.id) OR ((p.contract_id IS NULL OR p.contract_id = '') AND (TRIM(LOWER(p.customer_name)) = TRIM(LOWER(c.customer_name)) OR p.customer_name = c.customer_name))
              ), 0)
              ELSE COALESCE(c.total_paid, 0)
            END),
            last_payment_date = COALESCE(
              (
                SELECT MAX(p.payment_date)
                FROM payments p
                WHERE (p.contract_id = c.id) OR ((p.contract_id IS NULL OR p.contract_id = '') AND (TRIM(LOWER(p.customer_name)) = TRIM(LOWER(c.customer_name)) OR p.customer_name = c.customer_name))
              ),
              c.last_payment_date
            ),
            status = CASE 
              WHEN GREATEST(0, (COALESCE(c.total_price, 0) - COALESCE(c.advance_payment, 0)) - CASE
                WHEN EXISTS (SELECT 1 FROM payments p WHERE p.contract_id = c.id OR ((p.contract_id IS NULL OR p.contract_id = '') AND (TRIM(LOWER(p.customer_name)) = TRIM(LOWER(c.customer_name)) OR p.customer_name = c.customer_name)))
                THEN COALESCE((
                  SELECT SUM(COALESCE(p.amount_paid, p.amount, 0))
                  FROM payments p
                  WHERE (p.contract_id = c.id) OR ((p.contract_id IS NULL OR p.contract_id = '') AND (TRIM(LOWER(p.customer_name)) = TRIM(LOWER(c.customer_name)) OR p.customer_name = c.customer_name))
                ), 0)
                ELSE COALESCE(c.total_paid, 0)
              END) = 0 THEN 'completed'
              ELSE 'active'
            END
          WHERE (v_cid_old IS NOT NULL AND v_cid_old != '' AND c.id = v_cid_old)
             OR ((v_cid_old IS NULL OR v_cid_old = '') AND v_cname_old IS NOT NULL AND (TRIM(LOWER(c.customer_name)) = TRIM(LOWER(v_cname_old)) OR c.customer_name = v_cname_old))
             OR (v_cid_new IS NOT NULL AND v_cid_new != '' AND c.id = v_cid_new)
             OR ((v_cid_new IS NULL OR v_cid_new = '') AND v_cname_new IS NOT NULL AND (TRIM(LOWER(c.customer_name)) = TRIM(LOWER(v_cname_new)) OR c.customer_name = v_cname_new));

          RETURN NULL;
        END;
        $$;


ALTER FUNCTION public.recalc_contract_balance_on_payment_change() OWNER TO app_user;

--
-- Name: recalc_contract_on_contract_change(); Type: FUNCTION; Schema: public; Owner: app_user
--

CREATE FUNCTION public.recalc_contract_on_contract_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        DECLARE
          v_paid DOUBLE PRECISION := 0;
          v_last_d TEXT := NULL;
        BEGIN
          SELECT COALESCE(SUM(amount), 0), MAX(payment_date)
          INTO v_paid, v_last_d
          FROM payments
          WHERE (contract_id = NEW.id) OR ((contract_id IS NULL OR contract_id = '') AND customer_name = NEW.customer_name);

          IF v_paid > 0 OR NEW.total_paid IS NULL THEN
            NEW.total_paid := v_paid;
          END IF;

          NEW.remaining_balance := GREATEST(0, (COALESCE(NEW.total_price, 0) - COALESCE(NEW.advance_payment, 0)) - COALESCE(NEW.total_paid, 0));
          
          IF v_last_d IS NOT NULL AND v_last_d != '' THEN
            NEW.last_payment_date := v_last_d;
          END IF;

          IF NEW.remaining_balance <= 0 THEN
            NEW.status := 'completed';
          ELSE
            NEW.status := 'active';
          END IF;

          RETURN NEW;
        END;
        $$;


ALTER FUNCTION public.recalc_contract_on_contract_change() OWNER TO app_user;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
    -- Regclass of the table e.g. public.notes
    entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

    -- I, U, D, T: insert, update ...
    action realtime.action = (
        case wal ->> 'action'
            when 'I' then 'INSERT'
            when 'U' then 'UPDATE'
            when 'D' then 'DELETE'
            else 'ERROR'
        end
    );

    -- Is row level security enabled for the table
    is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

    subscriptions realtime.subscription[] = array_agg(subs)
        from
            realtime.subscription subs
        where
            subs.entity = entity_
            -- Filter by action early - only get subscriptions interested in this action
            -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
            and (subs.action_filter = '*' or subs.action_filter = action::text);

    -- Subscription vars
    working_role regrole;
    working_selected_columns text[];
    claimed_role regrole;
    claims jsonb;

    subscription_id uuid;
    subscription_has_access bool;
    visible_to_subscription_ids uuid[] = '{}';

    -- structured info for wal's columns
    columns realtime.wal_column[];
    -- previous identity values for update/delete
    old_columns realtime.wal_column[];

    error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

    -- Primary jsonb output for record
    output jsonb;

    -- Loop record for iterating unique roles (outer loop)
    role_record record;
    -- Loop record for iterating unique selected_columns within a role (inner loop)
    cols_record record;
    -- Subscription ids visible at the role level (before fanning out by selected_columns)
    visible_role_sub_ids uuid[] = '{}';

begin
    perform set_config('role', null, true);

    columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'columns') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    old_columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'identity') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    for role_record in
        select claims_role
        from (select distinct claims_role from unnest(subscriptions)) t
        order by claims_role::text
    loop
        working_role := role_record.claims_role;

        -- Update `is_selectable` for columns and old_columns (once per role)
        columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(columns) c;

        old_columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(old_columns) c;

        if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
            -- Fan out 400 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;
            end loop;

        -- The claims role does not have SELECT permission to the primary key of entity
        elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
            -- Fan out 401 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;
            end loop;

        else
            -- Create the prepared statement (once per role)
            if is_rls_enabled and action <> 'DELETE' then
                if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                    deallocate walrus_rls_stmt;
                end if;
                execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
            end if;

            -- Collect all visible subscription IDs for this role (filter check + RLS check)
            visible_role_sub_ids = '{}';

            for subscription_id, claims in (
                    select
                        subs.subscription_id,
                        subs.claims
                    from
                        unnest(subscriptions) subs
                    where
                        subs.entity = entity_
                        and subs.claims_role = working_role
                        and (
                            realtime.is_visible_through_filters(columns, subs.filters)
                            or (
                              action = 'DELETE'
                              and realtime.is_visible_through_filters(old_columns, subs.filters)
                            )
                        )
            ) loop

                if not is_rls_enabled or action = 'DELETE' then
                    visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                else
                    -- Check if RLS allows the role to see the record
                    perform
                        -- Trim leading and trailing quotes from working_role because set_config
                        -- doesn't recognize the role as valid if they are included
                        set_config('role', trim(both '"' from working_role::text), true),
                        set_config('request.jwt.claims', claims::text, true);

                    execute 'execute walrus_rls_stmt' into subscription_has_access;

                    -- Reset the role on every FOR..LOOP batch execution.
                    -- The first batch of 10 rows is pre-fetched using the current connection role (PG internal behaviour)
                    -- then we have to reset it again otherwise it would use the role defined in the `set_config` above
                    -- to fetch the remaining rows when rows>10, which could be a user-defined role that lacks execution grants.
                    -- The flow is:
                    --   1. run batch with conn role
                    --   2. set_config working_role
                    --   3. execute walrus
                    --   4. reset role (revert)
                    --   5. repeat
                    perform set_config('role', null, true);

                    if subscription_has_access then
                        visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                    end if;
                end if;
            end loop;

            perform set_config('role', null, true);

            -- Inner loop: per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;

                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                            left join (
                                select unnest(conkey) as pkey_attnum
                                from pg_constraint
                                where conrelid = entity_ and contype = 'p'
                            ) pk on pk.pkey_attnum = pa.attnum
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                            and (working_selected_columns is null or pa.attname = any(working_selected_columns) or pk.pkey_attnum is not null)
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and (working_selected_columns is null or coalesce((c).name, (oc).name) = any(working_selected_columns) or coalesce((c).is_pkey, (oc).is_pkey))
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Filter visible_role_sub_ids to those matching the current selected_columns group
                visible_to_subscription_ids = coalesce(
                    (
                        select array_agg(s.subscription_id)
                        from unnest(subscriptions) s
                        where s.claims_role = working_role
                          and (s.selected_columns is not distinct from working_selected_columns)
                          and s.subscription_id = any(visible_role_sub_ids)
                    ),
                    '{}'::uuid[]
                );

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;
            end loop;

        end if;
    end loop;

    perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO app_user;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO app_user;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO app_user;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO app_user;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
/*
Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
*/
declare
    op_symbol text = (
        case
            when op = 'eq' then '='
            when op = 'neq' then '!='
            when op = 'lt' then '<'
            when op = 'lte' then '<='
            when op = 'gt' then '>'
            when op = 'gte' then '>='
            when op = 'in' then '= any'
            else 'UNKNOWN OP'
        end
    );
    res boolean;
begin
    execute format(
        'select %L::'|| type_::text || ' ' || op_symbol
        || ' ( %L::'
        || (
            case
                when op = 'in' then type_::text || '[]'
                else type_::text end
        )
        || ')', val_1, val_2) into res;
    return res;
end;
$$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO app_user;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $$
declare
    op_symbol text;
    res boolean;
begin
    -- IS DISTINCT FROM / IS NOT DISTINCT FROM: infix, both sides typed literals
    if op = 'isdistinct' then
        execute format(
            'select %L::%s %s %L::%s',
            val_1,
            type_::text,
            case when negate then 'IS NOT DISTINCT FROM' else 'IS DISTINCT FROM' end,
            val_2,
            type_::text
        ) into res;
        return res;
    end if;

    -- IS requires a keyword RHS (NULL, TRUE, FALSE, UNKNOWN), not a typed literal
    if op = 'is' then
        if val_2 not in ('null', 'true', 'false', 'unknown') then
            raise exception 'invalid value for is filter: must be null, true, false, or unknown';
        end if;
        execute format(
            'select %L::%s %s %s',
            val_1,
            type_::text,
            case when negate then 'IS NOT' else 'IS' end,
            upper(val_2)
        ) into res;
        return res;
    end if;

    op_symbol = case
        when op = 'eq'    then '='
        when op = 'neq'   then '!='
        when op = 'lt'    then '<'
        when op = 'lte'   then '<='
        when op = 'gt'    then '>'
        when op = 'gte'   then '>='
        when op = 'in'    then '= any'
        when op = 'like'   then 'LIKE'
        when op = 'ilike'  then 'ILIKE'
        when op = 'match'  then '~'
        when op = 'imatch' then '~*'
        else null
    end;

    if op_symbol is null then
        raise exception 'unsupported equality operator: %', op::text;
    end if;

    execute format(
        'select %L::%s %s (%L::%s)',
        val_1,
        type_::text,
        op_symbol,
        val_2,
        case when op = 'in' then type_::text || '[]' else type_::text end
    ) into res;

    return case when negate then not res else res end;
end;
$$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) OWNER TO app_user;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
    select
        filters is null
        or array_length(filters, 1) is null
        or coalesce(
            count(col.name) = count(1)
            and sum(
                realtime.check_equality_op(
                    op:=f.op,
                    type_:=coalesce(col.type_oid::regtype, col.type_name::regtype),
                    val_1:=col.value #>> '{}',
                    val_2:=f.value,
                    negate:=coalesce(f.negate, false)
                )::int
            ) filter (where col.name is not null) = count(col.name),
            false
        )
    from
        unnest(filters) f
        left join unnest(columns) col
            on f.column_name = col.name;
$$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO app_user;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    realtime.wal2json_escape_identifier(nsp.nspname::text)
    || '.'
    || realtime.wal2json_escape_identifier(pc.relname::text)
  FROM pg_class pc
  JOIN pg_namespace nsp ON pc.relnamespace = nsp.oid
  WHERE pc.oid = entity
$$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO app_user;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO app_user;

--
-- Name: send_binary(bytea, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, binary_payload, event, topic, private, extension)
    VALUES (generated_id, payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) OWNER TO app_user;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    col_names text[] = coalesce(
            array_agg(a.attname order by a.attnum),
            '{}'::text[]
        )
        from
            pg_catalog.pg_attribute a
        where
            a.attrelid = new.entity
            and a.attnum > 0
            and not a.attisdropped
            and pg_catalog.has_column_privilege(
                (new.claims ->> 'role'),
                a.attrelid,
                a.attnum,
                'SELECT'
            );
    filter realtime.user_defined_filter;
    col_type regtype;
    in_val jsonb;
    selected_col text;
begin
    for filter in select * from unnest(new.filters) loop
        if not filter.column_name = any(col_names) then
            raise exception 'invalid column for filter %', filter.column_name;
        end if;

        col_type = (
            select atttypid::regtype
            from pg_catalog.pg_attribute
            where attrelid = new.entity
                  and attname = filter.column_name
        );
        if col_type is null then
            raise exception 'failed to lookup type for column %', filter.column_name;
        end if;

        if filter.op = 'in'::realtime.equality_op then
            in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
            if coalesce(jsonb_array_length(in_val), 0) > 100 then
                raise exception 'too many values for `in` filter. Maximum 100';
            end if;
        elsif filter.op = 'is'::realtime.equality_op then
            -- `is` requires a keyword RHS rather than a typed literal
            if filter.value not in ('null', 'true', 'false', 'unknown') then
                raise exception 'invalid value for is filter: must be null, true, false, or unknown';
            end if;
            -- IS NULL works for any type, but IS TRUE/FALSE/UNKNOWN require a boolean
            -- operand. Reject the non-null keywords on non-boolean columns here so they
            -- don't abort apply_rls at WAL time.
            if filter.value <> 'null' and col_type <> 'boolean'::regtype then
                raise exception 'is % filter requires a boolean column, got %', filter.value, col_type::text;
            end if;
        elsif filter.op in ('like'::realtime.equality_op, 'ilike'::realtime.equality_op) then
            -- like/ilike apply the text pattern operator (~~); reject column types that
            -- have no such operator instead of failing at WAL time
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = '~~' and oprleft = col_type
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
        elsif filter.op in ('match'::realtime.equality_op, 'imatch'::realtime.equality_op) then
            -- match/imatch apply the regex operators ~ / ~*; reject column types that have
            -- no such operator (e.g. integer) instead of failing at WAL time, mirroring the
            -- like/ilike guard above.
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = case when filter.op = 'imatch'::realtime.equality_op then '~*' else '~' end
                  and oprleft = col_type
                  and oprright = col_type
                  and oprresult = 'boolean'::regtype
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
            -- validate the regex eagerly so a bad pattern is rejected here, not inside
            -- apply_rls where it would abort the WAL stream for the entity
            begin
                perform '' ~ filter.value;
            exception when others then
                raise exception 'invalid regular expression for % filter: %', filter.op::text, sqlerrm;
            end;
        else
            -- eq/neq/lt/lte/gt/gte: value must be coercable to the type
            perform realtime.cast(filter.value, col_type);
        end if;
    end loop;

    if new.selected_columns is not null then
        for selected_col in select * from unnest(new.selected_columns) loop
            if not selected_col = any(col_names) then
                raise exception 'invalid column for select %', selected_col;
            end if;
        end loop;
    end if;

    -- Apply consistent order to filters so the unique constraint can't be tricked by a
    -- different filter order. negate is part of the sort key.
    new.filters = coalesce(
        array_agg(f order by f.column_name, f.op, f.value, f.negate),
        '{}'
    ) from unnest(new.filters) f;

    new.selected_columns = (
        select array_agg(c order by c)
        from unnest(new.selected_columns) c
    );

    return new;
end;
$$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO app_user;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO app_user;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO app_user;

--
-- Name: wal2json_escape_identifier(text); Type: FUNCTION; Schema: realtime; Owner: app_user
--

CREATE FUNCTION realtime.wal2json_escape_identifier(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  -- Prefix `\`, `,`, `.`, and any whitespace with `\`
  SELECT regexp_replace(name, '([\\,.[:space:]])', '\\\1', 'g')
$$;


ALTER FUNCTION realtime.wal2json_escape_identifier(name text) OWNER TO app_user;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO app_user;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO app_user;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO app_user;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO app_user;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Get the last path segment (the actual filename)
    SELECT _parts[array_length(_parts, 1)] INTO _filename;
    -- Extract extension: reverse, split on '.', then reverse again
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO app_user;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    RETURN _parts[array_length(_parts, 1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO app_user;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO app_user;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO app_user;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint)::bigint as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO app_user;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO app_user;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO app_user;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO app_user;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO app_user;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_prefix_len INT;
    v_prefix_start INT;
    v_combined_levels INT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_prefix_len := length(coalesce(prefix, ''));
    v_prefix_start := coalesce(array_length(string_to_array(coalesce(prefix, ''), v_delimiter), 1), 1);
    v_combined_levels := coalesce(array_length(string_to_array(v_prefix, v_delimiter), 1), 1);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT array_to_string(path_tokens[$1:$2], '/') AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $3 || '%%'
                  AND bucket_id = $4
                  AND array_length(objects.path_tokens, 1) <> $2
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT array_to_string(path_tokens[$1:$2], '/') AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $3 || '%%'
               AND bucket_id = $4
               AND array_length(objects.path_tokens, 1) = $2
             ORDER BY %I %s)
            LIMIT $5 OFFSET $6
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING v_prefix_start, v_combined_levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := substring(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter) from v_prefix_len + 1);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := substring(v_current.name from v_prefix_len + 1);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO app_user;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
    v_sort_order text;
    v_sort_column text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    -- Defense-in-depth: this function is independently reachable and must
    -- not trust p_sort_order/p_sort_column to already be validated by a
    -- caller. Normalize to the same strict allow-list storage.search_v2
    -- uses before interpolating anything into dynamic SQL below.
    v_sort_order := lower(coalesce(p_sort_order, 'asc'));
    IF v_sort_order NOT IN ('asc', 'desc') THEN
        v_sort_order := 'asc';
    END IF;

    v_sort_column := lower(coalesce(p_sort_column, 'updated_at'));
    IF v_sort_column NOT IN ('updated_at', 'created_at') THEN
        v_sort_column := 'updated_at';
    END IF;

    IF v_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        v_sort_column,
        v_cursor_op,
        v_sort_column,
        v_sort_order,
        v_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO app_user;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO app_user;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: app_user
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO app_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO app_user;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    custom_claims_allowlist text[] DEFAULT '{}'::text[] NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO app_user;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO app_user;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO app_user;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO app_user;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO app_user;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO app_user;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO app_user;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO app_user;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO app_user;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO app_user;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO app_user;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO app_user;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO app_user;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: app_user
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO app_user;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: app_user
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO app_user;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO app_user;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO app_user;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO app_user;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO app_user;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO app_user;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO app_user;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO app_user;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: app_user
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO app_user;

--
-- Name: cash_funds; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.cash_funds (
    id text NOT NULL,
    name text NOT NULL,
    balance double precision DEFAULT 0 NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    initial_capital double precision DEFAULT 0,
    remaining_capital double precision DEFAULT 0,
    total_spent double precision DEFAULT 0,
    total_collected double precision DEFAULT 0,
    notes text,
    rep_names text
);


ALTER TABLE public.cash_funds OWNER TO app_user;

--
-- Name: sales; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.sales (
    id text NOT NULL,
    sale_number text,
    customer_id text,
    customer_name text NOT NULL,
    customer_phone text NOT NULL,
    customer_address text,
    item_id text,
    item_name text NOT NULL,
    item_quantity integer DEFAULT 1,
    purchase_price double precision DEFAULT 0,
    list_id text,
    list_name text,
    total_price double precision NOT NULL,
    advance_payment double precision DEFAULT 0,
    remaining_balance double precision NOT NULL,
    daily_installment double precision NOT NULL,
    start_date text NOT NULL,
    notes text,
    status text DEFAULT 'active'::text NOT NULL,
    last_payment_date text,
    total_paid double precision DEFAULT 0,
    rep_name text,
    created_at text NOT NULL,
    completed_at text,
    updated_at text,
    is_edited boolean DEFAULT false
);


ALTER TABLE public.sales OWNER TO app_user;

--
-- Name: contracts; Type: VIEW; Schema: public; Owner: app_user
--

CREATE VIEW public.contracts AS
 SELECT sales.id,
    sales.customer_id,
    sales.customer_name,
    sales.customer_phone,
    sales.customer_address,
    sales.item_id,
    sales.item_name,
    sales.item_quantity,
    sales.purchase_price,
    sales.list_id,
    sales.list_name,
    sales.total_price,
    sales.advance_payment,
    sales.remaining_balance,
    sales.daily_installment,
    sales.start_date,
    sales.notes,
    sales.status,
    sales.last_payment_date,
    sales.total_paid,
    sales.rep_name,
    sales.created_at,
    sales.completed_at,
    sales.updated_at,
    sales.is_edited
   FROM public.sales;


ALTER VIEW public.contracts OWNER TO app_user;

--
-- Name: customer_lists; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.customer_lists (
    id text NOT NULL,
    name text NOT NULL,
    fund_id text,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT now(),
    color text DEFAULT '#3b82f6'::text
);


ALTER TABLE public.customer_lists OWNER TO app_user;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.customers (
    id text NOT NULL,
    name text NOT NULL,
    phone text,
    address text,
    list_id text,
    list_name text,
    notes text,
    total_purchases double precision DEFAULT 0,
    total_paid double precision DEFAULT 0,
    remaining_balance double precision DEFAULT 0,
    status text DEFAULT 'active'::text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customers OWNER TO app_user;

--
-- Name: deleted_records; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.deleted_records (
    record_id text NOT NULL,
    table_name text NOT NULL,
    deleted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.deleted_records OWNER TO app_user;

--
-- Name: employee_transactions; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.employee_transactions (
    id text NOT NULL,
    employee_id text,
    fund_id text,
    type text,
    amount double precision DEFAULT 0,
    notes text,
    rep_name text,
    created_at text,
    updated_at timestamp with time zone DEFAULT now(),
    note text,
    date text
);


ALTER TABLE public.employee_transactions OWNER TO app_user;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.employees (
    id text NOT NULL,
    name text NOT NULL,
    phone text,
    job_title text,
    "position" text,
    salary double precision DEFAULT 0,
    debt_balance double precision DEFAULT 0,
    total_debt double precision DEFAULT 0,
    is_rep boolean DEFAULT false,
    rep_id text,
    created_at text,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.employees OWNER TO app_user;

--
-- Name: fund_transactions; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.fund_transactions (
    id text NOT NULL,
    fund_id text,
    target_fund_id text,
    type text,
    amount double precision DEFAULT 0,
    note text,
    rep_name text,
    created_at text,
    updated_at timestamp with time zone DEFAULT now(),
    description text
);


ALTER TABLE public.fund_transactions OWNER TO app_user;

--
-- Name: inventory_items; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.inventory_items (
    id text NOT NULL,
    name text NOT NULL,
    price double precision DEFAULT 0 NOT NULL,
    purchase_price double precision DEFAULT 0,
    quantity integer DEFAULT 0 NOT NULL,
    daily_installment double precision DEFAULT 0,
    category text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.inventory_items OWNER TO app_user;

--
-- Name: payment_conflicts; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.payment_conflicts (
    id text NOT NULL,
    contract_id text,
    customer_name text,
    attempted_amount double precision DEFAULT 0,
    actual_remaining_balance double precision DEFAULT 0,
    excess_amount double precision DEFAULT 0,
    rep_name text,
    note text,
    payment_date text,
    created_at text,
    status text DEFAULT 'pending_review'::text,
    resolved_by text,
    resolved_at text,
    resolution_note text,
    accepted_amount double precision DEFAULT 0
);


ALTER TABLE public.payment_conflicts OWNER TO app_user;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.payments (
    id text NOT NULL,
    contract_id text NOT NULL,
    customer_name text NOT NULL,
    amount_paid double precision DEFAULT 0,
    payment_date text NOT NULL,
    rep_name text,
    note text,
    fund_id text,
    updated_at text,
    is_edited boolean DEFAULT false,
    amount double precision DEFAULT 0,
    created_at text
);


ALTER TABLE public.payments OWNER TO app_user;

--
-- Name: reps; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.reps (
    id text NOT NULL,
    name text,
    phone text,
    code text,
    role text DEFAULT 'rep'::text,
    can_edit boolean DEFAULT true,
    can_delete boolean DEFAULT false,
    can_move_customer boolean DEFAULT true,
    can_sell boolean DEFAULT true,
    allowed_list_ids text,
    updated_at timestamp with time zone DEFAULT now(),
    latitude double precision,
    longitude double precision,
    last_location_update text,
    location_address text,
    last_seen text,
    is_online boolean DEFAULT false
);


ALTER TABLE public.reps OWNER TO app_user;

--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: app_user
--

CREATE TABLE public.system_settings (
    key text NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.system_settings OWNER TO app_user;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: app_user
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea,
    skip_broadcast boolean DEFAULT false NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO app_user;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: app_user
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone DEFAULT now()
);


ALTER TABLE realtime.schema_migrations OWNER TO app_user;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: app_user
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    selected_columns text[],
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO app_user;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: app_user
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL,
    versioning_status text DEFAULT 'DISABLED'::text NOT NULL,
    CONSTRAINT buckets_versioning_dark_check CHECK ((versioning_status = 'DISABLED'::text)),
    CONSTRAINT buckets_versioning_standard_only_check CHECK (((type = 'STANDARD'::storage.buckettype) OR (versioning_status = 'DISABLED'::text))),
    CONSTRAINT buckets_versioning_status_check CHECK ((versioning_status = ANY (ARRAY['DISABLED'::text, 'ENABLED'::text, 'SUSPENDED'::text])))
);


ALTER TABLE storage.buckets OWNER TO app_user;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: app_user
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO app_user;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO app_user;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO app_user;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    archived_at timestamp with time zone,
    is_delete_marker boolean DEFAULT false NOT NULL,
    is_versioned boolean DEFAULT false NOT NULL
);


ALTER TABLE storage.objects OWNER TO app_user;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: app_user
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO app_user;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO app_user;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: app_user
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO app_user;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at, custom_claims_allowlist) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
20260625000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: app_user
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: cash_funds; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.cash_funds (id, name, balance, description, created_at, initial_capital, remaining_capital, total_spent, total_collected, notes, rep_names) FROM stdin;
fundtx_1788694391258_ar3lx		0		2026-09-06 11:33:11.259	0	0	0	0	\N	\N
fund-3	صندوق القائمة الاولى	12008000		2026-09-04 18:21:38.863	0	0	0	0	\N	\N
fund_1787350448071_bdhbq	صندوق الديوانية	0		2026-09-04 18:20:13.852	0	0	0	0	\N	\N
fundtx_1788545333848_a15gc	صندوق طويريج	0		2026-09-04 18:15:16.511	0	0	0	0	\N	\N
fund_1787351541464_lqvd8	صندوق كربلاء	0		2026-08-21 22:32:22.201751	0	0	0	0	\N	\N
fund-2	صندوق القائمة الثانية	2635000		2026-09-04 18:19:54.513	0	0	0	0	\N	\N
fund-1	صندوق كربلاء 1	212463000		2026-09-04 18:20:35.204	0	0	0	0	\N	\N
fund_1787350349137_204v6	صندوق كربلاء 3	0		2026-08-21 22:12:29.884654	0	0	0	0	\N	\N
fund-4	صندوق كربلاء 4	0		2026-09-04 18:20:53.845	0	0	0	0	\N	\N
fund_1787350326789_erqgt	صندوق كربلاء 2	0		2026-08-21 22:12:07.489127	0	0	0	0	\N	\N
fund_1787412692389_0x4u5	ماهر 1	0		2026-08-22 15:31:32.391	0	0	0	0	\N	\N
fund_1787350392388_zmj8l	صندوق متوقفين كربلاء	0		2026-08-21 22:13:13.099288	0	0	0	0	\N	\N
fund_1787412701870_5rh61	ماهر 2	0		2026-08-22 15:31:41.87	0	0	0	0	\N	\N
\.


--
-- Data for Name: customer_lists; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.customer_lists (id, name, fund_id, description, created_at, updated_at, color) FROM stdin;
list_1787350121291_e186z	متوقفين كربلاء	fund_1787350392388_zmj8l		2026-08-22 16:44:31.734	2026-08-21 22:08:41.997094+00	#3b82f6
list_1787350092691_n2xzi	طويريج	fundtx_1788545333848_a15gc		2026-09-04 18:13:48.92	2026-08-21 22:08:13.396993+00	#3b82f6
list_1786560962783_50vm6	القائمة الاولى	fund-3		2026-09-04 18:13:38.44	2026-08-26 11:02:02.338685+00	#3b82f6
list-4	قائمة الثانية	fund-2	سجل زبائن محافظة الديوانية	2026-08-21 22:10:57.548	2026-08-18 21:42:58.17985+00	#3b82f6
list-1	كربلاء الأولى	fund-1	سجل زبائن الكرخ والمنصور واليرموك	2026-09-04 18:12:13.16	2026-08-19 06:51:07.67413+00	#3b82f6
list-3	كربلاء الثالث	fund_1787350349137_204v6	سجل زبائن محافظة النجف والأحياء المجاورة	2026-08-21 22:21:32.852	2026-08-19 06:51:07.920873+00	#3b82f6
list-2	كربلاء الاولى	fund-1	سجل زبائن الرصافة والكرادة وزيونة	2026-08-21 22:20:24.937	2026-08-19 06:51:07.428699+00	#3b82f6
list_1787412721284_d7tle	ماهر 1	fund_1787412692389_0x4u5		2026-09-04 18:13:15.207	2026-08-22 16:36:41.668389+00	#3b82f6
list_1787412740241_xj8mp	ماهر 2	fund_1787412701870_5rh61		2026-09-04 18:12:40.043	2026-08-22 16:36:41.676677+00	#3b82f6
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.customers (id, name, phone, address, list_id, list_name, notes, total_purchases, total_paid, remaining_balance, status, created_at) FROM stdin;
cust-6016d9ee91d094fe545d23ea7df0f61f	حسن علي حسن	07805555550		list_1786560962783_50vm6	القائمة الاولى	\N	200000	32000	168000	active	2026-09-05 10:17:03.001253
cust-b1fdab4ae04de9c9de8e170e76b26caf	جبوري حمزه كامل	07805555550		list_1786560962783_50vm6	القائمة الاولى	\N	1700000	0	1700000	active	2026-09-09 07:37:41.836919
cust-00b669ef0a60f7e3080f40869c37c513	عميل تجربة الحذف	07712345678		\N	\N	\N	250000	0	200000	active	2026-09-08 18:03:01.976174
cust-4df11d9524bf1b646257b1e31d52d29f	احمد محمد	07804555888		list_1786560962783_50vm6	القائمة الاولى	\N	200000	0	200000	active	2026-09-06 18:22:09.892472
cust-533330cf7aefe1bb058bd4f4e0e67a08	امير محمد علي	07805555555		list_1786560962783_50vm6	القائمة الاولى	\N	200000	0	200000	active	2026-09-09 07:37:41.836919
cust-95391606f20d3057f4139d0e030cc297	امير احمد عبد	07829899552		list_1786560962783_50vm6	القائمة الاولى	\N	2550000	0	2550000	active	2026-09-08 19:16:18.613665
cust-743e8719e04721cd7128dadf3acfd461	حمودي ضياء	07805555555		list_1786560962783_50vm6	القائمة الاولى	\N	340000	0	340000	active	2026-09-05 10:36:37.374251
cust-d11b04de713434d009aca39ffe70c31d	كمال علي حسين	07800512558		list-1	كربلاء الأولى	\N	4950000	0	4950000	active	2026-09-05 10:37:47.929334
cust-99c80a11d57f21a9519e2c2833045d98	فاطمه نجم عبدالله	07805555555		list-1	كربلاء الأولى	\N	1500000	0	1500000	active	2026-09-05 10:37:47.929334
cust-b82444ae135246fa481294416f27e3d1	كريم عبدالرصا علي	07829899513		list-1	كربلاء الأولى	\N	600000	0	600000	active	2026-09-08 18:23:03.260266
cust-138b40e74198c56fcbc4208cc316db90	حسين نعمه	07829899546		list_1786560962783_50vm6	القائمة الاولى	\N	320000	0	320000	active	2026-09-09 07:20:55.866669
cust-6ede01543ae95042440f7cd886381112	كمال علي حسن	07805555500		list-4	قائمة الثانية	\N	160000	0	160000	active	2026-09-05 10:16:35.88659
cust-f7ead6557c8c9efa95a92b52dbb0eac1	محمد غايب	07805555550		list-1	كربلاء الأولى	\N	850000	0	850000	active	2026-09-05 10:36:37.374251
\.


--
-- Data for Name: deleted_records; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.deleted_records (record_id, table_name, deleted_at) FROM stdin;
pay_1788610116912_tz170	unknown	2026-09-06 09:47:45.534817
pay_1788610118565_9j4e3	unknown	2026-09-06 09:47:45.534817
pay_1788610120072_emsot	unknown	2026-09-06 09:47:45.534817
pay_1788610123917_5ukw3	unknown	2026-09-06 09:47:45.534817
pay_1788610125238_suiq4	unknown	2026-09-06 09:47:45.534817
pay_1788610127329_q61we	unknown	2026-09-06 09:47:45.534817
pay_1788610128785_av9ld	unknown	2026-09-06 09:47:45.534817
pay_1788610133249_u3whp	unknown	2026-09-06 09:47:45.534817
pay_1788610135858_gayme	unknown	2026-09-06 09:47:45.534817
pay_1788610140625_mqdyj	unknown	2026-09-06 09:47:45.534817
pay_1788610145360_0wyu8	unknown	2026-09-06 09:47:45.534817
pay_1788610148036_yke1v	unknown	2026-09-06 09:47:45.534817
pay_1788607284626_1keez	unknown	2026-09-06 09:47:45.534817
pay_1788607286663_6dq5g	unknown	2026-09-06 09:47:45.534817
pay_1788607288069_8m7z0	unknown	2026-09-06 09:47:45.534817
pay_1788607290043_x8lti	unknown	2026-09-06 09:47:45.534817
pay_1788607295298_odjnf	unknown	2026-09-06 09:47:45.534817
pay_1788607299157_tfjpq	unknown	2026-09-06 09:47:45.534817
pay_1788607306954_jhd77	unknown	2026-09-06 09:47:45.534817
pay_1788607309026_gfnd0	unknown	2026-09-06 09:47:45.534817
pay_1788607310151_as9cb	unknown	2026-09-06 09:47:45.534817
pay_1788605630611_in9so	unknown	2026-09-06 09:47:45.534817
pay_1788605633863_ubyjg	unknown	2026-09-06 09:47:45.534817
pay_1788605635218_7brmf	unknown	2026-09-06 09:47:45.534817
pay_1788605636341_f1i4a	unknown	2026-09-06 09:47:45.534817
pay_1788605638178_fh5yh	unknown	2026-09-06 09:47:45.534817
pay_1788605639319_yqkzn	unknown	2026-09-06 09:47:45.534817
pay_1788605640871_ykg0h	unknown	2026-09-06 09:47:45.534817
pay_1788605644634_t86fv	unknown	2026-09-06 09:47:45.534817
pay_1788605646580_l5vmn	unknown	2026-09-06 09:47:45.534817
pay_1788605649469_3eoak	unknown	2026-09-06 09:47:45.534817
pay_1788605650772_kp2ow	unknown	2026-09-06 09:47:45.534817
pay_1788605652134_7ml1b	unknown	2026-09-06 09:47:45.534817
pay_1788605655640_msehn	unknown	2026-09-06 09:47:45.534817
pay_1788605656978_1xxob	unknown	2026-09-06 09:47:45.534817
pay_1788605666847_6vzey	unknown	2026-09-06 09:47:45.534817
pay_1788605669640_osgyp	unknown	2026-09-06 09:47:45.534817
pay_1788605672466_i9x2y	unknown	2026-09-06 09:47:45.534817
pay_1788605673854_g8bym	unknown	2026-09-06 09:47:45.534817
pay_1788605675493_g1gal	unknown	2026-09-06 09:47:45.534817
pay_1788605676648_nvpwd	unknown	2026-09-06 09:47:45.534817
pay_1788605679125_hitei	unknown	2026-09-06 09:47:45.534817
pay_1788605686517_dr7d6	unknown	2026-09-06 09:47:45.534817
pay_1788464802794_80zmf	unknown	2026-09-06 09:47:45.534817
pay_1788351959593_ot8zc	unknown	2026-09-06 09:47:45.534817
pay_1788351976421_zhfm8	unknown	2026-09-06 09:47:45.534817
pay_1788351849031_vbt3d	unknown	2026-09-06 09:47:45.534817
pay_1788348036755_1u4y8	unknown	2026-09-06 09:47:45.534817
pay_1788346770769_kevtp	unknown	2026-09-06 09:47:45.534817
pay_1788465334459_4pkmz	unknown	2026-09-06 09:47:45.534817
pay_1788465337833_rimtv	unknown	2026-09-06 09:47:45.534817
pay_1788465372806_s2fw5	unknown	2026-09-06 09:47:45.534817
pay_1788465375300_fbdmn	unknown	2026-09-06 09:47:45.534817
pay_1788465368947_zp0jb	unknown	2026-09-06 09:47:45.534817
pay_1788465376521_zf9ki	unknown	2026-09-06 09:47:45.534817
pay_1788465377743_3zwr8	unknown	2026-09-06 09:47:45.534817
pay_1788465408216_cf0g7	unknown	2026-09-06 09:47:45.534817
pay_1788465405338_25gtk	unknown	2026-09-06 09:47:45.534817
pay_1788465347317_j2rzk	unknown	2026-09-06 09:47:45.534817
pay_1788465415629_blxdm	unknown	2026-09-06 09:47:45.534817
pay_1788465431565_ibto6	unknown	2026-09-06 09:47:45.534817
pay_1788465427018_v9s4f	unknown	2026-09-06 09:47:45.534817
pay_1788465432972_bfy5k	unknown	2026-09-06 09:47:45.534817
pay_1788465443556_rkaqi	unknown	2026-09-06 09:47:45.534817
pay_1788465441350_oskr8	unknown	2026-09-06 09:47:45.534817
pay_1788465448242_qmh95	unknown	2026-09-06 09:47:45.534817
pay_1788465445897_3d7ez	unknown	2026-09-06 09:47:45.534817
pay_1788465450514_89lwm	unknown	2026-09-06 09:47:45.534817
pay_1788468344496_pms3e	unknown	2026-09-06 09:47:45.534817
pay_1788468358229_ejg2q	unknown	2026-09-06 09:47:45.534817
pay_1788466538295_iwfal	unknown	2026-09-06 09:47:45.534817
pay_1788468352152_dx2rd	unknown	2026-09-06 09:47:45.534817
pay_1788468362060_54c9n	unknown	2026-09-06 09:47:45.534817
pay_1788466391811_ig74j	unknown	2026-09-06 09:47:45.534817
pay_1788468369360_z429v	unknown	2026-09-06 09:47:45.534817
pay_1788468365796_pb385	unknown	2026-09-06 09:47:45.534817
pay_1788468372111_5ls9e	unknown	2026-09-06 09:47:45.534817
pay_1788468383852_xr750	unknown	2026-09-06 09:47:45.534817
pay_1788468386565_wz5hc	unknown	2026-09-06 09:47:45.534817
pay_1788468388958_pqvx9	unknown	2026-09-06 09:47:45.534817
pay_1788468398874_97rv0	unknown	2026-09-06 09:47:45.534817
pay_1788468374475_7bfz1	unknown	2026-09-06 09:47:45.534817
pay_1788468376862_tga3d	unknown	2026-09-06 09:47:45.534817
pay_1788468381010_resn1	unknown	2026-09-06 09:47:45.534817
pay_1788468401733_x0d3c	unknown	2026-09-06 09:47:45.534817
pay_1788468409661_3tunl	unknown	2026-09-06 09:47:45.534817
b-pay-1	unknown	2026-09-06 09:47:45.534817
pay_1788525459590_rad1r	unknown	2026-09-06 09:47:45.534817
pay_1788525465767_y2rf6	unknown	2026-09-06 09:47:45.534817
pay_1788525484504_xvhj1	unknown	2026-09-06 09:47:45.534817
pay_1788525489203_b12c8	unknown	2026-09-06 09:47:45.534817
pay_1788525506499_t72hg	unknown	2026-09-06 09:47:45.534817
pay_1788525511583_sn20m	unknown	2026-09-06 09:47:45.534817
pay_1788525526003_ry5yw	unknown	2026-09-06 09:47:45.534817
pay_1788525528748_lsgr2	unknown	2026-09-06 09:47:45.534817
pay_1788525532093_sz22w	unknown	2026-09-06 09:47:45.534817
pay_1788525542770_tlcol	unknown	2026-09-06 09:47:45.534817
pay_1788525548917_e04kq	unknown	2026-09-06 09:47:45.534817
pay_1788525562865_txayt	unknown	2026-09-06 09:47:45.534817
pay_1788525572037_telk1	unknown	2026-09-06 09:47:45.534817
pay_1788468675036_duxlf	unknown	2026-09-06 09:47:45.534817
pay_1788468795482_a61xw	unknown	2026-09-06 09:47:45.534817
pay_1788468682161_e7aem	unknown	2026-09-06 09:47:45.534817
pay_1788524751203_oubk4	unknown	2026-09-06 09:47:45.534817
pay_1788524749230_vghfj	unknown	2026-09-06 09:47:45.534817
pay_1788524752961_4lds9	unknown	2026-09-06 09:47:45.534817
pay_1787340435683_s6mrz	unknown	2026-09-06 09:47:45.534817
pay_1787339440168_gymh5	unknown	2026-09-06 09:47:45.534817
pay_1787339425755_51y50	unknown	2026-09-06 09:47:45.534817
pay_1787339205110_j2zrx	unknown	2026-09-06 09:47:45.534817
pay_1787339110430_73db9	unknown	2026-09-06 09:47:45.534817
pay_1787339107269_93cu3	unknown	2026-09-06 09:47:45.534817
pay_1787339103958_5zzq5	unknown	2026-09-06 09:47:45.534817
pay_1787339052156_trfjs	unknown	2026-09-06 09:47:45.534817
pay_1787339043745_w5drm	unknown	2026-09-06 09:47:45.534817
pay_1787338820986_rn8nv	unknown	2026-09-06 09:47:45.534817
pay_1787338810667_1vql5	unknown	2026-09-06 09:47:45.534817
pay_1787338763315_pk3g3	unknown	2026-09-06 09:47:45.534817
pay_1787338757177_dxdxa	unknown	2026-09-06 09:47:45.534817
pay_1787338693655_mygs8	unknown	2026-09-06 09:47:45.534817
pay_1787338668699_uovon	unknown	2026-09-06 09:47:45.534817
pay_1787338594017_fvy5u	unknown	2026-09-06 09:47:45.534817
pay_1787338535962_0bze5	unknown	2026-09-06 09:47:45.534817
pay_1787338003467_veuvf	unknown	2026-09-06 09:47:45.534817
pay_1787332240229_yem9h	unknown	2026-09-06 09:47:45.534817
pay_1787322739233_7n7jy	unknown	2026-09-06 09:47:45.534817
pay_1787322682816_zugaj	unknown	2026-09-06 09:47:45.534817
pay_1787320777803_vbawy	unknown	2026-09-06 09:47:45.534817
pay_1787302965706_ok21i	unknown	2026-09-06 09:47:45.534817
pay_1787247161602_5qos6	unknown	2026-09-06 09:47:45.534817
pay_1787247157209_j7q6h	unknown	2026-09-06 09:47:45.534817
pay_1787243801433_r5to5	unknown	2026-09-06 09:47:45.534817
pay_1787243797838_p8td8	unknown	2026-09-06 09:47:45.534817
pay_1787243647739_0tj7s	unknown	2026-09-06 09:47:45.534817
pay_1787243644125_buxt5	unknown	2026-09-06 09:47:45.534817
pay_1787486823594_mf6su	unknown	2026-09-06 09:47:45.534817
pay_1787595713750_cdtu6	unknown	2026-09-06 09:47:45.534817
pay_1788262216493_1n5j4	unknown	2026-09-06 09:47:45.534817
pay_1788262157510_971x8	unknown	2026-09-06 09:47:45.534817
pay_1788262108504_oqixt	unknown	2026-09-06 09:47:45.534817
pay_1788262095657_p7950	unknown	2026-09-06 09:47:45.534817
pay_1788262090672_o7ea8	unknown	2026-09-06 09:47:45.534817
pay_1788262081695_bqvjq	unknown	2026-09-06 09:47:45.534817
pay_1788262039425_892v7	unknown	2026-09-06 09:47:45.534817
pay_1788262021894_61fhp	unknown	2026-09-06 09:47:45.534817
pay_1788261965627_evg8l	unknown	2026-09-06 09:47:45.534817
pay_1788261956014_7091x	unknown	2026-09-06 09:47:45.534817
pay_1788261942078_khcya	unknown	2026-09-06 09:47:45.534817
pay_1788261937779_c9c1z	unknown	2026-09-06 09:47:45.534817
pay_1788261928738_9xi5w	unknown	2026-09-06 09:47:45.534817
pay_1788261893221_1sq7v	unknown	2026-09-06 09:47:45.534817
pay_1788261881499_rny1d	unknown	2026-09-06 09:47:45.534817
pay_1788261685172_6hyc6	unknown	2026-09-06 09:47:45.534817
pay_1788261243301_c02xa	unknown	2026-09-06 09:47:45.534817
pay_1788257855533_mjczw	unknown	2026-09-06 09:47:45.534817
pay_1788211073650_d443s	unknown	2026-09-06 09:47:45.534817
pay_1788210267351_wjxa5	unknown	2026-09-06 09:47:45.534817
pay_1788210258697_sneaw	unknown	2026-09-06 09:47:45.534817
pay_1788210102539_nd9ex	unknown	2026-09-06 09:47:45.534817
pay_1788209919958_6g9bx	unknown	2026-09-06 09:47:45.534817
pay_1788207093347_3dna8	unknown	2026-09-06 09:47:45.534817
pay_1788193541412_shidm	unknown	2026-09-06 09:47:45.534817
pay_1788193363279_nult0	unknown	2026-09-06 09:47:45.534817
pay_1788192959253_qpq2x	unknown	2026-09-06 09:47:45.534817
pay_1788177474027_sbj83	unknown	2026-09-06 09:47:45.534817
pay_1788177321335_3xgcb	unknown	2026-09-06 09:47:45.534817
pay_1788177267506_7abi8	unknown	2026-09-06 09:47:45.534817
pay_1788177262090_38exk	unknown	2026-09-06 09:47:45.534817
pay_1788176175626_9amnc	unknown	2026-09-06 09:47:45.534817
pay_1788175788790_ags9d	unknown	2026-09-06 09:47:45.534817
pay_1788133691278_6eeoz	unknown	2026-09-06 09:47:45.534817
pay_1787993506671_htptg	unknown	2026-09-06 09:47:45.534817
pay_1788280265999_jbqrr	unknown	2026-09-06 09:47:45.534817
pay_1788280133099_5q1sz	unknown	2026-09-06 09:47:45.534817
pay_1788280069835_867eu	unknown	2026-09-06 09:47:45.534817
pay_1788280257509_4966i	unknown	2026-09-06 09:47:45.534817
pay_1788280284773_csykx	unknown	2026-09-06 09:47:45.534817
pay_1788280366213_s1ame	unknown	2026-09-06 09:47:45.534817
pay_1788280373013_m2a0g	unknown	2026-09-06 09:47:45.534817
pay_1788271422778_652s2	unknown	2026-09-06 09:47:45.534817
pay_1788271424535_mizul	unknown	2026-09-06 09:47:45.534817
pay_1788271426057_deyo9	unknown	2026-09-06 09:47:45.534817
pay_1788271480701_8sjl0	unknown	2026-09-06 09:47:45.534817
pay_1788273330223_zyr9x	unknown	2026-09-06 09:47:45.534817
pay_1788274749552_76ao7	unknown	2026-09-06 09:47:45.534817
pay_1788274752518_1rwvs	unknown	2026-09-06 09:47:45.534817
contract_1788266877551_940py	unknown	2026-09-06 09:47:45.534817
pay_1788266408333_wkkrr	unknown	2026-09-06 09:47:45.534817
pay_1788271431861_9vlrb	unknown	2026-09-06 09:47:45.534817
pay_1788271433701_59qld	unknown	2026-09-06 09:47:45.534817
pay_1788274836574_6zrn9	unknown	2026-09-06 09:47:45.534817
contract_1787993424348_8ixxj	unknown	2026-09-06 09:47:45.534817
pay_1788271259289_ur638	unknown	2026-09-06 09:47:45.534817
pay_1788271337363_ynryk	unknown	2026-09-06 09:47:45.534817
pay_1788265528731_f9ge0	unknown	2026-09-06 09:47:45.534817
pay_1788265534981_jei94	unknown	2026-09-06 09:47:45.534817
pay_1788265540702_gaw5o	unknown	2026-09-06 09:47:45.534817
pay_1788204211400_zujy8	unknown	2026-09-06 09:47:45.534817
pay_1788205340237_38z8q	unknown	2026-09-06 09:47:45.534817
pay_1788204769922_8azu9	unknown	2026-09-06 09:47:45.534817
pay_1788204467753_s38ke	unknown	2026-09-06 09:47:45.534817
pay_1788204224656_8lpuc	unknown	2026-09-06 09:47:45.534817
pay_1788204131665_umo7d	unknown	2026-09-06 09:47:45.534817
pay_1788204007664_sog6g	unknown	2026-09-06 09:47:45.534817
pay_1788202971506_jvs61	unknown	2026-09-06 09:47:45.534817
pay_1788199057491_wvif9	unknown	2026-09-06 09:47:45.534817
pay_1788198521563_33ikd	unknown	2026-09-06 09:47:45.534817
pay_1788198913973_v0s0m	unknown	2026-09-06 09:47:45.534817
__all_contracts_cleared__	unknown	2026-09-06 09:47:45.534817
rep-1	unknown	2026-09-06 09:47:45.534817
rep_1787351097051_174k1	unknown	2026-09-06 09:47:45.534817
test-pay-2	unknown	2026-09-06 09:47:45.534817
test-pay-1	unknown	2026-09-06 09:47:45.534817
pay_1788464421408_juam1	unknown	2026-09-06 09:47:45.534817
pay_1788464146337_pv7m2	unknown	2026-09-06 09:47:45.534817
pay_1788464366468_ns0cd	unknown	2026-09-06 09:47:45.534817
pay_1788464238398_zhcsh	unknown	2026-09-06 09:47:45.534817
pay_1788464409202_mmru1	unknown	2026-09-06 09:47:45.534817
pay_1788464502362_sz94g	unknown	2026-09-06 09:47:45.534817
pay_1788464498951_g9f4q	unknown	2026-09-06 09:47:45.534817
pay_1788464500958_uaxb0	unknown	2026-09-06 09:47:45.534817
pay_1788464752618_ftqx7	unknown	2026-09-06 09:47:45.534817
pay_1788464754842_09t3k	unknown	2026-09-06 09:47:45.534817
pay_1788464758605_pa23g	unknown	2026-09-06 09:47:45.534817
pay_1788464757032_mju9m	unknown	2026-09-06 09:47:45.534817
pay_1788464760032_o012x	unknown	2026-09-06 09:47:45.534817
pay_1788464761249_rcdnh	unknown	2026-09-06 09:47:45.534817
pay_1788464762518_xo5kd	unknown	2026-09-06 09:47:45.534817
pay_1788464763683_p339m	unknown	2026-09-06 09:47:45.534817
pay_1788464765080_3us6a	unknown	2026-09-06 09:47:45.534817
pay_1788464804054_pqory	unknown	2026-09-06 09:47:45.534817
pay_1788464805504_vohmk	unknown	2026-09-06 09:47:45.534817
pay_1788464807076_bwj2q	unknown	2026-09-06 09:47:45.534817
pay_test_999	unknown	2026-09-06 09:47:45.534817
pay_1788433894101_qspm9	unknown	2026-09-06 09:47:45.534817
pay_1788347096991_zdzmh	unknown	2026-09-06 09:47:45.534817
pay_1788525698019_u07op	unknown	2026-09-06 09:47:45.534817
pay_1788525701370_7p16t	unknown	2026-09-06 09:47:45.534817
pay_1788525705253_1v4xm	unknown	2026-09-06 09:47:45.534817
pay_1788525722645_5qrg3	unknown	2026-09-06 09:47:45.534817
pay_1788525725071_7n34e	unknown	2026-09-06 09:47:45.534817
pay_1788525726207_9xgyw	unknown	2026-09-06 09:47:45.534817
pay_1788525727332_rx37m	unknown	2026-09-06 09:47:45.534817
pay_1788525728449_5388f	unknown	2026-09-06 09:47:45.534817
pay_1788525729574_wqr39	unknown	2026-09-06 09:47:45.534817
pay_1788525730627_ofy3e	unknown	2026-09-06 09:47:45.534817
pay_1788525731698_usux9	unknown	2026-09-06 09:47:45.534817
pay_1788525732847_6cv0z	unknown	2026-09-06 09:47:45.534817
pay_1788525735941_s2hi5	unknown	2026-09-06 09:47:45.534817
pay_1788525737279_pdkzt	unknown	2026-09-06 09:47:45.534817
pay_1788525738467_1qalq	unknown	2026-09-06 09:47:45.534817
pay_1788525739609_5i68f	unknown	2026-09-06 09:47:45.534817
pay_1788525740792_0gkzu	unknown	2026-09-06 09:47:45.534817
pay_1788525742031_b51ii	unknown	2026-09-06 09:47:45.534817
pay_1788525743603_2089p	unknown	2026-09-06 09:47:45.534817
pay_1788525745242_65rno	unknown	2026-09-06 09:47:45.534817
pay_1788525746580_n8lws	unknown	2026-09-06 09:47:45.534817
pay_1788525747912_132bd	unknown	2026-09-06 09:47:45.534817
pay_1788525753921_9qazc	unknown	2026-09-06 09:47:45.534817
pay_1788525759242_3jh9o	unknown	2026-09-06 09:47:45.534817
pay_1788525761487_abn08	unknown	2026-09-06 09:47:45.534817
pay_1788525766762_n5h0y	unknown	2026-09-06 09:47:45.534817
pay_1788525776686_v1b6r	unknown	2026-09-06 09:47:45.534817
pay_1788531037207_pdjae	unknown	2026-09-06 09:47:45.534817
pay_1788531039306_rmjuw	unknown	2026-09-06 09:47:45.534817
pay_1788531041030_dvc03	unknown	2026-09-06 09:47:45.534817
pay_1788531044792_fulxb	unknown	2026-09-06 09:47:45.534817
pay_1788531046081_ud7wz	unknown	2026-09-06 09:47:45.534817
pay_1788531048992_a3gj2	unknown	2026-09-06 09:47:45.534817
pay_1788531050262_rl7qx	unknown	2026-09-06 09:47:45.534817
pay_1788531051484_f5skx	unknown	2026-09-06 09:47:45.534817
pay_1788531053841_rl4j8	unknown	2026-09-06 09:47:45.534817
pay_1788531055097_qwz3b	unknown	2026-09-06 09:47:45.534817
pay_1788531056369_0xwid	unknown	2026-09-06 09:47:45.534817
pay_1788531060883_0ri73	unknown	2026-09-06 09:47:45.534817
pay_1788531062388_oiu0x	unknown	2026-09-06 09:47:45.534817
pay_1788531064428_bolx9	unknown	2026-09-06 09:47:45.534817
pay_1788531065820_nveof	unknown	2026-09-06 09:47:45.534817
pay_1788531067188_j3zvh	unknown	2026-09-06 09:47:45.534817
pay_1788531072223_roxkg	unknown	2026-09-06 09:47:45.534817
pay_1788531076838_pn61b	unknown	2026-09-06 09:47:45.534817
pay_1788531078062_aay5w	unknown	2026-09-06 09:47:45.534817
pay_1788531079265_kxqw5	unknown	2026-09-06 09:47:45.534817
pay_1788531080391_glx3f	unknown	2026-09-06 09:47:45.534817
pay_1788531091397_o2f0m	unknown	2026-09-06 09:47:45.534817
pay_1788531093750_hdea2	unknown	2026-09-06 09:47:45.534817
pay_1788531094885_95727	unknown	2026-09-06 09:47:45.534817
pay_1788531095958_6l0xy	unknown	2026-09-06 09:47:45.534817
pay_1788531102483_20m7v	unknown	2026-09-06 09:47:45.534817
pay_1788541144347_s5f0f	unknown	2026-09-06 09:47:45.534817
pay_1788541147000_xbold	unknown	2026-09-06 09:47:45.534817
pay_1788541148639_sh5l0	unknown	2026-09-06 09:47:45.534817
pay_1788541150529_a5z69	unknown	2026-09-06 09:47:45.534817
pay_1788543289318_f0xxz	unknown	2026-09-06 09:47:45.534817
pay_1788545284947_a46tb	unknown	2026-09-06 09:47:45.534817
pay_1788546115978_wp6lz	unknown	2026-09-06 09:47:45.534817
pay_1788546134377_se3dy	unknown	2026-09-06 09:47:45.534817
pay_1788573147666_05y46	unknown	2026-09-06 09:47:45.534817
pay_1788613861637_3fu4k	unknown	2026-09-06 09:47:45.534817
pay_1788613881990_te535	unknown	2026-09-06 09:47:45.534817
pay_1788613879567_q2jel	unknown	2026-09-06 09:47:45.534817
pay_1788613864580_r5ssv	unknown	2026-09-06 09:47:45.534817
pay_1788613863191_rix8n	unknown	2026-09-06 09:47:45.534817
pay_1788613866402_uf0ct	unknown	2026-09-06 09:47:45.534817
pay_1788613877194_b88f6	unknown	2026-09-06 09:47:45.534817
pay_1788613868787_dwhv1	unknown	2026-09-06 09:47:45.534817
pay_1788613867590_psbgr	unknown	2026-09-06 09:47:45.534817
pay_1788613873024_c61yo	unknown	2026-09-06 09:47:45.534817
pay_1788613875924_f7can	unknown	2026-09-06 09:47:45.534817
pay_1788613871857_zanqz	unknown	2026-09-06 09:47:45.534817
pay_1788613880819_7ijb0	unknown	2026-09-06 09:47:45.534817
pay_1788613870636_uclqm	unknown	2026-09-06 09:47:45.534817
pay_1788613874748_wrbzj	unknown	2026-09-06 09:47:45.534817
pay_1788613883734_ohm02	unknown	2026-09-06 09:47:45.534817
pay_1788613884870_spaoi	unknown	2026-09-06 09:47:45.534817
pay_1788613885956_vmc1i	unknown	2026-09-06 09:47:45.534817
pay_1788655444783_ow3xr	unknown	2026-09-06 09:47:45.534817
pay_1788655520162_19fs8	unknown	2026-09-06 09:47:45.534817
pay_1788655522093_neg7w	unknown	2026-09-06 09:47:45.534817
pay_1788655447069_c0vk4	unknown	2026-09-06 09:47:45.534817
pay_1788655501763_lm6bn	unknown	2026-09-06 09:47:45.534817
pay_1788655525637_zuag7	unknown	2026-09-06 09:47:45.534817
pay_1788655524192_dxs72	unknown	2026-09-06 09:47:45.534817
pay_1788655503803_2swto	unknown	2026-09-06 09:47:45.534817
pay_1788655526910_mpaml	unknown	2026-09-06 09:47:45.534817
pay_1788655528192_05pu4	unknown	2026-09-06 09:47:45.534817
pay_1788655530883_041ru	unknown	2026-09-06 09:47:45.534817
pay_1788655529546_7rphq	unknown	2026-09-06 09:47:45.534817
pay_1788688415149_sojhu	payments	2026-09-06 11:12:39.204253
pay_1788688411192_tgybm	payments	2026-09-06 11:12:39.707866
pay_1788688416056_ws9e8	payments	2026-09-06 11:12:39.71926
pay_1788688408141_ak5uc	payments	2026-09-06 11:12:39.958261
pay_1788688412141_9xb26	payments	2026-09-06 11:12:39.969162
pay_1788688380205_4tsrq	payments	2026-09-06 11:12:40.207713
pay_1788688386066_llssw	payments	2026-09-06 11:12:40.22062
pay_1788688414215_96wn9	payments	2026-09-06 11:12:40.37631
pay_1788688413183_cenrx	payments	2026-09-06 11:12:41.078386
pay_1788688407118_6xw5v	payments	2026-09-06 11:12:41.153898
pay_1788688405162_encjt	payments	2026-09-06 11:12:41.339275
pay_1788688401167_3rkqp	payments	2026-09-06 11:12:41.40644
pay_1788688409183_ku83c	payments	2026-09-06 11:12:41.45641
pay_1788688397989_9zol6	payments	2026-09-06 11:12:41.658238
pay_1788688402191_g6mu1	payments	2026-09-06 11:12:41.706021
pay_1788688400134_wa6fw	payments	2026-09-06 11:12:41.838016
pay_1788688406119_s6fpr	payments	2026-09-06 11:12:42.174217
pay_1788688399076_a5uus	payments	2026-09-06 11:12:42.182087
pay_1788688384892_oyi4s	payments	2026-09-06 11:12:42.427557
pay_1788688388252_dpmuo	payments	2026-09-06 11:12:42.427908
pay_1788688394711_o45xq	payments	2026-09-06 11:12:42.602667
pay_1788688389310_055f3	payments	2026-09-06 11:12:42.605034
pay_1788688383442_ledvj	payments	2026-09-06 11:12:42.674018
pay_1788688403207_luwmu	payments	2026-09-06 11:12:42.879665
pay_1788688378039_4j66r	payments	2026-09-06 11:12:42.881292
pay_1788688392505_8pjdz	payments	2026-09-06 11:12:43.132255
pay_1788688374810_r7zx1	payments	2026-09-06 11:12:43.384312
pay_1788688395880_743og	payments	2026-09-06 11:12:43.412948
pay_1788688396973_yqmfq	payments	2026-09-06 11:12:43.415637
pay_1788688387191_nq04p	payments	2026-09-06 11:12:43.747715
pay_1788688371593_rpem1	payments	2026-09-06 11:12:44.398217
pay_1788688364872_e2toh	payments	2026-09-06 11:12:44.644033
pay_1788688368333_85lni	payments	2026-09-06 11:12:44.889794
pay_1788688360977_mp6hf	payments	2026-09-06 11:12:45.418109
pay_1788688347828_qkxn8	payments	2026-09-06 11:12:45.471132
pay_1788688363733_7wtg7	payments	2026-09-06 11:12:45.975599
pay_1788688382352_1nm6x	payments	2026-09-06 11:12:45.997306
pay_1788688345777_nc5sq	payments	2026-09-06 11:12:46.745799
pay_1788688344744_hgmko	payments	2026-09-06 11:12:47.238112
pay_1788688323763_n2pyk	payments	2026-09-06 11:12:47.743906
pay_1788688352045_ldusm	payments	2026-09-06 11:12:47.994872
pay_1788688340499_muft9	payments	2026-09-06 11:12:48.20992
pay_1788688312617_j6zcp	payments	2026-09-06 11:12:48.246551
pay_1788688346807_9x6g5	payments	2026-09-06 11:12:48.342768
pay_1788688335321_f67t1	payments	2026-09-06 11:12:48.492576
pay_1788688328450_r5u5p	payments	2026-09-06 11:12:49.002586
pay_1788688311333_jqvg8	payments	2026-09-06 11:12:49.209139
pay_1788688327274_1yk66	payments	2026-09-06 11:12:49.326445
pay_1788688339413_xdpow	payments	2026-09-06 11:12:49.506501
pay_1788688313840_cuydj	payments	2026-09-06 11:12:49.572494
pay_1788688322595_suqxf	payments	2026-09-06 11:12:49.711246
pay_1788688317339_zsygo	payments	2026-09-06 11:12:50.065055
pay_1788688319046_udyfo	payments	2026-09-06 11:12:50.212289
pay_1788688348901_rapqn	payments	2026-09-06 11:12:50.21455
pay_1788688298802_54kbt	payments	2026-09-06 11:12:51.273354
pay_1788688296148_69zh8	payments	2026-09-06 11:12:51.466254
pay_1788688300072_dz72d	payments	2026-09-06 11:12:51.474312
pay_1788688288849_q3unr	payments	2026-09-06 11:12:51.487249
pay_1788688116962_5kw90	payments	2026-09-06 11:12:51.525427
pay_1788688304912_v9ybx	payments	2026-09-06 11:12:51.540889
pay_1788688306048_gg6o4	payments	2026-09-06 11:12:53.256365
pay_1788688381282_f1vv0	payments	2026-09-06 11:12:43.44544
pay_1788688390361_5t08n	payments	2026-09-06 11:12:43.906675
pay_1788688379181_c9jaz	payments	2026-09-06 11:12:43.957627
pay_1788688410184_9103y	payments	2026-09-06 11:12:44.159159
pay_1788688391420_e139o	payments	2026-09-06 11:12:44.203726
pay_1788688358766_c1wwt	payments	2026-09-06 11:12:44.704689
pay_1788688366077_1svwh	payments	2026-09-06 11:12:44.714476
pay_1788688372631_dcuh1	payments	2026-09-06 11:12:44.954361
pay_1788688353032_yk19n	payments	2026-09-06 11:12:44.997309
pay_1788688370512_fufai	payments	2026-09-06 11:12:45.166308
pay_1788688369428_55bm6	payments	2026-09-06 11:12:45.204006
pay_1788688367252_bcuey	payments	2026-09-06 11:12:45.218592
pay_1788688356589_9f1n0	payments	2026-09-06 11:12:45.383974
pay_1788688351074_hg3nl	payments	2026-09-06 11:12:46.122018
pay_1788688362562_42gbu	payments	2026-09-06 11:12:46.227762
pay_1788688373672_y07mv	payments	2026-09-06 11:12:46.246376
pay_1788688349937_qg17r	payments	2026-09-06 11:12:46.683984
pay_1788688404184_gtbyr	payments	2026-09-06 11:12:46.708518
pay_1788688341554_kki4i	payments	2026-09-06 11:12:47.209357
pay_1788688325965_izbyx	payments	2026-09-06 11:12:47.948212
pay_1788688330772_vduy3	payments	2026-09-06 11:12:48.095819
pay_1788688329617_536kz	payments	2026-09-06 11:12:48.199946
pay_1788688337460_shgty	payments	2026-09-06 11:12:48.709485
pay_1788688331971_gmlai	payments	2026-09-06 11:12:48.751135
pay_1788688320262_8ykhj	payments	2026-09-06 11:12:48.83508
pay_1788688315027_hqi8q	payments	2026-09-06 11:12:48.95946
pay_1788688334233_yuc3i	payments	2026-09-06 11:12:49.080657
pay_1788688342628_0207w	payments	2026-09-06 11:12:49.460095
pay_1788688316208_a88vt	payments	2026-09-06 11:12:49.491559
pay_1788688333157_3ipoz	payments	2026-09-06 11:12:49.740593
pay_1788688321468_ygeek	payments	2026-09-06 11:12:49.758571
pay_1788688309962_rbonu	payments	2026-09-06 11:12:49.962314
pay_1788688324846_9ekyu	payments	2026-09-06 11:12:50.557204
pay_1788688303737_zod9w	payments	2026-09-06 11:12:51.295585
pay_1788688302552_b6mqk	payments	2026-09-06 11:12:51.715969
pay_1788688286375_flwol	payments	2026-09-06 11:12:51.725769
pay_1788688297514_kadmt	payments	2026-09-06 11:12:51.735954
pay_1788688307188_cy19p	payments	2026-09-06 11:12:51.777528
pay_1788688308387_tte7h	payments	2026-09-06 11:12:51.786365
pay_1788688290238_iu8va	payments	2026-09-06 11:12:51.984733
pay_1788688301329_cc00y	payments	2026-09-06 11:12:52.029292
pay_1788688375929_nmanm	payments	2026-09-06 11:12:47.188145
pay_1788688343729_h80pw	payments	2026-09-06 11:12:47.459552
pay_1788688336405_wun3a	payments	2026-09-06 11:12:47.742557
pay_1788699729325_axw67	unknown	2026-09-06 13:03:44.476753
pay_1788699544588_4s2o4	unknown	2026-09-06 13:03:44.476753
pay_1788699507971_641ol	unknown	2026-09-06 13:03:44.476753
pay_1788699462546_4nojx	unknown	2026-09-06 13:03:44.476753
pay_1788698124408_2uyf7	unknown	2026-09-06 13:03:44.476753
pay_1788698096883_zn903	unknown	2026-09-06 13:03:44.476753
pay_1788697355066_abklr	unknown	2026-09-06 13:03:44.476753
pay_1788696950519_opli8	unknown	2026-09-06 13:03:44.476753
pay_1788696692977_eqnor	unknown	2026-09-06 13:03:44.476753
pay_1788696646096_ibv5f	unknown	2026-09-06 13:03:44.476753
pay_1788696636514_l4ool	unknown	2026-09-06 13:03:44.476753
pay_1788696517498_3k0o2	unknown	2026-09-06 13:03:44.476753
pay_1788696472083_1rwf9	unknown	2026-09-06 13:03:44.476753
pay_1788696429945_gn5bg	unknown	2026-09-06 13:03:44.476753
pay_1788696134811_wm7rx	unknown	2026-09-06 13:03:44.476753
pay_1788695871941_n60sh	unknown	2026-09-06 13:03:44.476753
pay_1788695828485_mtjou	unknown	2026-09-06 13:03:44.476753
pay_1788694700920_qz88u	unknown	2026-09-06 13:03:44.476753
pay_1788694511447_x41ig	unknown	2026-09-06 13:03:44.476753
pay_1788694506166_p7gue	unknown	2026-09-06 13:03:44.476753
pay_1788694309372_98hco	unknown	2026-09-06 13:03:44.476753
pay_1788694068546_y4drn	unknown	2026-09-06 13:03:44.476753
pay_1788703414826_y0oyu	unknown	2026-09-06 14:07:19.875523
pay_1788700038183_8lrtg	unknown	2026-09-06 14:07:19.875523
pay_1788700036515_5essw	unknown	2026-09-06 14:07:19.875523
pay_1788700034812_uzqez	unknown	2026-09-06 14:07:19.875523
pay_1788700033293_gpamf	unknown	2026-09-06 14:07:19.875523
pay_1788700031546_8ccxb	unknown	2026-09-06 14:07:19.875523
pay_1788700030027_00gql	unknown	2026-09-06 14:07:19.875523
pay_1788700028368_jz1zi	unknown	2026-09-06 14:07:19.875523
pay_1788700026129_47qk7	unknown	2026-09-06 14:07:19.875523
pay_1788700024343_ktmux	unknown	2026-09-06 14:07:19.875523
pay_1788700022736_lix9s	unknown	2026-09-06 14:07:19.875523
pay_1788700020924_387qn	unknown	2026-09-06 14:07:19.875523
pay_1788700018420_1dfyn	unknown	2026-09-06 14:07:19.875523
pay_1788700016611_e1ji6	unknown	2026-09-06 14:07:19.875523
pay_1788700015057_79w2d	unknown	2026-09-06 14:07:19.875523
pay_1788700013384_up1o8	unknown	2026-09-06 14:07:19.875523
pay_1788700010860_iuaoc	unknown	2026-09-06 14:07:19.875523
pay_1788700009201_ot541	unknown	2026-09-06 14:07:19.875523
pay_1788700007668_mwkmm	unknown	2026-09-06 14:07:19.875523
pay_1788700005923_l9in6	unknown	2026-09-06 14:07:19.875523
pay_1788700004390_n1g32	unknown	2026-09-06 14:07:19.875523
pay_1788700002626_tkvde	unknown	2026-09-06 14:07:19.875523
pay_1788700000222_944z1	unknown	2026-09-06 14:07:19.875523
pay_1788699998513_pgci4	unknown	2026-09-06 14:07:19.875523
pay_1788699996873_8yu3x	unknown	2026-09-06 14:07:19.875523
pay_1788699994848_0pquw	unknown	2026-09-06 14:07:19.875523
pay_1788699993262_w2r3z	unknown	2026-09-06 14:07:19.875523
pay_1788699991492_1orzy	unknown	2026-09-06 14:07:19.875523
pay_1788699989852_f1df8	unknown	2026-09-06 14:07:19.875523
pay_1788699987809_7iuc2	unknown	2026-09-06 14:07:19.875523
pay_1788699986154_5g2hy	unknown	2026-09-06 14:07:19.875523
pay_1788699984456_yaiyi	unknown	2026-09-06 14:07:19.875523
pay_1788699982781_7fv16	unknown	2026-09-06 14:07:19.875523
pay_1788699981017_mygnv	unknown	2026-09-06 14:07:19.875523
pay_1788699979317_vyasx	unknown	2026-09-06 14:07:19.875523
pay_1788699977376_atz9y	unknown	2026-09-06 14:07:19.875523
pay_1788699975659_0aeed	unknown	2026-09-06 14:07:19.875523
pay_1788699973793_vt776	unknown	2026-09-06 14:07:19.875523
pay_1788699967351_miwwv	unknown	2026-09-06 14:07:19.875523
pay_1788699965611_hatzz	unknown	2026-09-06 14:07:19.875523
pay_1788699964109_yssgf	unknown	2026-09-06 14:07:19.875523
pay_1788699962367_czf4t	unknown	2026-09-06 14:07:19.875523
pay_1788699960783_u2zmu	unknown	2026-09-06 14:07:19.875523
pay_1788699959046_tuota	unknown	2026-09-06 14:07:19.875523
pay_1788699957494_leatf	unknown	2026-09-06 14:07:19.875523
pay_1788699955685_49y2s	unknown	2026-09-06 14:07:19.875523
pay_1788699954098_ufc1l	unknown	2026-09-06 14:07:19.875523
pay_1788699952470_zmfyo	unknown	2026-09-06 14:07:19.875523
pay_1788699950661_bn47t	unknown	2026-09-06 14:07:19.875523
pay_1788699941395_ndvfc	unknown	2026-09-06 14:07:19.875523
pay_1788699939791_73hk0	unknown	2026-09-06 14:07:19.875523
pay_1788699937797_l3pw5	unknown	2026-09-06 14:07:19.875523
pay_1788699936224_zyfx9	unknown	2026-09-06 14:07:19.875523
pay_1788699934517_2vpc1	unknown	2026-09-06 14:07:19.875523
pay_1788699932951_st59c	unknown	2026-09-06 14:07:19.875523
pay_1788699930393_9unh9	unknown	2026-09-06 14:07:19.875523
pay_1788699928716_rn5fv	unknown	2026-09-06 14:07:19.875523
pay_1788699926892_g042r	unknown	2026-09-06 14:07:19.875523
pay_1788699925316_o7cos	unknown	2026-09-06 14:07:19.875523
pay_1788699922778_jivog	unknown	2026-09-06 14:07:19.875523
pay_1788699921087_6qd5b	unknown	2026-09-06 14:07:19.875523
pay_1788699919301_ylwue	unknown	2026-09-06 14:07:19.875523
pay_1788699917503_fh8yh	unknown	2026-09-06 14:07:19.875523
pay_1788699915317_dtud0	unknown	2026-09-06 14:07:19.875523
pay_1788699912672_a5r0j	unknown	2026-09-06 14:07:19.875523
pay_1788699910720_mrpz2	unknown	2026-09-06 14:07:19.875523
pay_1788699909145_wavsq	unknown	2026-09-06 14:07:19.875523
pay_1788699907342_foz4m	unknown	2026-09-06 14:07:19.875523
pay_1788699905648_h1db5	unknown	2026-09-06 14:07:19.875523
pay_1788699902815_g61vi	unknown	2026-09-06 14:07:19.875523
pay_1788699901219_oi9oi	unknown	2026-09-06 14:07:19.875523
pay_1788699899447_xzg7h	unknown	2026-09-06 14:07:19.875523
pay_1788699897688_89bqq	unknown	2026-09-06 14:07:19.875523
pay_1788699895701_x7lyy	unknown	2026-09-06 14:07:19.875523
pay_1788699894012_07nyo	unknown	2026-09-06 14:07:19.875523
pay_1788699892217_qtvcw	unknown	2026-09-06 14:07:19.875523
pay_1788699890545_nnbub	unknown	2026-09-06 14:07:19.875523
pay_1788699888656_hc5zf	unknown	2026-09-06 14:07:19.875523
pay_1788699886704_yngan	unknown	2026-09-06 14:07:19.875523
pay_1788699884982_tzdgc	unknown	2026-09-06 14:07:19.875523
pay_1788699883252_a9x28	unknown	2026-09-06 14:07:19.875523
pay_1788699881320_ywooz	unknown	2026-09-06 14:07:19.875523
pay_1788699873734_2wt2i	unknown	2026-09-06 14:07:19.875523
pay_1788699871944_skp94	unknown	2026-09-06 14:07:19.875523
pay_1788699870292_enr73	unknown	2026-09-06 14:07:19.875523
pay_1788699867479_m4bpt	unknown	2026-09-06 14:07:19.875523
pay_1788699865305_ggp1r	unknown	2026-09-06 14:07:19.875523
pay_1788699863499_4dt0c	unknown	2026-09-06 14:07:19.875523
pay_1788699860638_6ssmn	unknown	2026-09-06 14:07:19.875523
pay_1788699858648_1hozl	unknown	2026-09-06 14:07:19.875523
pay_1788699856310_1np2b	unknown	2026-09-06 14:07:19.875523
pay_1788699853287_cpyl2	unknown	2026-09-06 14:07:19.875523
pay_1788699850175_z3qdp	unknown	2026-09-06 14:07:19.875523
pay_1788699847083_xk6c4	unknown	2026-09-06 14:07:19.875523
pay_1788699845320_gw7t2	unknown	2026-09-06 14:07:19.875523
pay_1788699843248_hy2d1	unknown	2026-09-06 14:07:19.875523
pay_1788699820218_zn3p3	unknown	2026-09-06 14:07:19.875523
rep-sup-1	unknown	2026-09-06 15:24:12.075416
test_rep_batch_2	unknown	2026-09-06 15:24:12.075416
test_rep_batch_1	unknown	2026-09-06 15:24:12.075416
pay_1788776472035_cmkrp	unknown	2026-09-07 10:22:43.85997
pay_1788775003694_99n31	unknown	2026-09-07 10:22:43.85997
pay_1788766292811_ryizb	unknown	2026-09-07 10:22:43.85997
pay_1788761387489_8hm93	unknown	2026-09-07 10:22:43.85997
pay_1788761382204_82a9n	unknown	2026-09-07 10:22:43.85997
pay_1788761369244_zf14n	unknown	2026-09-07 10:22:43.85997
pay_1788718790428_m44my	unknown	2026-09-07 10:22:43.85997
pay_1788718785494_8akoz	unknown	2026-09-07 10:22:43.85997
pay_1788718782133_cxf7w	unknown	2026-09-07 10:22:43.85997
pay_1788718756433_m34sn	unknown	2026-09-07 10:22:43.85997
pay_1788718443823_poy9z	unknown	2026-09-07 10:22:43.85997
pay_1788706681968_jr1v1	unknown	2026-09-07 10:22:43.85997
pay_1788706251684_ptmdj	unknown	2026-09-07 10:22:43.85997
pay_1788706248039_pijhy	unknown	2026-09-07 10:22:43.85997
pay_1788706244647_l4uxt	unknown	2026-09-07 10:22:43.85997
pay_1788705773297_ko526	unknown	2026-09-07 10:22:43.85997
pay_1788705772174_63enh	unknown	2026-09-07 10:22:43.85997
pay_1788705771063_r73h0	unknown	2026-09-07 10:22:43.85997
pay_1788705769935_a9jav	unknown	2026-09-07 10:22:43.85997
pay_1788705768900_j0a03	unknown	2026-09-07 10:22:43.85997
pay_1788705767815_sfmyw	unknown	2026-09-07 10:22:43.85997
pay_1788705766752_fbpld	unknown	2026-09-07 10:22:43.85997
pay_1788705765598_3wamg	unknown	2026-09-07 10:22:43.85997
pay_1788705764432_c9758	unknown	2026-09-07 10:22:43.85997
pay_1788705763278_8pi9a	unknown	2026-09-07 10:22:43.85997
pay_1788705762123_0hgsl	unknown	2026-09-07 10:22:43.85997
pay_1788705760971_sgfio	unknown	2026-09-07 10:22:43.85997
pay_1788705759797_y6tw6	unknown	2026-09-07 10:22:43.85997
pay_1788705758713_3i1wn	unknown	2026-09-07 10:22:43.85997
pay_1788705757253_n03lw	unknown	2026-09-07 10:22:43.85997
pay_1788705755966_b0psg	unknown	2026-09-07 10:22:43.85997
pay_1788705754712_p6edk	unknown	2026-09-07 10:22:43.85997
pay_1788705753509_rrpq3	unknown	2026-09-07 10:22:43.85997
pay_1788705751360_yfc8e	unknown	2026-09-07 10:22:43.85997
pay_1788705750026_6iwi2	unknown	2026-09-07 10:22:43.85997
pay_1788705748873_w5cew	unknown	2026-09-07 10:22:43.85997
pay_1788705746796_2ld5p	unknown	2026-09-07 10:22:43.85997
pay_1788705745666_tjct2	unknown	2026-09-07 10:22:43.85997
pay_1788705744230_3885u	unknown	2026-09-07 10:22:43.85997
pay_1788705742904_iax3h	unknown	2026-09-07 10:22:43.85997
pay_1788705741382_o6rus	unknown	2026-09-07 10:22:43.85997
pay_1788705739627_6qfgq	unknown	2026-09-07 10:22:43.85997
pay_1788705738397_vucg5	unknown	2026-09-07 10:22:43.85997
pay_1788705737191_fbo85	unknown	2026-09-07 10:22:43.85997
pay_1788705735844_41e46	unknown	2026-09-07 10:22:43.85997
pay_1788705734706_fsl9p	unknown	2026-09-07 10:22:43.85997
pay_1788705733522_riups	unknown	2026-09-07 10:22:43.85997
pay_1788705732237_bhhyx	unknown	2026-09-07 10:22:43.85997
pay_1788705730968_yvmb7	unknown	2026-09-07 10:22:43.85997
pay_1788705728476_6wzkb	unknown	2026-09-07 10:22:43.85997
pay_1788705727364_qio51	unknown	2026-09-07 10:22:43.85997
pay_1788705726326_gzuc3	unknown	2026-09-07 10:22:43.85997
pay_1788705725226_040a7	unknown	2026-09-07 10:22:43.85997
pay_1788705724102_9wrfr	unknown	2026-09-07 10:22:43.85997
pay_1788705722954_2kfx5	unknown	2026-09-07 10:22:43.85997
pay_1788705721765_gjfjs	unknown	2026-09-07 10:22:43.85997
pay_1788705720658_1iwa3	unknown	2026-09-07 10:22:43.85997
pay_1788705719541_ovke4	unknown	2026-09-07 10:22:43.85997
pay_1788705718450_1mx4w	unknown	2026-09-07 10:22:43.85997
pay_1788705717301_8tuxt	unknown	2026-09-07 10:22:43.85997
pay_1788705716191_x543i	unknown	2026-09-07 10:22:43.85997
pay_1788705715093_nht9e	unknown	2026-09-07 10:22:43.85997
pay_1788705713868_ehanm	unknown	2026-09-07 10:22:43.85997
pay_1788705711686_kxxnw	unknown	2026-09-07 10:22:43.85997
pay_1788705710494_udamb	unknown	2026-09-07 10:22:43.85997
pay_1788705709250_qs3qp	unknown	2026-09-07 10:22:43.85997
pay_1788705707831_c5vns	unknown	2026-09-07 10:22:43.85997
pay_1788705706628_radhf	unknown	2026-09-07 10:22:43.85997
pay_1788705705260_9zvcz	unknown	2026-09-07 10:22:43.85997
pay_1788705703370_o6ae9	unknown	2026-09-07 10:22:43.85997
pay_1788705702146_fsaju	unknown	2026-09-07 10:22:43.85997
pay_1788705700941_fzfjm	unknown	2026-09-07 10:22:43.85997
pay_1788705698312_bmogp	unknown	2026-09-07 10:22:43.85997
pay_1788705697089_1o75r	unknown	2026-09-07 10:22:43.85997
pay_1788705695855_hsohk	unknown	2026-09-07 10:22:43.85997
pay_1788705694668_agcik	unknown	2026-09-07 10:22:43.85997
pay_1788705693447_n1eke	unknown	2026-09-07 10:22:43.85997
pay_1788705692190_0t2bc	unknown	2026-09-07 10:22:43.85997
pay_1788705690973_amqe3	unknown	2026-09-07 10:22:43.85997
pay_1788705689784_621b9	unknown	2026-09-07 10:22:43.85997
pay_1788705688528_rsm5y	unknown	2026-09-07 10:22:43.85997
pay_1788705687212_vmrzc	unknown	2026-09-07 10:22:43.85997
pay_1788705685927_dq0cu	unknown	2026-09-07 10:22:43.85997
pay_1788705684748_6qlua	unknown	2026-09-07 10:22:43.85997
pay_1788705683530_y7hoe	unknown	2026-09-07 10:22:43.85997
pay_1788705682273_dduj2	unknown	2026-09-07 10:22:43.85997
pay_1788705681020_h98up	unknown	2026-09-07 10:22:43.85997
pay_1788705679763_cyzxs	unknown	2026-09-07 10:22:43.85997
pay_1788705678474_dd7e3	unknown	2026-09-07 10:22:43.85997
pay_1788705677289_7w2pj	unknown	2026-09-07 10:22:43.85997
pay_1788705676082_88sue	unknown	2026-09-07 10:22:43.85997
pay_1788705674915_2c80w	unknown	2026-09-07 10:22:43.85997
pay_1788705673709_fe40q	unknown	2026-09-07 10:22:43.85997
pay_1788705672441_glj0v	unknown	2026-09-07 10:22:43.85997
pay_1788705671199_74j3u	unknown	2026-09-07 10:22:43.85997
pay_1788705669895_p8f8d	unknown	2026-09-07 10:22:43.85997
pay_1788705668557_zjhuc	unknown	2026-09-07 10:22:43.85997
pay_1788705667205_kpndz	unknown	2026-09-07 10:22:43.85997
pay_1788705665835_vp8gu	unknown	2026-09-07 10:22:43.85997
pay_1788705664374_a8hzh	unknown	2026-09-07 10:22:43.85997
pay_1788705662987_q5omh	unknown	2026-09-07 10:22:43.85997
pay_1788705661672_fk3jm	unknown	2026-09-07 10:22:43.85997
pay_1788705660384_swghx	unknown	2026-09-07 10:22:43.85997
pay_1788705659054_zqx9q	unknown	2026-09-07 10:22:43.85997
pay_1788705650056_l2bwu	unknown	2026-09-07 10:22:43.85997
pay_1788705648608_xttrt	unknown	2026-09-07 10:22:43.85997
pay_1788705647335_ykged	unknown	2026-09-07 10:22:43.85997
pay_1788705646059_aiiju	unknown	2026-09-07 10:22:43.85997
pay_1788705644856_xd0h5	unknown	2026-09-07 10:22:43.85997
pay_1788705643571_hpjhr	unknown	2026-09-07 10:22:43.85997
pay_1788705642265_aixap	unknown	2026-09-07 10:22:43.85997
pay_1788705640909_antef	unknown	2026-09-07 10:22:43.85997
pay_1788705639555_xu4v5	unknown	2026-09-07 10:22:43.85997
pay_1788705638141_fr8gd	unknown	2026-09-07 10:22:43.85997
pay_1788705636786_dfldy	unknown	2026-09-07 10:22:43.85997
pay_1788705635439_9z19d	unknown	2026-09-07 10:22:43.85997
pay_1788705634000_n5xx4	unknown	2026-09-07 10:22:43.85997
pay_1788705632444_xbe7n	unknown	2026-09-07 10:22:43.85997
pay_1788705630854_bm8ur	unknown	2026-09-07 10:22:43.85997
pay_1788705629300_0nq7k	unknown	2026-09-07 10:22:43.85997
pay_1788705627826_83wby	unknown	2026-09-07 10:22:43.85997
pay_1788705626026_65urr	unknown	2026-09-07 10:22:43.85997
pay_1788781211157_pxhoi	unknown	2026-09-07 11:42:25.163654
pay_1788781165017_iij8u	unknown	2026-09-07 11:42:25.163654
pay_1788782739962_8wt9q	payments	2026-09-07 12:27:09.764063
pay_1788782618230_iff07	payments	2026-09-07 12:27:09.884987
pay_1788783446860_eirk8	payments	2026-09-07 12:27:09.903586
pay_1788784154068_hspzj	unknown	2026-09-07 12:40:08.227699
pay_1788784153160_3filz	unknown	2026-09-07 12:40:08.227699
pay_1788784152104_os99s	unknown	2026-09-07 12:40:08.227699
pay_1788784150973_91jao	unknown	2026-09-07 12:40:08.227699
pay_1788784149015_8u753	unknown	2026-09-07 12:40:08.227699
pay_1788784147928_qzzny	unknown	2026-09-07 12:40:08.227699
pay_1788784146928_9qo1h	unknown	2026-09-07 12:40:08.227699
pay_1788784145802_7bkx8	unknown	2026-09-07 12:40:08.227699
pay_1788784142610_2uhxm	unknown	2026-09-07 12:40:08.227699
pay_1788784141357_72fly	unknown	2026-09-07 12:40:08.227699
pay_1788784140135_67cws	unknown	2026-09-07 12:40:08.227699
pay_1788784138699_1a4cz	unknown	2026-09-07 12:40:08.227699
pay_1788784135281_r8vi6	unknown	2026-09-07 12:40:08.227699
pay_1788784133432_37owd	unknown	2026-09-07 12:40:08.227699
pay_1788784131419_xj8we	unknown	2026-09-07 12:40:08.227699
pay_1788784129378_mad6v	unknown	2026-09-07 12:40:08.227699
pay_1788784128225_eq78t	unknown	2026-09-07 12:40:08.227699
pay_1788784126936_yg1ln	unknown	2026-09-07 12:40:08.227699
pay_1788784124914_tg9cl	unknown	2026-09-07 12:40:08.227699
pay_1788784123491_u6g21	unknown	2026-09-07 12:40:08.227699
pay_1788784122344_bgcew	unknown	2026-09-07 12:40:08.227699
pay_1788784121173_pkmkb	unknown	2026-09-07 12:40:08.227699
pay_1788784120049_6jya4	unknown	2026-09-07 12:40:08.227699
pay_1788784118759_ao0za	unknown	2026-09-07 12:40:08.227699
pay_1788784117322_7ow4d	unknown	2026-09-07 12:40:08.227699
pay_1788784116051_a6jge	unknown	2026-09-07 12:40:08.227699
pay_1788784114844_0tdwe	unknown	2026-09-07 12:40:08.227699
pay_1788784113459_jmdur	unknown	2026-09-07 12:40:08.227699
pay_1788784111007_0kkwi	unknown	2026-09-07 12:40:08.227699
pay_1788784109918_rjtiu	unknown	2026-09-07 12:40:08.227699
pay_1788784108842_zven1	unknown	2026-09-07 12:40:08.227699
pay_1788784107786_ptib3	unknown	2026-09-07 12:40:08.227699
pay_1788784106797_4nkjh	unknown	2026-09-07 12:40:08.227699
pay_1788784105712_pn62m	unknown	2026-09-07 12:40:08.227699
pay_1788784104623_ffc63	unknown	2026-09-07 12:40:08.227699
pay_1788784103518_cwj57	unknown	2026-09-07 12:40:08.227699
pay_1788784101645_1f6ge	unknown	2026-09-07 12:40:08.227699
pay_1788784099009_c2y5d	unknown	2026-09-07 12:40:08.227699
pay_1788784097916_35kk8	unknown	2026-09-07 12:40:08.227699
pay_1788784096794_disne	unknown	2026-09-07 12:40:08.227699
pay_1788784095745_3f3v2	unknown	2026-09-07 12:40:08.227699
pay_1788784094654_r7ssp	unknown	2026-09-07 12:40:08.227699
pay_1788784093585_9opyl	unknown	2026-09-07 12:40:08.227699
pay_1788784092479_1k0h2	unknown	2026-09-07 12:40:08.227699
pay_1788784090397_w3rcp	unknown	2026-09-07 12:40:08.227699
pay_1788784089220_mngdk	unknown	2026-09-07 12:40:08.227699
pay_1788784087968_egecs	unknown	2026-09-07 12:40:08.227699
pay_1788784086844_cuhf4	unknown	2026-09-07 12:40:08.227699
pay_1788784085609_nk2l0	unknown	2026-09-07 12:40:08.227699
pay_1788784084503_49byy	unknown	2026-09-07 12:40:08.227699
pay_1788784083315_335te	unknown	2026-09-07 12:40:08.227699
pay_1788784082125_d1oz4	unknown	2026-09-07 12:40:08.227699
pay_1788784080679_e1aom	unknown	2026-09-07 12:40:08.227699
pay_1788784079382_1yf11	unknown	2026-09-07 12:40:08.227699
pay_1788784078181_i1ltq	unknown	2026-09-07 12:40:08.227699
pay_1788784076947_38g2h	unknown	2026-09-07 12:40:08.227699
pay_1788784075710_xvxn2	unknown	2026-09-07 12:40:08.227699
pay_1788784074373_5z7ls	unknown	2026-09-07 12:40:08.227699
pay_1788784073047_5kknj	unknown	2026-09-07 12:40:08.227699
pay_1788784071733_o6fgk	unknown	2026-09-07 12:40:08.227699
pay_1788784070369_lv9c3	unknown	2026-09-07 12:40:08.227699
pay_1788784068635_8t3jg	unknown	2026-09-07 12:40:08.227699
rep-emp-rep-sup-1	employees	2026-09-07 15:02:59.553425
pay_1788805097607_guf66	unknown	2026-09-08 09:37:52.420819
pay_1788805096716_teayp	unknown	2026-09-08 09:37:52.420819
pay_1788805095658_fgaat	unknown	2026-09-08 09:37:52.420819
pay_1788805094753_qysmm	unknown	2026-09-08 09:37:52.420819
pay_1788805093788_5o1ac	unknown	2026-09-08 09:37:52.420819
pay_1788805092860_xwycq	unknown	2026-09-08 09:37:52.420819
pay_1788805091893_unly0	unknown	2026-09-08 09:37:52.420819
pay_1788805090724_9e05o	unknown	2026-09-08 09:37:52.420819
pay_1788805089726_70mw4	unknown	2026-09-08 09:37:52.420819
pay_1788805088709_wg88s	unknown	2026-09-08 09:37:52.420819
pay_1788805087657_54okb	unknown	2026-09-08 09:37:52.420819
pay_1788805086503_rlek9	unknown	2026-09-08 09:37:52.420819
pay_1788805085472_rks0c	unknown	2026-09-08 09:37:52.420819
pay_1788805083430_4c6gz	unknown	2026-09-08 09:37:52.420819
pay_1788805082421_noeyx	unknown	2026-09-08 09:37:52.420819
pay_1788805081325_iwku3	unknown	2026-09-08 09:37:52.420819
pay_1788805080005_ksvbo	unknown	2026-09-08 09:37:52.420819
pay_1788805078897_odabj	unknown	2026-09-08 09:37:52.420819
pay_1788805077790_8jckc	unknown	2026-09-08 09:37:52.420819
pay_1788805076724_7prin	unknown	2026-09-08 09:37:52.420819
pay_1788805075699_x2nlj	unknown	2026-09-08 09:37:52.420819
pay_1788805074629_h087v	unknown	2026-09-08 09:37:52.420819
pay_1788805073408_grwqx	unknown	2026-09-08 09:37:52.420819
pay_1788805070283_g81kw	unknown	2026-09-08 09:37:52.420819
pay_1788805069124_ay842	unknown	2026-09-08 09:37:52.420819
pay_1788805068037_lsqa8	unknown	2026-09-08 09:37:52.420819
pay_1788805066941_08nm0	unknown	2026-09-08 09:37:52.420819
pay_1788805065766_bi99n	unknown	2026-09-08 09:37:52.420819
pay_1788805064550_wpecy	unknown	2026-09-08 09:37:52.420819
pay_1788805063301_dy0ks	unknown	2026-09-08 09:37:52.420819
pay_1788805062041_cne3c	unknown	2026-09-08 09:37:52.420819
pay_1788805060826_ym3r0	unknown	2026-09-08 09:37:52.420819
pay_1788805059087_epy4l	unknown	2026-09-08 09:37:52.420819
pay_1788805057853_aki48	unknown	2026-09-08 09:37:52.420819
pay_1788805056715_bjs81	unknown	2026-09-08 09:37:52.420819
pay_1788805055564_03i9z	unknown	2026-09-08 09:37:52.420819
pay_1788805054443_o5a3a	unknown	2026-09-08 09:37:52.420819
pay_1788805053317_y2tje	unknown	2026-09-08 09:37:52.420819
pay_1788805052147_csujv	unknown	2026-09-08 09:37:52.420819
pay_1788805050959_fz2d8	unknown	2026-09-08 09:37:52.420819
pay_1788805049536_o2ypr	unknown	2026-09-08 09:37:52.420819
pay_1788805048032_juccu	unknown	2026-09-08 09:37:52.420819
pay_1788805046241_yvnbk	unknown	2026-09-08 09:37:52.420819
pay_1788805044339_odwww	unknown	2026-09-08 09:37:52.420819
pay_1788805042914_rcc4u	unknown	2026-09-08 09:37:52.420819
pay_1788805041609_8rgjl	unknown	2026-09-08 09:37:52.420819
pay_1788805040155_90w9k	unknown	2026-09-08 09:37:52.420819
pay_1788804967934_65se6	unknown	2026-09-08 09:37:52.420819
pay_1788797518716_vkybl	unknown	2026-09-08 09:37:52.420819
pay_1788789077777_7shcl	unknown	2026-09-08 09:37:52.420819
pay_1788784585729_vymr9	unknown	2026-09-08 09:37:52.420819
undefined	payments	2026-09-08 18:02:32.902891
contract_1788275122825_9wjp9	sales	2026-09-09 07:36:25.995571
pay_1788939047861_meyze	unknown	2026-09-09 07:36:27.153602
pay_1788896115291_5igbg	unknown	2026-09-09 07:36:27.153602
pay_1788882261074_r2d98	unknown	2026-09-09 07:36:27.153602
pay_1788872316994_3inpz	unknown	2026-09-09 07:36:27.153602
pay_1788872289867_3uj29	unknown	2026-09-09 07:36:27.153602
pay_1788871592871_db1uo	unknown	2026-09-09 07:36:27.153602
pay_1788869357495_ko67q	unknown	2026-09-09 07:36:27.153602
pay_1788869356418_x6wzb	unknown	2026-09-09 07:36:27.153602
pay_1788869355231_7q1hz	unknown	2026-09-09 07:36:27.153602
pay_1788869354057_a1mbt	unknown	2026-09-09 07:36:27.153602
pay_1788869352905_t79rc	unknown	2026-09-09 07:36:27.153602
pay_1788869351817_1dn89	unknown	2026-09-09 07:36:27.153602
pay_1788869350728_3g1x2	unknown	2026-09-09 07:36:27.153602
pay_1788869349693_2ge4a	unknown	2026-09-09 07:36:27.153602
pay_1788869348535_mguw4	unknown	2026-09-09 07:36:27.153602
pay_1788869347398_ie3lg	unknown	2026-09-09 07:36:27.153602
pay_1788869346081_wq2x5	unknown	2026-09-09 07:36:27.153602
fund_del_test_1788890448376	cash_funds	2026-09-09 07:36:56.573369
fund_1788938978540_7g8zf	cash_funds	2026-09-09 07:36:59.300796
list_1788938991449_bt0z4	customer_lists	2026-09-09 07:37:16.842121
fundtx_1788694406629_3i1oh	cash_funds	2026-09-09 07:37:17.057305
item_1788939075031_wc2ji	inventory_items	2026-09-09 07:37:31.955235
inv-2	inventory_items	2026-09-09 07:37:39.657572
inv-1	inventory_items	2026-09-09 07:37:44.445963
inv-3	inventory_items	2026-09-09 07:37:50.169338
inv-5	inventory_items	2026-09-09 07:38:03.993593
inv-4	inventory_items	2026-09-09 07:38:05.282493
rep_1788939036636_3us2l	reps	2026-09-09 07:38:32.027864
emp_1788939009244_rq03x	employees	2026-09-09 07:38:38.115304
test_del_1788890422184	payments	2026-09-09 07:38:47.407241
pay_1788890552629_9u3ib	payments	2026-09-09 07:38:47.442599
pay_1788872359668_v5f08	unknown	2026-09-09 07:38:49.775828
pay_1788872340193_5bcho	unknown	2026-09-09 07:38:49.775828
pay_1788872329104_rygpb	unknown	2026-09-09 07:38:49.775828
pay_1788872322949_zxx6e	unknown	2026-09-09 07:38:49.775828
pay_1788869373976_cxhca	unknown	2026-09-09 07:38:49.775828
pay_1788869372334_jxipb	unknown	2026-09-09 07:38:49.775828
pay_1788869370732_tvruh	unknown	2026-09-09 07:38:49.775828
pay_1788869369490_2r1q4	unknown	2026-09-09 07:38:49.775828
pay_1788869368257_twi56	unknown	2026-09-09 07:38:49.775828
pay_1788869367194_jcxcq	unknown	2026-09-09 07:38:49.775828
pay_1788869366050_u8nk6	unknown	2026-09-09 07:38:49.775828
pay_1788869364960_f6k6z	unknown	2026-09-09 07:38:49.775828
pay_1788869363776_ate9t	unknown	2026-09-09 07:38:49.775828
pay_1788869362520_j5cne	unknown	2026-09-09 07:38:49.775828
pay_1788869360852_bz267	unknown	2026-09-09 07:38:49.775828
pay_1788869358905_hbxvh	unknown	2026-09-09 07:38:49.775828
pay_1788940514538_cmzl2	payments	2026-09-09 10:51:28.214554
pay_1788940512263_snn3w	payments	2026-09-09 10:51:28.219933
pay_1788940513443_wfucl	payments	2026-09-09 10:51:28.225883
pay_1788950909983_7t09y	unknown	2026-09-09 10:51:28.422069
pay_1788950908841_sktn1	unknown	2026-09-09 10:51:28.422069
pay_1788950907637_u168e	unknown	2026-09-09 10:51:28.422069
pay_1788950834622_g233w	unknown	2026-09-09 10:51:28.422069
pay_1788950833191_4ul2q	unknown	2026-09-09 10:51:28.422069
pay_1788950730518_kdxqq	unknown	2026-09-09 10:51:28.422069
pay_1788950728836_r7t83	unknown	2026-09-09 10:51:28.422069
pay_1788950727681_9ybrr	unknown	2026-09-09 10:51:28.422069
pay_1788950726397_gfk2p	unknown	2026-09-09 10:51:28.422069
pay_1788950539953_yug0u	unknown	2026-09-09 10:51:28.422069
pay_1788950538878_lj8n5	unknown	2026-09-09 10:51:28.422069
pay_1788950537735_g7ybu	unknown	2026-09-09 10:51:28.422069
pay_1788950536642_1f3a4	unknown	2026-09-09 10:51:28.422069
pay_1788950534998_w84bd	unknown	2026-09-09 10:51:28.422069
pay_1788950534225_bs28k	unknown	2026-09-09 10:51:28.422069
pay_1788950533206_g8uay	unknown	2026-09-09 10:51:28.422069
pay_1788950532151_atyt0	unknown	2026-09-09 10:51:28.422069
pay_1788950531166_tmnt7	unknown	2026-09-09 10:51:28.422069
pay_1788950530181_kk5r3	unknown	2026-09-09 10:51:28.422069
pay_1788950529096_ghrpf	unknown	2026-09-09 10:51:28.422069
pay_1788950527974_60pu9	unknown	2026-09-09 10:51:28.422069
pay_1788950526884_71jbj	unknown	2026-09-09 10:51:28.422069
pay_1788950525678_3iui5	unknown	2026-09-09 10:51:28.422069
pay_1788950523862_7yg3e	unknown	2026-09-09 10:51:28.422069
pay_1788940516339_65jrs	unknown	2026-09-09 10:51:28.422069
pay_1788940510423_wv2hp	unknown	2026-09-09 10:51:28.422069
pay_1788940509250_jb09q	unknown	2026-09-09 10:51:28.422069
pay_1788940508148_zldt7	unknown	2026-09-09 10:51:28.422069
pay_1788940507066_80tnm	unknown	2026-09-09 10:51:28.422069
pay_1788940505307_punfu	unknown	2026-09-09 10:51:28.422069
pay_1788940504213_uxm1h	unknown	2026-09-09 10:51:28.422069
pay_1788940503164_1pia0	unknown	2026-09-09 10:51:28.422069
pay_1788940501930_yhmc9	unknown	2026-09-09 10:51:28.422069
pay_1788940500090_54fhm	unknown	2026-09-09 10:51:28.422069
pay_1788940498963_8trdl	unknown	2026-09-09 10:51:28.422069
pay_1788940497847_mh3i7	unknown	2026-09-09 10:51:28.422069
pay_1788940496714_xju4m	unknown	2026-09-09 10:51:28.422069
pay_1788940495524_7qgzm	unknown	2026-09-09 10:51:28.422069
pay_1788940494316_pv89b	unknown	2026-09-09 10:51:28.422069
pay_1788940492291_swmnx	unknown	2026-09-09 10:51:28.422069
pay_1788940491109_bst4c	unknown	2026-09-09 10:51:28.422069
pay_1788940489964_nolz6	unknown	2026-09-09 10:51:28.422069
pay_1788940488595_46ydr	unknown	2026-09-09 10:51:28.422069
pay_1788940486706_8nxw0	unknown	2026-09-09 10:51:28.422069
pay_1788940485468_dvgam	unknown	2026-09-09 10:51:28.422069
pay_1788940484235_jpw2c	unknown	2026-09-09 10:51:28.422069
pay_1788940482961_158r9	unknown	2026-09-09 10:51:28.422069
pay_1788940480954_a0dvi	unknown	2026-09-09 10:51:28.422069
pay_1788940479728_9lxz9	unknown	2026-09-09 10:51:28.422069
pay_1788940478478_7ut3t	unknown	2026-09-09 10:51:28.422069
pay_1788940477236_qvvgs	unknown	2026-09-09 10:51:28.422069
pay_1788940475116_4yg50	unknown	2026-09-09 10:51:28.422069
pay_1788940473740_ev5ut	unknown	2026-09-09 10:51:28.422069
pay_1788940472015_psi1w	unknown	2026-09-09 10:51:28.422069
\.


--
-- Data for Name: employee_transactions; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.employee_transactions (id, employee_id, fund_id, type, amount, notes, rep_name, created_at, updated_at, note, date) FROM stdin;
emptx_1787228888756_8avtm	rep-emp-rep_1787228660515_6z1st	\N	loan	10000	\N	ضياء المحاسب	2026-08-20T12:28:08.756Z	2026-08-20 12:28:23.273863+00		\N
emptx_1788793184686_6ypol	rep-emp-rep-2	fundtx_1788694391258_ar3lx	loan	5000	\N	ضياء المحاسب	2026-09-07T14:59:44.686Z	2026-09-07 15:06:09.750339+00	\N	\N
emptx_1787228865508_3g05i	rep-emp-rep_1787228660515_6z1st	fund-4	loan	10000	\N	ضياء المحاسب	2026-08-20T12:27:45.508Z	2026-08-20 12:27:46.162167+00	\N	\N
emptx_1788793272143_5e2lk	rep-emp-rep-2	fundtx_1788694391258_ar3lx	repay	4000	\N	ضياء المحاسب	2026-09-07T15:01:12.143Z	2026-09-07 15:05:17.20481+00	\N	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.employees (id, name, phone, job_title, "position", salary, debt_balance, total_debt, is_rep, rep_id, created_at, updated_at) FROM stdin;
emp_1788940322089_pzxbp	امجد				0	0	0	f	\N	2026-09-09T07:52:02.090Z	2026-09-09 07:52:06.108979+00
rep-emp-rep_1787228660515_6z1st	سيد نزار	0000		\N	0	0	0	t	rep_1787228660515_6z1st	2026-08-20T12:26:45.241Z	2026-08-20 12:26:45.304114+00
\.


--
-- Data for Name: fund_transactions; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.fund_transactions (id, fund_id, target_fund_id, type, amount, note, rep_name, created_at, updated_at, description) FROM stdin;
ft_pay_pay_1788699973793_vt776	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.854475+00	\N
ft_pay_pay_1788940489964_nolz6	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:36.364931+00	\N
ft_pay_pay_1788940507066_80tnm	fund-1	\N	installment	6000	تسديد قسط زبون: كريم عبدالرصا علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:33.309704+00	\N
ft_pay_pay_1788869366050_u8nk6	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:43:46.617558+00	\N
ft_pay_pay_1788699544588_4s2o4	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:43.579503+00	\N
ft_pay_pay_1788869370732_tvruh	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:39:26.751216+00	\N
ft_pay_pay_1788950525678_3iui5	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:31.68334+00	\N
ft_pay_pay_1788699897688_89bqq	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.636432+00	\N
ft_pay_pay_1788869373976_cxhca	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:40:30.880579+00	\N
ft_pay_pay_1788705753509_rrpq3	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.791727+00	\N
ft_pay_pay_1788705661672_fk3jm	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:32.268702+00	\N
ft_pay_pay_1788871592871_db1uo	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:10.44737+00	\N
ft_pay_pay_1788699890545_nnbub	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.881463+00	\N
ft_pay_pay_1788950730518_kdxqq	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.783823+00	\N
ft_pay_pay_1788805046241_yvnbk	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:45:28.507729+00	\N
ft_pay_pay_1788705684748_6qlua	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.46675+00	\N
ft_pay_pay_1788705763278_8pi9a	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.538094+00	\N
ft_pay_pay_1788706681968_jr1v1	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	زيد	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.829286+00	\N
ft_pay_pay_1788705715093_nht9e	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.948549+00	\N
ft_pay_pay_1788869372334_jxipb	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:40:45.490155+00	\N
ft_pay_pay_1788896115291_5igbg	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 19:35:39.666171+00	\N
ft_pay_pay_1788706248039_pijhy	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:16.038082+00	\N
ft_pay_pay_1788940488595_46ydr	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.562565+00	\N
ft_pay_pay_1788699962367_czf4t	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:04.093664+00	\N
ft_pay_pay_1788705773297_ko526	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:16.077898+00	\N
ft_pay_pay_1788872340193_5bcho	fund-3	\N	installment	2000	تسديد قسط زبون: احمد محمد	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:39:16.424522+00	\N
ft_pay_pay_1788705768900_j0a03	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:16.287367+00	\N
ft_pay_pay_1788699871944_skp94	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.673735+00	\N
ft_pay_pay_1788705703370_o6ae9	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.746259+00	\N
ft_pay_pay_1788940484235_jpw2c	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:36.339684+00	\N
ft_pay_pay_1788950727681_9ybrr	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:31.666127+00	\N
ft_pay_pay_1788950532151_atyt0	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:29.137872+00	\N
ft_pay_pay_1788950523862_7yg3e	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.849439+00	\N
ft_pay_pay_1788940485468_dvgam	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.54067+00	\N
ft_pay_pay_1788950527974_60pu9	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.798736+00	\N
ft_pay_pay_1788869369490_2r1q4	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:43:46.647355+00	\N
ft_pay_pay_1788699895701_x7lyy	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.645957+00	\N
ft_pay_pay_1788705636786_dfldy	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.829272+00	\N
ft_pay_pay_1788705698312_bmogp	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.942917+00	\N
ft_pay_pay_1788705717301_8tuxt	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:14.84231+00	\N
ft_pay_pay_1788950538878_lj8n5	fund-3	\N	installment	2000	تسديد قسط زبون: حسين نعمه	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:29.121029+00	\N
ft_pay_pay_1788869360852_bz267	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:39:40.88017+00	\N
ft_pay_pay_1788705687212_vmrzc	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.907701+00	\N
ft_pay_pay_1788950536642_1f3a4	fund-3	\N	installment	2000	تسديد قسط زبون: حسين نعمه	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:02:28.442866+00	\N
ft_pay_pay_1788872329104_rygpb	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:40:03.958547+00	\N
ft_pay_pay_1788869367194_jcxcq	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:41:01.005163+00	\N
ft_pay_pay_1788705679763_cyzxs	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.729389+00	\N
ft_pay_pay_1788705754712_p6edk	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.938282+00	\N
ft_pay_pay_1788718782133_cxf7w	fund-3	\N	installment	2000	تسديد قسط زبون: احمد محمد	سيد نزار	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.652117+00	\N
ft_pay_pay_1788869368257_twi56	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:43:46.77841+00	\N
ft_pay_pay_1788940503164_1pia0	fund-3	\N	installment	2000	تسديد قسط زبون: احمد محمد	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:33.3241+00	\N
ft_pay_pay_1788940486706_8nxw0	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.524853+00	\N
ft_pay_pay_1788805044339_odwww	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:48:00.839772+00	\N
ft_pay_pay_1788940504213_uxm1h	fund-3	\N	installment	2000	تسديد قسط زبون: احمد محمد	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.316088+00	\N
ft_pay_pay_1788699870292_enr73	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.876056+00	\N
ft_pay_pay_1788940494316_pv89b	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.282351+00	\N
ft_pay_pay_1788872359668_v5f08	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:39:00.750043+00	\N
ft_pay_pay_1788940498963_8trdl	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.309092+00	\N
ft_pay_pay_1788699950661_bn47t	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.796847+00	\N
ft_pay_pay_1788706251684_ptmdj	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.845012+00	\N
ft_pay_pay_1788699902815_g61vi	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.408351+00	\N
ft_pay_pay_1788805097607_guf66	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 11:26:53.681643+00	\N
ft_pay_pay_1788950531166_tmnt7	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:31.940439+00	\N
ft_pay_pay_1788950530181_kk5r3	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:31.668527+00	\N
ft_pay_pay_1788805092860_xwycq	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 11:26:52.398093+00	\N
ft_pay_pay_1788950834622_g233w	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 10:57:58.748937+00	\N
ft_pay_pay_1788950537735_g7ybu	fund-3	\N	installment	2000	تسديد قسط زبون: حسين نعمه	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:00:57.778072+00	\N
ft_pay_pay_1788869358905_hbxvh	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:39:55.563888+00	\N
ft_pay_pay_1788699981017_mygnv	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.791323+00	\N
ft_pay_pay_1788940516339_65jrs	fund-3	\N	installment	45000	تسديد قسط زبون: امير احمد عبد	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.789174+00	\N
ft_pay_pay_1788940495524_7qgzm	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.275672+00	\N
ft_pay_pay_1788699996873_8yu3x	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.297758+00	\N
ft_pay_pay_1788705728476_6wzkb	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.313012+00	\N
ft_pay_pay_1788705626026_65urr	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.169066+00	\N
ft_pay_pay_1788950728836_r7t83	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.805957+00	\N
ft_pay_pay_1788940497847_mh3i7	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.565806+00	\N
ft_pay_pay_1788700002626_tkvde	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.114092+00	\N
ft_pay_pay_1788872289867_3uj29	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 13:04:37.680242+00	\N
ft_pay_pay_1788869363776_ate9t	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:43:46.658029+00	\N
ft_pay_pay_1788705734706_fsl9p	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.203744+00	\N
ft_pay_pay_1788869364960_f6k6z	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:41:18.022969+00	\N
ft_pay_pay_1788950907637_u168e	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:01:48.878169+00	\N
ft_pay_pay_1788950833191_4ul2q	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 10:59:32.482025+00	\N
ft_pay_pay_1788950529096_ghrpf	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:31.71648+00	\N
ft_pay_pay_1788705766752_fbpld	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.291783+00	\N
ft_pay_pay_1788940479728_9lxz9	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:36.345374+00	\N
ft_pay_pay_1788950526884_71jbj	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:31.956159+00	\N
ft_pay_pay_1788705694668_agcik	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.995802+00	\N
ft_pay_pay_1788705710494_udamb	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.495135+00	\N
ft_pay_pay_1788940496714_xju4m	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.301121+00	\N
ft_pay_pay_1788705644856_xd0h5	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.578865+00	\N
ft_pay_pay_1788940491109_bst4c	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:36.322805+00	\N
ft_pay_pay_1788699888656_hc5zf	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.882906+00	\N
ft_pay_pay_1788940480954_a0dvi	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:36.48273+00	\N
ft_pay_pay_1788950533206_g8uay	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:05:57.813606+00	\N
ft_pay_pay_1788705690973_amqe3	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:20.245441+00	\N
ft_pay_pay_1788705706628_radhf	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.684396+00	\N
ft_pay_pay_1788696692977_eqnor	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.50607+00	\N
ft_pay_pay_1788940509250_jb09q	fund-1	\N	installment	6000	تسديد قسط زبون: كريم عبدالرصا علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.818425+00	\N
ft_pay_pay_1788869362520_j5cne	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:43:46.664604+00	\N
ft_pay_pay_1788784585729_vymr9	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:53:55.145199+00	\N
ft_pay_pay_1788782618230_iff07	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-07 12:38:53.371563+00	\N
ft_pay_pay_1788699925316_o7cos	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.293622+00	\N
ft_pay_pay_1788950726397_gfk2p	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.840566+00	\N
ft_pay_pay_1788699884982_tzdgc	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.911964+00	\N
ft_pay_pay_1788699909145_wavsq	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.387915+00	\N
ft_pay_pay_1788705650056_l2bwu	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.386646+00	\N
ft_pay_pay_1788699941395_ndvfc	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.946394+00	\N
ft_pay_pay_1788699932951_st59c	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.193185+00	\N
ft_pay_pay_1788950534998_w84bd	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:03:53.275316+00	\N
ft_pay_pay_1788699930393_9unh9	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.199229+00	\N
ft_pay_pay_1788805096716_teayp	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 11:26:53.691877+00	\N
ft_pay_pay_1788951559995_mhsp6	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 10:59:47.488754+00	\N
ft_pay_pay_1788872322949_zxx6e	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-09 07:40:15.284786+00	\N
ft_pay_pay_1788940492291_swmnx	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.321465+00	\N
ft_pay_pay_1788699901219_oi9oi	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.485114+00	\N
ft_pay_pay_1788699905648_h1db5	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.397509+00	\N
ft_pay_pay_1788940500090_54fhm	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.306043+00	\N
ft_pay_pay_1788698096883_zn903	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.391602+00	\N
ft_pay_pay_1788705674915_2c80w	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.766804+00	\N
ft_pay_pay_1788940501930_yhmc9	fund-3	\N	installment	2000	تسديد قسط زبون: احمد محمد	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:33.311502+00	\N
ft_pay_pay_1788805076724_7prin	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:52:20.244007+00	\N
ft_pay_pay_1788699982781_7fv16	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.607702+00	\N
ft_pay_pay_1788940505307_punfu	fund-3	\N	installment	2000	تسديد قسط زبون: احمد محمد	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.290121+00	\N
ft_pay_pay_1788950909983_7t09y	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:01:18.038605+00	\N
ft_pay_pay_1788950908841_sktn1	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:32.834212+00	\N
ft_pay_pay_1788940508148_zldt7	fund-1	\N	installment	6000	تسديد قسط زبون: كريم عبدالرصا علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:33.327154+00	\N
ft_pay_pay_1788940482961_158r9	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:34.551176+00	\N
ft_pay_pay_1788940510423_wv2hp	fund-1	\N	installment	6000	تسديد قسط زبون: كريم عبدالرصا علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:33.242756+00	\N
ft_pay_pay_1788950534225_bs28k	fund-3	\N	installment	2000	تسديد قسط زبون: امير محمد علي	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:00.75054+00	\N
ft_pay_pay_1788940478478_7ut3t	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:36.320855+00	\N
ft_pay_pay_1788950539953_yug0u	fund-3	\N	installment	2000	تسديد قسط زبون: حسين نعمه	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:03.497575+00	\N
ft_pay_pay_1788940473740_ev5ut	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:37.186075+00	\N
ft_pay_pay_1788699921087_6qd5b	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:40.986544+00	\N
ft_pay_pay_1788699507971_641ol	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:43.566967+00	\N
ft_pay_pay_1788699820218_zn3p3	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.409853+00	\N
ft_pay_pay_1788705722954_2kfx5	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.565616+00	\N
ft_pay_pay_1788694068546_y4drn	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:32.407382+00	\N
ft_pay_pay_1788705711686_kxxnw	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.026974+00	\N
ft_pay_pay_1788940475116_4yg50	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:37.204456+00	\N
ft_pay_pay_1788694309372_98hco	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:32.255776+00	\N
ft_pay_pay_1788781165017_iij8u	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-07 11:56:58.020008+00	\N
ft_pay_pay_1788805064550_wpecy	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:08:30.617901+00	\N
ft_pay_pay_1788705721765_gjfjs	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.697277+00	\N
ft_pay_pay_1788694511447_x41ig	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:41.353844+00	\N
ft_pay_pay_1788805088709_wg88s	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:57.308678+00	\N
ft_pay_pay_1788805089726_70mw4	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:57.401251+00	\N
ft_pay_pay_1788705758713_3i1wn	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.763587+00	\N
ft_pay_pay_1788699899447_xzg7h	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.634819+00	\N
ft_pay_pay_1788705733522_riups	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.200843+00	\N
ft_pay_pay_1788705727364_qio51	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.44915+00	\N
ft_pay_pay_1788705700941_fzfjm	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.818111+00	\N
ft_pay_pay_1788705735844_41e46	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.059015+00	\N
ft_pay_pay_1788940477236_qvvgs	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:37.219169+00	\N
ft_pay_pay_1788940472015_psi1w	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 11:06:37.237785+00	\N
ft_pay_pay_1788869355231_7q1hz	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:05.474716+00	\N
ft_pay_pay_1788869352905_t79rc	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:05.685485+00	\N
ft_pay_pay_1788869349693_2ge4a	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:05.727359+00	\N
ft_pay_pay_1788869356418_x6wzb	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:05.442388+00	\N
ft_pay_pay_1788805066941_08nm0	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:59:32.491563+00	\N
ft_pay_pay_1788761369244_zf14n	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	سيد نزار	2026-09-07T00:00:00.000Z	2026-09-07 10:23:15.574637+00	\N
ft_pay_pay_1788805070283_g81kw	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.168405+00	\N
ft_pay_pay_1788805052147_csujv	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:09.075315+00	\N
ft_pay_pay_1788805048032_juccu	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:45:28.510219+00	\N
ft_pay_pay_1788805063301_dy0ks	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:52:00.544622+00	\N
fundtx_1788694391258_ar3lx	fund-3	fund_1787350448071_bdhbq	transfer	1000		ضياء المحاسب	2026-09-06T11:33:11.259Z	2026-09-06 11:33:14.198265+00	\N
ft_pay_pay_1788869350728_3g1x2	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:17:09.802943+00	\N
ft_pay_pay_1788705697089_1o75r	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.989442+00	\N
ft_pay_pay_1788705676082_88sue	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.764351+00	\N
ft_pay_pay_1788705665835_vp8gu	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:32.22097+00	\N
ft_pay_pay_1788700015057_79w2d	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:51.907057+00	\N
ft_pay_pay_1788705732237_bhhyx	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.205226+00	\N
ft_pay_pay_1788869351817_1dn89	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:17:09.592162+00	\N
ft_pay_pay_1788805053317_y2tje	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.924809+00	\N
fundtx_1788694406629_3i1oh	fund-3	\N	withdraw	1000		ضياء المحاسب	2026-09-06T11:33:26.629Z	2026-09-06 11:33:28.85977+00	\N
ft_pay_pay_1788951536014_a9dwu	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 10:59:07.258273+00	\N
ft_pay_pay_1788700028368_jz1zi	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:50.735203+00	\N
ft_pay_pay_1788705765598_3wamg	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.441395+00	\N
ft_pay_pay_1788869348535_mguw4	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:08.987729+00	\N
ft_pay_pay_1788869357495_ko67q	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:05.438502+00	\N
ft_pay_pay_1788869347398_ie3lg	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:17:09.815782+00	\N
ft_pay_pay_1788695871941_n60sh	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:26.933468+00	\N
ft_pay_pay_1788705693447_n1eke	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:20.07004+00	\N
ft_pay_pay_1788699847083_xk6c4	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.177252+00	\N
ft_pay_pay_1788699863499_4dt0c	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.921019+00	\N
ft_pay_pay_1788705725226_040a7	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.454966+00	\N
ft_pay_pay_1788766292811_ryizb	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-07 10:23:15.330087+00	\N
ft_pay_pay_1788699912672_a5r0j	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.15657+00	\N
ft_pay_pay_1788705648608_xttrt	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.413379+00	\N
ft_pay_pay_1788705671199_74j3u	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.981718+00	\N
ft_pay_pay_1788718785494_8akoz	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	سيد نزار	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.587471+00	\N
ft_pay_pay_1788705760971_sgfio	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.543734+00	\N
ft_pay_pay_1788699987809_7iuc2	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:21.901729+00	\N
ft_pay_pay_1788699926892_g042r	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.295894+00	\N
ft_pay_pay_1788705673709_fe40q	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.969517+00	\N
ft_pay_pay_1788695828485_mtjou	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:41.593793+00	\N
ft_pay_pay_1788700013384_up1o8	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:52.09578+00	\N
ft_pay_pay_1788705751360_yfc8e	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.02063+00	\N
ft_pay_pay_1788939047861_meyze	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-09T00:00:00.000Z	2026-09-09 07:31:19.810678+00	\N
ft_pay_pay_1788697355066_abklr	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.40367+00	\N
ft_pay_pay_1788705678474_dd7e3	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.572003+00	\N
ft_pay_pay_1788705643571_hpjhr	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.636387+00	\N
ft_pay_pay_1788705667205_kpndz	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:32.078794+00	\N
ft_pay_pay_1788872316994_3inpz	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 13:01:09.243108+00	\N
ft_pay_pay_1788705668557_zjhuc	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:32.020976+00	\N
ft_pay_pay_1788705739627_6qfgq	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:25:23.767057+00	\N
ft_pay_pay_1788705767815_sfmyw	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:16.331805+00	\N
ft_pay_pay_1788705755966_b0psg	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.802582+00	\N
ft_pay_pay_1788869346081_wq2x5	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:09.193589+00	\N
ft_pay_pay_1788700034812_uzqez	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:50.104459+00	\N
ft_pay_pay_1788699959046_tuota	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.548645+00	\N
ft_pay_pay_1788699865305_ggp1r	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.907938+00	\N
ft_pay_pay_1788705769935_a9jav	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:16.163072+00	\N
ft_pay_pay_1788699907342_foz4m	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.390071+00	\N
ft_pay_pay_1788700022736_lix9s	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:51.107245+00	\N
ft_pay_pay_1788705685927_dq0cu	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.319341+00	\N
ft_pay_pay_1788703414826_y0oyu	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	زيد	2026-09-06T00:00:00.000Z	2026-09-06 14:18:21.351533+00	\N
ft_pay_pay_1788705730968_yvmb7	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:12.226694+00	\N
ft_pay_pay_1788705681020_h98up	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.51654+00	\N
ft_pay_pay_1788699892217_qtvcw	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.733782+00	\N
ft_pay_pay_1788705707831_c5vns	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.567757+00	\N
ft_pay_pay_1788699984456_yaiyi	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:22.0349+00	\N
ft_pay_pay_1788705662987_q5omh	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:32.261595+00	\N
ft_pay_pay_1788882261074_r2d98	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 16:10:05.966193+00	\N
ft_pay_pay_1788869354057_a1mbt	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-08T00:00:00.000Z	2026-09-08 12:47:05.535227+00	\N
ft_pay_pay_1788699883252_a9x28	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.626969+00	\N
ft_pay_pay_1788700038183_8lrtg	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:49.750131+00	\N
ft_pay_pay_1788705692190_0t2bc	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:20.199209+00	\N
ft_pay_pay_1788699993262_w2r3z	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:21.786514+00	\N
ft_pay_pay_1788705634000_n5xx4	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.917896+00	\N
ft_pay_pay_1788696646096_ibv5f	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.594251+00	\N
ft_pay_pay_1788696517498_3k0o2	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.651628+00	\N
ft_pay_pay_1788705759797_y6tw6	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.689471+00	\N
ft_pay_pay_1788699994848_0pquw	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:19:37.661642+00	\N
ft_pay_pay_1788696472083_1rwf9	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:25.359621+00	\N
ft_pay_pay_1788705724102_9wrfr	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.472062+00	\N
ft_pay_pay_1788699886704_yngan	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.894153+00	\N
ft_pay_pay_1788705742904_iax3h	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.288338+00	\N
ft_pay_pay_1788700009201_ot541	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:52.820495+00	\N
ft_pay_pay_1788705664374_a8hzh	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:32.234735+00	\N
ft_pay_pay_1788699858648_1hozl	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.123662+00	\N
ft_pay_pay_1788705744230_3885u	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.279144+00	\N
ft_pay_pay_1788705762123_0hgsl	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.541904+00	\N
ft_pay_pay_1788705629300_0nq7k	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.135077+00	\N
ft_pay_pay_1788705772174_63enh	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:16.080143+00	\N
fundtx_1787489004824_6x12s	fund-1	fund_1787350448071_bdhbq	transfer	2500000		ضياء المحاسب	2026-08-23T12:43:24.824Z	2026-09-05 10:37:22.7007+00	\N
fundtx_1787488984285_lu4a0	fund-3	fund_1787350448071_bdhbq	transfer	3000000		ضياء المحاسب	2026-08-23T12:43:04.285Z	2026-09-05 10:37:22.9397+00	\N
ft_pay_pay_1788718790428_m44my	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	سيد نزار	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.577584+00	\N
ft_pay_pay_1788700036515_5essw	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:49.871125+00	\N
ft_pay_pay_1788699937797_l3pw5	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.025574+00	\N
ft_pay_pay_1788696134811_wm7rx	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:25.434653+00	\N
ft_pay_pay_1788694506166_p7gue	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:41.353954+00	\N
ft_pay_pay_1788700000222_944z1	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:21.621754+00	\N
ft_pay_pay_1788699989852_f1df8	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.541459+00	\N
ft_pay_pay_1788699986154_5g2hy	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.546245+00	\N
ft_pay_pay_1788705737191_fbo85	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:07.007184+00	\N
ft_pay_pay_1788700026129_47qk7	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:50.859609+00	\N
ft_pay_pay_1788705669895_p8f8d	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:32.013441+00	\N
ft_pay_pay_1788705683530_y7hoe	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.476404+00	\N
ft_pay_pay_1788700016611_e1ji6	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:51.861134+00	\N
ft_pay_pay_1788705745666_tjct2	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.186385+00	\N
ft_pay_pay_1788694700920_qz88u	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:05:41.540428+00	\N
ft_pay_pay_1788699917503_fh8yh	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.143184+00	\N
ft_pay_pay_1788705748873_w5cew	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.041798+00	\N
ft_pay_pay_1788699922778_jivog	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.439971+00	\N
ft_pay_pay_1788797518716_vkybl	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:41:01.912603+00	\N
ft_pay_pay_1788805042914_rcc4u	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:20:50.232219+00	\N
ft_pay_pay_1788805068037_lsqa8	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:56:27.661305+00	\N
ft_pay_pay_1788699979317_vyasx	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.789057+00	\N
ft_pay_pay_1788700004390_n1g32	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:19:37.413113+00	\N
ft_pay_pay_1788700018420_1dfyn	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:11.169959+00	\N
ft_pay_pay_1788705764432_c9758	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.507134+00	\N
ft_pay_pay_1788700020924_387qn	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:51.165029+00	\N
ft_pay_pay_1788700030027_00gql	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:50.365436+00	\N
ft_pay_pay_1788705746796_2ld5p	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.05785+00	\N
ft_pay_pay_1788805050959_fz2d8	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:09.089371+00	\N
ft_pay_pay_1788805083430_4c6gz	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:58.579394+00	\N
ft_pay_pay_1788700033293_gpamf	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:50.173316+00	\N
ft_pay_pay_1788705639555_xu4v5	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.815484+00	\N
ft_pay_pay_1788805069124_ay842	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.315738+00	\N
ft_pay_pay_1788705738397_vucg5	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:10.95579+00	\N
ft_pay_pay_1788699928716_rn5fv	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.272497+00	\N
ft_pay_pay_1788699952470_zmfyo	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.79145+00	\N
ft_pay_pay_1788699860638_6ssmn	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.925519+00	\N
ft_pay_pay_1788699934517_2vpc1	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.045248+00	\N
ft_pay_pay_1788700007668_mwkmm	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:52.898474+00	\N
ft_pay_pay_1788805095658_fgaat	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:13.363653+00	\N
ft_pay_pay_1788718756433_m34sn	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	سيد نزار	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.788964+00	\N
ft_pay_pay_1788805080005_ksvbo	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:58.69771+00	\N
ft_pay_pay_1788805091893_unly0	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:56.373814+00	\N
ft_pay_pay_1788805055564_03i9z	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.849915+00	\N
ft_pay_pay_1788805065766_bi99n	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:03:46.375302+00	\N
ft_pay_pay_1788705741382_o6rus	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.292037+00	\N
ft_pay_pay_1788805082421_noeyx	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:58.687354+00	\N
ft_pay_pay_1788705627826_83wby	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.168315+00	\N
ft_pay_pay_1788699955685_49y2s	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.699549+00	\N
ft_pay_pay_1788783446860_eirk8	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-07 12:32:52.355603+00	\N
ft_pay_pay_1788699910720_mrpz2	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.235704+00	\N
ft_pay_pay_1788699967351_miwwv	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:04.037066+00	\N
ft_pay_pay_1788699915317_dtud0	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.149218+00	\N
ft_pay_pay_1788705705260_9zvcz	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.732398+00	\N
ft_pay_pay_1788805094753_qysmm	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:56.179949+00	\N
ft_pay_pay_1788805087657_54okb	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:57.425964+00	\N
ft_pay_pay_1788805093788_5o1ac	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:56.181917+00	\N
ft_pay_pay_1788761382204_82a9n	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	سيد نزار	2026-09-07T00:00:00.000Z	2026-09-07 10:23:15.540243+00	\N
ft_pay_pay_1788805049536_o2ypr	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:39:39.427518+00	\N
ft_pay_pay_1788705750026_6iwi2	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.03812+00	\N
ft_pay_pay_1788805057853_aki48	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.836006+00	\N
ft_pay_pay_1788805074629_h087v	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.092149+00	\N
ft_pay_pay_1788805073408_grwqx	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.117582+00	\N
ft_pay_pay_1788789077777_7shcl	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	زيد	2026-09-07T00:00:00.000Z	2026-09-08 09:53:19.131028+00	\N
ft_pay_pay_1788782739962_8wt9q	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-07 12:32:40.030718+00	\N
ft_pay_pay_1788805086503_rlek9	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:57.439548+00	\N
ft_pay_pay_1788805062041_cne3c	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.597548+00	\N
ft_pay_pay_1788805040155_90w9k	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:29:23.051816+00	\N
ft_pay_pay_1788805075699_x2nlj	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.326474+00	\N
ft_pay_pay_1788805060826_ym3r0	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:15:22.208212+00	\N
ft_pay_pay_1788700031546_8ccxb	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:50.355796+00	\N
ft_pay_pay_1788805081325_iwku3	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:58.687354+00	\N
ft_pay_pay_1788705709250_qs3qp	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.565782+00	\N
ft_pay_pay_1788705695855_hsohk	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:20.066422+00	\N
ft_pay_pay_1788705682273_dduj2	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.515902+00	\N
ft_pay_pay_1788761387489_8hm93	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	سيد نزار	2026-09-07T00:00:00.000Z	2026-09-07 10:23:15.396324+00	\N
ft_pay_pay_1788805059087_epy4l	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.672734+00	\N
ft_pay_pay_1788805090724_9e05o	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:56.432541+00	\N
ft_pay_pay_1788705638141_fr8gd	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.88562+00	\N
ft_pay_pay_1788805054443_o5a3a	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.873107+00	\N
ft_pay_pay_1788775003694_99n31	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-07 10:23:15.326981+00	\N
ft_pay_pay_1788804967934_65se6	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:35:39.075706+00	\N
ft_pay_pay_1788805041609_8rgjl	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 10:24:35.098167+00	\N
ft_pay_pay_1788718443823_poy9z	fund-3	\N	installment	2000	تسديد قسط زبون: احمد محمد	سيد نزار	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.826963+00	\N
ft_pay_pay_1788705726326_gzuc3	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.45179+00	\N
ft_pay_pay_1788700010860_iuaoc	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:52.155766+00	\N
ft_pay_pay_1788699919301_ylwue	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.141013+00	\N
ft_pay_pay_1788700024343_ktmux	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:50.982837+00	\N
ft_pay_pay_1788705635439_9z19d	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.91692+00	\N
fundtx_1787415427498_t6zsh	fund-3	\N	withdraw	3000000		ضياء المحاسب	2026-08-22T16:17:07.499Z	2026-09-05 10:37:23.449949+00	\N
ft_pay_pay_1788700005923_l9in6	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:08:53.082637+00	\N
ft_pay_pay_1788705660384_swghx	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.312906+00	\N
ft_pay_pay_1788705646059_aiiju	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.564072+00	\N
ft_pay_pay_1788705689784_621b9	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:20.24572+00	\N
ft_pay_pay_1788699843248_hy2d1	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.37081+00	\N
ft_pay_pay_1788705716191_x543i	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.818256+00	\N
ft_pay_pay_1788705702146_fsaju	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.815775+00	\N
ft_pay_pay_1788696429945_gn5bg	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:25.429656+00	\N
ft_pay_pay_1788699957494_leatf	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.702148+00	\N
ft_pay_pay_1788699998513_pgci4	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.293825+00	\N
ft_pay_pay_1788705630854_bm8ur	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.08054+00	\N
ft_pay_pay_1788699954098_ufc1l	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.778879+00	\N
ft_pay_pay_1788699965611_hatzz	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:04.042188+00	\N
ft_pay_pay_1788696636514_l4ool	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.641612+00	\N
ft_pay_pay_1788705757253_n03lw	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.788204+00	\N
ft_pay_pay_1788705713868_ehanm	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:19.317363+00	\N
ft_pay_pay_1788699845320_gw7t2	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.369879+00	\N
ft_pay_pay_1788696950519_opli8	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.418186+00	\N
ft_pay_pay_1788705640909_antef	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.665834+00	\N
ft_pay_pay_1788699853287_cpyl2	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.161313+00	\N
ft_pay_pay_1788699856310_1np2b	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.122958+00	\N
ft_pay_pay_1788699960783_u2zmu	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.539309+00	\N
ft_pay_pay_1788705677289_7w2pj	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:31.71863+00	\N
ft_pay_pay_1788705632444_xbe7n	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:24.067589+00	\N
ft_pay_pay_1788705642265_aixap	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 15:06:32.393998+00	\N
ft_pay_pay_1788699729325_axw67	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:12.518761+00	\N
fundtx_1787489016176_ioqd2	fund-1	\N	withdraw	1000		ضياء المحاسب	2026-08-23T12:43:36.176Z	2026-09-05 10:37:22.692845+00	\N
ft_pay_pay_1788705771063_r73h0	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:16.102778+00	\N
ft_pay_pay_1788699850175_z3qdp	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:29.170086+00	\N
fundtx_1787429897694_u0xbs	fund-3	fund_1787350448071_bdhbq	transfer	3000000		ضياء المحاسب	2026-08-22T20:18:17.695Z	2026-09-05 10:37:22.946663+00	\N
ft_pay_pay_1788699894012_07nyo	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:22:41.660033+00	\N
ft_pay_pay_1788699881320_ywooz	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.659425+00	\N
ft_pay_pay_1788705719541_ovke4	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.704577+00	\N
ft_pay_pay_1788699939791_73hk0	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:05.950791+00	\N
ft_pay_pay_1788699873734_2wt2i	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.672058+00	\N
ft_pay_pay_1788705720658_1iwa3	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.700603+00	\N
ft_pay_pay_1788699977376_atz9y	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.794608+00	\N
ft_pay_pay_1788699991492_1orzy	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.539353+00	\N
ft_pay_pay_1788699964109_yssgf	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:04.042507+00	\N
ft_pay_pay_1788699975659_0aeed	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:09:03.842226+00	\N
ft_pay_pay_1788705688528_rsm5y	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:20.316521+00	\N
fundtx_1787489034181_ugbrp	fund_1787350448071_bdhbq	\N	withdraw	300000		ضياء المحاسب	2026-08-23T12:43:54.181Z	2026-09-05 10:37:22.698537+00	\N
fundtx_1787429916464_95kzv	fund-3	\N	withdraw	5000		ضياء المحاسب	2026-08-22T20:18:36.464Z	2026-09-05 10:37:22.859883+00	\N
fundtx_1787414746059_c6l4l	fund-3	\N	withdraw	3000000		ضياء المحاسب	2026-08-22T16:05:46.061Z	2026-09-05 10:37:23.586688+00	\N
fundtx_1787604949151_nojf2	fund_1787350448071_bdhbq	fund-3	transfer	9200000		ضياء المحاسب	2026-08-24T20:55:49.151Z	2026-09-05 10:37:22.600877+00	\N
fundtx_1787488997982_o25w7	fund-2	fund_1787350448071_bdhbq	transfer	1800000		ضياء المحاسب	2026-08-23T12:43:17.982Z	2026-09-05 10:37:22.83364+00	\N
ft_pay_pay_1788805077790_8jckc	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:59.190161+00	\N
ft_pay_pay_1788781211157_pxhoi	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-07 11:59:55.298133+00	\N
ft_pay_pay_1788805056715_bjs81	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:08.823407+00	\N
ft_pay_pay_1788705647335_ykged	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.413485+00	\N
ft_pay_pay_1788699462546_4nojx	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:27:15.601285+00	\N
ft_pay_pay_1788698124408_2uyf7	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 13:06:21.343173+00	\N
ft_pay_pay_1788705659054_zqx9q	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:23.327631+00	\N
ft_pay_pay_1788705672441_glj0v	fund-1	\N	installment	15000	تسديد قسط زبون: محمد غايب	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:58:52.78674+00	\N
ft_pay_pay_1788705718450_1mx4w	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:11.723617+00	\N
ft_pay_pay_1788706244647_l4uxt	fund-3	\N	installment	2000	تسديد قسط زبون: حسن علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-07 10:23:15.907213+00	\N
ft_pay_pay_1788699936224_zyfx9	fund-2	\N	installment	1000	تسديد قسط زبون: كمال علي حسن	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:21:06.044065+00	\N
ft_pay_pay_1788805078897_odabj	fund-3	\N	installment	3000	تسديد قسط زبون: حمودي ضياء	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:37:58.699093+00	\N
ft_pay_pay_1788699867479_m4bpt	fund-1	\N	installment	30000	تسديد قسط زبون: فاطمه نجم عبدالله	ضياء المحاسب	2026-09-06T00:00:00.000Z	2026-09-06 14:24:28.876513+00	\N
ft_pay_pay_1788805085472_rks0c	fund-1	\N	installment	75000	تسديد قسط زبون: كمال علي حسين	ضياء المحاسب	2026-09-07T00:00:00.000Z	2026-09-08 09:38:13.866059+00	\N
\.


--
-- Data for Name: inventory_items; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.inventory_items (id, name, price, purchase_price, quantity, daily_installment, category, created_at) FROM stdin;
item_1786741474102_rs4nj	اجهزه 160	160000	0	47	1000		2026-09-04 18:07:52.649
item_1786658536147_eefvf	اجهزه 170	170000	0	79	1500		2026-08-13 22:02:16.743087
item_1786658598996_rfmyl	اجهزه 200	200000	0	62	2000		2026-08-13 22:03:19.619832
\.


--
-- Data for Name: payment_conflicts; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.payment_conflicts (id, contract_id, customer_name, attempted_amount, actual_remaining_balance, excess_amount, rep_name, note, payment_date, created_at, status, resolved_by, resolved_at, resolution_note, accepted_amount) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.payments (id, contract_id, customer_name, amount_paid, payment_date, rep_name, note, fund_id, updated_at, is_edited, amount, created_at) FROM stdin;
pay_1788951559995_mhsp6	contract_1788275200844_jfxgz	محمد غايب	15000	2026-09-09	ضياء المحاسب	تسديد قسط يومي	fund-1	\N	f	15000	2026-09-09T10:59:19.995Z
pay_1788951536014_a9dwu	contract_1788275200844_jfxgz	محمد غايب	15000	2026-09-09	ضياء المحاسب	تسديد قسط يومي	fund-1	\N	f	15000	2026-09-09T10:58:56.014Z
\.


--
-- Data for Name: reps; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.reps (id, name, phone, code, role, can_edit, can_delete, can_move_customer, can_sell, allowed_list_ids, updated_at, latitude, longitude, last_location_update, location_address, last_seen, is_online) FROM stdin;
rep_1787351318939_bysbs	مندوب كربلاء 3	0780	3647	rep	f	f	f	f	["all"]	2026-08-21 22:28:39.631949+00	31.9637401	44.6099287	2026-08-27T19:01:59.499Z	31.96371, 44.60994	2026-08-27T13:06:13.972Z	f
rep_1787351361675_xp56x	مندوب كربلاء 4	0780	44788	rep	f	f	f	f	["all"]	2026-08-21 22:29:22.367568+00	\N	\N	\N	\N	2026-08-27T13:06:14.123Z	f
rep_1787351248238_bgr70	مندوب كربلاء 1	66666	3484	rep	f	f	f	f	["all"]	2026-08-21 22:27:28.972756+00	\N	\N	\N	\N	2026-08-27T13:06:13.881Z	f
rep_1787351151276_4k6lg	هيثم	0780	7843	rep	f	f	f	f	["all"]	2026-08-21 22:25:51.965733+00	\N	\N	\N	\N	2026-08-27T13:06:14.125Z	f
rep-3	رغيد	07509998877	0000	rep	t	t	t	f	["all"]	2026-08-18 21:42:58.17985+00	31.9847381	44.9034128	٢٧‏/٨‏/٢٠٢٦، ٣:٢٣:٣٣ م	31.98474, 44.90341	2026-08-27T13:06:13.630Z	f
rep-2	زيد	07704445566	5678	rep	f	f	t	f	["all"]	2026-08-18 21:42:58.17985+00	31.9637447	44.6099218	2026-08-28T16:40:44.819Z	31.96372, 44.60995	2026-08-27T13:06:13.637Z	f
rep_1787228660515_6z1st	سيد نزار	0000	5555	supervisor	f	f	t	t	["all"]	2026-08-20 12:24:21.168829+00	31.9847594	44.9034139	2026-08-27T18:38:29.281Z	31.96371, 44.60995	2026-08-27T13:01:21.325Z	t
rep_1787351289887_620kg	مندوب كربلاء 2	0780	47447	rep	f	f	f	f	["all"]	2026-08-21 22:28:10.583268+00	\N	\N	\N	\N	2026-08-27T13:06:13.967Z	f
rep_1786620296205_ae0e2	ماهر المندوب	07800001122	1234	supervisor	f	f	f	f	["all"]	2026-08-18 21:42:58.17985+00	31.984727	44.90343	٢٧‏/٨‏/٢٠٢٦، ٣:٥٤:٥٢ م	31.98473, 44.90343	2026-08-27T12:55:13.911Z	t
rep_1786553941658_rhljp	ضياء المحاسب	07801112233	4444	admin	t	t	t	t	["all"]	2026-08-18 21:42:58.17985+00	31.9636957	44.60994	2026-08-28T18:30:06.899Z	31.96370, 44.60994	2026-08-28T18:30:06.899Z	t
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.sales (id, sale_number, customer_id, customer_name, customer_phone, customer_address, item_id, item_name, item_quantity, purchase_price, list_id, list_name, total_price, advance_payment, remaining_balance, daily_installment, start_date, notes, status, last_payment_date, total_paid, rep_name, created_at, completed_at, updated_at, is_edited) FROM stdin;
contract_1788275200844_jfxgz	\N	\N	محمد غايب	07805555550		inv-5	سبليت حافظ 2 طن إنفرتر	1	0	list-1	كربلاء الأولى	850000	0	820000	15000	2026-09-01		active	2026-09-09	30000	ضياء المحاسب	2026-09-01T15:06:40.844Z	\N	2026-09-01T15:42:47.069Z	f
contract_1788890552519_9ifkb	\N	\N	عميل تجربة الحذف	07712345678		\N	جهاز تجريبي	1	0	\N	\N	250000	50000	200000	5000	2026-09-08		active	\N	0		2026-09-08T18:02:32.519Z	\N	2026-09-08T18:04:18.235Z	f
contract_1788938958037_mh8ox	\N	\N	امير محمد علي	07805555555		item_1786658598996_rfmyl	اجهزه 200	1	0	list_1786560962783_50vm6	القائمة الاولى	200000	0	200000	2000	2026-09-09		active	\N	0	ضياء المحاسب	2026-09-09T07:29:18.037Z	\N	2026-09-09T07:30:38.606Z	f
contract_1788708018754_d5dsk	\N	\N	احمد محمد	07804555888		item_1786658598996_rfmyl	اجهزه 200	1	0	list_1786560962783_50vm6	القائمة الاولى	200000	0	200000	2000	2026-09-06		active	\N	0	سيد نزار	2026-09-06T15:20:18.754Z	\N	2026-09-06T16:21:18.382Z	f
contract_1788545256909_iblzh	\N	\N	كمال علي حسن	07805555500		item_1786741474102_rs4nj	اجهزه 160	1	0	list-4	قائمة الثانية	160000	0	160000	1000	2026-09-04		active	\N	0	ضياء المحاسب	2026-09-04T18:07:36.909Z	\N	2026-09-05T06:23:12.070Z	f
contract_1788464616278_4gdm3	\N	\N	كمال علي حسين	07800512558		inv-1	آيفون 15 بروماكس 256GB (عدد 3)	1	0	list-1	كربلاء الأولى	4950000	0	4950000	75000	2026-09-03		active	\N	0	ضياء المحاسب	2026-09-03T19:43:36.278Z	\N	2026-09-03T19:43:38.383Z	f
contract_1788890002493_fropg	\N	\N	كريم عبدالرصا علي	07829899513		item_1786658598996_rfmyl	اجهزه 200 (عدد 3)	1	0	list-1	كربلاء الأولى	600000	0	600000	6000	2026-09-08		active	\N	0	ضياء المحاسب	2026-09-08T17:53:22.493Z	\N	2026-09-08T17:54:51.686Z	f
contract_1788937943069_0z2mo	\N	\N	حسين نعمه	07829899546		item_1786741474102_rs4nj	اجهزه 160 (عدد 2)	1	0	list_1786560962783_50vm6	القائمة الاولى	320000	0	320000	2000	2026-09-09		active	\N	0	ضياء المحاسب	2026-09-09T07:12:23.069Z	\N	2026-09-09T07:12:58.070Z	f
contract_1788464690567_fvcy7	\N	\N	فاطمه نجم عبدالله	07805555555		inv-2	شاشة سامسونج 55 بوصة Smart 4K (عدد 2)	1	0	list-1	كربلاء الأولى	1500000	0	1500000	30000	2026-09-03		active	\N	0	ضياء المحاسب	2026-09-03T19:44:50.568Z	\N	2026-09-04T12:44:31.295Z	f
contract_1788903041086_9id0s	\N	\N	جبوري حمزه كامل	07805555550		inv-5	سبليت حافظ 2 طن إنفرتر (عدد 2)	1	0	list_1786560962783_50vm6	القائمة الاولى	1700000	0	1700000	30000	2026-09-09		active	\N	0	ضياء المحاسب	2026-09-08T21:30:41.086Z	\N	2026-09-09T07:27:24.246Z	f
contract_1788289005498_291rd	\N	\N	حمودي ضياء	07805555555		item_1786658536147_eefvf	اجهزه 170 (عدد 2)	1	0	list_1786560962783_50vm6	القائمة الاولى	340000	0	340000	3000	2026-09-01		active	\N	0	ضياء المحاسب	2026-09-01T18:56:45.499Z	\N	2026-09-01T18:56:48.999Z	f
contract_1788893409544_lkqf6	\N	\N	امير احمد عبد	07829899552		inv-5	سبليت حافظ 2 طن إنفرتر (عدد 3)	1	0	list_1786560962783_50vm6	القائمة الاولى	2550000	0	2550000	45000	2026-09-08		active	\N	0	ضياء المحاسب	2026-09-08T18:50:09.545Z	\N	2026-09-08T18:52:33.879Z	f
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: app_user
--

COPY public.system_settings (key, value) FROM stdin;
schema_init_completed	true
welcome_message	{"title":"أهلاً بك في نظام مبيعات الأقساط","subtitle":"اختر القسم الذي تريد الدخول إليه:"}
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: app_user
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-08-11 09:14:58
20211116045059	2026-08-11 09:14:58
20211116050929	2026-08-11 09:14:58
20211116051442	2026-08-11 09:14:58
20211116212300	2026-08-11 09:14:58
20211116213355	2026-08-11 09:14:58
20211116213934	2026-08-11 09:14:58
20211116214523	2026-08-11 09:14:58
20211122062447	2026-08-11 09:14:58
20211124070109	2026-08-11 09:14:58
20211202204204	2026-08-11 09:14:58
20211202204605	2026-08-11 09:14:58
20211210212804	2026-08-11 09:14:58
20211228014915	2026-08-11 09:14:58
20220107221237	2026-08-11 09:14:58
20220228202821	2026-08-11 09:14:58
20220312004840	2026-08-11 09:14:58
20220603231003	2026-08-11 09:14:58
20220603232444	2026-08-11 09:14:58
20220615214548	2026-08-11 09:14:58
20220712093339	2026-08-11 09:14:58
20220908172859	2026-08-11 09:14:58
20220916233421	2026-08-11 09:14:58
20230119133233	2026-08-11 09:14:58
20230128025114	2026-08-11 09:14:58
20230128025212	2026-08-11 09:14:58
20230227211149	2026-08-11 09:14:58
20230228184745	2026-08-11 09:14:58
20230308225145	2026-08-11 09:14:58
20230328144023	2026-08-11 09:14:58
20231018144023	2026-08-11 09:14:58
20231204144023	2026-08-11 09:14:58
20231204144024	2026-08-11 09:14:58
20231204144025	2026-08-11 09:14:58
20240108234812	2026-08-11 09:14:58
20240109165339	2026-08-11 09:14:58
20240227174441	2026-08-11 09:14:58
20240311171622	2026-08-11 09:14:58
20240321100241	2026-08-11 09:14:58
20240401105812	2026-08-11 09:14:58
20240418121054	2026-08-11 09:14:58
20240523004032	2026-08-11 09:14:58
20240618124746	2026-08-11 09:14:58
20240801235015	2026-08-11 09:14:58
20240805133720	2026-08-11 09:14:58
20240827160934	2026-08-11 09:14:58
20240919163303	2026-08-11 09:14:58
20240919163305	2026-08-11 09:14:58
20241019105805	2026-08-11 09:14:58
20241030150047	2026-08-11 09:14:58
20241108114728	2026-08-11 09:14:58
20241121104152	2026-08-11 09:14:58
20241130184212	2026-08-11 09:14:58
20241220035512	2026-08-11 09:14:58
20241220123912	2026-08-11 09:14:58
20241224161212	2026-08-11 09:14:58
20250107150512	2026-08-11 09:14:58
20250110162412	2026-08-11 09:14:58
20250123174212	2026-08-11 09:14:58
20250128220012	2026-08-11 09:14:58
20250506224012	2026-08-11 09:14:58
20250523164012	2026-08-11 09:14:58
20250714121412	2026-08-11 09:14:58
20250905041441	2026-08-11 09:14:58
20251103001201	2026-08-11 09:14:58
20251120212548	2026-08-11 09:14:58
20251120215549	2026-08-11 09:14:58
20260218120000	2026-08-11 09:14:58
20260326120000	2026-08-11 09:14:58
20260514120000	2026-08-11 09:14:58
20260527120000	2026-08-11 09:14:58
20260528120000	2026-08-11 09:14:58
20260603120000	2026-08-11 09:14:58
20260605120000	2026-08-11 09:14:58
20260606110000	2026-08-11 09:14:58
20260616120000	2026-08-11 09:14:58
20260624120000	2026-08-11 09:14:58
20260626120000	2026-08-11 09:14:58
20260706120000	2026-08-11 09:14:58
20260707120000	2026-08-11 09:14:58
20260709120000	2026-08-11 09:14:58
20260714120000	2026-09-04 14:08:39
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: app_user
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type, versioning_status) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-08-11 09:15:24.857174
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-08-11 09:15:24.899425
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-08-11 09:15:24.903478
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-08-11 09:15:24.924573
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-08-11 09:15:24.938887
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-08-11 09:15:24.94203
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-08-11 09:15:24.947159
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-08-11 09:15:24.950755
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-08-11 09:15:24.953514
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-08-11 09:15:24.956542
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-08-11 09:15:24.960359
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-08-11 09:15:24.963986
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-08-11 09:15:24.968437
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-08-11 09:15:24.9798
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-08-11 09:15:24.984263
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-08-11 09:15:25.010887
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-08-11 09:15:25.014647
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-08-11 09:15:25.017946
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-08-11 09:15:25.02114
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-08-11 09:15:25.026912
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-08-11 09:15:25.030452
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-08-11 09:15:25.036168
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-08-11 09:15:25.048249
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-08-11 09:15:25.059421
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-08-11 09:15:25.063308
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-08-11 09:15:25.066986
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-08-11 09:15:25.071049
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-08-11 09:15:25.074083
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-08-11 09:15:25.07738
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-08-11 09:15:25.080853
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-08-11 09:15:25.084097
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-08-11 09:15:25.087415
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-08-11 09:15:25.090843
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-08-11 09:15:25.094164
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-08-11 09:15:25.097434
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-08-11 09:15:25.100642
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-08-11 09:15:25.104019
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-08-11 09:15:25.108023
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-08-11 09:15:25.117272
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-08-11 09:15:25.127833
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-08-11 09:15:25.131152
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-08-11 09:15:25.134418
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-08-11 09:15:25.137737
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-08-11 09:15:25.142103
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-08-11 09:15:25.146065
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-08-11 09:15:25.151483
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-08-11 09:15:25.161579
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-08-11 09:15:25.16606
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-08-11 09:15:25.171521
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-08-11 09:15:25.188344
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-08-11 09:15:25.192428
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-08-11 09:15:25.686095
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-08-11 09:15:25.688003
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-08-11 09:15:25.69655
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-08-11 09:15:25.699014
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-08-11 09:15:25.700542
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-08-11 09:15:25.705086
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-08-11 09:15:25.709649
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-08-11 09:15:25.713197
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-08-11 09:15:25.717388
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-08-11 09:15:25.721198
61	mark-filename-immutable	fe0096517ae9d60aaec1d110172ba9036dc66bb7	2026-08-11 09:15:25.72555
62	object-versioning-core	0b855f00ff3be0bfca91efee02a9858912491a9a	2026-08-19 21:27:24.576944
63	fix-search-name-relative-to-prefix	c7485e417624f795ce8bb2da21927f48e088904d	2026-08-23 08:40:57.566144
64	fix-search-by-timestamp-sqli	0af424ecd388a39bb1645184b222185a12149675	2026-08-23 08:40:57.585283
65	objects-key-version-index	603c1c55658e982d35839001e2c2b59a50703904	2026-09-08 09:23:33.064736
66	objects-current-version-index	191466c93aa2c46a00e36505577c5fcab8d7cb4b	2026-09-08 09:23:33.074814
67	objects-null-version-index	15bfe8c35b66642b6c78ba60060fa8793bd2207a	2026-09-08 09:23:33.083514
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, archived_at, is_delete_marker, is_versioned) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: app_user
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: app_user
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: app_user
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: cash_funds cash_funds_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.cash_funds
    ADD CONSTRAINT cash_funds_pkey PRIMARY KEY (id);


--
-- Name: customer_lists customer_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.customer_lists
    ADD CONSTRAINT customer_lists_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: deleted_records deleted_records_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.deleted_records
    ADD CONSTRAINT deleted_records_pkey PRIMARY KEY (record_id);


--
-- Name: employee_transactions employee_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.employee_transactions
    ADD CONSTRAINT employee_transactions_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: fund_transactions fund_transactions_new_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.fund_transactions
    ADD CONSTRAINT fund_transactions_new_pkey PRIMARY KEY (id);


--
-- Name: inventory_items inventory_items_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.inventory_items
    ADD CONSTRAINT inventory_items_pkey PRIMARY KEY (id);


--
-- Name: payment_conflicts payment_conflicts_new_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.payment_conflicts
    ADD CONSTRAINT payment_conflicts_new_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: reps reps_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.reps
    ADD CONSTRAINT reps_pkey PRIMARY KEY (id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: app_user
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (key);


--
-- Name: messages messages_payload_exclusive; Type: CHECK CONSTRAINT; Schema: realtime; Owner: app_user
--

ALTER TABLE realtime.messages
    ADD CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL))) NOT VALID;


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: app_user
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: app_user
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: app_user
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: app_user
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: app_user
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: idx_deleted_records_lookup; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_deleted_records_lookup ON public.deleted_records USING btree (record_id, table_name);


--
-- Name: idx_payments_contract_id; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_payments_contract_id ON public.payments USING btree (contract_id);


--
-- Name: idx_payments_customer_name; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_payments_customer_name ON public.payments USING btree (customer_name);


--
-- Name: idx_payments_payment_date; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_payments_payment_date ON public.payments USING btree (payment_date);


--
-- Name: idx_sales_customer_name; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_sales_customer_name ON public.sales USING btree (customer_name);


--
-- Name: idx_sales_list_id; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_sales_list_id ON public.sales USING btree (list_id);


--
-- Name: idx_sales_status; Type: INDEX; Schema: public; Owner: app_user
--

CREATE INDEX idx_sales_status ON public.sales USING btree (status);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: app_user
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: app_user
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_selec; Type: INDEX; Schema: realtime; Owner: app_user
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_selec ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter, COALESCE(selected_columns, '{}'::text[]));


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: idx_objects_current_version; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE UNIQUE INDEX idx_objects_current_version ON storage.objects USING btree (bucket_id, name COLLATE "C") WHERE (archived_at IS NULL);


--
-- Name: idx_objects_null_version; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE UNIQUE INDEX idx_objects_null_version ON storage.objects USING btree (bucket_id, name COLLATE "C") WHERE (NOT is_versioned);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: app_user
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: payments trg_payments_change; Type: TRIGGER; Schema: public; Owner: app_user
--

CREATE TRIGGER trg_payments_change AFTER INSERT OR DELETE OR UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.recalc_contract_balance_on_payment_change();


--
-- Name: sales trg_sales_recalc; Type: TRIGGER; Schema: public; Owner: app_user
--

CREATE TRIGGER trg_sales_recalc BEFORE INSERT OR UPDATE OF total_price, advance_payment ON public.sales FOR EACH ROW EXECUTE FUNCTION public.recalc_contract_on_contract_change();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: app_user
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: app_user
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: app_user
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: app_user
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: app_user
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: app_user
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: app_user
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: app_user
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: app_user
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: app_user
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: app_user
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO app_user;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: app_user
--

GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: app_user
--

GRANT USAGE ON SCHEMA realtime TO postgres WITH GRANT OPTION;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: app_user
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: app_user
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: app_user
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: app_user
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: app_user
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: app_user
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: app_user
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: app_user
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: app_user
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO postgres;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;


--
-- Name: FUNCTION send_binary(payload bytea, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO postgres;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;


--
-- Name: FUNCTION wal2json_escape_identifier(name text); Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO postgres;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.custom_oauth_providers TO postgres;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_authorizations TO postgres;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_client_states TO postgres;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_clients TO postgres;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_consents TO postgres;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: app_user
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.webauthn_challenges TO postgres;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.webauthn_credentials TO postgres;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: app_user
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: app_user
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict 5yUivNxI2suQjkbirFKJ2WsZTZ6pTURMbsUDktvtaOsYmy4b24jcruSP5QEBFaL

