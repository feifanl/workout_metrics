create table public.workout_sets (
    id serial not null, 
    workout_id int references workout_sessions on delete cascade,
    exercise_id int references exercises,
    set_number int,
    reps int not null default 0,
    set_weight float not null default 0,
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

create policy "Users can see their own workout sets and sets of public profiles."
on workout_sets for select
using ( 
    exists (
        select 1 from workout_sessions
        where workout_sessions.id = workout_sets.workout_id
        and workout_sessions.user_id = auth.uid()
    )
    OR exists (
        select 1 from workout_sessions
        join profiles on profiles.id = workout_sessions.user_id
        where workout_sessions.id = workout_sets.workout_id
        and profiles.is_public = true
    )
);

create policy "Users can only insert sets for themselves."
on workout_sets for insert 
with check ( 
    exists (
        select 1 from workout_sessions
        where workout_sessions.id = workout_sets.workout_id
        and workout_sessions.user_id = auth.uid()
    )
);