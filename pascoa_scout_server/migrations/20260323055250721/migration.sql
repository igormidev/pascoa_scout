BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_analysis_state" (
    "id" bigserial PRIMARY KEY,
    "jobInfoId" bigint NOT NULL,
    "createdJobInfoAt" timestamp without time zone NOT NULL,
    "createdJobScoringAt" timestamp without time zone,
    "createdJobAiResponsesAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "job_analysis_state_job_info_unique_idx" ON "job_analysis_state" USING btree ("jobInfoId");
CREATE INDEX "job_analysis_state_created_job_info_at_idx" ON "job_analysis_state" USING btree ("createdJobInfoAt");
CREATE INDEX "job_analysis_state_created_job_scoring_at_idx" ON "job_analysis_state" USING btree ("createdJobScoringAt");
CREATE INDEX "job_analysis_state_created_job_ai_responses_at_idx" ON "job_analysis_state" USING btree ("createdJobAiResponsesAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_automation_runtime" (
    "id" bigserial PRIMARY KEY,
    "singletonKey" text NOT NULL,
    "currentStep" text NOT NULL,
    "currentStepStartedAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "lastSuccessfulJobSyncAt" timestamp without time zone,
    "lastSuccessfulScoringAt" timestamp without time zone,
    "lastSuccessfulProposalGenerationAt" timestamp without time zone,
    "lastErrorMessage" text,
    "lastErrorAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "job_automation_runtime_singleton_key_unique_idx" ON "job_automation_runtime" USING btree ("singletonKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_automation_settings" (
    "id" bigserial PRIMARY KEY,
    "singletonKey" text NOT NULL,
    "jobFilter" json NOT NULL,
    "isJobFetchingPaused" boolean NOT NULL,
    "scoreBatchSize" bigint NOT NULL,
    "proposalBatchSize" bigint NOT NULL,
    "upworkSyncResultsPerPage" bigint NOT NULL,
    "proposalMinimumScorePercentage" bigint NOT NULL,
    "loopDelayMinutes" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_automation_settings_singleton_key_unique_idx" ON "job_automation_settings" USING btree ("singletonKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_curriculum_profile" (
    "id" bigserial PRIMARY KEY,
    "singletonKey" text NOT NULL,
    "markdownText" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_curriculum_profile_singleton_key_unique_idx" ON "job_curriculum_profile" USING btree ("singletonKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_info" (
    "id" bigserial PRIMARY KEY,
    "upworkId" text NOT NULL,
    "subId" text,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "url" text NOT NULL,
    "relativeDate" text,
    "relativeDateMinutes" bigint,
    "absoluteDate" text,
    "absoluteDateTime" timestamp without time zone,
    "budget" text,
    "fixedPriceAmount" double precision,
    "hourlyMinRate" double precision,
    "hourlyMaxRate" double precision,
    "jobType" text NOT NULL,
    "experienceLevel" text NOT NULL,
    "clientLocation" json,
    "paymentVerifiedStatus" text NOT NULL,
    "allowedApplicantCountries" json NOT NULL,
    "clientName" text,
    "clientNameConfidencePercent" double precision,
    "clientAvgHourlyRate" double precision,
    "clientRating" double precision,
    "clientHireRatePercent" double precision,
    "clientTotalSpent" double precision,
    "tags" json NOT NULL,
    "hasHired" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_info_upwork_id_unique_idx" ON "job_info" USING btree ("upworkId");
CREATE INDEX "job_info_absolute_date_time_idx" ON "job_info" USING btree ("absoluteDateTime");
CREATE INDEX "job_info_relative_date_minutes_idx" ON "job_info" USING btree ("relativeDateMinutes");
CREATE INDEX "job_info_fixed_price_amount_idx" ON "job_info" USING btree ("fixedPriceAmount");
CREATE INDEX "job_info_hourly_min_rate_idx" ON "job_info" USING btree ("hourlyMinRate");
CREATE INDEX "job_info_hourly_max_rate_idx" ON "job_info" USING btree ("hourlyMaxRate");
CREATE INDEX "job_info_client_avg_hourly_rate_idx" ON "job_info" USING btree ("clientAvgHourlyRate");
CREATE INDEX "job_info_client_rating_idx" ON "job_info" USING btree ("clientRating");
CREATE INDEX "job_info_client_hire_rate_idx" ON "job_info" USING btree ("clientHireRatePercent");
CREATE INDEX "job_info_client_name_confidence_idx" ON "job_info" USING btree ("clientNameConfidencePercent");
CREATE INDEX "job_info_client_total_spent_idx" ON "job_info" USING btree ("clientTotalSpent");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_opportunity_preference" (
    "id" bigserial PRIMARY KEY,
    "singletonKey" text NOT NULL,
    "markdownText" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_opportunity_preference_singleton_key_unique_idx" ON "job_opportunity_preference" USING btree ("singletonKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_proposal" (
    "id" bigserial PRIMARY KEY,
    "jobAnalysisStateId" bigint NOT NULL,
    "aiGeneratedCoverLetterText" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_proposal_job_analysis_state_unique_idx" ON "job_proposal" USING btree ("jobAnalysisStateId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_proposal_answer_to_question" (
    "id" bigserial PRIMARY KEY,
    "jobProposalId" bigint NOT NULL,
    "relatedQuestionId" bigint NOT NULL,
    "aiGeneratedAnswerText" text NOT NULL
);

-- Indexes
CREATE INDEX "job_proposal_answer_job_proposal_id_idx" ON "job_proposal_answer_to_question" USING btree ("jobProposalId");
CREATE UNIQUE INDEX "job_proposal_answer_related_question_unique_idx" ON "job_proposal_answer_to_question" USING btree ("relatedQuestionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_proposal_style_preference" (
    "id" bigserial PRIMARY KEY,
    "singletonKey" text NOT NULL,
    "markdownText" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_proposal_style_preference_singleton_key_unique_idx" ON "job_proposal_style_preference" USING btree ("singletonKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_score" (
    "id" bigserial PRIMARY KEY,
    "jobAnalysisStateId" bigint NOT NULL,
    "scorePercentage" bigint NOT NULL,
    "aiScoreJustificationText" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "job_score_job_analysis_state_unique_idx" ON "job_score" USING btree ("jobAnalysisStateId");
CREATE INDEX "job_score_score_percentage_idx" ON "job_score" USING btree ("scorePercentage");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "question" (
    "id" bigserial PRIMARY KEY,
    "question" text NOT NULL,
    "positionIndex" bigint NOT NULL,
    "jobInfoId" bigint
);

-- Indexes
CREATE INDEX "question_job_info_id_idx" ON "question" USING btree ("jobInfoId");
CREATE UNIQUE INDEX "question_job_info_position_unique_idx" ON "question" USING btree ("jobInfoId", "positionIndex");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_analysis_state"
    ADD CONSTRAINT "job_analysis_state_fk_0"
    FOREIGN KEY("jobInfoId")
    REFERENCES "job_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_proposal"
    ADD CONSTRAINT "job_proposal_fk_0"
    FOREIGN KEY("jobAnalysisStateId")
    REFERENCES "job_analysis_state"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_proposal_answer_to_question"
    ADD CONSTRAINT "job_proposal_answer_to_question_fk_0"
    FOREIGN KEY("jobProposalId")
    REFERENCES "job_proposal"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "job_proposal_answer_to_question"
    ADD CONSTRAINT "job_proposal_answer_to_question_fk_1"
    FOREIGN KEY("relatedQuestionId")
    REFERENCES "question"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "job_score"
    ADD CONSTRAINT "job_score_fk_0"
    FOREIGN KEY("jobAnalysisStateId")
    REFERENCES "job_analysis_state"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "question"
    ADD CONSTRAINT "question_fk_0"
    FOREIGN KEY("jobInfoId")
    REFERENCES "job_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR pascoa_scout
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pascoa_scout', '20260323055250721', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260323055250721', "timestamp" = now();

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
