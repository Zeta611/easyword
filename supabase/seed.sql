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
