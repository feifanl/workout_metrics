create table public.workout_sets (
    id serial not null, 
    workout_id int references workout_sessions on delete cascade,
    exercise_id int references exercises,
    set_number int,
    reps int not null default 0,
    set_weight int not null default 0,
    time_seconds int, --seconds
    distance float, --miles
    notes text,
    -- sets can be parts of circuits, supersets, dropsets, or be left/right in an exercise done one side at a time
    -- if multiple types are combined, circuit > superset > dropset > one-sided
    type_one text not null default 'normal',
    -- positions are important. if one set is a circuit set, we need to know which exercise was done first
    pos_group1 int,
    type_two text,
    pos_group2 int,
    type_three text,
    pos_group3 int,
    type_four text,
    pos_group4 int,

    primary key (id)
);

alter table public.workout_sets enable row level security;