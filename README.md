
# Hen Lehen – هُنَّ لَهُنَّ
## Doctor Application

---

## 1. Introduction

Hen Lehen – هُنَّ لَهُنَّ Doctor Application is a mobile application developed using **Flutter** and integrated with **Firebase** and **Supabase**.  
The application is designed exclusively for **female doctors** and represents the doctor-side system of the Hen Lehen women-only healthcare platform.

The main goal of this application is to provide a secure, organized, and professional environment that enables doctors to manage consultations, appointments, clinics, and patients efficiently.

---

## 2. Project Objectives

- Provide a dedicated application for female doctors
- Support online and clinic-based medical consultations
- Manage appointments and patient records
- Organize clinic branches and locations
- Maintain privacy, security, and medical professionalism
- Deliver a clean, scalable, and maintainable Flutter architecture

---

## 3. Target Users

| User Type | Description |
|---------|-------------|
| Doctor | Licensed female medical professional |
| System | Handles authentication, data storage, and workflows |

---

## 4. Technology Stack

| Layer | Technology |
|-----|-----------|
| Mobile Framework | Flutter |
| Authentication | Firebase Authentication |
| Backend & Database | Supabase |
| Notifications | Firebase |
| State Management | Provider |
| Architecture Pattern | Feature-based modular structure |

---

## 5. High-Level System Architecture

```

┌──────────────────────────────┐
│        Flutter UI Layer      │
│  Screens - Widgets - Theme   │
└───────────────┬──────────────┘
│
State Management
Provider
│
┌───────────────┴──────────────┐
│      Application Logic       │
│  Auth - Appointments - Chat  │
└───────────────┬──────────────┘
│
┌───────┴────────┐
│                │
┌───────▼───────┐ ┌──────▼──────┐
│   Firebase    │ │   Supabase  │
│ Authentication│ │ Database    │
└───────────────┘ └─────────────┘

```

---

## 6. Project Structure

```

lib/
│
├── main.dart
│
├── config/
│   ├── theme.dart
│   ├── routes.dart
│   ├── providers.dart
│   └── locale.dart
│
├── models/
│   └── models.dart
│
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── pending_screen.dart
│   │
│   ├── dashboard/
│   │   ├── main_screen.dart
│   │   └── dashboard_screen.dart
│   │
│   ├── appointments/
│   │   └── appointments_screen.dart
│   │
│   ├── chat/
│   │   └── chat_screen.dart
│   │
│   ├── branches/
│   │   ├── branches_screen.dart
│   │   └── add_branch_screen.dart
│   │
│   ├── patients/
│   │   └── patients_screen.dart
│   │
│   └── profile/
│       └── profile_screen.dart
│
└── widgets/
└── widgets.dart

```

---

## 7. Authentication Flow

```

Application Launch
|
v
Login / Register
|
v
Pending Verification
|
v
Dashboard Access

```

---

## 8. Main Navigation Sections

| Section | Description |
|-------|-------------|
| Dashboard | Overview, statistics, and daily summary |
| Appointments | Manage booking requests and statuses |
| Patients | Patient list and visit history |
| Chat | Online medical consultation |
| Profile | Doctor personal and professional data |
| Settings | Application configuration |

---

## 9. Appointment Types

| Type | Description | Chat Availability |
|----|-------------|------------------|
| Online | Consultation via in-app chat | Enabled |
| Clinic | Physical visit at clinic | Disabled |

---

## 10. Online Consultation Workflow

```

Appointment Confirmed
|
Payment Completed
|
Chat Session Activated
|
Consultation Completed

```

---

## 11. Clinic Branch Management

Doctors can add and manage multiple clinic branches.

| Field | Description |
|-----|------------|
| Branch Name | Clinic identifier |
| Governorate | Clinic location |
| City | City name |
| Address | Full address |
| Working Days | Available schedule |
| Consultation Fee | Visit cost |

---

## 12. Patient Management

Doctors can:
- View all registered patients
- Search patients by name
- Track visit history
- View last visit date and visit count

| Data | Purpose |
|----|--------|
| Last Visit | Follow-up |
| Visit Count | Medical history tracking |

---

## 13. UI and Design Guidelines

- Clean medical layout
- Feminine and calm color palette
- Light and dark mode support
- Arabic and English language support
- RTL and LTR layout handling
- Reusable and consistent UI components

---

## 14. Project Status

| Component | Status |
|---------|--------|
| Flutter UI | Completed |
| Firebase Integration | Completed |
| Supabase Integration | Completed |
| Doctor Workflow | Implemented |
| Patient Application | Separate module |

---

## 15. Conclusion

Hen Lehen – هُنَّ لَهُنَّ Doctor Application is a structured and scalable Flutter application that reflects real-world medical workflows.  
The project is suitable for graduation projects, healthcare prototypes, and production-ready MVPs.

---

## 16. License

This project is developed for educational and demonstration purposes as part of the Hen Lehen – هُنَّ لَهُنَّ platform.
```
