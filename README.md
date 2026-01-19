
# Hen Lehen – هُنَّ لَهُنَّ
## Doctor Application

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Mobile%20App-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Firebase-Authentication-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/>
  <img src="https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue?style=flat-square"/>
  <img src="https://img.shields.io/badge/Users-Female%20Doctors-purple?style=flat-square"/>
  <img src="https://img.shields.io/badge/Status-Ready-success?style=flat-square"/>
</p>

---

## Overview

Hen Lehen – هُنَّ لَهُنَّ Doctor Application is a mobile application developed using **Flutter** and integrated with **Firebase** and **Supabase**.  
The application is designed exclusively for **female doctors** and represents the doctor-side system of the Hen Lehen women-only healthcare platform.

The application provides a secure, professional, and structured environment that allows doctors to manage appointments, online consultations, clinic branches, and patient data efficiently.

---

## Demo Video

This video demonstrates the main workflows of the Hen Lehen – هُنَّ لَهُنَّ Doctor Application, including authentication, dashboard navigation, appointment management, online medical chat, and clinic branch management.

[Watch Demo Video](assets/hen_lehen_doctor_demo.mp4)

---

## Project Objectives

- Provide a dedicated application for female doctors
- Support online and clinic-based medical consultations
- Manage appointments and schedules efficiently
- Organize clinic branches and locations
- Ensure privacy, security, and medical professionalism
- Maintain a clean, scalable Flutter architecture

---

## Target Users

| User Type | Description |
|---------|-------------|
| Doctor | Licensed female medical professional |
| System | Handles authentication, data storage, and workflows |

---

## Technology Stack

| Layer | Technology |
|-----|-----------|
| Mobile Framework | Flutter |
| Authentication | Firebase Authentication |
| Backend Services | Supabase |
| Database | Supabase |
| Notifications | Firebase |
| State Management | Provider |

---

## System Architecture

```

┌───────────────────────────────┐
│         Flutter UI Layer      │
│ Screens • Widgets • Theme     │
└───────────────┬───────────────┘
│
State Management
Provider
│
┌───────────────┴───────────────┐
│       Application Logic       │
│ Auth • Appointments • Chat   │
└───────────────┬───────────────┘
│
┌───────┴────────┐
│                │
┌───────▼────────┐ ┌─────▼────────┐
│   Firebase     │ │   Supabase    │
│ Authentication│ │ Database/API  │
└────────────────┘ └──────────────┘

```

---

## Project Structure

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
│   ├── dashboard/
│   ├── appointments/
│   ├── chat/
│   ├── branches/
│   ├── patients/
│   └── profile/
│
└── widgets/
└── widgets.dart

```

---

## Authentication Flow

```

Application Launch
|
Login / Register
|
Pending Verification
|
Dashboard Access

```

---

## Main Application Modules

| Module | Description |
|------|-------------|
| Dashboard | Overview and statistics |
| Appointments | Manage booking requests |
| Patients | Patient history and visits |
| Chat | Online medical consultation |
| Branches | Clinic management |
| Profile | Doctor information |
| Settings | Application configuration |

---

## Appointment Types

| Type | Description | Chat Availability |
|----|-------------|------------------|
| Online | In-app medical consultation | Enabled |
| Clinic | Physical visit at clinic | Disabled |

---

## Online Consultation Workflow

```

Appointment Confirmed
|
Payment Completed
|
Chat Session Enabled
|
Consultation Completed

```

---

## Clinic Branch Management

Doctors can manage multiple clinic branches.

| Field | Description |
|-----|------------|
| Branch Name | Clinic identifier |
| Governorate | Location |
| City | City name |
| Address | Full address |
| Working Days | Schedule |
| Consultation Fee | Visit cost |

---

## Patient Management

Doctors can:
- View patient list
- Search patients by name
- Track visit history
- View last visit date and visit count

| Data | Purpose |
|----|--------|
| Last Visit | Follow-up |
| Visit Count | Medical history |

---

## UI and Design Guidelines

- Clean and professional medical layout
- Feminine and calm color palette
- Light and dark mode support
- Arabic and English localization
- RTL and LTR layout handling
- Reusable UI components

---

## Project Status

| Component | Status |
|---------|--------|
| Flutter UI | Completed |
| Firebase Integration | Completed |
| Supabase Integration | Completed |
| Doctor Workflow | Implemented |
| Patient Application | Separate Module |

---

## Conclusion

Hen Lehen – هُنَّ لَهُنَّ Doctor Application is a structured and scalable Flutter application that reflects real-world medical workflows.  
The project is suitable for graduation projects, healthcare prototypes, and production-ready MVPs.

---

## License

This project is developed for educational and demonstration purposes as part of the Hen Lehen – هُنَّ لَهُنَّ platform.
```

---

قوليلي وهنقفله تسليم نهائي.
