create table public.exercises (
    id serial not null,
    exercise_name text,
    primary_muscle_id int references muscle_groups(id),
    secondary_muscle_id int references muscle_groups(id),
    tertiary_muscle_id int references muscle_groups(id),
    quaternary_muscle_id int references muscle_groups(id),
    is_compound boolean,
    is_cardio boolean,
    
    primary key (id)
);

alter table public.exercises enable row level security;