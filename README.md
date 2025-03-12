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
