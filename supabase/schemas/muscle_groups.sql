create table public.muscle_groups (
    id serial not null,
    muscle_name text,
    category text,

    primary key (id)
);

alter table public.muscle_groups enable row level security;