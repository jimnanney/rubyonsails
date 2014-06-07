CREATE TABLE "accounts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "oauth_token" varchar(255) NOT NULL, "oauth_uid" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "email" varchar(255) NOT NULL, "bio" text, "created_at" datetime, "updated_at" datetime, "reviewer" boolean DEFAULT 'f', "email_verified" boolean DEFAULT 'f', "submitter" boolean DEFAULT 'f', "admin" boolean DEFAULT 'f');
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "index_accounts_on_email" ON "accounts" ("email");
CREATE INDEX "index_accounts_on_oauth_token" ON "accounts" ("oauth_token");
CREATE UNIQUE INDEX "index_accounts_on_oauth_uid" ON "accounts" ("oauth_uid");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20140222012826');

