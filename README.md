# Vroom 

Vroom is a Flutter-based mobile application designed to make buying and selling vehicles easier. The application allows users to explore available vehicles, view vehicle details, and navigate a streamlined vehicle shopping experience.

Built with Flutter and Dart, Vroom focuses on providing an intuitive mobile interface while applying modern mobile development practices, including MVVM architecture, API integration, state management, and automated testing.

## Features

- **User Authentication:** Register, log in, and manage user sessions.
- **Vehicle Listings:** Browse available vehicles for sale.
- **Vehicle Details:** View information about individual vehicles.
- **Product Cards:** Explore vehicle listings through reusable UI components.
- **Shopping Cart:** Manage selected items through a cart interface.
- **API Integration:** Communicate with backend services to retrieve and manage application data.
- **State Management:** Manage application state using Provider.
- **Error Handling:** Handle authentication failures and other application errors.
- **Automated Testing:** Test application logic and UI behavior using unit and widget tests.

## Technology Stack

- **Framework:** Flutter
- **Programming Language:** Dart
- **Architecture:** Model-View-ViewModel (MVVM)
- **State Management:** Provider
- **API Integration:** REST APIs
- **Testing:** Flutter Test and Mocktail
- **Local Storage:** Shared Preferences
- **Version Control:** Git and GitHub

## Project Structure

```text
lib/
├── model/
│   ├── auth-exception.dart
│   ├── cart.dart
│   ├── login_response.dart
│   ├── product.dart
│   ├── token_response.dart
│   └── user.dart
├── screens/
│   ├── cart_card.dart
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── product_card.dart
│   ├── redirect.dart
│   └── signup_screen.dart
├── services/
│   └── auth_api.dart
├── view_model/
│   └── auth_view.dart
└── main.dart

test/
├── model/
├── screens/
├── services/
└── view_model/
