# TV Assassin

A minimalist Android application that broadcasts IR shutdown commands to multiple television brands with single-button interaction.

## Features

- Instantly power off nearby TVs with one button press
- Supports 15+ TV brands including Samsung, LG, Sony, Panasonic, and more
- Dark/light theme support with system integration
- Minimalist, accessible interface
- No internet required - works entirely offline
- F-Droid compliant open source application

## Technical Details

- Built with Flutter using MVVM architecture
- Uses Android's ConsumerIrManager API for hardware IR transmission
- Implements Provider for state management
- Supports Android 8.0 (API 26) and above
- Fully tested with unit and widget tests

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Testing

Run all tests with:
```
flutter test
```

Run code analysis with:
```
flutter analyze
```

Format code with:
```
dart format .
```