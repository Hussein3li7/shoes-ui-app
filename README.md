# Luxury Sneaker UI App 👟

A premium, state-of-the-art Flutter Sneaker E-Commerce mobile application built with smooth animations, liquid glassmorphism navigation, 3D interactive sneaker rotation, and curved size selection.

---

## ✨ Features

- **Liquid Glass Navigation Bar**: Powered by native shader effects (`liquid_glass_container` / `lightweight_glass`) with dynamic refraction, chromatic aberration, and specular highlights.
- **Hero Transitions**: Smooth, seamless shared-element Hero transitions between the product catalog and the interactive product details screen.
- **Interactive 3D Sneaker Showcase**:
  - Multi-angle shoe perspective switching (Angle, Side, Top view).
  - Smooth interactive 360° orbit rotation with realistic contact shadows.
- **Curved Arc Size Selector**:
  - Interactive scrollable curved arc with tactile haptic feedback.
  - Automatically snaps and highlights the centered size with bold typography.
- **Stock Alert & Quantity Control**: Animated pulsating badge with smooth stepper controls.
- **Checkout & Payment Flow**: Multi-option payment selection (Apple Pay, PayPal, Credit Card) with interactive credit card details and instant visual feedback.

---

## 🛠️ Tech Stack & Packages

- **Framework**: [Flutter](https://flutter.dev) (Dart 3+)
- **Typography**: [Google Fonts (Plus Jakarta Sans)](https://pub.dev/packages/google_fonts)
- **Glassmorphism / Shaders**: [liquid_glass_container](https://pub.dev/packages/liquid_glass_container)
- **Icons**: Lucide Icons & Cupertino Icons
- **Architecture**: Modular widget hierarchy, separation of concerns (models, theme, widgets, screens)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.24.0 or newer recommended)
- Xcode (for iOS) or Android Studio (for Android)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Hussein3li7/shoes-ui-app-.git
   cd shoes-ui-app-
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on iOS/Android:**
   ```bash
   # For iOS (ensure CocoaPods is installed)
   cd ios && pod install && cd ..
   flutter run
   ```

---

## 🧪 Tests

To run the automated widget test suite:
```bash
flutter test
```

