--
-- Class Estimation as table estimation
--

CREATE TABLE "estimation" (
  "id" serial,
  "name" text NOT NULL,
  "topic" text NOT NULL,
  "storypoint" text NOT NULL
);

ALTER TABLE ONLY "estimation"
  ADD CONSTRAINT estimation_pkey PRIMARY KEY (id);


