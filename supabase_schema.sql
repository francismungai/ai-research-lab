


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."enforce_usd_email"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  -- Check if the email ends with either of the allowed domains
  IF NEW.email NOT LIKE '%@usd.edu' AND NEW.email NOT LIKE '%@coyotes.usd.edu' THEN
    -- If not, block the registration and return a clean error message
    RAISE EXCEPTION 'Access Denied: Only official USD email addresses (@usd.edu or @coyotes.usd.edu) are allowed.';
  END IF;
  
  -- If it passes, allow the user creation to proceed
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."enforce_usd_email"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_role"() RETURNS "text"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT role FROM profiles WHERE id = auth.uid();
$$;


ALTER FUNCTION "public"."get_my_role"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role)
  VALUES (new.id, new.email, 'user');
  RETURN new;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rls_auto_enable"() RETURNS "event_trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'pg_catalog'
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$$;


ALTER FUNCTION "public"."rls_auto_enable"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."blog_posts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "content" "text" DEFAULT ''::"text" NOT NULL,
    "excerpt" "text" DEFAULT ''::"text",
    "cover_image_url" "text",
    "author_id" "uuid" DEFAULT "auth"."uid"(),
    "author_name" "text" DEFAULT ''::"text" NOT NULL,
    "status" "text" DEFAULT 'draft'::"text" NOT NULL,
    "tags" "text"[] DEFAULT '{}'::"text"[],
    "published_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "blog_posts_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'in_review'::"text", 'published'::"text"])))
);


ALTER TABLE "public"."blog_posts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."books" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "authors" "text",
    "description" "text",
    "publisher" "text",
    "pub_year" "text",
    "isbn" "text",
    "amazon_url" "text",
    "publisher_url" "text",
    "image_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."books" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."people" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "category" "text" NOT NULL,
    "name" "text" NOT NULL,
    "role" "text",
    "photo_url" "text",
    "scholar_url" "text",
    "dblp_url" "text",
    "website_url" "text",
    "degree" "text",
    "grad_year" "text",
    "member_key" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."people" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "email" "text",
    "role" "text" DEFAULT 'user'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "profiles_role_check" CHECK (("role" = ANY (ARRAY['user'::"text", 'contributor'::"text", 'editor'::"text", 'admin'::"text"])))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."publications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "authors" "text",
    "description" "text",
    "venue" "text",
    "pub_year" "text",
    "paper_url" "text",
    "code_url" "text",
    "is_sample" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."publications" OWNER TO "postgres";


ALTER TABLE ONLY "public"."blog_posts"
    ADD CONSTRAINT "blog_posts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."blog_posts"
    ADD CONSTRAINT "blog_posts_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."books"
    ADD CONSTRAINT "books_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."people"
    ADD CONSTRAINT "people_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."publications"
    ADD CONSTRAINT "publications_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_blog_posts_author" ON "public"."blog_posts" USING "btree" ("author_id");



CREATE INDEX "idx_blog_posts_published_at" ON "public"."blog_posts" USING "btree" ("published_at" DESC);



CREATE INDEX "idx_blog_posts_status" ON "public"."blog_posts" USING "btree" ("status");



CREATE OR REPLACE TRIGGER "trigger-books-build" AFTER INSERT OR DELETE OR UPDATE ON "public"."books" FOR EACH ROW EXECUTE FUNCTION "supabase_functions"."http_request"('https://mrzbomclmlopohhoszbv.supabase.co/functions/v1/people_gh_hook', 'POST', '{"Content-type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yemJvbWNsbWxvcG9oaG9zemJ2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NTU3NTMzNCwiZXhwIjoyMDkxMTUxMzM0fQ.B-h_OR4dXpSUu7MFUQYCcsUVwDHFQ5XIBbtkDhYuV5w"}', '{}', '5000');



CREATE OR REPLACE TRIGGER "trigger-people-build" AFTER INSERT OR DELETE OR UPDATE ON "public"."people" FOR EACH ROW EXECUTE FUNCTION "supabase_functions"."http_request"('https://mrzbomclmlopohhoszbv.supabase.co/functions/v1/people_gh_hook', 'POST', '{"Content-type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yemJvbWNsbWxvcG9oaG9zemJ2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NTU3NTMzNCwiZXhwIjoyMDkxMTUxMzM0fQ.B-h_OR4dXpSUu7MFUQYCcsUVwDHFQ5XIBbtkDhYuV5w"}', '{}', '5000');



CREATE OR REPLACE TRIGGER "trigger-publications-build" AFTER INSERT OR DELETE OR UPDATE ON "public"."publications" FOR EACH ROW EXECUTE FUNCTION "supabase_functions"."http_request"('https://mrzbomclmlopohhoszbv.supabase.co/functions/v1/people_gh_hook', 'POST', '{"Content-type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yemJvbWNsbWxvcG9oaG9zemJ2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NTU3NTMzNCwiZXhwIjoyMDkxMTUxMzM0fQ.B-h_OR4dXpSUu7MFUQYCcsUVwDHFQ5XIBbtkDhYuV5w"}', '{}', '5000');



ALTER TABLE ONLY "public"."blog_posts"
    ADD CONSTRAINT "blog_posts_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "auth"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Admins can manage people" ON "public"."people" USING (("public"."get_my_role"() = 'admin'::"text"));



CREATE POLICY "Admins have full control over profiles" ON "public"."profiles" USING (("public"."get_my_role"() = 'admin'::"text"));



CREATE POLICY "Delete blog posts" ON "public"."blog_posts" FOR DELETE USING ((("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'editor'::"text"])) OR (("author_id" = "auth"."uid"()) AND ("public"."get_my_role"() = 'contributor'::"text"))));



CREATE POLICY "Editors and Admins manage books" ON "public"."books" USING (("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'editor'::"text"])));



CREATE POLICY "Editors and Admins manage publications" ON "public"."publications" USING (("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'editor'::"text"])));



CREATE POLICY "Insert blog posts" ON "public"."blog_posts" FOR INSERT WITH CHECK ((("auth"."uid"() = "author_id") AND (("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'editor'::"text"])) OR (("public"."get_my_role"() = 'contributor'::"text") AND ("status" = ANY (ARRAY['draft'::"text", 'in_review'::"text"]))))));



CREATE POLICY "Public can view books" ON "public"."books" FOR SELECT USING (true);



CREATE POLICY "Public can view people" ON "public"."people" FOR SELECT USING (true);



CREATE POLICY "Public can view publications" ON "public"."publications" FOR SELECT USING (true);



CREATE POLICY "Update blog posts" ON "public"."blog_posts" FOR UPDATE USING ((("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'editor'::"text"])) OR (("author_id" = "auth"."uid"()) AND ("public"."get_my_role"() = 'contributor'::"text")))) WITH CHECK ((("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'editor'::"text"])) OR (("author_id" = "auth"."uid"()) AND ("public"."get_my_role"() = 'contributor'::"text") AND ("status" = ANY (ARRAY['draft'::"text", 'in_review'::"text"])))));



CREATE POLICY "Users can view own profile" ON "public"."profiles" FOR SELECT USING (("auth"."uid"() = "id"));



CREATE POLICY "View blog posts" ON "public"."blog_posts" FOR SELECT USING ((("status" = 'published'::"text") OR ("author_id" = "auth"."uid"()) OR ("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'editor'::"text"]))));



ALTER TABLE "public"."blog_posts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."books" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."people" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."publications" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";





GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































GRANT ALL ON FUNCTION "public"."enforce_usd_email"() TO "anon";
GRANT ALL ON FUNCTION "public"."enforce_usd_email"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."enforce_usd_email"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_role"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_role"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_role"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."rls_auto_enable"() TO "anon";
GRANT ALL ON FUNCTION "public"."rls_auto_enable"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."rls_auto_enable"() TO "service_role";


















GRANT ALL ON TABLE "public"."blog_posts" TO "anon";
GRANT ALL ON TABLE "public"."blog_posts" TO "authenticated";
GRANT ALL ON TABLE "public"."blog_posts" TO "service_role";



GRANT ALL ON TABLE "public"."books" TO "anon";
GRANT ALL ON TABLE "public"."books" TO "authenticated";
GRANT ALL ON TABLE "public"."books" TO "service_role";



GRANT ALL ON TABLE "public"."people" TO "anon";
GRANT ALL ON TABLE "public"."people" TO "authenticated";
GRANT ALL ON TABLE "public"."people" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."publications" TO "anon";
GRANT ALL ON TABLE "public"."publications" TO "authenticated";
GRANT ALL ON TABLE "public"."publications" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";



































