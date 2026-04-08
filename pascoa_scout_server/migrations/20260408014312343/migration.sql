BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_proposal_milestone" (
    "id" bigserial PRIMARY KEY,
    "jobProposalId" bigint NOT NULL,
    "positionIndex" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "suggestedPrice" double precision NOT NULL
);

-- Indexes
CREATE INDEX "job_proposal_milestone_job_proposal_id_idx" ON "job_proposal_milestone" USING btree ("jobProposalId");
CREATE UNIQUE INDEX "job_proposal_milestone_job_proposal_position_unique_idx" ON "job_proposal_milestone" USING btree ("jobProposalId", "positionIndex");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_proposal_milestone"
    ADD CONSTRAINT "job_proposal_milestone_fk_0"
    FOREIGN KEY("jobProposalId")
    REFERENCES "job_proposal"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pascoa_scout
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pascoa_scout', '20260408014312343', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260408014312343', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
