create sequence "public"."exercises_id_seq";

create sequence "public"."muscle_groups_id_seq";

create sequence "public"."workout_sessions_id_seq";

create sequence "public"."workout_sets_id_seq";


  create table "public"."exercises" (
    "id" integer not null default nextval('public.exercises_id_seq'::regclass),
    "exercise_name" text,
    "primary_muscle_id" integer,
    "secondary_muscle_id" integer,
    "tertiary_muscle_id" integer,
    "quaternary_muscle_id" integer,
    "is_compound" boolean,
    "is_cardio" boolean
      );


alter table "public"."exercises" enable row level security;


  create table "public"."muscle_groups" (
    "id" integer not null default nextval('public.muscle_groups_id_seq'::regclass),
    "muscle_name" text,
    "category" text
      );


alter table "public"."muscle_groups" enable row level security;


  create table "public"."profiles" (
    "id" uuid not null,
    "first_name" text,
    "last_name" text
      );


alter table "public"."profiles" enable row level security;


  create table "public"."workout_sessions" (
    "id" integer not null default nextval('public.workout_sessions_id_seq'::regclass),
    "user_id" uuid not null,
    "session_date" date,
    "notes" text
      );


alter table "public"."workout_sessions" enable row level security;


  create table "public"."workout_sets" (
    "id" integer not null default nextval('public.workout_sets_id_seq'::regclass),
    "workout_id" integer,
    "exercise_id" integer,
    "set_number" integer,
    "reps" integer not null default 0,
    "set_weight" integer not null default 0,
    "time_seconds" integer,
    "distance" double precision,
    "notes" text,
    "type_one" text not null default 'normal'::text,
    "pos_group1" integer,
    "type_two" text,
    "pos_group2" integer,
    "type_three" text,
    "pos_group3" integer,
    "type_four" text,
    "pos_group4" integer
      );


alter table "public"."workout_sets" enable row level security;

alter sequence "public"."exercises_id_seq" owned by "public"."exercises"."id";

alter sequence "public"."muscle_groups_id_seq" owned by "public"."muscle_groups"."id";

alter sequence "public"."workout_sessions_id_seq" owned by "public"."workout_sessions"."id";

alter sequence "public"."workout_sets_id_seq" owned by "public"."workout_sets"."id";

CREATE UNIQUE INDEX exercises_pkey ON public.exercises USING btree (id);

CREATE UNIQUE INDEX muscle_groups_pkey ON public.muscle_groups USING btree (id);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX workout_sessions_pkey ON public.workout_sessions USING btree (id);

CREATE UNIQUE INDEX workout_sets_pkey ON public.workout_sets USING btree (id);

alter table "public"."exercises" add constraint "exercises_pkey" PRIMARY KEY using index "exercises_pkey";

alter table "public"."muscle_groups" add constraint "muscle_groups_pkey" PRIMARY KEY using index "muscle_groups_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."workout_sessions" add constraint "workout_sessions_pkey" PRIMARY KEY using index "workout_sessions_pkey";

alter table "public"."workout_sets" add constraint "workout_sets_pkey" PRIMARY KEY using index "workout_sets_pkey";

alter table "public"."exercises" add constraint "exercises_primary_muscle_id_fkey" FOREIGN KEY (primary_muscle_id) REFERENCES public.muscle_groups(id) not valid;

alter table "public"."exercises" validate constraint "exercises_primary_muscle_id_fkey";

alter table "public"."exercises" add constraint "exercises_quaternary_muscle_id_fkey" FOREIGN KEY (quaternary_muscle_id) REFERENCES public.muscle_groups(id) not valid;

alter table "public"."exercises" validate constraint "exercises_quaternary_muscle_id_fkey";

alter table "public"."exercises" add constraint "exercises_secondary_muscle_id_fkey" FOREIGN KEY (secondary_muscle_id) REFERENCES public.muscle_groups(id) not valid;

alter table "public"."exercises" validate constraint "exercises_secondary_muscle_id_fkey";

alter table "public"."exercises" add constraint "exercises_tertiary_muscle_id_fkey" FOREIGN KEY (tertiary_muscle_id) REFERENCES public.muscle_groups(id) not valid;

alter table "public"."exercises" validate constraint "exercises_tertiary_muscle_id_fkey";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."workout_sessions" add constraint "workout_sessions_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."workout_sessions" validate constraint "workout_sessions_user_id_fkey";

alter table "public"."workout_sets" add constraint "workout_sets_exercise_id_fkey" FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) not valid;

alter table "public"."workout_sets" validate constraint "workout_sets_exercise_id_fkey";

alter table "public"."workout_sets" add constraint "workout_sets_workout_id_fkey" FOREIGN KEY (workout_id) REFERENCES public.workout_sessions(id) ON DELETE CASCADE not valid;

alter table "public"."workout_sets" validate constraint "workout_sets_workout_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
begin
  insert into public.profiles (id, first_name, last_name)
  values (new.id, new.raw_user_meta_data ->> 'first_name', new.raw_user_meta_data ->> 'last_name');
  return new;
end;
$function$
;

grant delete on table "public"."exercises" to "anon";

grant insert on table "public"."exercises" to "anon";

grant references on table "public"."exercises" to "anon";

grant select on table "public"."exercises" to "anon";

grant trigger on table "public"."exercises" to "anon";

grant truncate on table "public"."exercises" to "anon";

grant update on table "public"."exercises" to "anon";

grant delete on table "public"."exercises" to "authenticated";

grant insert on table "public"."exercises" to "authenticated";

grant references on table "public"."exercises" to "authenticated";

grant select on table "public"."exercises" to "authenticated";

grant trigger on table "public"."exercises" to "authenticated";

grant truncate on table "public"."exercises" to "authenticated";

grant update on table "public"."exercises" to "authenticated";

grant delete on table "public"."exercises" to "service_role";

grant insert on table "public"."exercises" to "service_role";

grant references on table "public"."exercises" to "service_role";

grant select on table "public"."exercises" to "service_role";

grant trigger on table "public"."exercises" to "service_role";

grant truncate on table "public"."exercises" to "service_role";

grant update on table "public"."exercises" to "service_role";

grant delete on table "public"."muscle_groups" to "anon";

grant insert on table "public"."muscle_groups" to "anon";

grant references on table "public"."muscle_groups" to "anon";

grant select on table "public"."muscle_groups" to "anon";

grant trigger on table "public"."muscle_groups" to "anon";

grant truncate on table "public"."muscle_groups" to "anon";

grant update on table "public"."muscle_groups" to "anon";

grant delete on table "public"."muscle_groups" to "authenticated";

grant insert on table "public"."muscle_groups" to "authenticated";

grant references on table "public"."muscle_groups" to "authenticated";

grant select on table "public"."muscle_groups" to "authenticated";

grant trigger on table "public"."muscle_groups" to "authenticated";

grant truncate on table "public"."muscle_groups" to "authenticated";

grant update on table "public"."muscle_groups" to "authenticated";

grant delete on table "public"."muscle_groups" to "service_role";

grant insert on table "public"."muscle_groups" to "service_role";

grant references on table "public"."muscle_groups" to "service_role";

grant select on table "public"."muscle_groups" to "service_role";

grant trigger on table "public"."muscle_groups" to "service_role";

grant truncate on table "public"."muscle_groups" to "service_role";

grant update on table "public"."muscle_groups" to "service_role";

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

grant delete on table "public"."workout_sessions" to "anon";

grant insert on table "public"."workout_sessions" to "anon";

grant references on table "public"."workout_sessions" to "anon";

grant select on table "public"."workout_sessions" to "anon";

grant trigger on table "public"."workout_sessions" to "anon";

grant truncate on table "public"."workout_sessions" to "anon";

grant update on table "public"."workout_sessions" to "anon";

grant delete on table "public"."workout_sessions" to "authenticated";

grant insert on table "public"."workout_sessions" to "authenticated";

grant references on table "public"."workout_sessions" to "authenticated";

grant select on table "public"."workout_sessions" to "authenticated";

grant trigger on table "public"."workout_sessions" to "authenticated";

grant truncate on table "public"."workout_sessions" to "authenticated";

grant update on table "public"."workout_sessions" to "authenticated";

grant delete on table "public"."workout_sessions" to "service_role";

grant insert on table "public"."workout_sessions" to "service_role";

grant references on table "public"."workout_sessions" to "service_role";

grant select on table "public"."workout_sessions" to "service_role";

grant trigger on table "public"."workout_sessions" to "service_role";

grant truncate on table "public"."workout_sessions" to "service_role";

grant update on table "public"."workout_sessions" to "service_role";

grant delete on table "public"."workout_sets" to "anon";

grant insert on table "public"."workout_sets" to "anon";

grant references on table "public"."workout_sets" to "anon";

grant select on table "public"."workout_sets" to "anon";

grant trigger on table "public"."workout_sets" to "anon";

grant truncate on table "public"."workout_sets" to "anon";

grant update on table "public"."workout_sets" to "anon";

grant delete on table "public"."workout_sets" to "authenticated";

grant insert on table "public"."workout_sets" to "authenticated";

grant references on table "public"."workout_sets" to "authenticated";

grant select on table "public"."workout_sets" to "authenticated";

grant trigger on table "public"."workout_sets" to "authenticated";

grant truncate on table "public"."workout_sets" to "authenticated";

grant update on table "public"."workout_sets" to "authenticated";

grant delete on table "public"."workout_sets" to "service_role";

grant insert on table "public"."workout_sets" to "service_role";

grant references on table "public"."workout_sets" to "service_role";

grant select on table "public"."workout_sets" to "service_role";

grant trigger on table "public"."workout_sets" to "service_role";

grant truncate on table "public"."workout_sets" to "service_role";

grant update on table "public"."workout_sets" to "service_role";

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


