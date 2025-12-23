# ShriJi Garden - Flutter App

A beautiful Flutter application for ShriJi Garden wedding venue booking.

## Features

- 🏠 **Home Page**: Hero section with video background, features, gallery preview, and testimonials
- 📦 **Packages**: Browse wedding packages with detailed features and pricing
- ✏️ **Customize**: Create your own custom wedding plan with preferences
- 🖼️ **Gallery**: View beautiful venue images with full-screen photo viewer
- ℹ️ **About**: Learn about ShriJi Garden's story and values
- 📞 **Contact**: Get in touch with contact form and social links
- 👤 **Admin Panel**: View and manage booking requests

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. Navigate to the project directory:
   ```bash
   cd shriji_garden_flutter
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── app/
│   ├── app.dart              # Main app widget
│   └── router.dart           # GoRouter configuration
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── models/
│   │   ├── booking_request_model.dart
│   │   └── package_model.dart
│   └── theme/
│       ├── app_colors.dart
│       └── app_theme.dart
├── features/
│   ├── about/
│   ├── admin/
│   ├── contact/
│   ├── customize/
│   ├── gallery/
│   ├── home/
│   └── packages/
├── shared/
│   └── widgets/
│       └── app_scaffold.dart
└── main.dart
```

## Dependencies

- `go_router`: Declarative routing
- `cached_network_image`: Image caching
- `flutter_animate`: Beautiful animations
- `photo_view`: Image gallery viewer
- `google_fonts`: Typography
- `url_launcher`: External links
- `intl`: Date/number formatting

## Screenshots

The app includes:
- Modern UI with smooth animations
- Bottom navigation with animated states
- Image lightbox with zoom support
- Form validation with success/error states
- Responsive layouts for all screen sizes

## Author

Converted from React/Vite to Flutter by Antigravity AI
