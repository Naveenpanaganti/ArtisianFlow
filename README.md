# flutter_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# ArtisanFlow - Smart Enterprise for Local Artisans

## Project Overview
ArtisanFlow is a mobile-first solution designed to help local artisans in Tier-2/3 towns manage their inventory and showcase products in real-time.

## Folder Structure
- `lib/main.dart`: The entry point of the application.
- `lib/screens/`: Contains full-page UI components (e.g., WelcomeScreen).
- `lib/widgets/`: Reusable UI components to ensure a modular design.
- `lib/models/`: Reserved for data structures like Product and Order.
- `lib/services/`: Future home for Firebase Auth and Firestore logic.

## Setup Instructions
1. Install Flutter SDK.
2. Clone this repo: `git clone [YOUR_REPO_URL]`
3. Run `flutter pub get`.
4. Run the app: `flutter run`.

## Reflection
By using a modular folder structure, I can separate business logic from UI, making the app easier to scale. Learning about StatefulWidget was essential for handling the button interaction in this sprint.