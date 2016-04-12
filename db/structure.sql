--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    email character varying NOT NULL,
    password_digest character varying NOT NULL,
    email_confirmation_at timestamp without time zone,
    email_confirmation_token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: feed_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feed_items (
    id integer NOT NULL,
    feed_id integer,
    digest character varying NOT NULL,
    date timestamp without time zone,
    link text,
    titl text,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: feed_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feed_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feed_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feed_items_id_seq OWNED BY feed_items.id;


--
-- Name: feeds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feeds (
    id integer NOT NULL,
    url character varying NOT NULL,
    last_fetch_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: feeds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feeds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feeds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feeds_id_seq OWNED BY feeds.id;


--
-- Name: forums; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forums (
    id integer NOT NULL,
    user_id integer,
    name character varying NOT NULL,
    url character varying NOT NULL,
    target integer NOT NULL,
    "position" integer NOT NULL,
    last_post_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: forums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forums_id_seq OWNED BY forums.id;


--
-- Name: letter_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE letter_items (
    id integer NOT NULL,
    letter_id integer,
    name character varying NOT NULL,
    url character varying NOT NULL,
    last_post_at timestamp without time zone,
    "position" integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: letter_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE letter_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: letter_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE letter_items_id_seq OWNED BY letter_items.id;


--
-- Name: letters; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE letters (
    id integer NOT NULL,
    user_id integer,
    name character varying NOT NULL,
    d1 boolean,
    d2 boolean,
    d3 boolean,
    d4 boolean,
    d5 boolean,
    d6 boolean,
    d7 boolean,
    hour integer NOT NULL,
    minute integer NOT NULL,
    last_post_at timestamp without time zone,
    "position" integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: letters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE letters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: letters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE letters_id_seq OWNED BY letters.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    account_id integer,
    jabber character varying,
    jabber_confirmation_at timestamp without time zone,
    jabber_confirmation_token character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY feed_items ALTER COLUMN id SET DEFAULT nextval('feed_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY feeds ALTER COLUMN id SET DEFAULT nextval('feeds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forums ALTER COLUMN id SET DEFAULT nextval('forums_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY letter_items ALTER COLUMN id SET DEFAULT nextval('letter_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY letters ALTER COLUMN id SET DEFAULT nextval('letters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: feed_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feed_items
    ADD CONSTRAINT feed_items_pkey PRIMARY KEY (id);


--
-- Name: feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feeds
    ADD CONSTRAINT feeds_pkey PRIMARY KEY (id);


--
-- Name: forums_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forums
    ADD CONSTRAINT forums_pkey PRIMARY KEY (id);


--
-- Name: letter_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY letter_items
    ADD CONSTRAINT letter_items_pkey PRIMARY KEY (id);


--
-- Name: letters_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY letters
    ADD CONSTRAINT letters_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_accounts_on_email ON accounts USING btree (email);


--
-- Name: index_accounts_on_email_confirmation_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_accounts_on_email_confirmation_at ON accounts USING btree (email_confirmation_at);


--
-- Name: index_accounts_on_email_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_accounts_on_email_confirmation_token ON accounts USING btree (email_confirmation_token);


--
-- Name: index_feed_items_on_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_feed_items_on_created_at ON feed_items USING btree (created_at);


--
-- Name: index_feed_items_on_feed_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_feed_items_on_feed_id ON feed_items USING btree (feed_id);


--
-- Name: index_feed_items_on_feed_id_and_digest; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_feed_items_on_feed_id_and_digest ON feed_items USING btree (feed_id, digest);


--
-- Name: index_feeds_on_last_fetch_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_feeds_on_last_fetch_at ON feeds USING btree (last_fetch_at);


--
-- Name: index_feeds_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_feeds_on_url ON feeds USING btree (url);


--
-- Name: index_forums_on_last_post_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_on_last_post_at ON forums USING btree (last_post_at);


--
-- Name: index_forums_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_on_name ON forums USING btree (name);


--
-- Name: index_forums_on_target; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_on_target ON forums USING btree (target);


--
-- Name: index_forums_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_on_url ON forums USING btree (url);


--
-- Name: index_forums_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_on_user_id ON forums USING btree (user_id);


--
-- Name: index_letter_items_on_last_post_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letter_items_on_last_post_at ON letter_items USING btree (last_post_at);


--
-- Name: index_letter_items_on_letter_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letter_items_on_letter_id ON letter_items USING btree (letter_id);


--
-- Name: index_letter_items_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letter_items_on_name ON letter_items USING btree (name);


--
-- Name: index_letter_items_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letter_items_on_url ON letter_items USING btree (url);


--
-- Name: index_letters_on_d1; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_d1 ON letters USING btree (d1);


--
-- Name: index_letters_on_d2; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_d2 ON letters USING btree (d2);


--
-- Name: index_letters_on_d3; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_d3 ON letters USING btree (d3);


--
-- Name: index_letters_on_d4; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_d4 ON letters USING btree (d4);


--
-- Name: index_letters_on_d5; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_d5 ON letters USING btree (d5);


--
-- Name: index_letters_on_d6; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_d6 ON letters USING btree (d6);


--
-- Name: index_letters_on_d7; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_d7 ON letters USING btree (d7);


--
-- Name: index_letters_on_hour; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_hour ON letters USING btree (hour);


--
-- Name: index_letters_on_last_post_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_last_post_at ON letters USING btree (last_post_at);


--
-- Name: index_letters_on_minute; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_minute ON letters USING btree (minute);


--
-- Name: index_letters_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_letters_on_user_id ON letters USING btree (user_id);


--
-- Name: index_users_on_account_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_account_id ON users USING btree (account_id);


--
-- Name: index_users_on_jabber; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_jabber ON users USING btree (jabber);


--
-- Name: index_users_on_jabber_confirmation_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_jabber_confirmation_at ON users USING btree (jabber_confirmation_at);


--
-- Name: index_users_on_jabber_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_jabber_confirmation_token ON users USING btree (jabber_confirmation_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_0236efdee3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY letters
    ADD CONSTRAINT fk_rails_0236efdee3 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_0b1095a1ad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY feed_items
    ADD CONSTRAINT fk_rails_0b1095a1ad FOREIGN KEY (feed_id) REFERENCES feeds(id);


--
-- Name: fk_rails_2b6fa86a3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY letter_items
    ADD CONSTRAINT fk_rails_2b6fa86a3d FOREIGN KEY (letter_id) REFERENCES letters(id);


--
-- Name: fk_rails_61ac11da2b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_rails_61ac11da2b FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: fk_rails_99e32c35a4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forums
    ADD CONSTRAINT fk_rails_99e32c35a4 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20160131081004');

INSERT INTO schema_migrations (version) VALUES ('20160131081007');

INSERT INTO schema_migrations (version) VALUES ('20160131111532');

INSERT INTO schema_migrations (version) VALUES ('20160131111535');

INSERT INTO schema_migrations (version) VALUES ('20160131134612');

INSERT INTO schema_migrations (version) VALUES ('20160131134617');

INSERT INTO schema_migrations (version) VALUES ('20160131134630');

