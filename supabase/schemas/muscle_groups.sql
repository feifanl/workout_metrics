create table public.muscle_groups (
    id serial not null,
    muscle_name text,
    category text,

    primary key (id)
);

alter table public.muscle_groups enable row level security;

create policy "All users can view muscle groups."
on muscle_groups for select
using ( true );