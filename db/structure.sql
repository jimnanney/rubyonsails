CREATE TABLE "accounts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "oauth_token" varchar(255) NOT NULL, "oauth_uid" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "email" varchar(255) NOT NULL, "bio" text, "created_at" datetime, "updated_at" datetime, "reviewer" boolean DEFAULT 'f', "submitter" boolean DEFAULT 'f', "admin" boolean DEFAULT 'f');
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "submission_id" integer, "comment_id" integer, "account_id" integer, "text" text NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "submissions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "account_id" integer, "title" varchar(255) NOT NULL, "current" boolean DEFAULT 't', "draft" boolean DEFAULT 'f', "text" text NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "votes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "submission_id" integer, "account_id" integer, "approved" boolean DEFAULT 'f', "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_accounts_on_email" ON "accounts" ("email");
CREATE INDEX "index_accounts_on_oauth_token" ON "accounts" ("oauth_token");
CREATE UNIQUE INDEX "index_accounts_on_oauth_uid" ON "accounts" ("oauth_uid");
CREATE INDEX "index_comments_on_account_id" ON "comments" ("account_id");
CREATE INDEX "index_comments_on_comment_id" ON "comments" ("comment_id");
CREATE INDEX "index_comments_on_submission_id" ON "comments" ("submission_id");
CREATE INDEX "index_votes_on_account_id" ON "votes" ("account_id");
CREATE INDEX "index_votes_on_approved" ON "votes" ("approved");
CREATE INDEX "index_votes_on_submission_id" ON "votes" ("submission_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20140222012826');

