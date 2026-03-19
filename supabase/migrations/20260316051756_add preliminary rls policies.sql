drop policy "Users can see their own profiles." on "public"."profiles";


  create policy "Users can see their own profiles and any profiles set to public"
  on "public"."profiles"
  as permissive
  for select
  to public
using (((id = auth.uid()) OR (is_public = true)));



  create policy "Users can only insert sessions for themselves."
  on "public"."workout_sessions"
  as permissive
  for insert
  to public
with check ((user_id = ( SELECT auth.uid() AS uid)));



  create policy "Users can see their own workout sessions and sessions of public"
  on "public"."workout_sessions"
  as permissive
  for select
  to public
using (((user_id = auth.uid()) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = workout_sessions.user_id) AND (profiles.is_public = true))))));



  create policy "Users can only insert sets for themselves."
  on "public"."workout_sets"
  as permissive
  for insert
  to public
with check ((EXISTS ( SELECT 1
   FROM public.workout_sessions
  WHERE ((workout_sessions.id = workout_sets.workout_id) AND (workout_sessions.user_id = auth.uid())))));



  create policy "Users can see their own workout sets and sets of public profile"
  on "public"."workout_sets"
  as permissive
  for select
  to public
using (((EXISTS ( SELECT 1
   FROM public.workout_sessions
  WHERE ((workout_sessions.id = workout_sets.workout_id) AND (workout_sessions.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM (public.workout_sessions
     JOIN public.profiles ON ((profiles.id = workout_sessions.user_id)))
  WHERE ((workout_sessions.id = workout_sets.workout_id) AND (profiles.is_public = true))))));



