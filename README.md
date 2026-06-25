# FIFA World Cup 2026 + Liga Dunia Tracker — GitHub Pages

## Cara deploy
1. Buat repo baru di GitHub (atau pakai yang sudah ada)
2. Upload semua file ini ke root repo (drag & drop di tab "Add file" → "Upload files")
3. Settings → Pages → Source: "Deploy from a branch" → Branch: `main` → Folder: `/ (root)` → Save
4. Tunggu 1-2 menit, situs aktif di: `https://[username].github.io/[nama-repo]/`

## File yang harus diupload
- `index.html` — app utama (mode Piala Dunia + mode Liga Dunia)
- `config.js` — kredensial Supabase + token API-Football
- `manifest.json` — konfigurasi PWA
- `sw.js` — service worker (offline support)
- `icon.svg` — ikon app

## ⚠️ WAJIB sebelum fitur Liga Dunia bisa dipakai bersama (shared cache)
Buka **Supabase Dashboard → SQL Editor**, jalankan isi file `supabase_liga_cache_setup.sql`
(file ini tidak perlu diupload ke GitHub — cuma dijalankan sekali di Supabase).
Tabel `api_cache` ini membuat semua pengguna app berbagi 1 hasil fetch API-Football
yang sama selama 15 menit, jadi kuota gratis 100 request/hari tidak cepat habis
meski app dipakai banyak orang sekaligus.

Tanpa tabel ini, fitur Liga Dunia masih tetap berfungsi (fallback ke cache
per-device di localStorage), hanya saja kuota API-Football akan lebih cepat terpakai
kalau banyak orang membuka app bersamaan.

## Catatan penting
- Semua path sudah relative (`./`) — otomatis bekerja baik di root domain maupun di subfolder repo
- Setelah deploy, gunakan URL `https://[username].github.io/[nama-repo]/` sebagai Source URL baru di Web2App Pro
- File `analytics.html` dan `supabase_setup.sql` adalah referensi, tidak perlu diupload kecuali ingin akses dashboard analytics terpisah

