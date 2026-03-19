create table public.workout_sessions (
    id serial not null,
    user_id uuid not null references auth.users on delete cascade,
    session_date date,
    notes text,

    primary key (id)
);

alter table public.workout_sessions enable row level security;

create policy "Users can see their own workout sessions and sessions of public profiles."
on workout_sessions for select
using ( 
    user_id = auth.uid()
    OR exists (
        select 1 from profiles
        where profiles.id = workout_sessions.user_id
        and profiles.is_public = true
    )
);

create policy "Users can only insert sessions for themselves."
on workout_sessions for insert 
with check ( user_id = (select auth.uid()) );