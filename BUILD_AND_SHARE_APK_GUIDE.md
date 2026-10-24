# 🎮 Kinetic Surge — Android APK Build & Safe Sharing Guide

This project contains everything needed to package **Kinetic Surge: Neo-Arcade Touch Action** into a standalone Android APK (`.apk`) that can be shared with anyone and safely installed on any Android phone.

---

## ⚡ Method 1: Automated Cloud Build via GitHub Actions (Recommended)
> **Best for:** Fast, 1-click build with **zero tools or software to install on your computer**.

The repository includes a complete automated workflow in [`.github/workflows/build-apk.yml`](.github/workflows/build-apk.yml).

### Steps:
1. Create a new repository on [GitHub](https://github.com/new).
2. Upload this project folder to your repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit for Kinetic Surge Android"
   git remote add origin https://github.com/YOUR_USERNAME/kinetic-surge.git
   git push -u origin main
   ```
3. On GitHub, go to the **"Actions"** tab.
4. Select **"Build Kinetic Surge Mobile APK"** and click **"Run workflow"**.
5. Once completed (approx. 2 minutes), scroll down to **"Artifacts"** and download **`KineticSurge-Android-APK`** (or go to **Releases** to get `KineticSurge-v1.0.apk`).

---

## 🌐 Method 2: Instant 1-Click APK via Microsoft PWABuilder
> **Best for:** Instant generation without compiling code.

Since this game is already a compliant Progressive Web App (PWA) with offline support, touch controls, and high-res launcher icons:
1. Deploy the game to any free host (e.g. [Vercel](https://vercel.com), [Netlify](https://netlify.com), or [GitHub Pages](https://pages.github.com)).
2. Go to **[PWABuilder.com](https://www.pwabuilder.com)**.
3. Enter your deployed URL and click **"Start"**.
4. Click **"Package for Android"** > **"Generate APK"**.
5. Download your signed, ready-to-share `.apk` file!

---

## 💻 Method 3: Build locally with Android Studio
> **Best for:** Developers who want to test on Android emulators or local USB devices.

1. Open **Android Studio**.
2. Select **"Open"** and choose the `android` folder in this project:
   `C:\Users\Kajod-pc\.gemini\antigravity\scratch\project\android`
3. Before building, build the web assets (`npm run build`) and copy the `dist` folder into `android/app/src/main/assets/www`.
4. In Android Studio, go to **Build** > **Build Bundle(s) / APK(s)** > **Build APK(s)**.
5. The generated APK will be in `android/app/build/outputs/apk/debug/app-debug.apk`.

---

## 📲 How to Safely Share and Install the APK on Any Android Phone

### 1. Sending the APK:
You can share the `.apk` file directly via:
- **WhatsApp / Telegram**: Send as a document/file attachment.
- **Google Drive / Dropbox**: Upload the `.apk` and send a shareable download link.
- **Bluetooth / Nearby Share**: Send directly phone-to-phone.

### 2. Installing on the Recipient's Phone:
When someone taps the `.apk` file to install it, modern Android versions show a standard security prompt because it was sent directly rather than downloaded from the Google Play Store:

1. **"Install Unknown Apps" Prompt:**
   - Android will say: *"For your security, your phone currently isn't allowed to install unknown apps from this source."*
   - Tap **Settings**.
   - Toggle ON **"Allow from this source"** (e.g., allow Chrome, WhatsApp, or Files).
   - Tap the back arrow and tap **Install**.

2. **Google Play Protect Prompt:**
   - Google Play Protect may show: *"Unrecognized app"*.
   - Tap **"More details"** or **"Install anyway"**.

### 3. Why this APK is 100% Safe:
- **Zero Dangerous Permissions:** The app only requests `android.permission.VIBRATE` (for arcade collision haptics) and optional internet. It **cannot** access contacts, photos, microphone, camera, SMS, location, or private files.
- **100% Offline Gameplay:** All audio, graphics, physics, and gameplay logic run completely locally on the device without sending any personal data anywhere.
- **Full-Screen Immersive Neo-Arcade:** Runs in full-screen 60fps with automatic screen keep-awake and fixed-timestep physics.
