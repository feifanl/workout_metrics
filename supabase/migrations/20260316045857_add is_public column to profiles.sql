alter table "public"."profiles" add column "is_public" boolean;


  create policy "All users can view exercises."
  on "public"."exercises"
  as permissive
  for select
  to public
using (true);



  create policy "All users can view muscle groups."
  on "public"."muscle_groups"
  as permissive
  for select
  to public
using (true);



  create policy "Users can see their own profiles."
  on "public"."profiles"
  as permissive
  for select
  to public
using ((auth.uid() = id));



