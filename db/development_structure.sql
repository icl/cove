CREATE TABLE "job_tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "job_id" integer, "tag_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "job_videos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "job_id" integer, "video_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "jobs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "budget" float, "spent" float, "active" boolean, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "rails_admin_histories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "message" varchar(255), "username" varchar(255), "item" integer, "table" varchar(255), "month" integer(2), "year" integer(5), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "training_tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "training_id" integer, "tag_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "training_videos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "training_id" integer, "video_training_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "trainings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime, "updated_at" datetime, "kind" varchar(255) DEFAULT 'turk');
CREATE TABLE "video_tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "video_id" integer, "tag_id" integer, "created_at" datetime, "updated_at" datetime, "job_id" integer, "user_id" integer, "start_time" decimal, "end_time" decimal);
CREATE TABLE "video_trainings" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "filepath" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "videos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "filepath" varchar(255), "duration" float, "starttime" datetime, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "work_records" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "job_id" integer, "user_id" integer, "video_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_histories_on_item_and_table_and_month_and_year" ON "rails_admin_histories" ("item", "table", "month", "year");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20110419040011');

INSERT INTO schema_migrations (version) VALUES ('20110419234215');

INSERT INTO schema_migrations (version) VALUES ('20110419235031');

INSERT INTO schema_migrations (version) VALUES ('20110419235043');

INSERT INTO schema_migrations (version) VALUES ('20110420000241');

INSERT INTO schema_migrations (version) VALUES ('20110420001503');

INSERT INTO schema_migrations (version) VALUES ('20110422014857');

INSERT INTO schema_migrations (version) VALUES ('20110422014858');

INSERT INTO schema_migrations (version) VALUES ('20110422014859');

INSERT INTO schema_migrations (version) VALUES ('20110427222637');

INSERT INTO schema_migrations (version) VALUES ('20110428004102');

INSERT INTO schema_migrations (version) VALUES ('20110429232826');

INSERT INTO schema_migrations (version) VALUES ('20110429232847');

INSERT INTO schema_migrations (version) VALUES ('20110502233447');

INSERT INTO schema_migrations (version) VALUES ('20110505231331');

INSERT INTO schema_migrations (version) VALUES ('20110507005720');

INSERT INTO schema_migrations (version) VALUES ('20110507014200');

INSERT INTO schema_migrations (version) VALUES ('20110507014407');

INSERT INTO schema_migrations (version) VALUES ('20110507015304');

INSERT INTO schema_migrations (version) VALUES ('20110507015501');

INSERT INTO schema_migrations (version) VALUES ('20110513012458');

INSERT INTO schema_migrations (version) VALUES ('20110514204526');

INSERT INTO schema_migrations (version) VALUES ('20110514205422');

INSERT INTO schema_migrations (version) VALUES ('20110515193643');

INSERT INTO schema_migrations (version) VALUES ('20110515193725');