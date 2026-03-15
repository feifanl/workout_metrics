create table public.workout_sessions (
    id serial not null,
    user_id uuid not null references auth.users on delete cascade,
    session_date date,
    notes text,

    primary key (id)
);

alter table public.workout_sessions enable row level security;