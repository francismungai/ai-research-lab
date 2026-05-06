SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict A06m3vRGyuYFm8MP1wxL8LORlBBUGX4P7oKyQyPhguGHG2PZaMOcMG6iCNBDU1F

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '01df5d90-c1ad-482a-a29f-76971c5b7faa', 'authenticated', 'authenticated', 'zachary.tschetter@usd.edu', '$2a$10$Bw8i8hRpxsd90h/c8lAVUOnQ4jq83sZ1HvdkaiNDixhpbS3cDaGhW', '2026-05-05 15:45:16.850738+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-05 18:41:30.278888+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-05-05 15:45:16.825953+00', '2026-05-06 13:45:37.401979+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '195c37b1-c99c-4289-8fc5-d2f7037c6224', 'authenticated', 'authenticated', 'frankmungai77@gmail.com', '$2a$10$fnvkGqGkNMJ8mPEKeuMcy.Fub4v3wZPpuIFQpblX/mXcyPcSGXeOm', '2026-04-07 20:00:25.050471+00', NULL, '', '2026-04-07 20:00:03.928367+00', '', NULL, '', '', NULL, '2026-05-02 18:13:57.91166+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "195c37b1-c99c-4289-8fc5-d2f7037c6224", "email": "frankmungai77@gmail.com", "password_hint": "test", "email_verified": true, "phone_verified": false}', NULL, '2026-04-07 20:00:03.877627+00', '2026-05-06 15:09:51.022736+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '8c037f81-047d-438e-81fd-60f05fe39a9b', 'authenticated', 'authenticated', 'francis.mungai@coyotes.usd.edu', '$2a$10$WYp/e9b4wJ.Fia/C0.WZDOY33nadt8PpkJJFNc3k1p9EPRBEoXwhe', '2026-05-01 16:53:31.834653+00', NULL, '', '2026-05-01 16:53:19.463963+00', '', NULL, '', '', NULL, '2026-05-01 17:05:37.625067+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "8c037f81-047d-438e-81fd-60f05fe39a9b", "email": "francis.mungai@coyotes.usd.edu", "password_hint": "normal fast", "email_verified": true, "phone_verified": false}', NULL, '2026-05-01 16:53:19.423849+00', '2026-05-01 17:05:37.634958+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '4e6b16c7-c0c0-4642-afff-9a5c144a1bf5', 'authenticated', 'authenticated', 'kc.santosh@usd.edu', '$2a$10$BsMY7v30rh0iutIFiJLfl.XG/.N2a2QefGBOzfNhzVNjvNISN9vL2', '2026-05-01 17:09:54.333121+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-05-01 17:09:54.329005+00', '2026-05-01 17:09:54.333856+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'bcb6c457-325c-44c7-905a-3f08fae60d2e', 'authenticated', 'authenticated', 'rodrigue.rizk@usd.edu', '$2a$10$SN9FP/tRLL/kPDe4VdQOoOyNmcQzWoiccjaWvQwrKIqqzjO1ybCpi', '2026-05-01 17:09:23.235517+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-05-01 17:14:56.074337+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-05-01 17:09:23.211891+00', '2026-05-01 17:14:56.081484+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('195c37b1-c99c-4289-8fc5-d2f7037c6224', '195c37b1-c99c-4289-8fc5-d2f7037c6224', '{"sub": "195c37b1-c99c-4289-8fc5-d2f7037c6224", "email": "frankmungai77@gmail.com", "password_hint": "test", "email_verified": true, "phone_verified": false}', 'email', '2026-04-07 20:00:03.914143+00', '2026-04-07 20:00:03.914198+00', '2026-04-07 20:00:03.914198+00', '8f2a7345-ffc4-418a-a1ee-703db8915c0e'),
	('8c037f81-047d-438e-81fd-60f05fe39a9b', '8c037f81-047d-438e-81fd-60f05fe39a9b', '{"sub": "8c037f81-047d-438e-81fd-60f05fe39a9b", "email": "francis.mungai@coyotes.usd.edu", "password_hint": "normal fast", "email_verified": true, "phone_verified": false}', 'email', '2026-05-01 16:53:19.455398+00', '2026-05-01 16:53:19.455456+00', '2026-05-01 16:53:19.455456+00', 'cc250ece-0a49-454b-adc7-8288aadc92e6'),
	('bcb6c457-325c-44c7-905a-3f08fae60d2e', 'bcb6c457-325c-44c7-905a-3f08fae60d2e', '{"sub": "bcb6c457-325c-44c7-905a-3f08fae60d2e", "email": "rodrigue.rizk@usd.edu", "email_verified": false, "phone_verified": false}', 'email', '2026-05-01 17:09:23.233648+00', '2026-05-01 17:09:23.233703+00', '2026-05-01 17:09:23.233703+00', '46dc1f7a-0cc4-4895-a778-8c9de4f9f657'),
	('4e6b16c7-c0c0-4642-afff-9a5c144a1bf5', '4e6b16c7-c0c0-4642-afff-9a5c144a1bf5', '{"sub": "4e6b16c7-c0c0-4642-afff-9a5c144a1bf5", "email": "kc.santosh@usd.edu", "email_verified": false, "phone_verified": false}', 'email', '2026-05-01 17:09:54.331633+00', '2026-05-01 17:09:54.331685+00', '2026-05-01 17:09:54.331685+00', '8f1650b0-fc36-46d8-a783-ad32d54e6b9c'),
	('01df5d90-c1ad-482a-a29f-76971c5b7faa', '01df5d90-c1ad-482a-a29f-76971c5b7faa', '{"sub": "01df5d90-c1ad-482a-a29f-76971c5b7faa", "email": "zachary.tschetter@usd.edu", "email_verified": false, "phone_verified": false}', 'email', '2026-05-05 15:45:16.845536+00', '2026-05-05 15:45:16.846124+00', '2026-05-05 15:45:16.846124+00', '9d136ac8-4bae-4f88-ac4f-c124906b7b58');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('f0f1aa7d-c6cb-40a0-bf58-cbb4bf3f1d5b', '195c37b1-c99c-4289-8fc5-d2f7037c6224', '2026-05-02 18:13:57.912781+00', '2026-05-02 18:13:57.912781+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '165.23.15.151', NULL, NULL, NULL, NULL, NULL),
	('90fad49e-b61f-4c7c-bf83-53625a11be18', '01df5d90-c1ad-482a-a29f-76971c5b7faa', '2026-05-05 18:41:30.280136+00', '2026-05-06 13:45:37.417925+00', NULL, 'aal1', NULL, '2026-05-06 13:45:37.417813', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', '140.186.6.140', NULL, NULL, NULL, NULL, NULL),
	('3de91402-9bd1-49a4-aefc-c9b8d82fefd1', '195c37b1-c99c-4289-8fc5-d2f7037c6224', '2026-05-01 17:25:12.772182+00', '2026-05-06 15:09:51.033801+00', NULL, 'aal1', NULL, '2026-05-06 15:09:51.033699', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', '165.23.15.151', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('3de91402-9bd1-49a4-aefc-c9b8d82fefd1', '2026-05-01 17:25:12.783176+00', '2026-05-01 17:25:12.783176+00', 'password', '7b4f6b67-c4dc-4308-a22a-06a3d5681caf'),
	('f0f1aa7d-c6cb-40a0-bf58-cbb4bf3f1d5b', '2026-05-02 18:13:57.982263+00', '2026-05-02 18:13:57.982263+00', 'password', '30276f0b-bc95-4b5b-b1fb-8f5ddf5024d1'),
	('90fad49e-b61f-4c7c-bf83-53625a11be18', '2026-05-05 18:41:30.354459+00', '2026-05-05 18:41:30.354459+00', 'password', '58b352e9-cb65-4458-a96c-3e436a1915e4');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 32, '7hr5rz7jjcn6', '195c37b1-c99c-4289-8fc5-d2f7037c6224', true, '2026-05-01 17:25:12.780942+00', '2026-05-01 18:29:55.495171+00', NULL, '3de91402-9bd1-49a4-aefc-c9b8d82fefd1'),
	('00000000-0000-0000-0000-000000000000', 34, '5cunabbfs2q6', '195c37b1-c99c-4289-8fc5-d2f7037c6224', false, '2026-05-02 18:13:57.94816+00', '2026-05-02 18:13:57.94816+00', NULL, 'f0f1aa7d-c6cb-40a0-bf58-cbb4bf3f1d5b'),
	('00000000-0000-0000-0000-000000000000', 33, 'coormjwkp5rb', '195c37b1-c99c-4289-8fc5-d2f7037c6224', true, '2026-05-01 18:29:55.503821+00', '2026-05-05 15:43:04.667605+00', '7hr5rz7jjcn6', '3de91402-9bd1-49a4-aefc-c9b8d82fefd1'),
	('00000000-0000-0000-0000-000000000000', 36, '2ttxscudb5v3', '01df5d90-c1ad-482a-a29f-76971c5b7faa', true, '2026-05-05 18:41:30.31922+00', '2026-05-06 13:45:37.365048+00', NULL, '90fad49e-b61f-4c7c-bf83-53625a11be18'),
	('00000000-0000-0000-0000-000000000000', 37, 'uww5nlii2qjw', '01df5d90-c1ad-482a-a29f-76971c5b7faa', false, '2026-05-06 13:45:37.388569+00', '2026-05-06 13:45:37.388569+00', '2ttxscudb5v3', '90fad49e-b61f-4c7c-bf83-53625a11be18'),
	('00000000-0000-0000-0000-000000000000', 35, 'zxbdatnm6f5a', '195c37b1-c99c-4289-8fc5-d2f7037c6224', true, '2026-05-05 15:43:04.698192+00', '2026-05-06 15:09:51.006348+00', 'coormjwkp5rb', '3de91402-9bd1-49a4-aefc-c9b8d82fefd1'),
	('00000000-0000-0000-0000-000000000000', 38, '7vrd6lajo7ci', '195c37b1-c99c-4289-8fc5-d2f7037c6224', false, '2026-05-06 15:09:51.017785+00', '2026-05-06 15:09:51.017785+00', 'zxbdatnm6f5a', '3de91402-9bd1-49a4-aefc-c9b8d82fefd1');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."blog_posts" ("id", "title", "slug", "content", "excerpt", "cover_image_url", "author_id", "author_name", "status", "tags", "published_at", "created_at", "updated_at") VALUES
	('44e3def5-737d-4a6d-bf92-0eb2d4f8502e', 'Welcome to the USD AI Research Lab Blog', 'welcome-to-the-usd-ai-research-lab-blog', '# Welcome to the USD AI Research Lab Blog

We''re excited to launch our new blog platform! This is a space where our researchers, PhD students, and Master''s students can share their work, insights, and discoveries in the field of Artificial Intelligence.

## What You''ll Find Here

Our blog will feature:

- **Research Updates** - Latest findings from our lab
- **Tutorials** - Step-by-step guides on AI/ML techniques
- **Paper Reviews** - Summaries of important papers in the field
- **Project Showcases** - Demos and explanations of our projects
- **Industry Insights** - Thoughts on AI trends and applications

## Contributing

All USD AI Research Lab members with a @usd.edu email can contribute to this blog. Simply:

1. Fork the repository
2. Write your post in Markdown
3. Submit a Pull Request
4. Get reviewed and published!

See the [README](/content/blog/README.md) for detailed instructions.

## Stay Connected

Follow our research and connect with us:

- [GitHub](https://github.com/USD-AI-ResearchLab)
- [USD AI Research Lab Website](https://usd-ai-researchlab.github.io)

We look forward to sharing knowledge and fostering discussions in the AI community!

*— The USD AI Research Lab Team*', 'Introducing our new blog platform where researchers share insights on AI, machine learning, and cutting-edge research.', NULL, '195c37b1-c99c-4289-8fc5-d2f7037c6224', 'frankmungai77', 'published', '{}', '2026-05-01 13:17:24.789+00', '2026-04-30 16:14:29.763727+00', '2026-05-01 13:17:24.789+00');


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."books" ("id", "title", "authors", "description", "publisher", "pub_year", "isbn", "amazon_url", "publisher_url", "image_url", "created_at") VALUES
	('1f55d017-56d6-4dc8-9322-74503a620dba', 'AI, Ethical Issues and Explainability—Applied Biometrics', 'KC Santosh', 'Research on AI ethics, explainability, and biometric applications with focus on responsible AI development.', 'KC Santosh Personal', '2024', NULL, 'https://kc-santosh.org/', 'https://kc-santosh.org/', '/assets/book3.png', '2026-04-23 17:43:22.592172+00'),
	('0278fbcf-d9c0-4419-b5cd-7f82238eecac', 'CrackML: Machine Learning for Materials Science', 'KC Santosh, Casey Wall', 'Advanced machine learning techniques applied to materials science and crack detection in structural systems.', 'Springer', '2024', '978-981-97-2720-9', 'https://link.springer.com/book/10.1007/978-981-97-2720-9', 'https://link.springer.com/book/10.1007/978-981-97-2720-9', '/assets/book-crackML.png', '2026-04-23 17:43:22.592172+00'),
	('28e9e18e-873d-45ba-983d-eeafe782bc4b', 'Pattern Recognition and AI: Advanced Topics', 'KC Santosh, et al.', 'Comprehensive coverage of advanced pattern recognition techniques and artificial intelligence applications.', 'Springer', '2024', '978-981-99-7441-2', 'https://link.springer.com/book/9789819974412', 'https://link.springer.com/book/9789819974412', '/assets/book5.png', '2026-04-23 17:43:22.592172+00'),
	('a26e21a6-d99f-4b4e-802f-0c4455a49a98', 'Recent Trends in Image Processing and Pattern Recognition', 'KC Santosh, Ravindra S. Hegadi', 'Latest advances in computer vision, medical imaging, document analysis, and biometric recognition systems.', 'Springer', '2022', '978-981-19-3935-8', 'https://link.springer.com/book/10.1007/978-981-19-3935-8', 'https://link.springer.com/book/10.1007/978-981-19-3935-8', '/assets/book2.png', '2026-04-23 17:43:22.592172+00'),
	('2bd32e43-5a6f-40eb-91c1-a7aef48a96e4', 'AI and ML for Healthcare: Challenges and Opportunities', 'KC Santosh, Nibaran Das, Krishanu Maity', 'Machine learning and deep learning algorithms for healthcare applications, security systems, and automation.', 'Springer', '2021', '978-981-16-6767-1', 'https://link.springer.com/book/9789811667671', 'https://link.springer.com/book/9789811667671', '/assets/book-ai-ml-healthcare.png', '2026-04-23 17:43:22.592172+00'),
	('686f1b86-2956-4fcf-85ff-17e120496c87', 'Deep Learning Models for Medical Imaging', 'KC Santosh, Sameer Antani', 'Comprehensive guide to deep learning approaches for medical imaging including CNNs, transfer learning, and domain adaptation.', 'Elsevier', '2021', '978-0-12-823504-1', 'https://www.elsevier.com/books/deep-learning-models-for-medical-imaging/santosh/978-0-12-823504-1', 'https://www.elsevier.com/books/deep-learning-models-for-medical-imaging/santosh/978-0-12-823504-1', '/assets/book-dl-medical-imaging2.png', '2026-04-23 17:43:22.592172+00'),
	('748380d2-8035-4ffc-aef5-b6f17cbdc818', 'Document Image Analysis: Benchmarking State-of-the-Art Systems', 'KC Santosh, Laurent Wendling', 'Benchmarking methodologies for OCR, layout analysis, handwritten text recognition, and document processing systems.', 'Springer', '2017', '978-981-13-2339-3', 'https://link.springer.com/book/10.1007%2F978-981-13-2339-3', 'https://link.springer.com/book/10.1007%2F978-981-13-2339-3', '/assets/book-coverS2017.png', '2026-04-23 17:43:22.592172+00'),
	('ffcf1ec8-6e15-4fc1-91ef-eaabf3cd2c05', 'COVID-19: Prediction, Decision-Making, and its Impacts', 'KC Santosh, Amit Joshi', 'Analysis of COVID-19 prediction models, decision-making frameworks, and socioeconomic impacts using AI and data science.', 'Springer', '2020', '978-981-15-9681-0', 'https://www.springer.com/gp/book/9789811596810', 'https://www.springer.com/gp/book/9789811596810', '/assets/book-covid1.png', '2026-04-23 17:43:22.592172+00'),
	('aff4b354-4eec-4b49-8149-af4b70a78279', 'COVID-19: Technologies and Applications', 'KC Santosh, Laurent Wendling', 'Technological solutions and applications for COVID-19 analysis, screening, and research methodologies.', 'Springer', '2020', '978-981-15-6571-7', 'https://www.springer.com/gp/book/9789811565717', 'https://www.springer.com/gp/book/9789811565717', '/assets/book-covid2.jpg', '2026-04-23 17:43:22.592172+00'),
	('bd3e8fc3-257c-43b9-a747-396eee81b053', 'Medical Image Processing: Advanced Fuzzy Set Theoretic Techniques', 'Tamalika Chaira, KC Santosh', 'Advanced fuzzy set techniques for medical image enhancement, segmentation, classification, and analysis.', 'CRC Press', '2019', '978-0-429-02941-7', 'https://www.taylorfrancis.com/books/e/9780429029417', 'https://www.taylorfrancis.com/books/e/9780429029417', '/assets/book-MedImag.jpg', '2026-04-23 17:43:22.592172+00'),
	('5d380a84-e840-4fa3-b66b-e5fe624cb136', 'Document Processing Using Machine Learning', 'SK Md Obaidullah, KC Santosh, Teresa Gonçalves, Nibaran Das, Kaushik Roy', 'Machine learning approaches for document processing including text recognition, classification, and information extraction.', 'CRC Press', '2020', '978-0-429-27757-3', 'https://www.taylorfrancis.com/books/document-processing-using-machine-learning-sk-md-obaidullah-kc-santosh-teresa-gon%C3%A7alves-nibaran-das-kaushik-roy/e/10.1201/9780429277573', 'https://www.taylorfrancis.com/books/document-processing-using-machine-learning-sk-md-obaidullah-kc-santosh-teresa-gon%C3%A7alves-nibaran-das-kaushik-roy/e/10.1201/9780429277573', '/assets/book-doc.jpg', '2026-04-23 17:43:22.592172+00'),
	('1441fdae-5a60-45c7-a7ed-7bb03a08ce7d', 'Recent Trends in Image Processing and Pattern Recognition Vol. 1', 'KC Santosh, et al.', 'Advanced techniques in pattern recognition and machine learning applications across multiple domains.', 'Springer', '2023', '978-3-031-27762-7', 'https://link.springer.com/book/10.1007/978-3-031-27762-7', 'https://link.springer.com/book/10.1007/978-3-031-27762-7', '/assets/book6.png', '2026-04-23 17:43:22.592172+00'),
	('5ec8496a-a7cb-4330-ba14-7e363d19fb56', 'Recent Trends in Image Processing and Pattern Recognition Vol. 2', 'KC Santosh, et al.', 'Comprehensive coverage of machine learning applications and pattern recognition across various industries.', 'Springer', '2023', '978-3-031-27609-5', 'https://link.springer.com/book/10.1007/978-3-031-27609-5', 'https://link.springer.com/book/10.1007/978-3-031-27609-5', '/assets/book7.png', '2026-04-23 17:43:22.592172+00'),
	('56e643e9-78b2-4a2c-99ee-8742971d0502', 'Recent Trends in Image Processing and Pattern Recognition Vol. 3', 'KC Santosh, et al.', 'Latest developments in image processing, pattern recognition, and artificial intelligence methodologies.', 'Springer', '2023', '978-3-031-23599-3', 'https://link.springer.com/book/10.1007/978-3-031-23599-3', 'https://link.springer.com/book/10.1007/978-3-031-23599-3', '/assets/book8.png', '2026-04-23 17:43:22.592172+00'),
	('2680ad03-1a9e-4fd0-b391-06a9e5e73fdb', 'IEEE Conference Proceedings on Computer Vision', 'KC Santosh, et al.', 'Collection of IEEE proceedings on computer vision, machine learning, and pattern recognition.', 'IEEE', '2022', '978-1-5386-6947-0', 'https://ieeexplore.ieee.org/xpl/conhome/9866947/proceeding', 'https://ieeexplore.ieee.org/xpl/conhome/9866947/proceeding', '/assets/book1.png', '2026-04-23 17:43:22.592172+00'),
	('aa1fc3de-1a9b-4333-9321-f0402f7133b4', 'IEEE CBMS 2020 Proceedings', 'KC Santosh, et al.', 'Proceedings of the 33rd International Symposium on Computer-Based Medical Systems focusing on medical informatics.', 'IEEE', '2020', '978-1-7281-7350-4', 'https://ieeexplore.ieee.org/xpl/conhome/9169740/proceeding', 'https://ieeexplore.ieee.org/xpl/conhome/9169740/proceeding', '/assets/cbms2020-proceedings.png', '2026-04-23 17:43:22.592172+00'),
	('0df4671f-3c05-40be-8775-db50ccdf13ad', 'Recent Trends in Image Processing & Pattern Recognition 2020 Vol. 1', 'KC Santosh, Ravindra S. Hegadi, Umapada Pal', 'Conference proceedings covering latest research in image processing, pattern recognition, and artificial intelligence.', 'Springer', '2021', '978-981-16-0507-9', 'https://link.springer.com/book/10.1007/978-981-16-0507-9#volumes', 'https://link.springer.com/book/10.1007/978-981-16-0507-9#volumes', '/assets/rtip2r-2020-1.png', '2026-04-23 17:43:22.592172+00'),
	('250b9fea-ae5f-43c7-8232-4be3beb0035a', 'Recent Trends in Image Processing & Pattern Recognition 2020 Vol. 2', 'KC Santosh, Ravindra S. Hegadi, Umapada Pal', 'Advanced research proceedings in image processing, machine learning, and pattern recognition applications.', 'Springer', '2021', '978-981-16-0508-6', 'https://link.springer.com/book/10.1007/978-981-16-0507-9#volumes', 'https://link.springer.com/book/10.1007/978-981-16-0507-9#volumes', '/assets/rtip2r-2020-2.png', '2026-04-23 17:43:22.592172+00'),
	('66541c26-5c02-42b4-a8cf-a59755eca771', 'Recent Trends in Image Processing and Pattern Recognition (Part I)', 'KC Santosh, Ravindra S. Hegadi', 'Part I covering theoretical foundations and applications in image processing and pattern recognition.', 'Springer', '2019', '978-981-13-9181-1', 'https://rd.springer.com/book/10.1007/978-981-13-9181-1', 'https://rd.springer.com/book/10.1007/978-981-13-9181-1', '/assets/part1.png', '2026-04-23 17:43:22.592172+00'),
	('75783f20-6c5e-4e86-a1e6-4ac92751703a', 'Recent Trends in Image Processing and Pattern Recognition (Part II)', 'KC Santosh, Ravindra S. Hegadi', 'Part II focusing on advanced applications and emerging trends in computer vision and machine learning.', 'Springer', '2019', '978-981-13-9184-2', 'https://rd.springer.com/book/10.1007/978-981-13-9184-2', 'https://rd.springer.com/book/10.1007/978-981-13-9184-2', '/assets/part2.png', '2026-04-23 17:43:22.592172+00'),
	('7bfe614b-9501-49dd-bcf3-c3e37af6bb51', 'Recent Trends in Image Processing and Pattern Recognition (Part III)', 'KC Santosh, Ravindra S. Hegadi', 'Part III covering state-of-the-art techniques with emphasis on deep learning and neural networks.', 'Springer', '2019', '978-981-13-9187-3', 'https://rd.springer.com/book/10.1007/978-981-13-9187-3', 'https://rd.springer.com/book/10.1007/978-981-13-9187-3', '/assets/part3.png', '2026-04-23 17:43:22.592172+00'),
	('de39e60a-09ea-4efc-a733-14190803b28d', 'Test Book', 'Test User', 'This is a test book', 'Test Publisher', '2026', '', 'https://francismungai.github.io/ai-research-lab/', 'https://francismungai.github.io/ai-research-lab/', 'https://mrzbomclmlopohhoszbv.supabase.co/storage/v1/object/public/book-covers/1777642755607-8j1rj5k.jpeg', '2026-05-01 13:39:15.855571+00');


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."people" ("id", "category", "name", "role", "photo_url", "scholar_url", "dblp_url", "website_url", "degree", "grad_year", "member_key", "created_at") VALUES
	('765d4ba0-52e9-405d-91ea-ab00534e873c', 'student', 'Casey Wall', 'PhD Student | Computer Science', NULL, NULL, NULL, 'https://www.linkedin.com/in/casey-wall-47181024a/', NULL, NULL, 'casey-wall', '2026-04-23 17:43:22.00072+00'),
	('8d1540bd-b9ea-440b-bf02-2779f78de5c1', 'student', 'Nickolas Rasmussen', 'PhD Student | Computer Science', NULL, NULL, NULL, 'https://www.linkedin.com/in/nicholas-rasmussen-022902174/', NULL, NULL, 'nickolas-rasmussen', '2026-04-23 17:43:22.00072+00'),
	('dfa46344-34c7-42db-ba30-e27668d48663', 'student', 'Moinak Bose', 'PhD Student | Computer Science', NULL, NULL, NULL, 'https://www.linkedin.com/in/moinak-bose-mdastudent/', NULL, NULL, 'moinak-bose', '2026-04-23 17:43:22.00072+00'),
	('1b95bfd8-d99a-499c-909b-0447b00e60ba', 'student', 'Kiran Prasannan Nair', 'PhD Student | Computer Science', NULL, NULL, NULL, NULL, NULL, NULL, 'kiran-prasannan-nair', '2026-04-23 17:43:22.00072+00'),
	('43be4c0d-810e-40b1-b1db-ffbb3cbda98f', 'student', 'Smriti Regmi', 'PhD Student | Computer Science', NULL, NULL, NULL, NULL, NULL, NULL, 'smriti-regmi', '2026-04-23 17:43:22.00072+00'),
	('ac40df5b-f755-4bfa-aa87-eff5b6198c65', 'student', 'Debra Han', 'PhD Student | Computer Science', NULL, NULL, NULL, NULL, NULL, NULL, 'debra-han', '2026-04-23 17:43:22.00072+00'),
	('8880dc69-2861-48de-b1ee-abd6545d0c77', 'student', 'Carrie Minette', 'PhD Student | Computer Science', NULL, NULL, NULL, NULL, NULL, NULL, 'carrie-minette', '2026-04-23 17:43:22.00072+00'),
	('c7f65cd5-5ee1-4ab9-b4a3-78ee62a109ff', 'student', 'Ifrat Ikhtear Uddin', 'PhD Student | Computer Science (starts from fall 2026)', NULL, NULL, NULL, NULL, NULL, NULL, 'ifrat-ikhtear-uddin-phd', '2026-04-23 17:43:22.00072+00'),
	('674727dd-da00-46f7-866f-9b5c8eda8ccb', 'student', 'Puskal Khadka', 'M.S. Computer Science | Graduate Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'puskal-khadka', '2026-04-23 17:43:22.00072+00'),
	('729acb49-c15c-494f-9905-353a7c9801e7', 'student', 'Sai Shankar Swarna', 'M.S. Computer Science | Teaching Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'sai-shankar-swarna', '2026-04-23 17:43:22.00072+00'),
	('f0aca123-a13c-4b17-a86d-450c6bff7ffe', 'student', 'Ifrat Ikhtear Uddin', 'M.S. Computer Science | Teaching Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'ifrat-ikhtear-uddin-ms', '2026-04-23 17:43:22.00072+00'),
	('ef7e8809-c062-422d-8226-de50bc6091dc', 'student', 'Rahisha Pokharel', 'M.S. Computer Science | Teaching Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'rahisha-pokharel', '2026-04-23 17:43:22.00072+00'),
	('b57e19bc-6df5-4822-a748-b4a0989e438b', 'student', 'Seejan Bhattarai', 'M.S. Computer Science | Teaching Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'seejan-bhattarai', '2026-04-23 17:43:22.00072+00'),
	('9805681b-b9e2-4931-8e15-47ae835af5c2', 'student', 'Neelam Karki', 'M.S. Computer Science | Research Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'neelam-karki', '2026-04-23 17:43:22.00072+00'),
	('13a0a452-f0b4-487a-ac25-0565c64cce6a', 'student', 'Dipika Ranabhat', 'M.S. Computer Science | Research Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'dipika-ranabhat', '2026-04-23 17:43:22.00072+00'),
	('ccc35795-c901-4161-a99a-5c2ff4500e39', 'student', 'Harshith Reddy Nalla', 'Undergraduate | Research Assistant', NULL, NULL, NULL, NULL, NULL, NULL, 'harshith-reddy-nalla', '2026-04-23 17:43:22.00072+00'),
	('624c1219-fe5d-4593-aacc-3c9326c7d31b', 'staff', 'Deepika Nuthalapati', 'Research Associate, Department of Computer Science, USD | Member, USD AI Research', '/assets/deepika-nuthalapati.jpg', NULL, NULL, NULL, NULL, NULL, 'deepika-nuthalapati', '2026-04-23 17:43:22.00072+00'),
	('74ba5e75-f0d1-4f15-97f7-411e81e52895', 'alumni', 'David Cortes', 'PhD Graduate | Computer Science', NULL, NULL, NULL, NULL, 'PhD', '2024', 'david-cortes', '2026-04-23 17:43:22.00072+00'),
	('206a9f13-4e1a-4513-bc20-66f213c5d32c', 'alumni', 'Priyam Pandey', 'PhD Graduate | Computer Science', NULL, NULL, NULL, NULL, 'PhD', '2024', 'priyam-pandey', '2026-04-23 17:43:22.00072+00'),
	('5def7e1a-0627-4edb-a7de-e4953f50f6d0', 'alumni', 'Chenchaiah Mekalathu', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'chenchaiah-mekalathu', '2026-04-23 17:43:22.00072+00'),
	('1e75a8d7-d615-411c-9141-987a67243c43', 'alumni', 'Hari Sukarti', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'hari-sukarti', '2026-04-23 17:43:22.00072+00'),
	('286f0501-9f3e-44e9-bded-eb5b22e377a9', 'alumni', 'Murthy Srinivasa Reddy', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'murthy-srinivasa-reddy', '2026-04-23 17:43:22.00072+00'),
	('93d6cede-2a1b-4e0a-8e3e-ae147c0d9fe4', 'alumni', 'Vinit Kumar Yadav', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'vinit-kumar-yadav', '2026-04-23 17:43:22.00072+00'),
	('2aac8fb8-6d50-4644-98b7-ada987eecaf2', 'alumni', 'Thabesum Tazeem Sheikh', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'thabesum-tazeem-sheikh', '2026-04-23 17:43:22.00072+00'),
	('c2a14b48-c9ec-46f5-ad0f-f28f466bac64', 'alumni', 'Ashwin Karthik Amudalavalasa', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'ashwin-karthik-amudalavalasa', '2026-04-23 17:43:22.00072+00'),
	('bed2586c-dde1-4715-b01d-d26ef311f699', 'alumni', 'Srinath Reddy Devireddy', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'srinath-reddy-devireddy', '2026-04-23 17:43:22.00072+00'),
	('83b9de8c-8b53-4146-a5d5-7b23bb00423f', 'alumni', 'Swapna Reddy Nalla', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'swapna-reddy-nalla', '2026-04-23 17:43:22.00072+00'),
	('c54c671c-fca3-4d87-9a5c-358381a46ea5', 'alumni', 'Vamshi Krishna Andeshra', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'vamshi-krishna-andeshra', '2026-04-23 17:43:22.00072+00'),
	('abf2b98a-5f5a-4a75-9f10-121890769ad4', 'alumni', 'Kanishka Parankusham', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'kanishka-parankusham', '2026-04-23 17:43:22.00072+00'),
	('cc07655c-f3e1-4a46-88f6-fed8a0824f15', 'alumni', 'Neerajdattu Dudam', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'neerajdattu-dudam', '2026-04-23 17:43:22.00072+00'),
	('a58291da-5701-4995-a677-729d08d560db', 'alumni', 'Akshay Reddy', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'akshay-reddy', '2026-04-23 17:43:22.00072+00'),
	('ca0dcf54-62a7-481b-ae06-25f09f190592', 'alumni', 'Mohammad Navid Nayyem', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'mohammad-navid-nayyem', '2026-04-23 17:43:22.00072+00'),
	('bed9a8c8-7fb3-4d2f-bcfa-245ee9bb596f', 'alumni', 'KrishnaPhanindra Marupaka', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'krishnaphanindra-marupaka', '2026-04-23 17:43:22.00072+00'),
	('1a922594-bc1c-44f7-866b-0c9eed813853', 'alumni', 'Satya Mouli Dhangati', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'satya-mouli-dhangati', '2026-04-23 17:43:22.00072+00'),
	('3351128c-27c4-4141-b280-b60bff202fef', 'alumni', 'Sivani Maddepalli', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'sivani-maddepalli', '2026-04-23 17:43:22.00072+00'),
	('6061cee4-1cc9-4e3e-8633-3ee26de3c2bd', 'alumni', 'Sainath Vaddi', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'sainath-vaddi', '2026-04-23 17:43:22.00072+00'),
	('2efd0fe4-1abb-4dcf-9ada-5badca5e1a4c', 'alumni', 'Sony Gurram', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', 'sony-gurram', '2026-04-23 17:43:22.00072+00'),
	('02124db1-3fae-4cef-ae33-5b0a2f43671c', 'alumni', 'Aashish Ghimire', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'aashish-ghimire', '2026-04-23 17:43:22.00072+00'),
	('ed9cfc66-06e2-445d-8147-955ce8cd2c53', 'alumni', 'Sabin Adhikari', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'sabin-adhikari', '2026-04-23 17:43:22.00072+00'),
	('7de20c78-12c9-4091-b3e6-0eda5f774528', 'alumni', 'Jayakumar Pujar', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'jayakumar-pujar', '2026-04-23 17:43:22.00072+00'),
	('07ad288a-013c-4b3c-bddb-7cd028503727', 'faculty', 'Dr. Nand K Yadav', 'Postdoc, Department of Computer Science, USD | Member, USD AI Research', '/assets/nand-yadav.jpg', 'https://scholar.google.com/citations?hl=en&user=MYuCzcsAAAAJ', NULL, 'https://www.linkedin.com/in/nand-k-yadav-891883262/', NULL, NULL, '4-nand-yadav', '2026-04-23 17:43:22.00072+00'),
	('102bb1a6-f1b4-4287-af19-b37d22235cea', 'faculty', 'Dr. Srikanth Baride', 'Postdoc, Department of Computer Science, USD | Member, USD AI Research', '/assets/srikanth-baride.jpg', 'https://scholar.google.com/citations?hl=en&user=Sy_2zJcAAAAJ', 'https://dblp.org/pid/93/9638', 'https://www.linkedin.com/in/srikanth-baride', NULL, NULL, '5-srikanth-baride', '2026-04-23 17:43:22.00072+00'),
	('8a318040-1b6c-447c-8e90-1b7c8f104bdf', 'alumni', 'Deepika Nuthalapati', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2024', '6-deepika-nuthalapati-alumni', '2026-04-23 17:43:22.00072+00'),
	('fe4575ef-8673-43dc-93de-0cde3a8d5168', 'faculty', 'Dr. Longwei Wang', 'Assistant Professor, Department of Computer Science, USD | Vice-Director, Research', '/assets/longwei-wang.jpeg', 'https://scholar.google.com/citations?hl=en&user=nRGDT_sAAAAJ', 'https://dblp.org/pid/150/5640', NULL, NULL, NULL, '3-longwei-wang', '2026-04-23 17:43:22.00072+00'),
	('9f6a328f-4caa-4d79-b2c0-8803472872d4', 'alumni', 'Pooja Singh', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'pooja-singh', '2026-04-23 17:43:22.00072+00'),
	('515c7ff5-49e9-475c-9cfc-34496a77a904', 'alumni', 'Alexis Haiar', 'Undergraduate Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Bachelor''s', '2024', 'alexis-haiar', '2026-04-23 17:43:22.00072+00'),
	('3f396a0a-b6de-4338-bbed-605fb28a4dc7', 'alumni', 'Malashree Dhungel', 'Undergraduate Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Bachelor''s', '2024', 'malashree-dhungel', '2026-04-23 17:43:22.00072+00'),
	('9d1ae924-74f1-4f86-92b7-2ceba3e7dec0', 'alumni', 'Anup Khanal', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'anup-khanal', '2026-04-23 17:43:22.00072+00'),
	('fa42daaa-7842-4d10-91d2-f4ef8b6a3872', 'alumni', 'Anushuya Baidya', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'anushuya-baidya', '2026-04-23 17:43:22.00072+00'),
	('ffae123c-7142-4879-9400-febf6079ee31', 'alumni', 'MdAftabul Islam', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'mdaftabul-islam', '2026-04-23 17:43:22.00072+00'),
	('6284d0b9-d182-453f-b682-ca11c71c9773', 'alumni', 'AkhilReddy Mendu', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'akhilreddy-mendu', '2026-04-23 17:43:22.00072+00'),
	('01bb88f3-79a0-4867-9455-df3d08cd368d', 'alumni', 'Anuska Pokharel', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'anuska-pokharel', '2026-04-23 17:43:22.00072+00'),
	('bc985c9b-ca4f-40d2-990a-c9de1190e8e1', 'alumni', 'Yslam Ismailov', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'yslam-ismailov', '2026-04-23 17:43:22.00072+00'),
	('9bc27377-2459-45d9-bbe0-99bd179e666c', 'alumni', 'Hansakrish Kuttubaskar', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'hansakrish-kuttubaskar', '2026-04-23 17:43:22.00072+00'),
	('6242bb40-a224-48c0-b8c3-6874ab881cd4', 'alumni', 'Praveen Paramsivam', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2023', 'praveen-paramsivam', '2026-04-23 17:43:22.00072+00'),
	('d2c5c695-5880-4d1b-84e7-1c5ef8800abc', 'alumni', 'Abhishek Chaudhary', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'abhishek-chaudhary', '2026-04-23 17:43:22.00072+00'),
	('ad48099c-73b7-41f8-b0ac-fa1697b52116', 'alumni', 'A Matthew Chacko', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'a-matthew-chacko', '2026-04-23 17:43:22.00072+00'),
	('7994bdc5-7640-48a5-ad05-5e941ecba68a', 'alumni', 'KalyanVikram Muppudoju', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'kalyanvikram-muppudoju', '2026-04-23 17:43:22.00072+00'),
	('6f06690b-bab1-431e-b93f-2075233368cd', 'alumni', 'Srijana Raut', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'srijana-raut', '2026-04-23 17:43:22.00072+00'),
	('e5c3fa24-d9e4-4f18-8a99-59f838fb180a', 'alumni', 'Suprim Nakarmi', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'suprim-nakarmi', '2026-04-23 17:43:22.00072+00'),
	('c334f35e-d11b-4e85-90f4-952e89996e86', 'alumni', 'Gaurrav Subedi', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'gaurrav-subedi', '2026-04-23 17:43:22.00072+00'),
	('0fa3ed11-7ab8-4f85-81ba-d57266d3d845', 'alumni', 'Rakshya Dahal', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'rakshya-dahal', '2026-04-23 17:43:22.00072+00'),
	('3004936e-2538-4760-9f74-b98d653e7cd8', 'alumni', 'Alisha Karna', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'alisha-karna', '2026-04-23 17:43:22.00072+00'),
	('a9e5f60f-3ac7-4750-9f30-77aece9a8578', 'alumni', 'Aarati Dhungel', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2022', 'aarati-dhungel', '2026-04-23 17:43:22.00072+00'),
	('c4b1ca72-eef8-49d5-8edd-6893a2f3d243', 'alumni', 'Anup Dhakal', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2021', 'anup-dhakal', '2026-04-23 17:43:22.00072+00'),
	('626c87c5-62f8-47dc-92db-75cca516b66d', 'alumni', 'Ronaj Pradhan', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2021', 'ronaj-pradhan', '2026-04-23 17:43:22.00072+00'),
	('e9ab7c14-6d10-4f5a-a73a-a5f834739f4a', 'alumni', 'Md Masum Rana', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2021', 'md-masum-rana', '2026-04-23 17:43:22.00072+00'),
	('618cf768-5763-4d80-8835-e8f901c1dbef', 'alumni', 'Bipul Bhattarai', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2021', 'bipul-bhattarai', '2026-04-23 17:43:22.00072+00'),
	('b786d810-b291-443e-86a2-b896b992498d', 'alumni', 'Josh Henderson', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2021', 'josh-henderson', '2026-04-23 17:43:22.00072+00'),
	('cc3123d3-0533-45a8-a470-5bbe59cd152a', 'alumni', 'Siddhi Kiran Bajracharya', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2021', 'siddhi-kiran-bajracharya', '2026-04-23 17:43:22.00072+00'),
	('0ca3ca9b-3648-47e8-b01e-3a5b5e351a4a', 'alumni', 'Hugo Morvan', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2021', 'hugo-morvan', '2026-04-23 17:43:22.00072+00'),
	('e6191f6b-5877-46d1-83e4-a008dcb50dac', 'alumni', 'Bichar Shrestha Gurung', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2020', 'bichar-shrestha-gurung', '2026-04-23 17:43:22.00072+00'),
	('f50e27da-9fd8-4a7f-96c7-c718c40ada82', 'alumni', 'Bigyan Shrestha', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2020', 'bigyan-shrestha', '2026-04-23 17:43:22.00072+00'),
	('08ebca49-21f6-421f-aa09-5ff205991213', 'alumni', 'Raman Regmi', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2020', 'raman-regmi', '2026-04-23 17:43:22.00072+00'),
	('bb3e64ec-8a23-4759-bc19-f5fba03836db', 'alumni', 'Adedeji Waisu Yusuff', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2020', 'adedeji-waisu-yusuff', '2026-04-23 17:43:22.00072+00'),
	('269fdb53-3267-485b-818f-51fcd95074d7', 'alumni', 'Muntamir Mamun', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2020', 'muntamir-mamun', '2026-04-23 17:43:22.00072+00'),
	('c507f97d-a35d-4b3e-aee9-2893fdac4f31', 'alumni', 'Rafia Sharmin Alice', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2020', 'rafia-sharmin-alice', '2026-04-23 17:43:22.00072+00'),
	('a09e4bd9-2e8b-4a78-bcc7-ea53bd0b5cd4', 'alumni', 'Nikita Shrestha', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2019', 'nikita-shrestha', '2026-04-23 17:43:22.00072+00'),
	('b4fd8c8b-1b77-4630-9634-1dfe036b2132', 'alumni', 'Siva Allu', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2019', 'siva-allu', '2026-04-23 17:43:22.00072+00'),
	('22225699-3c56-4e35-878b-a0fb351d05b5', 'alumni', 'Prakash Madai', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2019', 'prakash-madai', '2026-04-23 17:43:22.00072+00'),
	('27972123-1a42-4531-846d-c094ab475e79', 'alumni', 'Shotadbi Roy', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2019', 'shotadbi-roy', '2026-04-23 17:43:22.00072+00'),
	('76e72ea1-49fa-4b43-b701-eb6532f26e81', 'alumni', 'Supriti Ghosh', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2019', 'supriti-ghosh', '2026-04-23 17:43:22.00072+00'),
	('e81b7c6a-8191-4f6b-a9e5-3fd1aae95657', 'alumni', 'Bruce Stofft', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2019', 'bruce-stofft', '2026-04-23 17:43:22.00072+00'),
	('2e8cab1d-edce-43d1-833b-ffb18f8d1505', 'alumni', 'Afia Farjana', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2018', 'afia-farjana', '2026-04-23 17:43:22.00072+00'),
	('a5f0c3ca-fb5d-4e8f-9f67-64782afff076', 'alumni', 'Jahirul Islam', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2018', 'jahirul-islam', '2026-04-23 17:43:22.00072+00'),
	('886331a5-8e17-4361-949d-e73b2b223515', 'alumni', 'Haidong Wang', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2018', 'haidong-wang', '2026-04-23 17:43:22.00072+00'),
	('13a6c9a4-aa4e-4e63-bbd9-fe806caa8b4d', 'alumni', 'Alina Chu', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2018', 'alina-chu', '2026-04-23 17:43:22.00072+00'),
	('fd38eb2a-eb2c-466a-9d17-70536c3b6ab1', 'alumni', 'Airu Liu', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2018', 'airu-liu', '2026-04-23 17:43:22.00072+00'),
	('20411011-47f9-4f70-9260-5ae7e592c752', 'alumni', 'Fatema Tu Zohora', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2017', 'fatema-tu-zohora', '2026-04-23 17:43:22.00072+00'),
	('fe8cdef2-d4d1-40a5-abfd-6f5a24df4383', 'alumni', 'A Afaque', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2017', 'a-afaque', '2026-04-23 17:43:22.00072+00'),
	('cee37162-d484-43f5-b66f-4a4f39e0c90e', 'alumni', 'Nikul Vyas', 'Master''s Graduate | Computer Science', NULL, NULL, NULL, NULL, 'Master''s', '2017', 'nikul-vyas', '2026-04-23 17:43:22.00072+00'),
	('bdce53ac-e2b9-49f2-9448-2e0fbb5db35c', 'collaborator', 'Dr. Veerpratap Meena', 'Assistant Professor
Department of Electrical Engineering
National Institute of Technology
Jamshedpur, India', NULL, 'https://scholar.google.com/citations?user=lLKzGwQAAAAJ&hl=en', NULL, 'https://www.linkedin.com/in/veerpratapmeena/', NULL, NULL, NULL, '2026-04-23 17:43:22.00072+00'),
	('059a1e21-cbd1-4aa1-8b5f-de8fc8b4606e', 'collaborator', 'Dr. Akram Bennour', 'Professor of Computer Science
Larbi Tebessi University
LAMIS Laboratory
Algeria', NULL, 'https://scholar.google.com/citations?hl=fr&user=t4hzC-cAAAAJ', NULL, 'https://sites.google.com/view/akram-bennour/biography?authuser=0', NULL, NULL, NULL, '2026-04-23 17:43:22.00072+00'),
	('a3cc7225-5c8d-442d-9049-5ada0881e0ec', 'collaborator', 'Dr. Dominick Rizk', 'Professor
Catholic University of America
Washington, DC, USA', NULL, 'https://scholar.google.com/citations?user=YOUR_ID&hl=en', NULL, NULL, NULL, NULL, NULL, '2026-04-23 17:43:22.00072+00'),
	('2041c7ef-cd75-4b7e-959c-39f60ba59945', 'collaborator', 'Dr. Frederic Rizk', 'Professor
Department of Electrical Engineering
University of Texas at Tyler
Tyler, Texas, USA', NULL, 'https://scholar.google.com/citations?user=YOUR_ID&hl=en', NULL, 'https://www.uttyler.edu/directory/electrical-engineering/frederic-rizk.php', NULL, NULL, NULL, '2026-04-23 17:43:22.00072+00'),
	('f9d6d064-d29c-4c5e-9906-8858f102acc1', 'staff', 'Test User', 'Test User', 'https://mrzbomclmlopohhoszbv.supabase.co/storage/v1/object/public/people-photos/1777643681320-nwzt1fz.jpeg', '', '', 'https://francismungai.github.io/ai-research-lab/', '', '', '', '2026-05-01 13:54:41.550365+00'),
	('fe2d94ad-1b42-4d65-a74e-557de1551bf0', 'faculty', 'Prof. KC Santosh', 'Professor (AI) & Chair, Department of Computer Science, USD | Founding Director, USD AI Research', '/assets/kc-santosh.jpg', 'https://scholar.google.com/citations?hl=en&user=luPx18QAAAAJ', 'https://dblp.uni-trier.de/pid/17/735.html?view=by-type', 'https://kc-santosh.org/', NULL, NULL, '1-kc-santosh', '2026-04-23 17:43:22.00072+00'),
	('684d278a-6715-46f4-a1e9-25fe2767f3d5', 'faculty', 'Dr. Rodrigue Rizk', 'Assistant Professor, Department of Computer Science, USD | Vice-Director, Engineering | Graduate Program Co-ordinator', '/assets/rodrigue-rizk.jpg', 'https://scholar.google.com/citations?hl=en&user=CZkCb5QAAAAJ', 'https://dblp.org/pid/244/7657.html', 'https://www.linkedin.com/in/rodrigue-rizk', NULL, NULL, '2-rodrigue-rizk', '2026-04-23 17:43:22.00072+00');


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profiles" ("id", "email", "role", "created_at") VALUES
	('195c37b1-c99c-4289-8fc5-d2f7037c6224', 'frankmungai77@gmail.com', 'admin', '2026-04-27 21:59:57.900248+00'),
	('8c037f81-047d-438e-81fd-60f05fe39a9b', 'francis.mungai@coyotes.usd.edu', 'contributor', '2026-05-01 16:53:19.422955+00'),
	('bcb6c457-325c-44c7-905a-3f08fae60d2e', 'rodrigue.rizk@usd.edu', 'admin', '2026-05-01 17:09:23.209453+00'),
	('4e6b16c7-c0c0-4642-afff-9a5c144a1bf5', 'kc.santosh@usd.edu', 'admin', '2026-05-01 17:09:54.328066+00'),
	('01df5d90-c1ad-482a-a29f-76971c5b7faa', 'zachary.tschetter@usd.edu', 'admin', '2026-05-05 15:45:16.825596+00');


--
-- Data for Name: publications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."publications" ("id", "title", "authors", "description", "venue", "pub_year", "paper_url", "code_url", "is_sample", "created_at") VALUES
	('f84604cb-f038-482e-b9ce-b69698473e02', 'Non-Uniform Illumination Attack for Fooling Convolutional Neural Networks', 'Akshay Jain, Shiv Ram Dubey, Satish Kumar Singh, KC Santosh, Bidyut Baran Chaudhuri', 'Introduces a Non‑Uniform Illumination (NUI) attack and evaluates defenses across CNNs.', 'IEEE Transactions on Artificial Intelligence', '2025', 'https://doi.org/10.1109/TAI.2025.3549396', '#', false, '2026-04-23 17:43:22.460601+00'),
	('8480afcc-08fd-4e59-b39e-3f3bf8a03b28', 'Advances and Challenges in Meta-Learning: A Technical Review', 'Anna Vettoruzzo, Mohamed-Rafik Bouguelia, Joaquin Vanschoren, Thorsteinn Rögnvaldsson, KC Santosh', 'Comprehensive technical overview of meta‑learning and related areas.', 'IEEE Transactions on Pattern Analysis and Machine Intelligence', '2024', 'https://doi.org/10.1109/TPAMI.2024.3357847', '#', false, '2026-04-23 17:43:22.460601+00'),
	('4c3b734c-19f8-49f0-a93d-b55e73e5faa3', 'Advances in Deep Learning for Tuberculosis Screening using Chest X‑rays: The Last 5 Years Review', 'KC Santosh, Siva Allu, Sivaramakrishnan Rajaraman, Sameer Antani', 'Systematic review and meta‑analysis of DL‑based TB screening via CXRs.', 'Journal of Medical Systems (Springer)', '2022', 'https://doi.org/10.1007/s10916-022-01870-8', '#', false, '2026-04-23 17:43:22.460601+00'),
	('e07fb85f-5f60-4edf-8cc1-22358462526e', 'Guest Editorial Multimodal Learning in Medical Imaging Informatics', 'KC Santosh, Sameer Antani', 'Overview of multimodal learning across diverse healthcare data sources.', 'IEEE Journal of Biomedical and Health Informatics', '2023', 'https://doi.org/10.1109/JBHI.2023.3241369', '#', false, '2026-04-23 17:43:22.460601+00'),
	('dc29c155-f454-4262-bb77-746d510871fb', 'Cervical cancerous cell classification: opposition‑based harmony search for deep feature selection', 'Nibaran Das, Bodhisatwa Mandal, KC Santosh, Linlin Shen, Sukanta Chakraborty', 'CNN deep features + Opposition‑based Harmony Search for cervical cancer classification.', 'International Journal of Machine Learning and Cybernetics', '2023', 'https://doi.org/10.1007/s13042-023-01872-z', '#', false, '2026-04-23 17:43:22.460601+00'),
	('6f20ff02-d6fe-4c5b-ad17-bc0f3384b45e', 'SecureFed: federated learning empowered medical imaging technique to analyze lung abnormalities in chest X‑rays', 'Aaisha Makkar, KC Santosh', 'Secure aggregation improving fairness/robustness in federated medical imaging.', 'International Journal of Machine Learning and Cybernetics', '2023', 'https://doi.org/10.1007/s13042-023-01789-7', '#', false, '2026-04-23 17:43:22.460601+00'),
	('9b743a3e-9c03-4272-a4a8-42e213bfa8fb', 'AI Tools for Assessing Human Fertility Using Risk Factors: A State‑of‑the‑Art Review', 'Debasmita GhoshRoy, P. A. Alvi, KC Santosh', 'Systematic review (42 studies) of AI for infertility risk factors.', 'Journal of Medical Systems', '2023', 'https://doi.org/10.1007/s10916-023-01983-8', '#', false, '2026-04-23 17:43:22.460601+00'),
	('7aaa504f-b44a-4e7b-af9f-608e640e0b8a', 'Hybrid approach for text categorization: A case study with Bangla news article', 'Ankita Dhar, Himadri Mukherjee, Kaushik Roy, KC Santosh, Niladri Sekhar Dash', 'Hybrid text + graph features for Bangla news classification.', 'Journal of Information Science', '2023', 'https://doi.org/10.1177/01655515211027770', '#', false, '2026-04-23 17:43:22.460601+00'),
	('1fee8d79-3a3a-4337-bfd8-b3673e05f5ee', 'Enabling clustering algorithms to detect clusters of varying densities through scale-invariant data preprocessing', 'Sunil Aryal, Jonathan R. Wells, Arbind Agrahari Baniya, KC Santosh', 'ARES rank-based preprocessing stabilizes clustering across densities.', 'arXiv preprint', '2024', 'https://arxiv.org/abs/2401.11402', '#', false, '2026-04-23 17:43:22.460601+00'),
	('e6b85275-7fb1-4e42-a61b-d852985cd852', 'Investigation of DNA discontinuity for detecting tuberculosis', 'Sonia Farhana Nimmy, Md. Golam Sarowar, Nilanjan Dey, Amira S. Ashour, KC Santosh', 'Automated ML to assess breaks in long DNA sequences for TB detection.', 'Journal of Ambient Intelligence and Humanized Computing', '2024', 'https://doi.org/10.1007/s12652-018-0878-0', '#', false, '2026-04-23 17:43:22.460601+00'),
	('2ad95118-dc9a-4d0c-957b-53ce5a6720a5', 'LIFA: Language identification from audio with LPCC-G features', 'Himadri Mukherjee, Ankita Dhar, Sk Md Obaidullah, KC Santosh, Santanu Phadikar, Kaushik Roy, Umapada Pal', 'LPCC‑G features + RF for language ID across 11 Indian languages.', 'Multimedia Tools and Applications', '2024', 'https://doi.org/10.1007/s11042-023-17782-9', '#', false, '2026-04-23 17:43:22.460601+00'),
	('70e850c7-688b-418d-b246-f84d32f3f03b', 'Leveraging Sampling Schemes on Skewed Class Distribution to Enhance Male Fertility Detection with Ensemble AI Learners', 'Debasmita GhoshRoy, P. A. Alvi, KC Santosh', 'Benchmarks 14 re‑sampling approaches; highlights LightGBM + SMOTE‑ENN.', 'International Journal of Pattern Recognition and Artificial Intelligence', '2024', 'https://doi.org/10.1142/S0218001424510030', '#', false, '2026-04-23 17:43:22.460601+00'),
	('b7e14bb4-5132-43eb-9721-0fe9b1ee0351', 'Shallow Convolutional Neural Network for COVID-19 Outbreak Screening Using Chest X-rays', 'Himadri Mukherjee, Subhankar Ghosh, Ankita Dhar, Sk Md Obaidullah, KC Santosh, Kaushik Roy', 'Light‑weight CNN for CXR COVID‑19 screening; 5‑fold CV.', 'Cognitive Computation', '2021', 'https://doi.org/10.1007/s12559-020-09775-9', '#', false, '2026-04-23 17:43:22.460601+00'),
	('c7eacc93-c095-4381-b9a9-cd668128a3d1', 'Covid-19 Imaging Tools: How Big Data is Big?', 'KC Santosh, Sourodip Ghosh', 'Perspective on dataset size, model (under/over)fitting, transfer learning, augmentation.', 'Journal of Medical Systems (Springer)', '2021', 'https://doi.org/10.1007/s10916-021-01747-2', '#', false, '2026-04-23 17:43:22.460601+00'),
	('17298f9f-9d0a-4a5d-9c41-7084ce0d355e', 'SegFast‑V2: Semantic image segmentation with less parameters in deep learning for autonomous driving', 'Swarnendu Ghosh, Anisha Pal, Shourya Jaiswal, KC Santosh, Nibaran Das, Mita Nasipuri', 'Compact semantic segmentation with fewer parameters; strong runtime gains.', 'International Journal of Machine Learning and Cybernetics', '2019', 'https://doi.org/10.1007/s13042-019-01005-5', '#', false, '2026-04-23 17:43:22.460601+00'),
	('99c35e9f-52c1-4dfb-9f42-d1e947264eac', 'Deep features to detect pulmonary abnormalities in chest X-rays due to infectious disease: Covid-19, pneumonia, and tuberculosis', 'MK Mahbub, M Biswas, L Gaur, F Alenezi, KC Santosh', 'Custom DNN for non‑healthy vs healthy CXR screening across diseases.', 'Information Sciences (Elsevier)', '2022', 'https://doi.org/10.1016/j.ins.2022.01.062', '#', false, '2026-04-23 17:43:22.460601+00'),
	('19671447-41fe-4b2e-a85a-87c524268c55', 'A systematic review on cough sound analysis for Covid-19 diagnosis and screening: is my cough sound COVID-19?', 'KC Santosh, Nicholas Rasmussen, Mohammad Mamun, Saroj Aryal', 'Systematic review (2020–2021) of AI‑guided cough sound analysis for COVID‑19.', 'PeerJ Computer Science', '2022', 'https://doi.org/10.7717/peerj-cs.958', '#', false, '2026-04-23 17:43:22.460601+00'),
	('810387f6-5679-427a-9bfa-318220df10fa', 'COVID-19 Prediction Models and Unexploited Data', 'KC Santosh', 'Perspective on SEIR/agent‑based/curve‑fitting predictors and data limitations.', 'Journal of Medical Systems (Springer)', '2020', 'https://doi.org/10.1007/s10916-020-01645-z', '#', false, '2026-04-23 17:43:22.460601+00'),
	('3d9767b3-0523-4e2a-a552-324e8cf2fd9c', 'Truncated inception net: COVID-19 outbreak screening using chest X-rays', 'Dipayan Das, KC Santosh, Umapada Pal', 'Truncated Inception architecture for CXR screening.', 'Physical and Engineering Sciences in Medicine', '2020', 'https://doi.org/10.1007/s13246-020-00888-x', '#', false, '2026-04-23 17:43:22.460601+00'),
	('10e5d48b-ae0c-47c8-a023-d8d130d9aa11', 'Covid-19 Imaging Tools: How Big Data is Big?', 'KC Santosh, Soumyajit Ghosh', 'Analysis of imaging tools and data size considerations for COVID‑19.', 'Journal of Medical Systems (Springer)', '2021', 'https://doi.org/10.1007/s10916-021-01747-2', '#', false, '2026-04-23 17:43:22.460601+00'),
	('8a541d17-5ff5-4b76-92e6-5069690d87e8', 'Shallow Convolutional Neural Network for COVID-19 Outbreak Screening Using Chest X-rays', 'Himansu Mukherjee, Soumyajit Ghosh, Ankita Dhar, Sk Md Obaidullah, KC Santosh, Kaushik Roy', 'Light‑weight CNN for CXR screening.', 'Cognitive Computation (Springer)', '2021', 'https://doi.org/10.1007/s12559-020-09775-9', '#', false, '2026-04-23 17:43:22.460601+00'),
	('830f4996-8e27-4db5-9f1b-c879eb75d160', 'Deep neural network to detect COVID-19: one architecture for both CT Scans and Chest X-rays', 'Himansu Mukherjee, Soumyajit Ghosh, Ankita Dhar, Sk Md Obaidullah, KC Santosh, Kaushik Roy', 'Single DNN architecture trained on both CT and CXR.', 'Applied Intelligence (Springer)', '2021', 'https://doi.org/10.1007/s10489-020-01943-6', '#', false, '2026-04-23 17:43:22.460601+00'),
	('18818cb7-e4dd-42a5-b84c-50c1124a6d0f', 'Socioeconomic impact due to COVID-19: An empirical assessment', 'Vikrant Gupta, KC Santosh, Richa Arora, Tommaso Ciano, Kousik Sankar Kalid, Satya Mohan', 'Then/now socioeconomic analysis (India) across unemployment, IIP, trade, markets, FX, metals.', 'Information Processing & Management (Elsevier)', '2022', 'https://doi.org/10.1016/j.ipm.2021.102810', '#', false, '2026-04-23 17:43:22.460601+00'),
	('bb23db7c-07c7-44a0-9dba-bc93a57f94cf', 'Winsor-CAM: Human-Tunable Visual Explanations from Deep Networks via Layer-Wise Winsorization', 'C Wall, L Wang, R Rizk, KC Santosh', NULL, 'IEEE Transactions on Pattern Analysis & Machine Intelligence', '2025', 'https://arxiv.org/abs/2507.10846', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('df6b6bdc-5518-41ee-8e62-1376936ad73f', 'PC-SNN: Predictive Coding-based Local Hebbian Plasticity Learning in Spiking Neural Networks', 'H Wang, X Xiong, M Lan, Y Chu, Z Jiang, KC Santosh, S Wang, R Zhong', NULL, 'Neurocomputing', '2025', 'https://arxiv.org/abs/2211.15386', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('e5ee7c4c-c84c-4e34-bdd4-947cda0e5b5b', 'Ecologically Valid Benchmarking and Adaptive Attention: Scalable Marine Bioacoustic Monitoring', 'NR Rasmussen, R Rizk, L Wang, KC Santosh', NULL, 'IEEE Transactions on Artificial Intelligence', '2025', 'https://arxiv.org/abs/2509.04682', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('869acc3e-eb39-4f35-b5ce-fbf6412e7cc5', 'Bi-cephalic self-attended model to classify Parkinson’s disease patients with freezing of gait', 'Shomoita Jahid Mitin, Rodrigue Rizk, Maximilian Scherer, Thomas Koeglsperger, Daniel Lench, KC Santosh, Arun Singh', NULL, 'European Journal of Neuroscience', '2025', 'https://arxiv.org/abs/2507.20862', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('950f16aa-92a5-45ce-8e7a-5a3363c69e29', 'Expert-Guided Explainable Few-Shot Learning with Active Sample Selection for Medical Image Analysis', 'L Wang, I Uddin, KC Santosh', NULL, 'IEEE Journal of Biomedical and Health Informatics', '2025', 'https://doi.org/10.1109/JBHI.2025.3650334', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('b5f7f87f-b292-4ca6-b1a9-ff08d67e5691', 'EEG-Based Classification of Parkinson’s Disease With Freezing of Gait Using Midfrontal Beta Oscillations', 'Shotabdi Roy, Joseph Nuamah, Taylor J Bosch, Richa Barsainya, Maximilian Scherer, Thomas Koeglsperger, KC Santosh, Arun Singh', NULL, 'Journal of Integrative Neuroscience', '2025', 'https://doi.org/10.31083/JIN39023', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a2418a1a-af00-4d04-8356-50b8a9a51497', 'Non-Uniform Illumination Attack for Fooling Convolutional Neural Networks', 'A Jain, SR Dubey, SK Singh, KC Santosh, BB Chaudhuri', NULL, 'IEEE Transactions on Artificial Intelligence', '2025', 'https://doi.org/10.1109/TAI.2025.3549396', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('39c82054-d7d9-4349-9d91-f7ec0de9dab9', 'An algorithmic approach to construct the library of universal logic gates beyond NAND and NOR', 'A Goenka, S Mitra, KC Santosh, M Naskar, N Das', NULL, 'Integration, Elsevier', '2025', 'https://doi.org/10.1016/j.vlsi.2025.102514', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a6d345a1-9b53-4545-a43c-1d16da546419', 'Towards Building Robust Models for Unimodal and Multimodal Medical Imaging Data', 'J Dhar, M Haghighat, N Zaidi, F Sohel, B-Q Vo, KC Santosh', NULL, 'Information Fusion, Elsevier', '2025', 'https://doi.org/10.1016/j.inffus.2025.103822', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('6daa6b1d-3656-4b02-8098-e2f3550a2bb8', 'The heart of transformation: exploring artificial intelligence in cardiovascular disease', 'Mohammed A Chowdhury, Rodrigue Rizk, Conroy Chiu, Jing J Zhang, Jamie L Scholl, Taylor J Bosch, Arun Singh, Lee A Baugh, Jeffrey S McGough, KC Santosh, William CW Chen', NULL, 'Biomedicines', '2025', 'https://doi.org/10.3390/biomedicines13020427', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('722bdeba-ea81-4f9b-8f55-d78e8ebe4ced', 'Advances and Challenges in Meta-Learning: A Technical Review', 'A Vettoruzzo, MR Bouguelia, J Vanschoren, T Rognvaldsson, KC Santosh', NULL, 'IEEE Transactions on Pattern Analysis & Machine Intelligence', '2024', 'https://doi.org/10.1109/TPAMI.2024.3357847', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('d9a3a3d6-8fad-4cdc-85ae-3bd250b3a1d6', 'LIFA: Language Identification From Audio with LPCC-G Features', 'H Mukherjee, A Dhar, Sk Md Obaidullah, KC Santosh, S Phadikar, K Roy, U Pal', NULL, 'Multimedia Tools & Applications, Springer', '2024', 'https://doi.org/10.1007/s11042-023-17782-9', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('98e257c1-b2c5-4089-bfd8-d6f621c6203e', 'Multimodal Learning in Medical Imaging and Informatics', 'KC Santosh and S. Antani', NULL, 'IEEE Journal of Biomedical & Health Informatics', '2023', 'https://doi.org/10.1109/JBHI.2023.3241369', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('0fd81d06-7a63-4429-8ce1-19f64141d52d', 'Leveraging sampling schemes on skewed class distribution to enhance male fertility detection with ensemble AI learners', 'D GhoshRoy, PA Alvi, KC Santosh', NULL, 'International Journal of Artificial Intelligence Tools, World Scientific', '2023', 'https://doi.org/10.1142/S0218001424510030', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('296b0a2d-c3c9-471d-9e9f-5b42989cf2e4', 'A Systematic Review on Deep Structured Learning for COVID-19 Screening Using Chest CT from 2020 to 2022', 'KC Santosh, D GhoshRoy, S Nakarmi', NULL, 'Healthcare, MDPI', '2023', 'https://doi.org/10.3390/healthcare11172388', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('9811ff29-4d35-47e3-83dc-6d66765c6f31', 'Unboxing industry-standard AI models for male fertility prediction with SHAP', 'D GhoshRoy, PA Alvi, and KC Santosh', NULL, 'Healthcare, MDPI', '2023', 'https://doi.org/10.3390/healthcare11070929', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('b45eb861-9720-4c44-8ba5-657988b8fde9', 'SecureFed: Federated learning empowered medical imaging technique to analyze lung abnormalities in chest x-rays', 'A Makkar and KC Santosh', NULL, 'International Journal of Machine Learning and Cybernetics, Springer', '2023', 'https://doi.org/10.1007/s13042-023-01789-7', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('e3af95e0-1d14-459b-acf1-5fa214ace59b', 'Cervical Cancerous Cell Classification: Opposition-based Harmony Search for Deep Feature Selection', 'N Das, KC Santosh, L Shen, S Chakraborty', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2023', 'https://doi.org/10.1007/s13042-023-01872-z', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('826ffc78-20d8-47ac-9d2e-ab68e63278a0', 'AI Tools for Assessing Human Fertility using Risk Factors: A State-of-the-Art Review', 'D GhoshRoy, PA Alvi, and KC Santosh', NULL, 'Journal of Medical Systems, Springer', '2023', 'https://doi.org/10.1007/s10916-023-01983-8', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('1218ad09-fd61-42fe-8074-7d64b9f49fa6', 'Analyzing Non-biological Foreign Objects in Chest X-rays – Clinical Significance and AI tools', 'S Roy and KC Santosh', NULL, 'Healthcare, MDPI', '2023', 'https://doi.org/10.3390/healthcare11030308', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('05ea50c8-b10e-49cc-9eb9-e289893444e4', 'eXplainable AI to predict male fertility using extreme gradient boosting algorithm with SMOTE', 'D GhoshRoy, PA Alvi, and KC Santosh', NULL, 'Electronics, MDPI', '2023', 'https://doi.org/10.3390/electronics12010015', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('d19ba1e9-c1e6-4317-b213-b45a9840a15a', 'Advances in Online Handwritten Recognition in the last decades', 'T Ghosh, S Sen, Sk Md Obaidullah, KC Santosh, K Roy, and U Pal', NULL, 'Computer Science Review, Elsevier', '2022', 'https://doi.org/10.1016/j.cosrev.2022.100515', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('d3f58e79-c7f0-448e-ab3e-6d7a92efe933', 'Advances in Deep Learning for Tuberculosis Screening using Chest X-rays: The last 5-Year Systematic Review', 'KC Santosh, S Allu, S Rajaraman, S Antani', NULL, 'Journal of Medical Systems, Springer', '2022', 'https://doi.org/10.1007/s10916-022-01870-8', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('6013f5e7-c634-48ad-9397-d62ac58f2021', 'Covid-19 versus Lung Cancer: Understanding chest CT images through Deep Ensemble Neural Networks', 'KC Santosh and S Ghosh', NULL, 'International Journal of Artificial Intelligence Tools, World Scientific', '2022', 'https://doi.org/10.1142/S021821302250049X', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('41c6e92d-9e17-4de5-b962-f15c6d4d427a', 'Hate and aggression analysis in NLP using interpretable AI', 'S Raman, V Gupta, P Nagrath, and KC Santosh', NULL, 'International Journal of Pattern Recognition and Artificial Intelligence, World Scientific', '2022', NULL, NULL, true, '2026-04-23 17:43:22.460601+00'),
	('3dd0f7be-8b6b-476c-a34a-b1096f7767f2', 'A systematic review on cough sound analysis for Covid-19 diagnosis and screening: is my cough sound COVID-19?', 'KC Santosh, N Rasmussen, M Mamun, S Aryal', NULL, 'PeerJ Computer Science', '2022', 'https://doi.org/10.7717/peerj-cs.958', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('39ef4e1a-62f2-40aa-931c-4aef5420a9fe', 'Underwater image dehazing using global color features', 'F Alenezi, A Armghan, KC Santosh', NULL, 'Engineering Applications of Artificial Intelligence, Elsevier', '2022', 'https://doi.org/10.1016/j.engappai.2022.105489', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('993728b1-5e33-4bd0-893f-81853d5542cf', 'Explainable AI for Glaucoma Prediction Analysis to Understand Risk Factors in Treatment Planning', 'Md S Kamal, L Chowdhury, S Hasan, N Dey, and KC Santosh', NULL, 'IEEE Transactions on Instrumentation & Measurement', '2022', 'https://doi.org/10.1109/TIM.2022.3171613', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('03844aac-383b-431a-a2f8-6d638a7551e6', 'Do-It-Yourself Recommender System: Reusing and Recycling with Blockchain and Deep Learning', 'S Pandey, V Chouhan, D Verma, S Rajrah, R Saini, and KC Santosh', NULL, 'IEEE Access', '2022', 'https://ieeexplore.ieee.org/document/9864188', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('5148b735-db12-4c8c-8636-b977dcfdcea1', 'Deep Learning for Covid-19 Screening using Chest X-rays in 2020: A Systematic Review', 'KC Santosh, S Ghosh, D GhoshRoy', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2022', 'https://doi.org/10.1142/S0218001422520103', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('e94ad30f-b5e5-4f55-8d85-03f0c113bdd3', 'Deep Features to Detect Pulmonary Abnormalities in Chest X-rays due to Infectious Disease: Covid-19, Pneumonia, and Tuberculosis', 'Md Kawsher, M Biswas, L Gaur, F Alenezi, and KC Santosh', NULL, 'Information Sciences, Elsevier', '2022', 'https://doi.org/10.1016/j.ins.2022.01.062', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('d835f870-473f-46f7-94ea-ae5d3bf948d3', 'Interval timing and midfrontal delta oscillations are impaired in Parkinson’s disease patients with freezing of gait', 'TJ Bosch, R Barsainya, A Ridder, KC Santosh, and A Singh', NULL, 'Journal of Neurology, Springer', '2021', 'https://doi.org/10.1007/s00415-021-10843-9', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a346cb0a-f55c-4c44-b0ac-153149b67e11', 'Current Trends in Image Processing and Pattern Recognition', 'KC Santosh', NULL, 'Frontiers in Robotics and AI', '2021', 'https://doi.org/10.3389/frobt.2021.785075', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('80709941-47c8-4de0-919a-72051479b407', 'Socioeconomic impact due to COVID-19: An empirical assessment', 'V Gupta, KC Santosh, R Arora, T Ciano, KS Kalid, S Mohan', NULL, 'Information Processing and Management, Elsevier', '2021', 'https://doi.org/10.1016/j.ipm.2021.102810', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('648f8a2d-4659-4c0f-a0a5-b508fe2003da', 'Balance Your Work-Life: Personal Interactive Web-Interface', 'S Majumder, S Chowdhury, N Dey, and KC Santosh', NULL, 'International Journal Of Interactive Multimedia And Artificial Intelligence', '2021', 'http://doi.org/10.9781/ijimai.2021.08.016', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('f6d9859b-60d7-4d3b-ae9f-0047e9adce5a', 'Covid-19 medical imaging tools: how big data is big?', 'KC Santosh and S Ghosh', NULL, 'Journal of Medical Systems, Springer', '2021', 'https://doi.org/10.1007/s10916-021-01747-2', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('67f3969f-83e5-49a9-ae76-55908f5d88fa', 'Deep learning for graphics recognition: document understanding and beyond', 'J-C Burie, A Fornés, KC Santosh, and MM Luqman', NULL, 'International Journal of Document Analysis and Recognition', '2021', 'https://doi.org/10.1007/s10032-021-00372-6', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('56c570be-774d-47fd-b931-29afdababf12', 'Cervical Cancerous Cell Classification: Opposition-based Harmony Search for Deep Features Selection', 'A Koilada, N Das, KC Santosh', NULL, 'Engineering Applications of Artificial Intelligence, Elsevier', '2021', NULL, NULL, true, '2026-04-23 17:43:22.460601+00'),
	('30946818-1928-4782-b680-0c9f0c534eac', 'Lung Health Analysis: Adventitious Respiratory Sound Classification Using Filterbank Energies', 'H Mukherjee, H Salam, KC Santosh', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2021', 'https://doi.org/10.1142/S0218001421570081', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('81b41cd9-7e1c-429c-b240-85fe748070d7', 'Improved U-Net architecture with VGG-16 for brain tumor segmentation', 'S Ghosh, A Chaki, KC Santosh', NULL, 'Physical and Engineering Sciences in Medicine, Springer', '2021', 'https://doi.org/10.1007/s13246-021-01019-w', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('147e8e06-2c29-4017-bbd7-088adb64551e', 'Personalized Recommendation: An Enhanced Hybrid Collaborative Filtering', 'P Pirasteh, MR Bouguelia, KC Santosh', NULL, 'Advances in Computational Intelligence, Springer', '2021', 'https://doi.org/10.1007/s43674-021-00001-z', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('1ab3849c-6d4f-4e16-bbc3-2bced4eb7b28', 'Understanding Cartoon Emotion using Integrated Deep Neural Network on Large Dataset', 'N Jain, V Gupta, KC Santosh', NULL, 'Neural Computing and Applications, Springer', '2021', 'https://doi.org/10.1007/s00521-021-06003-9', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('c0ad4ca4-63ac-434c-abec-ebe85831bbcc', 'LWSINet: A deep learning-based approach towards video script identification', 'M Ghosh, H Mukherjee, Obaidullah Sk, KC Santosh, N Das, Kaushik Roy', NULL, 'Multimedia Tools and Applications, Springer', '2021', 'https://doi.org/10.1007/s11042-021-11103-8', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('36b06a3c-1d90-4da9-a92a-58a79a1e893a', 'Understanding movie poster: Transfer-deep learning approach for graphic-rich text recognition', 'M Ghosh, S Roy, H Mukherjee, Sk Md Obaidullah, KC Santosh, K Roy', NULL, 'The Visual Computer, Springer', '2021', 'https://doi.org/10.1007/s00371-021-02094-6', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('993080a8-b942-4595-bde5-7088bc2727c6', 'Machine Translation using Deep Learning for Universal Networking Language based on their Structure', 'Md N Yousuf Ali, Md L Rahman, J Chaki, N Dey, KC Santosh', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2021', 'https://doi.org/10.1007/s13042-021-01317-5', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('b259a8d3-8f5f-48ff-b3a9-13587cd626cb', 'Geometric Regularized Hopfield Neural Network for Medical Image Enhancement', 'F Alenezi, KC Santosh', NULL, 'International Journal of Biomedical Imaging', '2021', 'https://doi.org/10.1155/2021/6664569', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('7d2c711c-6386-41ba-840c-5aed042d5a38', 'Colorectal Histology Tumor Detection using Ensemble Deep Neural Network', 'S Ghosh, A Bandyopadhyay, S Sahay, R Ghosh, I Kundu, KC Santosh', NULL, 'Engineering Applications of Artificial Intelligence, Elsevier', '2021', 'https://doi.org/10.1016/j.engappai.2021.104202', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('71aaac97-cece-4a38-a551-d6c3ed580eae', '5K+ CT Images on Fractured Limbs: A Dataset for Medical Imaging Research', 'D Ruikar, KC Santosh, R Hegadi, L Rupnar, V Chaudhary', NULL, 'Journal of Medical Systems, Springer', '2021', 'https://doi.org/10.1007/s10916-021-01724-9', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('b226ce36-9122-4ae1-98e8-277855f2d521', 'Development of a Machine-Learning-Based Decision Support Mechanism for Predicting Chemical Tanker Cleaning Activity', 'B Cankaya, B Eren Tokgoz, A Dag, and KC Santosh', NULL, 'Journal of Modelling in Management', '2020', NULL, NULL, true, '2026-04-23 17:43:22.460601+00'),
	('407b9b16-65c8-4cdf-93c1-6fb402cbaa32', 'Automatic lung health screening using respiratory sounds', 'H Mukherjee, P Sreerama, K Roy, Z Temesgen, and KC Santosh', NULL, 'Journal of Medical Systems, Springer', '2020', 'https://doi.org/10.1007/s10916-020-01681-9', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('f35e0d2d-b6c3-4ee1-85c8-f687f4df055a', 'Skin Cancer Classification through Quantized color features and Generative Adversarial Network', 'A Maiti, B Chaterjee, and KC Santosh', NULL, 'International Journal of Ambient Computing and Intelligence', '2020', NULL, NULL, true, '2026-04-23 17:43:22.460601+00'),
	('225cb3c0-1ebc-4e4f-9a93-f744cc9a2cf5', 'Identifying Language from Songs', 'H Mukherjee, A Dhar, Sk Obaidullah, KC Santosh, S Phadikar, Kaushik Roy', NULL, 'Multimedia Tools and Applications, Springer', '2020', 'https://doi.org/10.1007/s11042-020-10163-6', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('372bc6b9-ac73-4612-8535-f78851510a31', 'Weber Local Descriptor for Image Analysis and Recognition: A Review', 'A Banerjee, N Das, and KC Santosh', NULL, 'The Visual Computer, Springer', '2020', 'https://doi.org/10.1007/s00371-020-02017-x', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('b185d1fd-3582-4ff5-abf8-32f562794743', 'Shallow Convolutional Neural Networks for COVID-19 Outbreak Screening using Chest X-rays', 'H Mukherjee, S Ghosh, A Dhar, Sk Obaidullah, KC Santosh, K Roy', NULL, 'Cognitive Computation, Springer', '2020', 'https://doi.org/10.1007/s12559-020-09775-9', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('732c933b-ee19-4479-bdcf-253f242ce3d9', 'Deep Neural Network to Detect COVID-19: One Architecture for both Chest X-rays and CT Scans', 'H Mukherjee, S Ghosh, A Dhar, Sk Obaidullah, KC Santosh, K Roy', NULL, 'Applied Intelligence, Springer', '2020', 'https://doi.org/10.1007/s10489-020-01943-6', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('12ddd919-4b27-4137-84a9-aca03be9e11e', 'Revisited COVID-19 mortality and recovery rates: are we missing recovery time period?', 'HR Bhapkar, P Mahalle, N Dey, KC Santosh', NULL, 'Journal of Medical Systems, Springer', '2020', 'https://doi.org/10.1007/s10916-020-01668-6', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('87bb0a18-da02-45b0-aa6c-c9903e6f7a63', 'usfAD: A robust unsupervised stochastic forest-based anomaly detector', 'S Aryal, KC Santosh, R Dazeley', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2020', 'https://doi.org/10.1007/s13042-020-01225-0', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('1c1d97b8-f817-49ab-adb1-9d30dc8060bd', 'COVID-19: Psychological and Psychosocial Impact, Fear, and Passion', 'N Dey, KC Santosh', NULL, 'Digital Government: Research and Practice, ACM', '2020', 'https://doi.org/10.1145/3428088', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('f3a80f25-a72f-4f0f-bf90-08a61f60d17b', 'Niblack Binarization on Document Images: Area Efficient, Low Cost, and Noise Tolerant Stochastic Architecture', 'S Mitra, KC Santosh, MK Naskar', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2020', 'https://doi.org/10.1142/S0218001421540136', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('5bb690ca-4a8d-4253-a05e-b1f2accb0a9f', 'COVID-19 Prediction Models and Unexploited Data', 'KC Santosh', NULL, 'Journal of Medical Systems, Springer', '2020', 'https://doi.org/10.1007/s10916-020-01645-z', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('755ba3ef-363e-4b67-8282-3ad266198f7c', 'AI-driven tools for coronavirus outbreak: Need of active learning and cross-population train/test models on multitudinal/multimodal data', 'KC Santosh', NULL, 'Journal of Medical Systems, Springer', '2020', 'https://doi.org/10.1007/s10916-020-01562-1', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('55ffd087-2497-426f-b9ca-abcb335a6158', 'Truncated Inception Net: COVID-19 Outbreak Screening using Chest X-rays', 'D Das, KC Santosh, U Pal', NULL, 'Physical and Engineering Sciences in Medicine, Springer', '2020', 'https://doi.org/10.1007/s13246-020-00888-x', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('9ea9dfea-b05e-47a6-9a17-e9e0e8267eb5', 'Gradient boosting in crowd ensembles for Q-learning using weight sharing', 'D Elliott, KC Santosh, C Anderson', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2020', 'https://doi.org/10.1007/s13042-020-01115-5', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('917d8aa6-a1e9-4bac-8b1b-2f6cb0a4b734', 'Cardiotocograph-based labor stage classification from uterine contraction pressure during ante-partum and intra-partum period – a fuzzy theoretic approach', 'S Das, Sk Md Obaidullah, KC Santosh, K Roy, C K Saha', NULL, 'Health Information Science and Systems, Springer', '2020', 'https://doi.org/10.1007/s13755-020-00107-7', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('7832317e-56d0-4e4e-b0eb-7d583d3675a5', 'DevNet: an efficient CNN architecture for handwritten Devanagari character recognition', 'R Guha, N Das, M Kundu, M Nasipuri, KC Santosh', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2020', 'https://doi.org/10.1142/S0218001420520096', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('0c446325-9be0-4adc-9739-d65ce7ae6dc2', 'A Novel Data Pre-processing Technique: Making Data Mining Robust to Different Units and Scales of Measurement', 'S Aryal, AA Baniya, KC Santosh', NULL, 'The Australian Journal of Intelligent Information Processing Systems', '2020', NULL, NULL, true, '2026-04-23 17:43:22.460601+00'),
	('838b27ec-7576-4be1-ba9a-0efe62e5182f', 'segFast-02: Semantic-based image segmentation using encoder-decoder compression architecture', 'S Ghosh, A Pal, S Jaiswal, KC Santosh, N Das, M Nassipuri', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2019', 'https://doi.org/10.1007/s13042-019-01005-5', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('d1670096-37bd-4464-a5d4-34ef1c27de60', 'Deep learning for spoken language identification: Can we visualize speech signal patterns?', 'H Mukherjee, Sk Md Obaidullah, KC Santosh, S Phadikar, K Roy', NULL, 'Neural Computing and Applications, Springer', '2019', 'https://doi.org/10.1007/s00521-019-04468-3', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('48323ec8-8cc0-4f93-a9cd-f86084c3cd3d', 'Feature Learning for Offline Handwritten Signature Verification Using Convolutional Neural Network', 'A Jagtap, RS Hegadi, KC Santosh', NULL, 'International Journal of Technology and Human Interaction (IJTHI)', '2019', 'https://doi.org/10.4018/IJTHI.2019100105', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a0872fe9-81b2-434f-861f-6e588ac841c3', 'Linear predictive coefficients-based feature to identify top-7 spoken languages', 'H Mukherjee, A Dhar, Sk Md Obaidullah, KC Santosh, S Phadikar, K Roy', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2019', 'https://doi.org/10.1142/S0218001420580069', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('93a2c373-85d5-403b-8b45-a32ffc032bbc', 'Improved word level handwritten Indic script identification through integrated small convolutional neural networks', 'S Ukil, S Ghosh, Sk Md Obaidullah, KC Santosh, K Roy, N Das', NULL, 'Neural Computing and Applications, Springer', '2019', 'https://doi.org/10.1007/s00521-019-04111-1', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('3f64fafb-a42b-4bba-8525-1074a690342b', 'Automated fractured bone segmentation and labeling from CT images', 'D Ruikar, KC Santosh, RS Hegadi', NULL, 'Journal of Medical Systems, Springer', '2019', 'https://doi.org/10.1007/s10916-019-1176-x', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('b08acb8a-3d5e-4904-a2a6-fed0d031033b', 'A lazy learning-based language identification from speech using MFCC-2 features', 'H Mukherjee, Sk Md Obaidullah, KC Santosh, S Phadikar, K Roy', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2019', 'https://doi.org/10.1007/s13042-019-00928-3', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('93c50b15-2498-47d9-bccf-499f63de3280', 'Kinect sensor-based interaction monitoring system using the BLSTM neural network in healthcare', 'R Saini, P Kumar, B Kaur, P P Roy, D P Dogra, KC Santosh', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2019', 'https://doi.org/10.1007/s13042-018-0887-5', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('6ec476a8-b6b1-492d-b20e-011faac80848', 'Imperceptible watermark for a game-theoretic watermarking system', 'S Vaidya, C Mouli, KC Santosh', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2019', 'https://doi.org/10.1007/s13042-018-0813-x', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('9f0adf67-22fe-474a-9d02-cc4873450b7d', 'Automatic Indic script identification from handwritten documents: page, block, line and word-level approach', 'Sk Md Obaidullah, KC Santosh, C Halder, N Das, K Roy', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2019', 'https://doi.org/10.1007/s13042-017-0702-8', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a3ad2917-fdc0-4195-be88-a6863f994f58', 'Speech processing in healthcare: can we integrate?', 'KC Santosh', NULL, 'Intelligent Speech Signal Processing, Elsevier Press', '2019', 'https://www.sciencedirect.com/science/article/pii/B9780128181300000015', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('cb635aa5-c2bf-4235-983b-2303ca2fa60e', 'Automated chest X-ray screening: can lung section symmetry help detect pulmonary abnormalities?', 'KC Santosh and S Antani', NULL, 'IEEE Transactions on Medical Imaging', '2018', 'https://doi.org/10.1109/TMI.2017.2775636', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('d2f70588-76e3-490e-9274-f6b632395c5f', 'Angular relational signature-based chest radiograph image view classification', 'KC Santosh and L Wendling', NULL, 'Medical & Biological Engineering & Computing, Springer', '2018', 'https://doi.org/10.1007/s11517-018-1786-3', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('caca77d9-9d42-4d9c-8e91-66713186a5f8', 'Investigation of DNA discontinuity for detecting Tuberculosis', 'S F Nimmy, G Sarowar, N Dey, A Ashour, KC Santosh', NULL, 'Journal of Ambient Intelligence and Humanized Computing, Springer', '2018', 'https://doi.org/10.1007/s12652-018-0878-0', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('5ad61316-4e33-44c5-b0bb-b1adff92402e', 'A Systematic Review on Orthopedic Simulators for Psycho-Motor Skill and Surgical Procedure Training', 'D Ruikar, RS Hegadi, KC Santosh', NULL, 'Journal of Medical Systems, Springer', '2018', 'https://doi.org/10.1007/s10916-018-1019-1', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('74113f5d-329c-4ce8-8fb3-518cef7631df', 'Feature Selection for Automatic Tuberculosis Screening in Frontal Chest Radiographs', 'S Vajda, A Karagyris, S Jaeger, KC Santosh, S Candemir, Z Xue, S Antani, G Thoma', NULL, 'Journal of Medical Systems, Springer', '2018', 'https://doi.org/10.1007/s10916-018-0991-9', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('3439b7d4-1978-4651-8920-be433a9b1c66', 'Line spectral frequency-based features and extreme learning machine for voice activity detection from audio signal', 'H Mukherjee, Sk Md Obaidullah, KC Santosh, S Phadikar, K Roy', NULL, 'International Journal of Speech Technology, Springer', '2018', 'https://doi.org/10.1007/s10772-018-9525-6', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('e692bdfa-a1fb-45e3-82bd-2b7d6dead703', 'Extreme learning machine for handwritten Indic script identification in multi-script documents', 'Sk Md Obaidullah, A Bose, H Mukherjee, KC Santosh, N Das, K Roy', NULL, 'Journal of Electronic Imaging, SPIE', '2018', 'https://doi.org/10.1117/1.JEI.27.5.051214', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('0c22f2e7-471c-4afe-af4f-590651040682', 'Handwritten Indic script identification in multi-script document images: A survey', 'Sk Md Obaidullah, C Halder, KC Santosh, N Das, K Roy', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2018', 'https://doi.org/10.1142/S0218001418560128', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('8b1c1965-a3a4-4b70-bc2e-0a8becb1f1c7', 'Content independent writer identification on Bangla script: A document level approach', 'C Halder, Sk Md Obaidullah, KC Santosh, K Roy', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2018', 'https://doi.org/10.1142/S0218001418560116', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a17b83aa-29e6-4e19-8bf2-790c1c4ac46e', 'PHDIndic 11: Page-level handwritten document image dataset of 11 official Indic scripts for script identification', 'Sk Md Obaidullah, C Halder, KC Santosh, N Das, K Roy', NULL, 'Multimedia Tools and Applications, Springer', '2018', 'https://doi.org/10.1007/s11042-017-4373-y', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('5a3c550a-14bd-4672-b441-7ba980d954f1', 'Correspondence: Edge map analysis in chest X-rays for automatic pulmonary abnormality screening', 'KC Santosh', NULL, 'Indian Journal of Tuberculosis, Elsevier', '2018', 'https://doi.org/10.1016/j.ijtb.2016.10.001', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('2dafe2ec-553f-490a-8b5a-7d58de91d04e', 'Automatic Line-Level Script Identification From Handwritten Document Images – A Region-Wise Classification Framework For Indian Subcontinent', 'Sk Md Obaidullah, N Das, KC Santosh, K Roy', NULL, 'Malaysian Journal of Computer Science', '2018', 'https://mjir.um.edu.my/index.php/MJCS/article/view/10610', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('882ec803-46ee-441f-a540-b08553c2dbb5', 'Arrow detection in biomedical images using sequential classifier', 'KC Santosh and P Roy', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2018', 'https://doi.org/10.1007/s13042-016-0623-y', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('1ed8697b-176d-424b-ad92-b2c311612f2b', 'Agreeing to disagree: active learning with noisy labels without crowdsourcing', 'M Bouguelia, S Nowaczyk, KC Santosh, Antanas Verikas', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2018', 'https://doi.org/10.1007/s13042-017-0645-0', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('0887555c-9665-4438-b2ba-c81a53872728', 'Line segment-based stitched multipanel figure separation for effective biomedical CBIR', 'KC Santosh, A Aafaque, S Antani, G Thoma', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2017', 'https://doi.org/10.1142/S0218001417570038', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('58b08ed7-b3ba-4095-92c7-28decf69052c', 'Automated chest X-ray screening: can edge map measure the evidence of pulmonary abnormalities?', 'KC Santosh and S Vajda', NULL, 'Atlas of Science', '2017', 'https://atlasofscience.org/automated-chest-x-ray-screening/', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('3e9745a8-ad33-4936-89ac-b8e73a9fb232', 'Foreign Circular Element Detection in Chest X-rays for Effective Automated Pulmonary Abnormality Screening', 'F Zohora and KC Santosh', NULL, 'International Journal of Computer Vision and Image Processing', '2017', 'https://doi.org/10.4018/IJCVIP.2017040103', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('f86fae67-4658-4f1c-b068-527e13c41aa3', 'Word-level Multi-script Indic Document Image Dataset and Baseline Results on Script Identification', 'Sk Md Obaidullah, KC Santosh, C Halder, N Das, K Roy', NULL, 'International Journal of Computer Vision and Image Processing', '2017', 'https://doi.org/10.4018/IJCVIP.2017040106', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('03a5ecd3-d9fa-48e3-999c-346887ec87c2', 'Separating Indic scripts with mantra for effective handwritten script identification in multiscript documents', 'Sk Md Obaidullah, C Goswami, KC Santosh, N Das, C Halder, K Roy', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2017', 'https://doi.org/10.1142/S0218001417530032', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('202e961f-06b5-4587-9b6a-976609fcaa9a', 'Edge map analysis in Chest X-rays for Automatic Abnormality Screening', 'KC Santosh, S Vajda, S Antani, G Thoma', NULL, 'International Journal of Computer Assisted Radiology & Surgery, Springer', '2016', 'https://doi.org/10.1007/s11548-016-1359-6', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('6e6255ef-4812-4322-b305-c4df4c3cff40', 'A Simple and Efficient Arrowhead Detection in Biomedical Images', 'KC Santosh, N Alam, P Roy, L Wendling, S Antani, G Thoma', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2016', 'https://doi.org/10.1142/S0218001416570020', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('ae5d329b-708c-4d4e-8eb6-733dcf8a958a', 'Overlaid Arrow Detection for Labeling Biomedical Image Regions', 'KC Santosh, L Wendling, S Antani, G Thoma', NULL, 'IEEE Intelligent Systems (special issue: Pattern Recognition)', '2016', 'https://doi.org/10.1109/MIS.2016.24', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('e812e479-c548-48af-9872-47be69abf893', 'Combination of texture and shape features to detect Tuberculosis in digital chest X-rays', 'A Karargyris, J Siegelman, D Tzortzis, S Jaeger, S Candemir, Z Xue, KC Santosh, S Vajda, S Antani, L Folio, G Thoma', NULL, 'International Journal of Computer Assisted Radiology & Surgery, Springer', '2016', 'https://doi.org/10.1007/s11548-015-1242-x', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('07980bfb-99c4-4b72-b673-25b4026e98e7', 'g-DICE: Graph mining-based Document Information Content Exploitation', 'KC Santosh', NULL, 'International Journal on Document Analysis and Recognition, Springer', '2015', 'https://doi.org/10.1007/s10032-015-0253-z', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a6bf6330-3a53-49b2-b0ea-aae062c96c88', 'Automatically Detecting Rotation in Chest Radiographs using Principal Rib-Orientation Measure for Quality Control', 'KC Santosh, S Candemir, S Jaeger, S Antani, G Thoma, L Folio', NULL, 'International Journal of Pattern Recognition & Artificial Intelligence, World Scientific', '2015', 'https://doi.org/10.1142/S0218001415570013', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('9913aaf7-421f-4526-8b73-b31e89512d4f', 'Character recognition based on Multi-projection Non-linear Profiles Measure', 'KC Santosh, L Wendling', NULL, 'Frontiers of Computer Science, Springer', '2015', 'https://doi.org/10.1007/s11704-015-3400-2', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('dbc55791-b574-449c-9115-6d05c9fd3e51', 'Graphical Symbol Recognition', 'KC Santosh, L Wendling', NULL, 'Wiley Encyclopedia of Electrical and Electronics Engineering', '2015', 'https://doi.org/10.1002/047134608X.W8260', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('05e1e51a-c1c5-4de9-a161-1161eab8f48e', 'RSILC: Rotation and Scale Invariant, Line Colour aware Descriptor', 'S Candemir, E Borovikov, KC Santosh, S Antani, G Thoma', NULL, 'Image and Vision Computing', '2015', 'https://doi.org/10.1016/j.imavis.2015.06.010', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('7471cddb-ddb1-41ce-935d-ba7316cbe6f6', 'Bayesian Networks for Incomplete Data Analysis in Form Processing', 'E Philippot, KC Santosh, A Belaïd, Y Belaïd', NULL, 'International Journal of Machine Learning & Cybernetics, Springer', '2015', 'https://doi.org/10.1007/s13042-014-0234-4', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('cfdc6ef6-788c-45f4-92d5-8355e2716d42', 'BoR: Bags-of-Relations for Symbol Retrieval', 'KC Santosh, L Wendling, B Lamiroy', NULL, 'International Journal of Pattern Recognition and Artificial Intelligence, World Scientific', '2014', 'https://doi.org/10.1142/S0218001414500177', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('a34c31d4-f0b5-457b-873c-2ed22be10a99', 'Integrating Vocabulary Clustering with Spatial Relations for Symbol Recognition', 'KC Santosh, B Lamiroy, L Wendling', NULL, 'International Journal of Document Analysis and Application, Springer', '2014', 'https://doi.org/10.1007/s10032-013-0205-4', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('1e61a898-30b0-41ed-ac57-25bf39010d0b', 'DTW–Radon Shape Descriptor for Pattern Recognition', 'KC Santosh, L Wendling, B Lamiroy', NULL, 'International Journal of Pattern Recognition and Artificial Intelligence, World Scientific', '2013', 'https://doi.org/10.1142/S0218001413500080', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('1d9a1262-1228-484e-b21f-baf91f1358a5', 'Relative Positioning of Stroke Based Clustering: A New Approach to On-line Handwritten Devanagari Character Recognition', 'KC Santosh, C Nattee, B Lamiroy', NULL, 'International Journal of Image & Graphics (IJIG), World Scientific', '2012', 'https://doi.org/10.1142/S0219467812500167', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('9ac779f6-24da-4d13-b8ae-34c4f0a30b70', 'Symbol Recognition using Spatial Relations', 'KC Santosh, B Lamiroy, L Wendling', NULL, 'Pattern Recognition Letters (PRL), Elsevier', '2012', 'https://doi.org/10.1016/j.patrec.2011.09.040', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('7d63be81-c2b6-4628-aa33-6527dad7409c', 'Use of Dynamic Time Warping for Object Shape Classification through Signature', 'KC Santosh', NULL, 'Kathmandu University Journal of Science, Engineering and Technology', '2010', 'https://www.nepjol.info/index.php/KUSET/article/view/3308/2848', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('b0b6fb04-3bb1-4be7-9626-50506f126047', 'A Comprehensive Survey on On-line Handwriting Recognition Technology and its Real Application to the Nepalese Natural Handwriting', 'KC Santosh, C Nattee', NULL, 'Kathmandu University Journal of Science, Engineering and Technology', '2009', 'https://hal.inria.fr/inria-00354242v2', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('9503fd95-e2fb-42d6-bbca-d0f376f9b538', 'Template-based Nepali Handwritten Alphanumeric Character Recognition', 'KC Santosh, C Nattee', NULL, 'Thammasat International Journal of Science and Technology', '2009', 'https://ph02.tci-thaijo.org/index.php/SciTechAsia/article/download/41524/34312', NULL, true, '2026-04-23 17:43:22.460601+00'),
	('9240d071-774e-4240-b588-9b8b41ee86e4', 'Test paper', 'Test User', 'This is a test paper', 'USD-AI', '2026', 'https://francismungai.github.io/ai-research-lab/', 'https://francismungai.github.io/ai-research-lab/portal/manage-pubs.html', false, '2026-05-01 13:35:26.952453+00');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") VALUES
	('book-covers', 'book-covers', NULL, '2026-04-29 17:29:14.053817+00', '2026-04-29 17:29:14.053817+00', true, false, NULL, '{image/jpeg,image/png,image/webp}', NULL, 'STANDARD'),
	('people-photos', 'people-photos', NULL, '2026-04-29 18:00:21.172988+00', '2026-04-29 18:00:21.172988+00', true, false, NULL, '{image/jpeg,image/png,image/webp}', NULL, 'STANDARD'),
	('blog-covers', 'blog-covers', NULL, '2026-04-29 18:18:05.696952+00', '2026-04-29 18:18:05.696952+00', true, false, NULL, '{image/jpeg,image/png,image/webp}', NULL, 'STANDARD');


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") VALUES
	('3e37b111-7d37-469e-8ec2-6c7d495467eb', 'book-covers', '1777642755607-8j1rj5k.jpeg', '195c37b1-c99c-4289-8fc5-d2f7037c6224', '2026-05-01 13:39:15.665415+00', '2026-05-01 13:39:15.665415+00', '2026-05-01 13:39:15.665415+00', '{"eTag": "\"195469572a760fbfecd5f8bc44705fab\"", "size": 199675, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-01T13:39:16.000Z", "contentLength": 199675, "httpStatusCode": 200}', '5b939fca-af7d-47c9-8ec9-b7155f472e98', '195c37b1-c99c-4289-8fc5-d2f7037c6224', '{}'),
	('c2015e16-0706-4650-ae51-957b4150fe7e', 'people-photos', '1777643681320-nwzt1fz.jpeg', '195c37b1-c99c-4289-8fc5-d2f7037c6224', '2026-05-01 13:54:41.363569+00', '2026-05-01 13:54:41.363569+00', '2026-05-01 13:54:41.363569+00', '{"eTag": "\"195469572a760fbfecd5f8bc44705fab\"", "size": 199675, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-05-01T13:54:42.000Z", "contentLength": 199675, "httpStatusCode": 200}', 'c161ee4c-ec7d-4802-b670-08f23fec4746', '195c37b1-c99c-4289-8fc5-d2f7037c6224', '{}');


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

INSERT INTO "supabase_functions"."hooks" ("id", "hook_table_id", "hook_name", "created_at", "request_id") VALUES
	(1, 22054, 'trigger-publications-build', '2026-05-01 13:19:28.525157+00', 1),
	(2, 22054, 'trigger-publications-build', '2026-05-01 13:33:39.994534+00', 2),
	(3, 22054, 'trigger-publications-build', '2026-05-01 13:35:26.952453+00', 3),
	(4, 22064, 'trigger-books-build', '2026-05-01 13:39:15.855571+00', 4),
	(5, 22045, 'trigger-people-build', '2026-05-01 13:54:41.550365+00', 5),
	(6, 22045, 'trigger-people-build', '2026-05-01 15:02:49.207733+00', 6),
	(7, 22045, 'trigger-people-build', '2026-05-01 15:03:19.343711+00', 7),
	(8, 22045, 'trigger-people-build', '2026-05-01 15:05:15.483526+00', 8),
	(9, 22045, 'trigger-people-build', '2026-05-01 15:05:34.149906+00', 9),
	(10, 22045, 'trigger-people-build', '2026-05-01 15:06:12.56813+00', 10),
	(11, 22045, 'trigger-people-build', '2026-05-01 15:12:19.386132+00', 11);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 38, true);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 11, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict A06m3vRGyuYFm8MP1wxL8LORlBBUGX4P7oKyQyPhguGHG2PZaMOcMG6iCNBDU1F

RESET ALL;
