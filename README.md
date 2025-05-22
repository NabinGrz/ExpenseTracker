# Expense Tracker

## Flutter Project

This is a Simple 2 Page Expense Tracker app developed(For Personal Use Only) using Bloc Pattern & Firebase(FIRESTORE DATABASE) for practicing.
Also has a fully working code for Login & Signup but not used in Application.
## Dependencies:
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [rxdart](https://pub.dev/packages/rxdart)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [cupertino_icons](https://pub.dev/packages/cupertino_icons)
- [fluttertoast](https://pub.dev/packages/fluttertoast)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [flutter_typeahead](https://pub.dev/packages/flutter_typeahead)
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
- [table_calendar](https://pub.dev/packages/table_calendar)
- [persistent_bottom_nav_bar](https://pub.dev/packages/persistent_bottom_nav_bar)
- [get_it](https://pub.dev/packages/get_it)
- [syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts)
- [fl_chart](https://pub.dev/packages/fl_chart)
- [image_picker](https://pub.dev/packages/image_picker)
- [device_preview](https://pub.dev/packages/device_preview)
- [pie_chart](https://pub.dev/packages/pie_chart)
- [mockito](https://pub.dev/packages/mockito)

## How to Use

### Prerequisites
- Ensure you have Flutter installed on your system. You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/expensetracker.git
   ```
2. Navigate to the project directory:
   ```bash
   cd expensetracker
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Firebase Configuration
This project uses Firebase for backend services. You will need to set up your own Firebase project to run the application.

1. Create a new project on the [Firebase console](https://console.firebase.google.com/).
2. Add your Firebase configuration files to this project:
   - For **Android**: Place your `google-services.json` file in the `android/app/` directory.
   - For **iOS**: Place your `GoogleService-Info.plist` file in the `ios/Runner/` directory.
3. For more detailed instructions on adding Firebase to a Flutter project, refer to the [official Firebase documentation](https://firebase.google.com/docs/flutter/setup).

### Running the Application
Once the setup and Firebase configuration are complete, you can run the application using the following command:
```bash
flutter run
```
This command will build and run the application on a connected device or an emulator.
