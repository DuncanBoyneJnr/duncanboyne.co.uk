-- =============================================
-- Girlfriend Applications table
-- Run this in Supabase SQL Editor
-- =============================================

create table if not exists public.girlfriend_applications (
  id bigint generated always as identity primary key,
  name text,
  nickname text,
  favourite_snack text,
  sass_line text,
  assets text[] not null default '{}',
  relationship_mode text,
  dog_compatibility_plan text,
  dogs_board_members text not null check (dogs_board_members in ('yes', 'no')),
  dog_favourite_plan text,
  chicken_authority smallint not null check (chicken_authority between 1 and 10),
  named_chicken_legal text check (named_chicken_legal in ('yes', 'no')),
  building_type text,
  traits text[] not null default '{}',
  roast_when_needed boolean not null default false,
  protect_when_needed boolean not null default false,
  eye_roll_sometimes boolean not null default false,
  love_wiser boolean not null default false,
  believe_again text not null,
  five_year_vision text not null,
  final_answer text not null,
  created_at timestamptz not null default now()
);

alter table public.girlfriend_applications enable row level security;

drop policy if exists "Allow public insert on girlfriend_applications" on public.girlfriend_applications;
create policy "Allow public insert on girlfriend_applications"
on public.girlfriend_applications
for insert
with check (true);

