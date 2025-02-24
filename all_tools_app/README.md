# all_tools_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Project Prerequisites

## 1. System Requirements
Ensure your system meets the following requirements before setting up the project:

- **Operating System:** Windows / macOS / Linux
- **RAM:** Minimum 8GB (Recommended 16GB for better performance)
- **Storage:** At least 10GB of free disk space
- **Processor:** Intel i5 / AMD Ryzen 5 or higher

## 2. Software Dependencies
The following software must be installed:

- **Flutter SDK** (Latest Stable Version) - [Download Here](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (Included with Flutter)
- **Android Studio** (For Android development) - [Download Here](https://developer.android.com/studio)
- **Xcode** (For iOS development, macOS only) - [Download Here](https://developer.apple.com/xcode/)
- **VS Code** (Recommended) or any preferred code editor - [Download Here](https://code.visualstudio.com/)
- **Node.js & npm** (For Strapi Backend) - [Download Here](https://nodejs.org/)
- **Git** (For version control) - [Download Here](https://git-scm.com/downloads)

## 3. Flutter Project Setup
Ensure Flutter is properly set up:

1. **Check Flutter Installation:**
   ```sh
   flutter doctor
   ```
   Resolve any issues before proceeding.

2. **Clone the Project Repository:**
   ```sh
   git clone <GITHUB_REPO_URL>
   cd <PROJECT_FOLDER>
   ```

3. **Install Flutter Dependencies:**
   ```sh
   flutter pub get
   ```

## 4. Backend (Strapi) Setup
Ensure Strapi is installed and configured:

1. **Install Strapi Globally:**
   ```sh
   npm install -g create-strapi-app@latest
   ```

2. **Navigate to Backend Directory:**
   ```sh
   cd backend
   ```

3. **Install Dependencies & Run Strapi:**
   ```sh
   npm install
   npm run develop