-- create mv_creation_metadata table
CREATE TABLE "APP"."MV_CREATION_METADATA" ("MV_CREATION_METADATA_ID" BIGINT NOT NULL, "DB_NAME" VARCHAR(128) NOT NULL, "TBL_NAME" VARCHAR(256) NOT NULL, "TXN_LIST" CLOB);
CREATE TABLE "APP"."MV_TABLES_USED" ("MV_CREATION_METADATA_ID" BIGINT NOT NULL, "TBL_ID" BIGINT NOT NULL);
ALTER TABLE "APP"."MV_CREATION_METADATA" ADD CONSTRAINT "MV_CREATION_METADATA_PK" PRIMARY KEY ("MV_CREATION_METADATA_ID");
CREATE UNIQUE INDEX "APP"."MV_UNIQUE_TABLE" ON "APP"."MV_CREATION_METADATA" ("TBL_NAME", "DB_NAME");
ALTER TABLE "APP"."MV_TABLES_USED" ADD CONSTRAINT "MV_TABLES_USED_FK1" FOREIGN KEY ("MV_CREATION_METADATA_ID") REFERENCES "APP"."MV_CREATION_METADATA" ("MV_CREATION_METADATA_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "APP"."MV_TABLES_USED" ADD CONSTRAINT "MV_TABLES_USED_FK2" FOREIGN KEY ("TBL_ID") REFERENCES "APP"."TBLS" ("TBL_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- modify completed_txn_components table
ALTER TABLE "APP"."COMPLETED_TXN_COMPONENTS" ADD "CTC_TIMESTAMP" timestamp;
UPDATE "APP"."TBLS" SET "IS_REWRITE_ENABLED" = CURRENT_TIMESTAMP;
ALTER TABLE "APP"."COMPLETED_TXN_COMPONENTS" ALTER COLUMN "CTC_TIMESTAMP" SET DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE "APP"."COMPLETED_TXN_COMPONENTS" ALTER COLUMN "CTC_TIMESTAMP" NOT NULL;
CREATE INDEX "APP"."COMPLETED_TXN_COMPONENTS_IDX" ON "APP"."COMPLETED_TXN_COMPONENTS" ("CTC_DATABASE", "CTC_TABLE", "CTC_PARTITION");
