-- ════════════════════════════════════════════════════════════════════════
-- Shared API cache table — dipakai bersama oleh fitur Liga Dunia & Stats WC
-- Tujuan: 1 fetch ke API-Football dipakai bersama SEMUA pengguna app,
-- bukan tiap device fetch sendiri-sendiri. Ini yang menghemat kuota
-- gratis 100 request/hari API-Football.
--
-- Cara pakai: copy semua isi file ini, buka Supabase Dashboard →
-- SQL Editor → New query → paste → Run.
-- ════════════════════════════════════════════════════════════════════════

create table if not exists api_cache (
  cache_key  text primary key,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

-- Aktifkan Row Level Security
alter table api_cache enable row level security;

-- App ini pakai anon key publik (sama seperti table match_updates),
-- jadi policy dibuat public read & write. Tidak ada data sensitif di sini —
-- isinya cuma cache hasil pertandingan/klasemen/top skor yang memang publik.
drop policy if exists "Public read api_cache" on api_cache;
create policy "Public read api_cache" on api_cache
  for select using (true);

drop policy if exists "Public write api_cache" on api_cache;
create policy "Public write api_cache" on api_cache
  for insert with check (true);

drop policy if exists "Public update api_cache" on api_cache;
create policy "Public update api_cache" on api_cache
  for update using (true);

-- (Opsional) Index untuk query cepat berdasarkan umur cache
create index if not exists idx_api_cache_updated_at on api_cache(updated_at);
