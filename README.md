### **Devlog: Firebase CLI Installation and Setup for Flutter**

**Date**: March 12, 2025  
**Objective**:  
To set up the Firebase CLI in my development environment for a Flutter project, ensuring that the Firebase tools are ready for use in future Firebase integrations and configurations.

---

### **Step 1: Installing Node.js with nvm-windows**

To begin, I needed **Node.js** for the Firebase CLI. Instead of manually downloading and installing Node.js, I decided to use **nvm-windows** (Node Version Manager for Windows) for easier management of Node.js versions.

#### **Download and Install nvm-windows**:  
I downloaded the latest release of **nvm-windows** from the official [GitHub repository](https://github.com/coreybutler/nvm-windows/releases). After following the installation instructions, I verified that **nvm** was installed correctly.

#### **Install Node.js**:  
Since the Firebase CLI requires Node.js v18.0.0 or later, I installed the correct version using **nvm**:
```bash
nvm install 18.0.0
```
Then, I verified that **Node.js** and **npm** were installed correctly:
```bash
node -v  # Should display Node.js v18 or later
npm -v   # Should display the installed npm version
```

---

### **Step 2: Installing the Firebase CLI**

With **Node.js** successfully installed, I proceeded to install the **Firebase CLI** globally using npm.

#### **Install Firebase CLI**:  
I ran the following command to install the Firebase CLI:
```bash
npm install -g firebase-tools
```
This enabled me to use the **firebase** command from any directory on my system.

#### **Dealing with Permission Issues**:  
In case the installation failed due to permission errors (which is common on some systems), I ran the command with elevated privileges:
```bash
sudo npm install -g firebase-tools  # On macOS/Linux
```
For **Windows** users encountering permission issues, I followed the [npm documentation](https://docs.npmjs.com/resolving-eacces-permissions-errors) to adjust the npm permissions.

---

### **Step 3: Logging In to Firebase CLI**

After the installation was successful, I needed to authenticate my Firebase account to access Firebase services.

1. **Log in to Firebase**:  
   I ran the following command to log in:
   ```bash
   firebase login
   ```
   This opened a browser window asking me to sign in with my Google account. After signing in successfully, the CLI confirmed that I was logged in.

---

### **Step 4: Testing Firebase CLI**

Now that the setup was complete, I ran the following command to test whether the Firebase CLI was installed correctly and was working:
```bash
firebase --version
```
The output displayed the installed version of **Firebase CLI**, confirming that everything was set up correctly.

---

### **Step 5: Installing and Running the FlutterFire CLI**

Once the workspace was ready, I moved to the next step: integrating Firebase with my Flutter app using the **FlutterFire CLI**.

#### **Activate FlutterFire CLI**:  
I activated the **FlutterFire CLI** by running:
```bash
dart pub global activate flutterfire_cli
```

#### **Configure Firebase for the Flutter App**:  
After activation, I navigated to the root directory of my Flutter project and ran:
```bash
flutterfire configure --project=tutorial-64f6e
```
This command automatically registered my app with Firebase and generated the necessary Firebase configuration file (`firebase_options.dart`) for my project.

---

### **Step 6: Initializing Firebase and Adding Plugins**

With the project now connected to Firebase, I moved on to initializing Firebase in my Flutter app.

#### **Initialize Firebase**:  
In the `main.dart` file, I imported the **firebase_core** package and the **firebase_options.dart** configuration file. I then initialized Firebase by adding the following code:
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
```
This ensures Firebase is properly initialized before the app starts.

#### **Add Firebase Plugins**:  
In the `pubspec.yaml` file, I added the required Firebase plugins for the features I intended to use:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: latest_version
  firebase_auth: latest_version
  cloud_firestore: latest_version
  firebase_messaging: latest_version
```
After updating the `pubspec.yaml` file, I ran:
```bash
flutter pub get
```
This installed the necessary dependencies.

---

### **Step 7: Running the App**

Everything was set up correctly, so I ran the app on my emulator to ensure everything was functioning as expected:
```bash
flutter run
```
I was happy to see that Firebase was successfully integrated, and my Flutter app was now connected to Firebase without any errors.

---

### **Key Takeaways**:

- The **FlutterFire CLI** makes it incredibly easy to configure Firebase with Flutter projects.
- The **firebase_options.dart** file generated by the CLI handles all platform-specific configurations for Firebase.
- Using **firebase_core** to initialize Firebase is essential to make Firebase work properly across multiple platforms (Android, iOS).

---

### **Challenges Encountered**:

- The only challenge I faced was ensuring the proper version of the **FlutterFire CLI** and Firebase plugins were used. Always check for the latest versions on **pub.dev** before installation.

---

### **Next Steps**:

Now that Firebase is successfully integrated, I plan to implement **Firebase Authentication** and **Firestore** in the app to allow user login and store data.

---
# Devlog: Authentication System in Flutter

## **Phase 1: Project Initialization**
### **Date:** 13 March , 2025
### **Tasks:**
- Set up a new Flutter project.
- Integrated Firebase into the Flutter project.
- Configured Firebase Authentication.
- Enabled Email/Password authentication in Firebase Console.
- Installed necessary dependencies:
  - `firebase_core`
  - `firebase_auth`

### **Challenges & Solutions:**
- **Issue:** Firebase connection was not initializing correctly.
  - **Solution:** Ensured `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) were correctly placed in the project.
  - Checked and implemented `Firebase.initializeApp();` before using authentication services.

---

## **Phase 2: Creating Authentication Service**
### **Date:** [Insert Date]
### **Tasks:**
- Created `firebase_authentication.dart` to handle Firebase authentication.
- Implemented methods for:
  - User registration (`signUp`)
  - User login (`signIn`)
  - User logout (`signOut`)
- Structured authentication responses to return success status and error messages.

### **Authentication Code:**
```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      debugPrint('SignUp Error: ${e.message}');
      return null;
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      debugPrint('SignIn Error: ${e.message}');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint('User signed out.');
  }
}
```

### **Challenges & Solutions:**
- **Issue:** Authentication errors were not being properly handled.
  - **Solution:** Implemented structured responses using a `Map<String, dynamic>` format to return both `success` and `message` fields.
- **Issue:** Firebase authentication was not working after app restart.
  - **Solution:** Implemented `FirebaseAuth.instance.currentUser` to check the logged-in state.

---

## **Phase 3: Designing Authentication UI**
### **Date:** [Insert Date]
### **Tasks:**
- Created `AuthScreen.dart` with:
  - Email & password input fields.
  - Login and Sign Up toggle.
  - Submit button.
- Implemented form validation using `TextFormField` validators.
- Added UI improvements:
  - Gradient background.
  - Rounded input fields.
  - Visibility toggle for password fields.

### **Challenges & Solutions:**
- **Issue:** UI was not updating after switching between Login and Sign Up.
  - **Solution:** Used `setState()` to manage UI state changes.
- **Issue:** Password fields were always hidden.
  - **Solution:** Added a visibility toggle button with `obscureText` and `IconButton`.

---

## **Phase 4: Implementing Authentication Logic**
### **Date:** [Insert Date]
### **Tasks:**
- Connected `AuthScreen.dart` to `firebase_authentication.dart`.
- Implemented `_submitForm()` to handle authentication based on login/signup state.
- Displayed authentication errors using `ScaffoldMessenger` and `SnackBar`.
- Navigated to `HomePage` upon successful login/signup.

### **Challenges & Solutions:**
- **Issue:** Navigation was happening even when authentication failed.
  - **Solution:** Checked authentication response before calling `Navigator.pushReplacement`.
- **Issue:** User credentials were not being cleared after authentication.
  - **Solution:** Called `emailController.clear();` and `passwordController.clear();` after successful authentication.

---

## **Phase 5: Testing and Debugging**
### **Date:** [Insert Date]
### **Tasks:**
- Conducted unit tests for `signIn` and `signUp` methods.
- Tested UI responsiveness and form validation.
- Debugged Firebase errors and ensured smooth authentication flow.
- Verified session persistence using `FirebaseAuth.instance.currentUser`.

### **Challenges & Solutions:**
- **Issue:** Invalid emails were being accepted.
  - **Solution:** Used regex validation for email format.
- **Issue:** Users were logged out after app restart.
  - **Solution:** Implemented session persistence by checking `FirebaseAuth.instance.currentUser` at app start.

---

## **Future Improvements**
- Implement Google and Facebook authentication.
- Implement password reset functionality.
- Improve error messages for better user experience.
- Add biometric authentication for quicker login.

---

## **Conclusion**
The authentication system is now fully functional with Firebase. The system ensures secure login/signup, proper error handling, and user-friendly UI. Further improvements will be made based on user feedback and additional security enhancements.

