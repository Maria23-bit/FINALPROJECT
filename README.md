# Ethosplore - Ethical & Sustainable Tourism App

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Web%20%7C%20Android%20%7C%20iOS-lightgrey)

**Live Demo**: [https://maria23-bit.github.io/ethosplore/](https://maria23-bit.github.io/ethosplore/)

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Installation & Setup](#-installation--setup)
- [Project Structure](#-project-structure)
- [Screens](#-screens)
- [Design System](#-design-system)
- [Deployment](#-deployment)
- [License](#-license)

## 🌱 Project Overview

**Ethosplore** is a Flutter-based mobile application dedicated to ethical and sustainable tourism. The platform serves as a trusted guide for conscious travelers seeking authentic experiences that make a positive difference in local communities and the environment.

### 🎯 Purpose
- Connect travelers with eco-friendly and ethical tourism options
- Provide tools for tracking environmental impact
- Support local communities through responsible tourism
- Offer seamless payment and booking experiences

### ✨ Live Application
The application is currently deployed and accessible at:  
[https://maria23-bit.github.io/ethosplore/](https://maria23-bit.github.io/ethosplore/)

## 🚀 Features

### ✅ Implemented Features

#### 1. **Multi-Screen Application**
- **Welcome Screen**: Brand introduction and primary navigation
- **Login Screen**: User authentication with form validation
- **Dashboard**: Comprehensive user analytics and impact tracking
- **Send Money**: Secure payment processing interface

#### 2. **Interactive UI Components**
- **Custom Button Widget**: Reusable `EthosploreButton` with loading states
- **Form Validation**: Comprehensive input validation with visual feedback
- **Animated Transitions**: Smooth UI animations using `AnimatedContainer`
- **Responsive Design**: Adapts to different screen sizes and orientations

#### 3. **User Experience**
- Loading states with progress indicators
- Success/error feedback systems
- Intuitive navigation flow
- Professional color scheme and typography

#### 4. **Dashboard Analytics**
- Personal environmental impact tracking (CO₂ savings)
- Sustainable trip management
- Community contribution metrics
- Recent activity timeline

## 🛠️ Tech Stack

### Core Technologies
- **Flutter 3.0+**: Cross-platform framework
- **Dart 3.0+**: Programming language
- **Material Design**: UI component library

### Architecture
- **Widget-based Architecture**: Modular component design
- **State Management**: Local state using `setState`
- **Navigation**: Named routes with custom transitions
- **Form Handling**: `TextEditingController` and validation

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

#** 📥 Installation & Setup

## Prerequisites

- **Flutter SDK** (version 3.0.0 or higher)
- **Dart SDK** (version 3.0.0 or higher)
- **Chrome browser** (for web development)

## Step-by-Step Setup

### 1. Clone the Repository

```bash
git clone https://github.com/maria23-bit/ethosplore.git
cd ethosplore
## Install Dependencies

```bash
flutter pub get
## Run the Application

```bash
# For web development
flutter run -d chrome

# For Android emulator
flutter run

## Build for Production

```bash
# Web build
flutter build web --release

# Android build
flutter build apk --release

## Development Commands

```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Run tests
flutter test

# Analyze code
flutter analyze

📁 Project Structure
text
ethosplore/
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── widgets/                  # Reusable UI components
│   │   └── ethosplore_button.dart
│   └── screens/                  # Application screens
│       ├── welcome_screen.dart   # Landing page with navigation
│       ├── login_screen.dart     # Authentication interface
│       ├── dashboard_screen.dart # User dashboard with analytics
│       └── send_money_screen.dart # Payment processing
├── pubspec.yaml                  # Dependencies & metadata
├── web/                         # Web-specific configuration
└── README.md                    # Project documentation

📱 Screens
Welcome Screen (welcome_screen.dart)
Brand introduction with sustainable travel imagery

Navigation to main application features

Feature highlights with green and gold theme

Call-to-action buttons for user engagement

Login Screen (login_screen.dart)
User authentication interface

Form validation with real-time feedback

Registration and password recovery options

Professional styling with brand colors

Dashboard Screen (dashboard_screen.dart)
Personalized user greeting and stats

Impact metrics (CO₂ savings, ethical trips)

Quick action buttons for main features

Sustainable trip management

Community impact tracking

Recent activities timeline

Send Money Screen (send_money_screen.dart)
Secure payment interface

Recipient and amount input with validation

Payment method selection

Transaction favoriting

Success states with animations

🎨 Design System
Color Palette
Color	Hex	Usage
Ethosplore Blue	#3498DB	Primary brand, navigation, headers
Sustainable Green	#27AE60	Success states, eco-features, positive actions
Ethical Gold	#F39C12	Premium features, highlights, badges
Darker Blue	#2980B9	Accent colors, secondary actions
Light Blue	#E0F2F7	Backgrounds, subtle elements
ypography
Headlines: Bold, 24-32px, Ethosplore Blue

Body Text: Regular, 14-16px, Grey shades

Labels: Semi-bold, 14px, Dark grey

Buttons: Semi-bold, 16px, White on colored backgrounds

Design Principles
Clarity: Clean, uncluttered interfaces

Consistency: Uniform component behavior

Accessibility: High contrast ratios, readable fonts

Sustainability: Green color emphasis for eco-features

🚀 Deployment
Web Deployment (Current)
The application is deployed using GitHub Pages:

Build for web: flutter build web --release

Deploy: Automatic deployment via GitHub Actions

Live URL: https://maria23-bit.github.io/ethosplore/

Mobile Deployment
Android:

bash
flutter build apk --release
# Upload to Google Play Store
iOS:

bash
flutter build ios --release
# Upload to App Store Connect
Deployment Commands
bash
# Build for web
flutter build web --release

# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release
🔮 Future Enhancements
Planned Features
Backend Integration: Real user authentication and data persistence

Carbon Calculator: Advanced environmental impact tracking

Booking System: Direct booking for ethical tours and accommodations

Community Features: Traveler reviews and recommendations

Multi-language Support: Global accessibility

Technical Improvements
State management with Provider/Riverpod

Persistent local storage

Push notifications

Advanced animations

Performance optimization

🐛 Troubleshooting
Common Issues
Dependencies not loading:

bash
flutter clean
flutter pub get
Web build issues:

bash
flutter config --enable-web
flutter create .
Hot reload not working:

Ensure Chrome is updated

Check for console errors

Try full app restart

Support
Check Flutter documentation

Review Dart dev tools

Use Flutter inspector for UI debugging

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

🤝 Contributing
We welcome contributions! Please:

Fork the repository

Create a feature branch

Follow existing code style

Add tests for new features

<p align="center">
  <strong>Built with 💚 for a more sustainable travel future</strong>
</p>

<p align="center">
  <em>Ethosplore - Where Every Journey Matters</em>
</p>

<p align="center">
  <strong>Live Application</strong>: <a href="https://maria23-bit.github.io/ethosplore/">https://maria23-bit.github.io/ethosplore/</a>
</p>

## 🔗 Quick Links

- [Live Demo](https://maria23-bit.github.io/ethosplore/)
- [Source Code](https://github.com/maria23-bit/ethosplore)
- [Issue Tracker](https://github.com/maria23-bit/ethosplore/issues)
- [Documentation](https://github.com/maria23-bit/ethosplore#readme)

---

*This project was developed as part of the PLP Web Technologies July 2025 Final Project and Deployment assignment.*




