# ✅ To-Do– Smart To-Do App (Flutter)

**To-Do** is a modern Flutter-based to-do app built with offline-first capabilities, Google Sign-In,
Firebase backend, and a clean, maintainable architecture. It enables users to create, manage, and
search tasks by date, name, or priority — even when offline.

---

## 🚀 Features

- 🔐 Google Sign-In for authentication
- 🔄 Three-layer Clean Architecture
- ☁️ Firebase Firestore for remote database
- 💾 Hive for local storage and offline access
- 🔔 Local & Push Notifications
- 🗓️ Date-based task view
- 🔍 Name-based search
- ⚙️ Priority-based filtering
- 🧠 State management using Provider

---

## ⚙️ Setup Instructions

### 1. Unzip the Project

Extract the zipped project folder to your development directory.

### 2. Install Flutter Packages

Run the following in your terminal:

flutter pub get

Major three layer architecture:

lib/
├── data/         # Handles Firebase, Hive, API access
├── domain/       # Core business logic, entities, and repositories,usecase
├── presentation/ # UI layer, widgets, providers


The app supports offline task creation, viewing, and editing via Hive.

Syncs seamlessly with Firestore when network is available.

Uses Provider for dependency injection and state management.
