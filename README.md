# Style Hub

Style Hub - go'zallik va sog'lomlashtirish xizmatlarini taqdim etuvchi zamonaviy mobil ilova. Bu ilova orqali foydalanuvchilar soch kesish, pardoz, manikür va massaj kabi xizmatlarni topish va band qilish imkoniyatiga ega bo'ladilar.

## Xususiyatlar

- **Zamonaviy UI/UX dizayn**: Material Design 3 asosida ishlab chiqilgan
- **Mavzular qo'llab-quvvatlash**: Yorug' va qorong'i rejimlar
- **Xizmatlar katalogi**: Turli go'zallik va sog'lomlashtirish xizmatlari
- **Salon qidirish**: Eng yaqin va mashhur salonlarni topish
- **Banner reklamalar**: Maxsus takliflar va aksiyalar
- **Profil boshqaruvi**: Foydalanuvchi profili va sozlamalar

## Texnologiyalar

- Flutter
- GetX (Holatni boshqarish va navigatsiya)
- Cached Network Image (Rasmlarni keshlashtirish)
- Flutter Carousel Slider (Banner karuseli)
- Flutter SVG (SVG rasmlarni ko'rsatish)
- Iconsax Plus (Zamonaviy ikonalar to'plami)

## O'rnatish

1. Flutter SDK o'rnatilganligiga ishonch hosil qiling
2. Loyihani klonlang:
   ```
   git clone https://github.com/username/style_hub.git
   ```
3. Kerakli paketlarni o'rnating:
   ```
   flutter pub get
   ```
4. Ilovani ishga tushiring:
   ```
   flutter run
   ```

## Loyiha tuzilishi

```
lib/
  ├── data/                  # Ma'lumotlar qatlami
  ├── domain/                # Biznes mantiq qatlami
  ├── presentation/          # Taqdimot qatlami
  │   ├── controllers/       # GetX kontrollerlar
  │   ├── pages/             # Ilova sahifalari
  │   ├── routes/            # Navigatsiya yo'llari
  │   └── widgets/           # Qayta ishlatiluvchi vidjetlar
  ├── core/                  # Asosiy utilita va konstantalar
  └── main.dart              # Ilova kirish nuqtasi
```

## Hissa qo'shish

Loyihaga hissa qo'shish uchun Pull Request yuborishingiz mumkin. Katta o'zgarishlar kiritishdan oldin, iltimos, muhokama uchun Issue yarating.

## Litsenziya

Bu loyiha MIT litsenziyasi ostida tarqatiladi. Batafsil ma'lumot uchun LICENSE faylini ko'ring.
