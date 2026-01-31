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
# Flutter Environment Setup and First App Run

### Steps Followed:
1. **SDK Installation**: Installed Flutter SDK on `F:\flutter` and added the `bin` folder to the System PATH.
2. **Environment Configuration**: Set `ANDROID_HOME` to `F:\Android\Sdk` and fixed the VS Code Dart SDK path.
3. **Emulator Setup**: Created a Pixel 7 Virtual Device using Android Studio's AVD Manager.
4. **Firebase Integration**: Successfully linked the project using `flutterfire configure`.

### Setup Verification:
* **Flutter Doctor Output**:![alt text](image.png)
* **Running App**: ![alt text](image-1.png)

### Reflection:
The main challenge was managing storage constraints on the C: drive and redirecting all SDK components to the F: drive. This setup is crucial because it ensures that the app has a stable environment to communicate with Firebase for real-time data persistence.

## Folder Structure Exploration
I have documented the full architecture of the ArtisanFlow project. 
- See the full breakdown here: [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)
- **Key Insight**: Understanding the `android/app/build.gradle` was vital for our Firebase MultiDex setup earlier in the sprint.


# Widget tree Hierarcy 
The Widget Tree Hierarchy:

MaterialApp (Root)

Scaffold (Layout Structure)

AppBar (Top Navigation)

Center (Alignment)

Column (Vertical Layout)

Text (Displays count)

SizedBox (Spacing)

Container (Reactive color box)

ElevatedButton (The trigger)


## stateless and stateful widget:

Stateless Widget: These are "immutable." Their properties cannot change once they are drawn. They are lightweight and great for performance when the UI is static.

Stateful Widget: These have a companion State object. When setState() is called, Flutter "re-builds" this specific part of the tree to show new data.

Performance Tip: We separate them so that when the favorite icon (Stateful) changes color, the Header (Stateless) doesn't have to waste energy rebuilding itself.

## HOT RELOAD 
  (Which auto updates the app redering without running it everytime)
Hot Reload Reflection: This feature improves productivity by allowing for sub-second iterations, meaning I can "paint" the UI in real-time without waiting minutes for a full recompile.

## DevTools: 
   (Used to view the widget tree essesntial to diagnose layout issues)
DevTools Reflection: The Widget Inspector is essential for diagnosing layout issues (like "overflow" errors), while the Performance tab helps identify frames that are "janking" or slowing down the user experience.

## Navigator stack
Navigator Stack: The Navigator works like a stack of cards; pushNamed adds a card to the top, and pop removes it to reveal the one underneath.

Named Routes Benefits: Using named routes (like '/detail') makes the code more readable and centralizes navigation logic in main.dart, which is essential for scaling large apps.


## Scrollable views
Efficiency: Using .builder() is critical for the "ArtisanFlow" catalog because it only creates the widgets that are currently visible on the screen, saving memory.

Performance Pitfalls: Avoid nesting scrollable views (like a ListView inside another ListView) without using shrinkWrap or defined heights, as this can lead to layout crashes.