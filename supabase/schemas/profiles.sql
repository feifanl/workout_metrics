create table public.profiles (
  id uuid not null references auth.users on delete cascade,
  username text UNIQUE,
  first_name text,
  last_name text,
  is_public boolean,
  -- will need to add more public functionalities later -- its not a simple binary of share all data / don't share, but rather choosing what to share
  -- add friend functionality later

  primary key (id)
);

alter table public.profiles enable row level security;

-- inserts a row into public.profiles
create function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, first_name, last_name)
  values (new.id, new.raw_user_meta_data ->> 'first_name', new.raw_user_meta_data ->> 'last_name');
  return new;
end;
$$;
-- trigger the function every time a user is created
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

create policy "Users can see their own profiles and any profiles set to public."
on profiles for select
using ( id = auth.uid() OR is_public = true );