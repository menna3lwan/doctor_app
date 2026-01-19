# Hen Lehen – هُنَّ لَهُنَّ  
## Doctor Application (Flutter)

Hen Lehen Doctor Application is a mobile application developed using **Flutter**, integrated with **Firebase** and **Supabase**, and designed exclusively for **female doctors** as part of the Hen Lehen – هُنَّ لَهُنَّ women-only healthcare platform.

This application allows doctors to manage appointments, patients, clinic branches, profiles, and online medical consultations in a secure and professional environment.

---

## Project Purpose

The Doctor Application represents the professional side of the Hen Lehen platform.  
It enables licensed female doctors to:

- Manage daily appointments
- Provide online consultations through medical chat
- Manage clinic branches and locations
- View and track patient information
- Control profile and application settings

The application follows a clean and scalable Flutter project structure.

---

## Technologies Used

- Flutter (Cross-platform mobile development)
- Firebase
  - Authentication
  - Notifications
- Supabase
  - Database
  - Backend services
- Provider (State Management)
- Clean folder-based architecture

---

## Project Structure

The project follows a modular and organized structure under the `lib` directory.

---

### lib/

#### main.dart
- Application entry point
- Initializes the app
- Loads theme, routes, and localization

---

### config/
Handles global application configuration.

- `theme.dart`  
  Defines light and dark themes.

- `routes.dart`  
  Centralized route management for navigation.

- `providers.dart`  
  Application-wide providers and state management.

- `locale.dart`  
  Language and localization configuration.

---

### models/
- `models.dart`  
  Contains application data models such as:
  - Doctor
  - Patient
  - Appointment
  - Branch

---

### screens/
Contains all application UI screens, grouped by feature.

---

#### auth/
Authentication-related screens.

- `login_screen.dart`  
  Doctor login screen.

- `register_screen.dart`  
  Doctor registration screen.

- `pending_screen.dart`  
  Account pending verification screen after registration.

---

#### dashboard/
Main application navigation and overview.

- `main_screen.dart`  
  Bottom navigation container for main sections.

- `dashboard_screen.dart`  
  Doctor dashboard showing statistics and daily overview.

---

#### appointments/
- `appointments_screen.dart`  
  Displays all appointments with filtering by status.

---

#### chat/
- `chat_screen.dart`  
  Medical chat screen for online consultations only.

---

#### branches/
Clinic management screens.

- `branches_screen.dart`  
  Displays doctor clinic branches.

- `add_branch_screen.dart`  
  Allows adding a new clinic branch with location details.

---

#### patients/
- `patients_screen.dart`  
  Displays patient list and visit history.

---

#### profile/
- `profile_screen.dart`  
  Doctor profile details and information.

---

#### settings/
- Settings-related screens and configurations.

---

### widgets/
- `widgets.dart`  
  Reusable UI components shared across the application.

---

## Application Flow

1. Doctor opens the application
2. Login or Register
3. Account enters pending verification (if new)
4. Dashboard is displayed after approval
5. Doctor navigates using main screen:
   - Dashboard
   - Appointments
   - Patients
   - Profile
   - Settings
6. Online consultations are handled via chat screen
7. Clinic branches are managed through branches screens

---

## Online Consultation Logic

- Chat is available only for online appointments
- Each chat session is linked to a single appointment
- Chat is not available for clinic-based consultations
- Doctors can end the consultation session manually

---

## Architecture Overview

- UI Layer: Flutter Screens and Widgets
- State Management: Provider
- Authentication: Firebase
- Backend and Database: Supabase
- Routing: Centralized in routes.dart
- Theming and Localization: Centralized in config folder

---

## Project Status

- Flutter application fully structured
- Firebase and Supabase integrated
- Core doctor workflows implemented
- Clean and scalable codebase
- Suitable for graduation projects and real-world MVPs

---

## License

This project is developed for educational and demonstration purposes as part of the Hen Lehen – هُنَّ لَهُنَّ platform.
