-- =============================================
-- Lists & Reviews: Tables + Seed Data
-- Run this in Supabase SQL Editor
-- =============================================

-- 1. BOOKS TABLE
create table if not exists public.books (
  id bigint generated always as identity primary key,
  title text not null,
  slug text not null unique,
  author text not null,
  series text,
  status text not null default 'want_to_read' check (status in ('want_to_read', 'reading', 'completed')),
  rating smallint check (rating >= 1 and rating <= 10),
  tags text[] default '{}',
  started_at timestamptz,
  finished_at timestamptz,
  excerpt text,
  review text,
  image text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.books enable row level security;
create policy "Allow public read access on books" on public.books for select using (true);

-- 2. ANIME TABLE
create table if not exists public.anime (
  id bigint generated always as identity primary key,
  title text not null,
  slug text not null unique,
  seasons smallint,
  episodes smallint,
  year smallint,
  status text not null default 'plan_to_watch' check (status in ('watching', 'completed', 'on_hold', 'dropped', 'plan_to_watch')),
  rating smallint check (rating >= 1 and rating <= 10),
  tags text[] default '{}',
  started_at timestamptz,
  finished_at timestamptz,
  excerpt text,
  review text,
  image text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.anime enable row level security;
create policy "Allow public read access on anime" on public.anime for select using (true);

-- 3. GAMING ACHIEVEMENTS TABLE
create table if not exists public.gaming_achievements (
  id bigint generated always as identity primary key,
  title text not null,
  slug text not null unique,
  game text not null,
  achievement_type text not null,
  value text not null,
  season text,
  rating smallint check (rating >= 1 and rating <= 10),
  tags text[] default '{}',
  notes text,
  image text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.gaming_achievements enable row level security;
create policy "Allow public read access on gaming_achievements" on public.gaming_achievements for select using (true);

-- =============================================
-- SEED DATA
-- =============================================

-- BOOKS (3 entries)
insert into public.books (title, slug, author, series, status, rating, tags, started_at, finished_at, excerpt, review)
values
(
  'Project Hail Mary',
  'project-hail-mary',
  'Andy Weir',
  null,
  'completed',
  9,
  '{"sci-fi", "space", "survival"}',
  '2025-11-01T00:00:00+00',
  '2025-12-15T00:00:00+00',
  'A lone astronaut must save the earth from disaster in this gripping sci-fi thriller.',
  '## A Masterpiece of Sci-Fi

*Project Hail Mary* grabbed me from the first chapter and didn''t let go.

Andy Weir does what he does best — takes hard science, wraps it in humour, and makes you care deeply about the characters. Ryland Grace is an accidental hero, stumbling through impossible problems with genuine curiosity and stubborn optimism.

The relationship that develops mid-book (no spoilers) is one of the most heartwarming things I''ve ever read. It''s funny, tense, and deeply human — even when the characters aren''t.

If you liked *The Martian*, this is better.

**Verdict:** A near-perfect sci-fi novel. Read it.'
),
(
  'The Pragmatic Programmer',
  'the-pragmatic-programmer',
  'David Thomas & Andrew Hunt',
  null,
  'reading',
  null,
  '{"programming", "non-fiction", "career"}',
  '2026-01-20T00:00:00+00',
  null,
  'A classic guide to software craftsmanship that every developer should read.',
  null
),
(
  'Fullmetal Alchemist: The Complete Four-Panel Comics',
  'fullmetal-alchemist-four-panel',
  'Hiromu Arakawa',
  'Fullmetal Alchemist',
  'want_to_read',
  null,
  '{"manga", "comedy", "anime-tie-in"}',
  null,
  null,
  'The lighter side of Fullmetal Alchemist — four-panel gag comics by the original creator.',
  null
);

-- ANIME (3 entries)
insert into public.anime (title, slug, seasons, episodes, year, status, rating, tags, started_at, finished_at, excerpt, review)
values
(
  'Fullmetal Alchemist: Brotherhood',
  'fullmetal-alchemist-brotherhood',
  1,
  64,
  2009,
  'completed',
  10,
  '{"action", "adventure", "fantasy", "drama"}',
  '2024-06-01T00:00:00+00',
  '2024-07-20T00:00:00+00',
  'Two brothers search for the Philosopher''s Stone to restore their bodies after a failed alchemical experiment.',
  '## The Best Anime Ever Made

I''ll say it: *Fullmetal Alchemist: Brotherhood* is the greatest anime of all time.

The story of Edward and Alphonse Elric is equal parts action, philosophy, politics, and heart. The world-building is immaculate. Every character — even the villains — has depth and motivation.

The themes of equivalent exchange, sacrifice, and what it means to be human run through every episode. It never wastes a moment.

> "Humankind cannot gain anything without first giving something in return."

Brotherhood is the anime I recommend to everyone, whether they''ve watched anime before or not. It''s that good.

**Verdict:** 10/10. A flawless series.'
),
(
  'Vinland Saga',
  'vinland-saga',
  2,
  48,
  2019,
  'watching',
  null,
  '{"action", "historical", "drama", "vikings"}',
  '2026-01-10T00:00:00+00',
  null,
  'A young Viking warrior seeks vengeance, then purpose, in this epic historical saga.',
  null
),
(
  'Spy x Family',
  'spy-x-family',
  2,
  37,
  2022,
  'plan_to_watch',
  null,
  '{"comedy", "action", "family"}',
  null,
  null,
  'A spy, an assassin, and a telepath form an unlikely family — and none of them know each other''s secrets.',
  null
);

-- GAMING ACHIEVEMENTS (3 entries)
insert into public.gaming_achievements (title, slug, game, achievement_type, value, season, tags, notes)
values
(
  'Peak TFT Rating',
  'tft-peak-rating',
  'Teamfight Tactics',
  'Peak Rating',
  'Diamond IV',
  'Set 10 - Remix Rumble',
  '{"TFT", "ranked", "strategy"}',
  'Hit Diamond for the first time running Pentakill reroll. The dopamine was unreal.'
),
(
  'TFT Season 11 Climb',
  'tft-season-11',
  'Teamfight Tactics',
  'Season Rank',
  'Platinum II',
  'Set 11 - Inkborn Fables',
  '{"TFT", "ranked", "strategy"}',
  'Consistent Platinum finishes. Focused on flex play and econ-heavy strategies.'
),
(
  'League of Legends Peak',
  'lol-peak-rank',
  'League of Legends',
  'Peak Rank',
  'Gold I',
  'Season 2023',
  '{"LoL", "ranked", "MOBA"}',
  'Support main. Peaked Gold I playing Thresh and Nautilus. One game off Platinum promos.'
);
