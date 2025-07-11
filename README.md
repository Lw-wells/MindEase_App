# MindEase_App


# 📘 MindEase – Setup & Documentation

MindEase is a mental wellness Flutter application that combines AI-assisted conversation, real counselor access, and helpful tools to promote emotional well-being.

This guide explains how to **set up**, **run**, and **understand** the structure of the project.

---

## 🚀 Getting Started

### 1. Prerequisites

Ensure you have the following installed:
- Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- Dart SDK (usually comes with Flutter)
- Android Studio or VS Code
- Git

### 2. Clone the Repository

```bash
git clone https://github.com/lw-wells/mindease.git
cd mindease
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

To run the app on an emulator or connected device:

```bash
flutter run
```

> 📝 Tip: If prompted to select a device, choose the one available or configure an Android/iOS simulator.

---

## 📁 Project Structure

```plaintext
lib/
├── main.dart                  # Entry point of the app
├── screens/                  # All screen UIs like Home, Chat, Counselor, etc.
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── home_screen.dart
│   ├── chat_screen.dart
│   ├── counselor_screen.dart
│   ├── profile_screen.dart
│   ├── settings_screen.dart
│   ├── resources_screen.dart
│   ├── emergency_screen.dart
│   └── mood_journal_screen.dart
├── theme/
│   └── theme_provider.dart   # Dark mode state management
└── models/                   # (If applicable) Data models for future use
```

---

## 🛠 Features Implemented

- **AI Chat Companion** ("Maya") with simulated responses.
- **Dark Mode Support**: Toggle via `SettingsScreen`, managed with `ThemeProvider`.
- **Profile Customization**: Set name and anonymity.
- **Counselor Access**: Route to live support page.
- **Mood Journal & Resources**: Placeholders for journaling and self-help content.
- **Emergency Help**: Quick access for urgent mental health situations.

---

## 🎨 Theme & State Management

The app uses a simple `ThemeProvider` based on `ChangeNotifier` to switch between `light` and `dark` modes globally:

```dart
ChangeNotifierProvider(
  create: (_) => ThemeProvider(),
  child: Consumer<ThemeProvider>(
    builder: (context, provider, _) {
      return MaterialApp(
        themeMode: provider.themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        ...
      );
    },
  ),
)
```

---

## 🔗 Navigation

Named routing is used for easy screen transitions:

```dart
routes: {
  '/home': (context) => HomeScreen(...),
  '/chat': (context) => ChatScreen(),
  '/settings': (context) => SettingsScreen(...),
  ...
}
```

---

## 🧪 Testing

To verify that everything works:
- Navigate through the onboarding to Home
- Toggle dark mode in Settings
- Chat with Maya
- Access profile/counselor/emergency sections

---

## ❓ FAQ

- **Why does dark mode not apply immediately?**  
  Ensure you are using the `themeMode` from the provider in `MaterialApp`.

- **How do I add Firebase or Supabase?**  
  Backend integrations are not yet configured but can be added easily with FlutterFire or Supabase Flutter packages.

---

## 📬 Contact

For bugs or questions, reach out at wells.lincholmn@students.jkuat.ac.ke or open an issue on the [GitHub repo](https://github.com/lw-wells/mindease).
