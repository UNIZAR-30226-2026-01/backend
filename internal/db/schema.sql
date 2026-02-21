CREATE TABLE placeholder (
    id SERIAL PRIMARY KEY,
    data TEXT NOT NULL
);

CREATE TYPE "winner" AS ENUM (
	'P1_WINS',
	'P2_WINS',
	'DRAW',
	'NONE'
);

CREATE TYPE "board_type" AS ENUM (
	'ACE',
	'CURIOSITY',
	'SOPHIE',
	'GRAIL',
	'MERCURY'
);

CREATE TYPE "match_type" AS ENUM (
	'RANKED',
	'FRIENDLY',
	'PRIVATE',
	'BOTS'
);

CREATE TYPE "termination" AS ENUM (
	'OUT_OF_TIME',
	'SURRENDER',
	'LASER',
	'UNFINISHED'
);

CREATE TYPE "item_type" AS ENUM (
	'board_skin',
	'piece_skin'
);

CREATE TABLE IF NOT EXISTS "account" (
	"account_id" BIGSERIAL NOT NULL UNIQUE,
	"password_hash" TEXT NOT NULL,
	"mail" TEXT NOT NULL UNIQUE,
	"username" TEXT,
	-- Estado de la cuenta:
	-- Borrada, Bloqueada, Activa...
	-- 
	"is_deleted" BOOLEAN,
	"level" INTEGER,
	"xp" INTEGER,
	"money" INTEGER,
	"elo_blitz" INTEGER,
	"elo_bullet" INTEGER,
	"elo_rapid" INTEGER,
	"elo_classic" INTEGER,
	"board_skin" INTEGER,
	"piece_skin" INTEGER,
	PRIMARY KEY("account_id"),
	UNIQUE ("board_skin", "piece_skin")
);

CREATE TABLE IF NOT EXISTS "shop_item" (
	"item_id" SERIAL NOT NULL UNIQUE,
	"price" INTEGER,
	"level_requisite" INTEGER,
	"item_type" ITEM_TYPE,
	PRIMARY KEY("item_id")
);

CREATE TABLE IF NOT EXISTS "item_owner" (
	"user_id" BIGINT NOT NULL,
	"item_id" INTEGER NOT NULL,
	PRIMARY KEY("user_id", "item_id"),
	FOREIGN KEY("user_id") REFERENCES "account"("account_id"),
	FOREIGN KEY("item_id") REFERENCES "shop_item"("item_id")
);

ALTER TABLE "account"
	ADD FOREIGN KEY("board_skin") REFERENCES "shop_item"("item_id");
ALTER TABLE "account"
	ADD FOREIGN KEY("piece_skin") REFERENCES "shop_item"("item_id");

CREATE TABLE IF NOT EXISTS "match" (
	"match_id" BIGSERIAL NOT NULL UNIQUE,
	"p1_id" BIGINT NOT NULL,
	"p2_id" BIGINT NOT NULL,
	"p1_elo" INTEGER,
	"p2_elo" INTEGER,
	"date" TIMESTAMPTZ,
	"winner" WINNER,
	"termination" TERMINATION,
	"match_type" MATCH_TYPE,
	"board" BOARD_TYPE,
	"movement_history" TEXT,
	"time_base" INTEGER,
	"time_increment" INTEGER,
	PRIMARY KEY("match_id"),
	FOREIGN KEY("p1_id") REFERENCES "account"("account_id"),
	FOREIGN KEY("p2_id") REFERENCES "account"("account_id")
);




CREATE TABLE IF NOT EXISTS "friendship" (
	"user1_id" BIGINT NOT NULL,
	"user2_id" BIGINT NOT NULL,
	"accepted_1" BOOLEAN,
	"accepted_2" BOOLEAN,
	PRIMARY KEY("user1_id", "user2_id"),
	FOREIGN KEY("user1_id") REFERENCES "account"("account_id"),
	FOREIGN KEY("user2_id") REFERENCES "account"("account_id")
);




