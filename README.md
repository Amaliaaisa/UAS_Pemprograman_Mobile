# DailyGlow  
**Aplikasi Catatan Kegiatan Harian Wanita**

## 📌 Deskripsi Aplikasi
DailyGlow adalah aplikasi mobile berbasis Flutter yang dirancang khusus untuk membantu perempuan dalam mencatat kegiatan harian, rutinitas perawatan diri, kesehatan, serta siklus menstruasi. Aplikasi ini juga menyediakan fitur catatan pribadi dan kutipan inspiratif harian untuk meningkatkan motivasi pengguna.

Aplikasi ini dibuat sebagai **tugas Ujian Akhir Semester (UAS) mata kuliah Pemrograman Mobile**.

---

## 🎯 Tujuan Aplikasi
- Membantu pengguna mengelola kegiatan harian secara terstruktur
- Menyediakan pencatatan catatan pribadi dan rutinitas kesehatan
- Mencatat dan memantau siklus menstruasi
- Memberikan pengalaman UI yang nyaman dan ramah pengguna
- Menerapkan konsep CRUD, Provider, API, dan penyimpanan lokal

---

## ✨ Fitur Utama
1. **Onboarding**
   - Tampilan awal pengenalan aplikasi

2. **Dashboard Utama**
   - Navigasi ke seluruh fitur aplikasi

3. **Catatan (Notes)**
   - Tambah, edit, hapus catatan (CRUD)
   - Kategori catatan
   - Tandai catatan favorit

4. **Kegiatan Mingguan**
   - Manajemen aktivitas harian dan mingguan
   - Tandai aktivitas selesai atau belum

5. **Pelacak Menstruasi**
   - Mencatat tanggal, gejala, dan tingkat aliran
   - Prediksi siklus berikutnya

6. **Pengaturan**
   - Mengubah format tanggal
   - Mengatur hari awal minggu
   - Mode terang & gelap

7. **Kutipan Harian**
   - Mengambil data dari API publik

---

## 📂 Struktur Folder Proyek
lib/
├── models/
│ ├── activity_model.dart
│ ├── menstruation_model.dart
│ └── note_model.dart
│
├── providers/
│ ├── activity_provider.dart
│ ├── menstruation_provider.dart
│ ├── note_provider.dart
│ └── settings_provider.dart
│
├── services/
│ ├── api_service.dart
│ ├── calendar_service.dart
│ └── local_storage_service.dart
│
├── views/
│ └── onboarding/
│ ├── home/
│ ├── notes/
│ ├── menstruation/
│ ├── weekly/
│ └── settings/
│
├── widgets/
│ ├── colors.dart
│ └── dashboard_card.dart
│
├── main.dart
└── firebase_options.dart

Link apk: https://github.com/Amaliaaisa/UAS_Pemprograman_Mobile/releases/download/v1.0.0/app-release.apk
