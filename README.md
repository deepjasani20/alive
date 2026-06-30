# Alive — Flutter Developer Technical Assessment

A Flutter demo for **LVS Innovation Pvt. Ltd.** implementing the required flow:

**Splash (animated) → Login (Google / Firebase Auth) → Home (live-stream UI)**

Built with **GetX** state management on a **clean MVVM** architecture, a
REST-API-ready data layer, reusable widgets, and smooth animations throughout.
The Login and Home screens are reproduced pixel-for-pixel from the supplied
reference design.

---

## ✨ Features

| Screen | Highlights |
| --- | --- |
| **Splash** | Brand logo pops in (elastic scale + fade), a soft ring pulses behind it, the tagline slides up, then auto-navigates. |
| **Login** | Pixel-matched UI: brand mark, form fields, gradient *Login* button, clipped green wave, *Continue with Google* (functional) & *Continue with Facebook* (UI parity). Staggered entrance animation. |
| **Home** | Brand header with notification badge + gift button, Stream/Hot/Follow tabs, scrollable region chips, animated 2-column live-stream grid (cards cascade in), and a custom green bottom nav with an elevated *Go Live* button. Pull-to-refresh enabled. |

---

## 🏗 Architecture — Clean MVVM + GetX

```
lib/
├── main.dart                       # Entry point — best-effort Firebase init
├── app/
│   └── alive_app.dart              # GetMaterialApp (routing + DI root)
│
├── core/                           # Cross-cutting concerns (no UI, no logic)
│   ├── constants/                  # colors · strings · text styles
│   ├── theme/                      # global ThemeData
│   ├── routes/                     # named routes + GetX page registry
│   └── utils/                      # responsive helpers
│
├── data/                           # ── Model layer (API-ready) ──
│   ├── models/                     # UserModel · StreamModel · CountryModel
│   ├── services/                   # AuthService (Firebase + Google Sign-In)
│   └── repositories/               # AuthRepository · StreamRepository
│
├── modules/                        # ── Feature modules (one per screen) ──
│   ├── splash/  { view · viewmodel · binding }
│   ├── login/   { view · viewmodel · binding }
│   └── home/    { view · viewmodel · binding }
│
└── widgets/                        # ── Reusable UI components ──
    ├── alive_logo.dart             # code-drawn brand mark (no asset needed)
    ├── google_g_logo.dart          # code-drawn Google "G" (CustomPainter)
    ├── primary_button.dart
    ├── social_button.dart
    ├── app_text_field.dart
    ├── wave_clipper.dart
    ├── stream_card.dart
    └── app_bottom_nav.dart
```

**How MVVM maps to the code**

- **View** (`*_view.dart`) — pure widgets. No business logic; binds to the
  ViewModel's reactive state with `Obx`.
- **ViewModel** (`*_viewmodel.dart`, a `GetxController`) — holds state and
  presentation logic, talks only to repositories.
- **Model / Data layer** — `repositories` expose use-cases; `services` wrap the
  concrete backend (Firebase). The UI never imports Firebase directly, so the
  backend can be swapped for a REST client without touching views or
  view-models.
- **Binding** (`*_binding.dart`) — lazily injects each ViewModel when its route
  opens, so dependencies are created on demand and disposed automatically.

The repositories already return `Future`s shaped like REST responses
(`fromJson` / `toJson` on every model), so wiring a real HTTP client later is a
drop-in change — this is the **"REST API ready structure"** the brief asks for.

---

## 🚀 Getting Started

```bash
flutter pub get
flutter run
```

The app boots straight away. **Without** a Firebase project attached it runs in
a documented **demo fallback** (see below) so the full navigation flow is
demonstrable immediately.

---

## 🔐 Firebase Google Authentication setup

The real Google → Firebase credential exchange is fully implemented in
[`data/services/auth_service.dart`](lib/data/services/auth_service.dart). To run
it against a live Firebase project:

1. Create a project in the [Firebase Console](https://console.firebase.google.com/)
   and enable **Authentication → Sign-in method → Google**.
2. Register your Android & iOS apps and download the config files:
   - Android → `android/app/google-services.json`
   - iOS → `ios/Runner/GoogleService-Info.plist`
3. (Recommended) run `flutterfire configure` to generate `firebase_options.dart`,
   then pass those options to `Firebase.initializeApp()` in `main.dart`.
4. Android: add the **SHA-1 / SHA-256** signing fingerprints in the Firebase
   console. iOS: add the reversed-client-ID URL scheme to `Info.plist`.
5. In `AuthService`, set `enableDemoFallback: false` to require real auth.

### Demo fallback
`AuthService.enableDemoFallback` defaults to `true`. When Firebase isn't
configured (or a transient error occurs), *Continue with Google* resolves to a
mock user so Splash → Login → Home can be recorded without backend setup.
User-initiated cancellation of the Google picker is always treated as a no-op.

---

## 🧪 Quality

```bash
flutter analyze   # 0 issues
flutter test      # widget smoke test passes
```

---

## 📦 Tech stack

- **Flutter** (stable) · **Dart 3**
- **GetX** — state management, routing, DI
- **firebase_core**, **firebase_auth**, **google_sign_in** — authentication
- **google_fonts** (Poppins) — typography matching the design
- **cached_network_image** — efficient stream thumbnails

> Live-streaming itself is intentionally out of scope per the brief — only the
> UI and navigation flow are implemented.
