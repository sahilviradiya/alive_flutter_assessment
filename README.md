# Alive Flutter Assessment

A Flutter application developed for the technical assessment by LVS Innovation Pvt. Ltd.

## Features
- **Splash Screen**: Animated app logo with automatic navigation.
- **Login Screen**: Firebase Google Authentication implementation.
- **Home Screen**: Responsive UI matching the provided design, featuring live stream grids and region filters.
- **Clean Architecture**: Decoupled layers (Core, Data, Domain, Presentation).
- **MVVM Pattern**: State management using Provider and ViewModels.
- **REST API Ready**: Structured network layer using Dio.

## Project Structure
- `lib/core`: Constants, theme, routing, and shared widgets.
- `lib/data`: Data models, repositories implementations, and data sources.
- `lib/domain`: Business logic entities, repository abstractions, and use cases.
- `lib/presentation`: UI screens, widgets, and ViewModels.

## Setup
1. Clone the repository.
2. Run `flutter pub get`.
3. Ensure Firebase is configured for your environment (google-services.json / GoogleService-Info.plist).
4. Run `flutter run`.
