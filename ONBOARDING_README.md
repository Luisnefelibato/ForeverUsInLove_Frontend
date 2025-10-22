# 🎨 Onboarding Implementation Guide

## ✅ Completed Features

### 1. Splash Screen (`splash_page.dart`)
- **Animated logo** with fade and scale effects
- **Hero animation** ready for transitions
- **Gradient background** matching brand colors
- **Auto-navigation** to intro screens after 3 seconds

### 2. Intro Screens (`intro_pages_v2.dart`)
- **3 screens** matching wireframe designs exactly:
  - Screen 1: "Where meaningful connections begin again"
  - Screen 2: "Verified profiles. Feel safe being yourself."
  - Screen 3: "However You Identify Yourself, you're Always Welcome Here"
- **Skip button** (top right)
- **Dot indicator** (bottom center)
- **Swipeable** page view
- **Background image support** (optional)

### 3. Permissions Screen (`permissions_page.dart`)
- **3 permissions** with toggle switches:
  - Location
  - Camera
  - Notifications
- **"Allow All" button** to grant all permissions
- **"Customize Permission" button** to continue with selected permissions
- **Skip button** to bypass permissions
- **Individual toggle switches** for each permission

---

## 🎨 Customizable Theme

All colors and styles are centralized in `onboarding_theme.dart`:

```dart
class OnboardingTheme {
  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color skipButtonColor = Colors.black;
  
  // Text colors
  static const Color titleColor = Colors.black;
  static const Color descriptionColor = Colors.black54;
  
  // Dot indicator colors
  static const Color activeDotColor = Colors.black;
  static const Color inactiveDotColor = Color(0xFFE0E0E0);
  
  // Button colors
  static const Color primaryButtonColor = Colors.black;
  static const Color primaryButtonTextColor = Colors.white;
  
  // Typography
  static const String fontFamily = 'Delight'; // Change font here
  static const double titleFontSize = 32.0;
  static const FontWeight titleFontWeight = FontWeight.bold;
}
```

### How to Change Colors:
1. Open `lib/features/onboarding/presentation/widgets/onboarding_theme.dart`
2. Modify the static color constants
3. Save and hot reload

---

## 📱 Navigation Flow

```
Splash Screen (3 seconds)
    ↓
Intro Screen 1
    ↓ (swipe or next)
Intro Screen 2
    ↓ (swipe or next)
Intro Screen 3
    ↓ (get started)
Permissions Screen
    ↓ (allow all / customize)
Welcome Screen (placeholder)
```

### Skip Options:
- **Intro screens**: Skip button → Permissions screen
- **Permissions screen**: Skip button → Welcome screen

---

## 🖼️ Adding Background Images

### Option 1: Add images to intro screens

1. Add your images to `assets/images/`:
   ```
   assets/images/intro_bg_1.png
   assets/images/intro_bg_2.png
   assets/images/intro_bg_3.png
   ```

2. Update `intro_pages_v2.dart`:
   ```dart
   final List<IntroPageDataV2> _pages = [
     IntroPageDataV2(
       title: 'Where meaningful\nconnections begin\nagain',
       backgroundImage: 'assets/images/intro_bg_1.png', // Add here
     ),
     // ... other pages
   ];
   ```

### Option 2: Use gradient backgrounds

Background images are optional. The screens work perfectly with solid colors or gradients.

---

## 🎯 Typography - Delight Font

To use the **Delight font** as specified:

### 1. Add font files to project:
```
assets/fonts/
├── Delight-Regular.ttf
├── Delight-Bold.ttf
└── Delight-Medium.ttf
```

### 2. Update `pubspec.yaml`:
```yaml
flutter:
  fonts:
    - family: Delight
      fonts:
        - asset: assets/fonts/Delight-Regular.ttf
        - asset: assets/fonts/Delight-Bold.ttf
          weight: 700
        - asset: assets/fonts/Delight-Medium.ttf
          weight: 500
```

### 3. Font is already configured in `onboarding_theme.dart`:
```dart
static const String fontFamily = 'Delight';
```

**Note**: If the Delight font is not available, the system will use the default font.

---

## 🚀 Running the App

### Install Dependencies:
```bash
flutter pub get
```

### Run on Device/Emulator:
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome
```

### Hot Reload:
- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

---

## 🔧 Customization Checklist

- [ ] Change colors in `onboarding_theme.dart`
- [ ] Add Delight font files (or use system font)
- [ ] Add background images for intro screens (optional)
- [ ] Replace logo image in `assets/images/logo_hummingbird.png`
- [ ] Adjust animation duration in `splash_page.dart` (currently 2s + 3s delay)
- [ ] Update permission descriptions in `permissions_page.dart`
- [ ] Connect to actual authentication flow after onboarding

---

## 📁 File Structure

```
lib/features/onboarding/
├── presentation/
│   ├── pages/
│   │   ├── splash_page.dart           # Animated splash screen
│   │   ├── intro_pages_v2.dart        # 3 intro screens with dots
│   │   └── permissions_page.dart      # Permission request screen
│   └── widgets/
│       └── onboarding_theme.dart      # Centralized theme config
```

---

## ✨ Features Matching Wireframes

### Splash Screen:
- ✅ App logo (animated)
- ✅ App name
- ✅ Tagline

### Intro Screens:
- ✅ Image placeholder icon (top center)
- ✅ Title text (32px, bold, centered)
- ✅ Dot indicator (bottom center)
- ✅ Skip button (top right)
- ✅ Exact text from wireframes

### Permissions Screen:
- ✅ Icon placeholder (top left)
- ✅ Title: "Allow access to personalize your experience."
- ✅ 3 permission items with descriptions
- ✅ Toggle switches
- ✅ "Allow All" button (primary)
- ✅ "Customize Permission" button (secondary)
- ✅ Skip button (top right)

---

## 🎨 Design Notes

### Wireframe Compliance:
- All screens match the provided wireframes **exactly**
- Typography set to **Delight/32px/Bold** for titles
- Minimal, clean design
- Easy color customization
- Background image support

### Responsive:
- Works on all screen sizes
- Portrait orientation locked
- Safe area respected

---

## 🔜 Next Steps

After onboarding is complete, implement:

1. **Welcome/Login Screen**
2. **Registration Flow** (6 steps)
3. **Face ID Verification**
4. **Document Verification**
5. **Profile Image Upload**
6. **Personality Questionnaire**

---

## 📝 Notes for Developers

### Changing Navigation:
Edit the route names in `main.dart`:
```dart
routes: {
  '/': (context) => const SplashPage(),
  '/intro': (context) => const IntroPagesScreenV2(),
  '/permissions': (context) => const PermissionsPage(),
  '/welcome': (context) => const WelcomeScreen(),
}
```

### Testing Permissions:
- iOS: Permissions dialog will show
- Android: Permissions dialog will show
- Web: Some permissions may not work

### Debugging:
- Check console for navigation issues
- Verify asset paths in `pubspec.yaml`
- Ensure `.env` file exists (copied from `.env.example`)

---

## 📞 Support

For questions or issues with the onboarding implementation:
- Review this README
- Check `onboarding_theme.dart` for customization
- Verify all assets are in correct folders
- Run `flutter pub get` after changes

---

**Version**: 1.0.0  
**Last Updated**: October 2024  
**Status**: ✅ Complete and Ready for Testing
