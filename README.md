# Roamly - Global Travel eSIM Flutter App

A production-grade Flutter application clone replicating the modern design system, Clean Architecture, and feature workflows of premier travel eSIM platforms. Designed specifically for portfolio showcase.

---

## 📱 Features

- **Store & Discovery**: Browse 200+ destinations with regional filters (Europe, Americas, Asia), live search, and dynamic pricing previews.
- **Interactive PDP Plan Customizer**: Dynamic day selector (1–30 days) with real-time price calculations and unlimited high-speed data breakdown.
- **Streamlined Checkout**: Complete order checkout flow featuring digital payment options (Apple Pay, Google Pay, PayPal, Credit Card) and RoamCoins loyalty redemption.
- **eSIM Management**: Inspect active, ready-to-install, and expired eSIM profiles. Includes simulated QR activation codes and network tools (Ad Blocker, Safe Browsing, Virtual Location).
- **Order History**: Detailed receipt modal dialogs with ICCID and transaction breakdown.
- **RoamCoins Loyalty Program**: Tier progression (Gold/Platinum), cashback rates, and friend referral program.
- **Modern UI & Design System**: Material 3 theming with custom typography (`ModernEra`), responsive layouts, and extracted vector flags and icons.

---

## 🏛️ Architecture & Tech Stack

- **Pattern**: Clean Architecture (Presentation, Domain, Data layers)
- **State Management**: `flutter_bloc` (v9.x) with distinct Events and States
- **Design System**: Custom `AppTheme` with `ModernEra` font family and `AppColors`
- **Data Layer**: Robust offline mock repositories (`DestinationRepository`, `EsimRepository`, `OrderRepository`, `LoyaltyRepository`)
- **Key Dependencies**:
  - `flutter_bloc`: State management
  - `flutter_svg`: Vector graphics rendering
  - `intl`: Number & currency formatting
  - `cupertino_icons`: iOS design parity

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.13+ (or 3.24+/3.27+)
- Dart 3.x

### Run on Web (Chrome)
```bash
flutter pub get
flutter run -d chrome
```

### Run Tests
```bash
flutter test
flutter analyze
```
