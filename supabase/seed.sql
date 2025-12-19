-- auth.users
INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', 'authenticated', 'authenticated', 'jaeho.lee@snu.ac.kr', NULL, '2025-08-28 04:27:30.258836+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-08-28 07:58:16.594996+00', '{"provider": "github", "userrole": "admin", "providers": ["github"]}', '{"iss": "https://api.github.com", "sub": "9553691", "name": "Jay Lee", "email": "jaeho.lee@snu.ac.kr", "full_name": "Jay Lee the Tester", "user_name": "Zeta611", "avatar_url": "https://avatars.githubusercontent.com/u/9553691?v=4", "provider_id": "9553691", "email_verified": true, "phone_verified": false, "preferred_username": "Zeta611"}', NULL, '2025-08-28 04:27:30.253169+00', '2025-08-28 07:58:16.597091+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '98e607fc-ef95-4272-9b66-62526b576c84', 'authenticated', 'authenticated', 'usera@example.com', NULL, '2025-08-28 04:27:30.258836+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-08-28 04:29:30.162166+00', '{"provider": "github", "providers": ["github"]}', '{"iss": "https://api.github.com", "sub": "1000000", "name": "User A", "email": "usera@example.com", "full_name": "User A", "user_name": "usera", "avatar_url": "", "provider_id": "1000000", "email_verified": true, "phone_verified": false, "preferred_username": "usera"}', NULL, '2025-08-28 04:27:30.253169+00', '2025-08-28 04:29:30.164132+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);

-- category
INSERT INTO "public"."category" ("id", "name", "acronym") VALUES
	(1, 'programming languages', 'PL'),
	(2, 'artificial intelligence', 'AI'),
	(3, 'algorithms', 'AL'),
	(4, 'software engineering', 'SE'),
	(5, 'databases', 'DB'),
	(6, 'operating systems', 'OS'),
	(7, 'network', 'NW'),
	(8, 'graphics & HCI', 'GH'),
	(9, 'architecture', 'AR'),
	(10, 'security', 'SC');

-- jargon
INSERT INTO "public"."jargon" ("name", "author_id", "created_at", "updated_at", "id", "slug") VALUES
	('user A test', '98e607fc-ef95-4272-9b66-62526b576c84', '2025-08-28 07:17:26.730353+00', '2025-08-28 07:17:26.730353+00', '6af4329d-49e6-4110-8938-f43f3cf30194', 'user-a-test'),
	('test', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-08-28 07:17:26.730353+00', '2025-08-28 07:17:26.730353+00', 'd4ed1ffb-896f-47c5-a94e-0fc7cd7ec1f6', 'test'),
	('test 2', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-08-28 07:17:41.53785+00', '2025-08-28 07:17:41.53785+00', 'fed56078-e4f7-41cf-b608-56fa173a82e6', 'test-2');

-- jargon_category: set categories for "test" (PL, DB)
INSERT INTO "public"."jargon_category" ("jargon_id", "category_id") VALUES
	('d4ed1ffb-896f-47c5-a94e-0fc7cd7ec1f6', 1),
	('d4ed1ffb-896f-47c5-a94e-0fc7cd7ec1f6', 5);

-- translation
INSERT INTO "public"."translation" ("name", "author_id", "created_at", "updated_at", "id", "jargon_id", "comment_id", "llm_rank") VALUES
	('테스트 1', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-09-27 07:19:24.414112+00', '2025-09-27 07:19:24.414112+00', 'f46ea122-430a-48e1-a343-880af92916c8', 'fed56078-e4f7-41cf-b608-56fa173a82e6', 'ccab4d26-8641-415c-935b-b982e8968951', 1),
	('테스트 2', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-08-28 07:19:24.414112+00', '2025-08-28 07:19:24.414112+00', '7b1c9053-d772-4e13-bf43-1940ec66534e', 'fed56078-e4f7-41cf-b608-56fa173a82e6', '02c0cd00-3ccc-444b-bdfb-c7c25b444f7e', 0);

-- comment
INSERT INTO "public"."comment" ("content", "author_id", "created_at", "updated_at", "removed", "id", "jargon_id", "translation_id", "parent_id") VALUES
	('test의 번역이 필요해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-08-28 07:17:26.730353+00', '2025-08-28 07:17:26.730353+00', false, '31418f6a-fe63-49a8-a8eb-e6205171a4ac', 'd4ed1ffb-896f-47c5-a94e-0fc7cd7ec1f6', NULL, NULL),
	('test 2의 번역이 필요해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-08-28 07:17:41.53785+00', '2025-08-28 07:17:41.53785+00', false, '205e4e38-5fb1-47e0-94b2-8ab2616fcc74', '6af4329d-49e6-4110-8938-f43f3cf30194', NULL, NULL),
    ('user a test의 번역이 필요해요.', '98e607fc-ef95-4272-9b66-62526b576c84', '2025-08-28 07:17:41.53785+00', '2025-08-28 07:17:41.53785+00', false, '14fe7f09-18d9-4194-a2e1-6ad7e0acea8b', '6af4329d-49e6-4110-8938-f43f3cf30194', NULL, NULL),
	('테스트 1을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-09-27 07:19:24.414112+00', '2025-09-27 07:19:24.414112+00', false, 'ccab4d26-8641-415c-935b-b982e8968951', 'fed56078-e4f7-41cf-b608-56fa173a82e6', 'f46ea122-430a-48e1-a343-880af92916c8', NULL),
	('테스트 2를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', '2025-08-28 07:19:24.414112+00', '2025-08-28 07:19:24.414112+00', false, '02c0cd00-3ccc-444b-bdfb-c7c25b444f7e', 'fed56078-e4f7-41cf-b608-56fa173a82e6', '7b1c9053-d772-4e13-bf43-1940ec66534e', NULL);

-- mock data (collected from easyword.kr home list)
-- jargon (keep `featured` nullable; we set it later via UPDATE)
INSERT INTO "public"."jargon" ("name", "author_id", "created_at", "updated_at", "id", "slug") VALUES
	('calculus of construction', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '42e6fb03-582b-4d97-92bc-5b7571ee1e05', 'calculus-of-construction'),
	('just-in-time compiler', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '67d5b8cf-5313-4657-ba21-3d3b06358c9c', 'just-in-time-compiler'),
	('top-down program synthesis', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'd2eaef5d-9b78-4ec4-b33b-593a1991a319', 'top-down-program-synthesis'),
	('under-approximation', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '7ca21bbe-1e56-473b-848c-2810d355d8aa', 'under-approximation'),
	('over-approximation', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '72c35ef9-f4a5-43c9-88fc-6122f9702282', 'over-approximation'),
	('confluence', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '9d0d62d6-f241-4848-b13c-ba728d6a1d2b', 'confluence'),
	('retrieval augmented generation', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '173b24ca-abb2-4491-89fe-13974e57d9a2', 'retrieval-augmented-generation'),
	('predicate', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'e367c3be-91b8-4558-8f12-d684928d9005', 'predicate'),
	('scope', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'd1edebce-00e7-4530-9cde-f6f0b5dfcd94', 'scope'),
	('proof assistant', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '3f7f6810-d8ed-4c3d-95e5-df2eedcd6c2e', 'proof-assistant'),
	('beta-reduction', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '177382b3-cc03-4dae-a569-5b51ff31cc4b', 'beta-reduction'),
	('vacuously true', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '12627c83-9373-4706-9189-19c38de601e7', 'vacuously-true'),
	('modular programming', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '0f9c5a7d-8f4e-482d-bc64-df9609e43ce4', 'modular-programming'),
	('modular analysis', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '48505ec8-7825-46a6-a0f4-0596d5220ada', 'modular-analysis'),
	('bottom-up program synthesis', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'ddec46be-13f2-45f8-a29e-03a15c3760e8', 'bottom-up-program-synthesis'),
	('contra-variant', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'b0aa4aff-3851-4bfe-b201-9371b82a1a41', 'contra-variant'),
	('co-variant', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '5eb568e8-e1db-4c59-9093-149bc374aa72', 'co-variant'),
	('subtype', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '55186f0a-7153-489d-ad06-860379fa42ea', 'subtype'),
	('normalization', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '662f0219-a948-4c81-bad6-65389642bfbf', 'normalization'),
	('macro', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'bb632397-6c50-4c67-b9c9-5b66d88b3b8d', 'macro'),
	('fault localization', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '8160b90f-e9e2-4ed1-9f1a-75d32039e276', 'fault-localization'),
	('programming by demonstration', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '1cd2f28a-e4af-44b9-a6d9-ecc3f47211d0', 'programming-by-demonstration'),
	('out-of-order execution', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '5bdac616-283a-46e7-afcc-6eb66427b820', 'out-of-order-execution'),
	('iff', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'be89e162-fcf4-424f-b272-81ff0731bec6', 'iff'),
	('transition sequence', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'd3a916df-774a-48aa-bcc9-15d5ebd2c183', 'transition-sequence'),
	('transitional semantics', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '756d6337-97be-4c07-aa9a-3afeedab4d99', 'transitional-semantics'),
	('fully abstract semantics', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '83133b05-bbd4-4c89-be3c-16988d51128d', 'fully-abstract-semantics'),
	('complement', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '676cbf63-63ab-4bf8-87af-e5cb74730e0b', 'complement'),
	('lifting', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '41502bc5-a99b-433b-a2e7-333b71f5549a', 'lifting'),
	('extensional proof', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '286f8076-0899-4dc1-914c-d2c385ac3618', 'extensional-proof');

-- jargon_category
INSERT INTO "public"."jargon_category" ("jargon_id", "category_id") VALUES
	('42e6fb03-582b-4d97-92bc-5b7571ee1e05', 1),
	('67d5b8cf-5313-4657-ba21-3d3b06358c9c', 1),
	('d2eaef5d-9b78-4ec4-b33b-593a1991a319', 1),
	('7ca21bbe-1e56-473b-848c-2810d355d8aa', 1),
	('72c35ef9-f4a5-43c9-88fc-6122f9702282', 1),
	('9d0d62d6-f241-4848-b13c-ba728d6a1d2b', 1),
	('173b24ca-abb2-4491-89fe-13974e57d9a2', 2),
	('e367c3be-91b8-4558-8f12-d684928d9005', 1),
	('d1edebce-00e7-4530-9cde-f6f0b5dfcd94', 1),
	('3f7f6810-d8ed-4c3d-95e5-df2eedcd6c2e', 1),
	('177382b3-cc03-4dae-a569-5b51ff31cc4b', 1),
	('12627c83-9373-4706-9189-19c38de601e7', 1),
	('0f9c5a7d-8f4e-482d-bc64-df9609e43ce4', 1),
	('48505ec8-7825-46a6-a0f4-0596d5220ada', 1),
	('ddec46be-13f2-45f8-a29e-03a15c3760e8', 1),
	('b0aa4aff-3851-4bfe-b201-9371b82a1a41', 1),
	('5eb568e8-e1db-4c59-9093-149bc374aa72', 1),
	('55186f0a-7153-489d-ad06-860379fa42ea', 1),
	('662f0219-a948-4c81-bad6-65389642bfbf', 5),
	('bb632397-6c50-4c67-b9c9-5b66d88b3b8d', 1),
	('8160b90f-e9e2-4ed1-9f1a-75d32039e276', 4),
	('1cd2f28a-e4af-44b9-a6d9-ecc3f47211d0', 1),
	('5bdac616-283a-46e7-afcc-6eb66427b820', 1),
	('be89e162-fcf4-424f-b272-81ff0731bec6', 1),
	('d3a916df-774a-48aa-bcc9-15d5ebd2c183', 1),
	('756d6337-97be-4c07-aa9a-3afeedab4d99', 1),
	('83133b05-bbd4-4c89-be3c-16988d51128d', 1),
	('676cbf63-63ab-4bf8-87af-e5cb74730e0b', 9),
	('41502bc5-a99b-433b-a2e7-333b71f5549a', 1),
	('286f8076-0899-4dc1-914c-d2c385ac3618', 1);

-- translation (one per jargon, with a matching comment row inserted below)
INSERT INTO "public"."translation" ("name", "author_id", "created_at", "updated_at", "id", "jargon_id", "comment_id", "llm_rank") VALUES
	('하나된 계산법', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'cfe8b8fd-2cad-483d-bcf8-a361bac3be20', '42e6fb03-582b-4d97-92bc-5b7571ee1e05', '0ab5949f-0743-4738-aad8-8e03a00d1a63', 1),
	('실행때 번역기', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '4c60d40f-8104-4bc9-9e0f-bde682b5249e', '67d5b8cf-5313-4657-ba21-3d3b06358c9c', 'a2ea40b8-f067-48a8-ae69-aac095d897d1', 1),
	('위에서부터 프로그램 합성해하기', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '14785290-a8ed-450e-a985-921d6cd49fba', 'd2eaef5d-9b78-4ec4-b33b-593a1991a319', '2666aab7-16cb-427d-942e-1345d9877e72', 1),
	('덜어림잡기', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '61d2652a-e14e-4cb4-a66d-c3d7e32e574e', '7ca21bbe-1e56-473b-848c-2810d355d8aa', 'e79345f2-0e77-44e2-b66d-4b2883f836ad', 1),
	('넉넉잡기', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '7eaa3733-1c18-47f3-a8fc-5da15350b4c2', '72c35ef9-f4a5-43c9-88fc-6122f9702282', '37cec8a2-10b8-4049-9134-ca1952023c46', 1),
	('합류', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '1245d735-7d51-459c-b653-bce3a997be65', '9d0d62d6-f241-4848-b13c-ba728d6a1d2b', '9171e187-0c95-40ad-b2ae-f119b56dda06', 1),
	('검색 생성', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '8d1985f7-6ad1-48e9-b6de-61408f75d5eb', '173b24ca-abb2-4491-89fe-13974e57d9a2', '5f72d469-7d7f-4aa3-ab16-40be9acd0144', 1),
	('조건식', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '7acacf7e-da37-46b6-b694-5d2e6cf8a519', 'e367c3be-91b8-4558-8f12-d684928d9005', 'cbdf7db8-de6b-400f-a230-465aa82d51a4', 1),
	('유효범위', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '9d76aa8d-c3dd-4869-8050-2e52b87fec3e', 'd1edebce-00e7-4530-9cde-f6f0b5dfcd94', 'b70323f6-5772-46f8-ba0f-df305082dc90', 1),
	('증명도우미', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '49dad4b7-b607-42ed-b3cf-3b477884ec39', '3f7f6810-d8ed-4c3d-95e5-df2eedcd6c2e', '301b253e-40a5-4937-91b7-1135df514e29', 1),
	('베타계산', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '6238c7bc-4450-4a73-a8ac-69d951a98f61', '177382b3-cc03-4dae-a569-5b51ff31cc4b', '65b26475-b43d-490c-8e19-32ee1bfba098', 1),
	('따질 필요 없다', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '621af9c3-4e5d-465a-9df0-05f18766a1e8', '12627c83-9373-4706-9189-19c38de601e7', '211c40f9-eea8-4b0f-8b6c-2c96c6ba0e16', 1),
	('조립식 프로그래밍', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '108269bf-51b4-4fe3-956b-a62de086f393', '0f9c5a7d-8f4e-482d-bc64-df9609e43ce4', '52b70425-6dc0-4f44-9a1f-e45f49c790d7', 1),
	('조립식 분석', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'cf2014f6-3a8d-4e6a-8907-9c694fe3e54b', '48505ec8-7825-46a6-a0f4-0596d5220ada', '06eda434-1966-4e5c-aad7-83e2581ce84b', 1),
	('부품에서 전체로 프로그램 합성하기', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '62514f33-1e2c-4bf1-a0b9-c42844f7945b', 'ddec46be-13f2-45f8-a29e-03a15c3760e8', 'deb6b5d8-b0c8-4f22-a649-55e3e3d895c2', 1),
	('거슬러 변하는', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '0ff9bfef-b433-4d07-8c83-4b29b7e276ef', 'b0aa4aff-3851-4bfe-b201-9371b82a1a41', '12dfc56a-1792-4f90-a75b-f7cdcdd3917b', 1),
	('맞춰 변하기', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '0f04137a-6141-4253-ac76-31a7cfe25f23', '5eb568e8-e1db-4c59-9093-149bc374aa72', '4c548300-f73b-456e-a800-fbab3dd142f6', 1),
	('하위타입', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '2f074262-6c9f-4513-b553-6b373dba414e', '55186f0a-7153-489d-ad06-860379fa42ea', '8bf96a84-f2c6-40a4-9d2c-eb121b8cad06', 1),
	('표준화', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'a53bf791-746f-4762-8352-77e1b87a30f8', '662f0219-a948-4c81-bad6-65389642bfbf', '86f866fd-b0f2-4440-9865-ea12e4fbcaf2', 1),
	('코드펼치기', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '28b7d3e3-e76d-4981-b08d-e919ca42dc21', 'bb632397-6c50-4c67-b9c9-5b66d88b3b8d', '80da07fb-705b-433d-ac5c-7da8856dd218', 1),
	('결함 위치 식별', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'b6e65631-9af1-40ef-91d2-a8f577b108e8', '8160b90f-e9e2-4ed1-9f1a-75d32039e276', '43872456-2c9d-4c98-ac10-62c59329d632', 1),
	('시연 프로그래밍', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'c76fb9e4-c32e-4a15-a90d-42efc4a67f0c', '1cd2f28a-e4af-44b9-a6d9-ecc3f47211d0', '34a38f04-a68f-421d-bec9-9e819367c9a0', 1),
	('새치기 실행', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'c8afd2df-5afa-49d3-b98b-d1aa0e060c59', '5bdac616-283a-46e7-afcc-6eb66427b820', 'ba93a063-acef-488a-bdf0-12ef6c864cdd', 1),
	('이면이', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '8f332197-52cc-48a5-a04c-4815ed85bbdb', 'be89e162-fcf4-424f-b272-81ff0731bec6', '6e755c73-be01-4111-a616-a294f4a3fe13', 1),
	('실행발자국', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '1bb23db3-b1d8-49e3-872f-0ad493dc42ba', 'd3a916df-774a-48aa-bcc9-15d5ebd2c183', '7060143c-bbef-430a-a101-dd871d3320bc', 1),
	('실행발자국 의미구조', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '8c2d51c9-805c-48d8-bf2f-25acec7e1c7b', '756d6337-97be-4c07-aa9a-3afeedab4d99', '9255e18c-dee3-4d1e-bc21-2cee1e71be4c', 1),
	('찰떡같은 의미구조', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'ed1f1177-c92e-4c6a-8067-223847a00b50', '83133b05-bbd4-4c89-be3c-16988d51128d', '81c94bb2-d691-423b-b9c6-6d9989c5ad08', 1),
	('채움수', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'a6080866-235c-41af-954f-bf5d565900a5', '676cbf63-63ab-4bf8-87af-e5cb74730e0b', '0b1cc517-6f4f-4e1e-91c4-4ad15c4782ed', 1),
	('이고가기 변환', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), 'a27f7e5c-f424-4827-8ef2-1c0dc2da309e', '41502bc5-a99b-433b-a2e7-333b71f5549a', '0074109c-3540-4b06-bb2f-437c0ad159ee', 1),
	('겉보기 증명', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), '07e1f9d0-5456-4350-b711-6772c83aa3d8', '286f8076-0899-4dc1-914c-d2c385ac3618', '3e6655d9-e867-4da3-9643-b1b3dbfd0dd4', 1);

-- translation suggestion comments (ids match translation.comment_id)
INSERT INTO "public"."comment" ("content", "author_id", "created_at", "updated_at", "removed", "id", "jargon_id", "translation_id", "parent_id") VALUES
	('하나된 계산법을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '0ab5949f-0743-4738-aad8-8e03a00d1a63', '42e6fb03-582b-4d97-92bc-5b7571ee1e05', 'cfe8b8fd-2cad-483d-bcf8-a361bac3be20', NULL),
	('실행때 번역기를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, 'a2ea40b8-f067-48a8-ae69-aac095d897d1', '67d5b8cf-5313-4657-ba21-3d3b06358c9c', '4c60d40f-8104-4bc9-9e0f-bde682b5249e', NULL),
	('위에서부터 프로그램 합성해하기를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '2666aab7-16cb-427d-942e-1345d9877e72', 'd2eaef5d-9b78-4ec4-b33b-593a1991a319', '14785290-a8ed-450e-a985-921d6cd49fba', NULL),
	('덜어림잡기를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, 'e79345f2-0e77-44e2-b66d-4b2883f836ad', '7ca21bbe-1e56-473b-848c-2810d355d8aa', '61d2652a-e14e-4cb4-a66d-c3d7e32e574e', NULL),
	('넉넉잡기를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '37cec8a2-10b8-4049-9134-ca1952023c46', '72c35ef9-f4a5-43c9-88fc-6122f9702282', '7eaa3733-1c18-47f3-a8fc-5da15350b4c2', NULL),
	('합류를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '9171e187-0c95-40ad-b2ae-f119b56dda06', '9d0d62d6-f241-4848-b13c-ba728d6a1d2b', '1245d735-7d51-459c-b653-bce3a997be65', NULL),
	('검색 생성을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '5f72d469-7d7f-4aa3-ab16-40be9acd0144', '173b24ca-abb2-4491-89fe-13974e57d9a2', '8d1985f7-6ad1-48e9-b6de-61408f75d5eb', NULL),
	('조건식을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, 'cbdf7db8-de6b-400f-a230-465aa82d51a4', 'e367c3be-91b8-4558-8f12-d684928d9005', '7acacf7e-da37-46b6-b694-5d2e6cf8a519', NULL),
	('유효범위를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, 'b70323f6-5772-46f8-ba0f-df305082dc90', 'd1edebce-00e7-4530-9cde-f6f0b5dfcd94', '9d76aa8d-c3dd-4869-8050-2e52b87fec3e', NULL),
	('증명도우미를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '301b253e-40a5-4937-91b7-1135df514e29', '3f7f6810-d8ed-4c3d-95e5-df2eedcd6c2e', '49dad4b7-b607-42ed-b3cf-3b477884ec39', NULL),
	('베타계산을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '65b26475-b43d-490c-8e19-32ee1bfba098', '177382b3-cc03-4dae-a569-5b51ff31cc4b', '6238c7bc-4450-4a73-a8ac-69d951a98f61', NULL),
	('따질 필요 없다를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '211c40f9-eea8-4b0f-8b6c-2c96c6ba0e16', '12627c83-9373-4706-9189-19c38de601e7', '621af9c3-4e5d-465a-9df0-05f18766a1e8', NULL),
	('조립식 프로그래밍을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '52b70425-6dc0-4f44-9a1f-e45f49c790d7', '0f9c5a7d-8f4e-482d-bc64-df9609e43ce4', '108269bf-51b4-4fe3-956b-a62de086f393', NULL),
	('조립식 분석을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '06eda434-1966-4e5c-aad7-83e2581ce84b', '48505ec8-7825-46a6-a0f4-0596d5220ada', 'cf2014f6-3a8d-4e6a-8907-9c694fe3e54b', NULL),
	('부품에서 전체로 프로그램 합성하기를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, 'deb6b5d8-b0c8-4f22-a649-55e3e3d895c2', 'ddec46be-13f2-45f8-a29e-03a15c3760e8', '62514f33-1e2c-4bf1-a0b9-c42844f7945b', NULL),
	('거슬러 변하는을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '12dfc56a-1792-4f90-a75b-f7cdcdd3917b', 'b0aa4aff-3851-4bfe-b201-9371b82a1a41', '0ff9bfef-b433-4d07-8c83-4b29b7e276ef', NULL),
	('맞춰 변하기를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '4c548300-f73b-456e-a800-fbab3dd142f6', '5eb568e8-e1db-4c59-9093-149bc374aa72', '0f04137a-6141-4253-ac76-31a7cfe25f23', NULL),
	('하위타입을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '8bf96a84-f2c6-40a4-9d2c-eb121b8cad06', '55186f0a-7153-489d-ad06-860379fa42ea', '2f074262-6c9f-4513-b553-6b373dba414e', NULL),
	('표준화를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '86f866fd-b0f2-4440-9865-ea12e4fbcaf2', '662f0219-a948-4c81-bad6-65389642bfbf', 'a53bf791-746f-4762-8352-77e1b87a30f8', NULL),
	('코드펼치기를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '80da07fb-705b-433d-ac5c-7da8856dd218', 'bb632397-6c50-4c67-b9c9-5b66d88b3b8d', '28b7d3e3-e76d-4981-b08d-e919ca42dc21', NULL),
	('결함 위치 식별을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '43872456-2c9d-4c98-ac10-62c59329d632', '8160b90f-e9e2-4ed1-9f1a-75d32039e276', 'b6e65631-9af1-40ef-91d2-a8f577b108e8', NULL),
	('시연 프로그래밍을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '34a38f04-a68f-421d-bec9-9e819367c9a0', '1cd2f28a-e4af-44b9-a6d9-ecc3f47211d0', 'c76fb9e4-c32e-4a15-a90d-42efc4a67f0c', NULL),
	('새치기 실행을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, 'ba93a063-acef-488a-bdf0-12ef6c864cdd', '5bdac616-283a-46e7-afcc-6eb66427b820', 'c8afd2df-5afa-49d3-b98b-d1aa0e060c59', NULL),
	('이면이를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '6e755c73-be01-4111-a616-a294f4a3fe13', 'be89e162-fcf4-424f-b272-81ff0731bec6', '8f332197-52cc-48a5-a04c-4815ed85bbdb', NULL),
	('실행발자국을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '7060143c-bbef-430a-a101-dd871d3320bc', 'd3a916df-774a-48aa-bcc9-15d5ebd2c183', '1bb23db3-b1d8-49e3-872f-0ad493dc42ba', NULL),
	('실행발자국 의미구조를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '9255e18c-dee3-4d1e-bc21-2cee1e71be4c', '756d6337-97be-4c07-aa9a-3afeedab4d99', '8c2d51c9-805c-48d8-bf2f-25acec7e1c7b', NULL),
	('찰떡같은 의미구조를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '81c94bb2-d691-423b-b9c6-6d9989c5ad08', '83133b05-bbd4-4c89-be3c-16988d51128d', 'ed1f1177-c92e-4c6a-8067-223847a00b50', NULL),
	('채움수를 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '0b1cc517-6f4f-4e1e-91c4-4ad15c4782ed', '676cbf63-63ab-4bf8-87af-e5cb74730e0b', 'a6080866-235c-41af-954f-bf5d565900a5', NULL),
	('이고가기 변환을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '0074109c-3540-4b06-bb2f-437c0ad159ee', '41502bc5-a99b-433b-a2e7-333b71f5549a', 'a27f7e5c-f424-4827-8ef2-1c0dc2da309e', NULL),
	('겉보기 증명을 제안해요.', 'faa73ac2-bbed-40ea-a392-53baf1a946fe', now(), now(), false, '3e6655d9-e867-4da3-9643-b1b3dbfd0dd4', '286f8076-0899-4dc1-914c-d2c385ac3618', '07e1f9d0-5456-4350-b711-6772c83aa3d8', NULL);

-- featured ranking (1 is top)
UPDATE public.jargon SET featured = 1 WHERE id = '67d5b8cf-5313-4657-ba21-3d3b06358c9c'; -- just-in-time compiler
UPDATE public.jargon SET featured = 2 WHERE id = '173b24ca-abb2-4491-89fe-13974e57d9a2'; -- retrieval augmented generation
UPDATE public.jargon SET featured = 3 WHERE id = '662f0219-a948-4c81-bad6-65389642bfbf'; -- normalization
UPDATE public.jargon SET featured = 4 WHERE id = 'bb632397-6c50-4c67-b9c9-5b66d88b3b8d'; -- macro
UPDATE public.jargon SET featured = 5 WHERE id = '5bdac616-283a-46e7-afcc-6eb66427b820'; -- out-of-order execution
UPDATE public.jargon SET featured = 6 WHERE id = '3f7f6810-d8ed-4c3d-95e5-df2eedcd6c2e'; -- proof assistant
UPDATE public.jargon SET featured = 7 WHERE id = 'd2eaef5d-9b78-4ec4-b33b-593a1991a319'; -- top-down program synthesis
UPDATE public.jargon SET featured = 8 WHERE id = '72c35ef9-f4a5-43c9-88fc-6122f9702282'; -- over-approximation
