
# Hen Lehen – هُنَّ لَهُنَّ  
## Doctor Application

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Mobile%20Application-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Firebase-Authentication-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/>
  <img src="https://img.shields.io/badge/Supabase-Backend%20%26%20Database-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-C8A97E?style=flat-square"/>
  <img src="https://img.shields.io/badge/Users-Female%20Doctors-D291BC?style=flat-square"/>
  <img src="https://img.shields.io/badge/Status-Production%20Ready-9BCF9B?style=flat-square"/>
</p>

---

## Overview

**Hen Lehen – هُنَّ لَهُنَّ Doctor Application** is a mobile application developed using **Flutter** and integrated with **Firebase** and **Supabase**.  
The application is designed exclusively for **female doctors** and represents the professional (doctor-side) system of the Hen Lehen women-only healthcare platform.

The application provides a calm, secure, and feminine digital environment that enables doctors to manage medical consultations, appointments, clinic branches, and patient information with clarity and professionalism.

---

## Demo Video

This video presents a full walkthrough of the Hen Lehen – هُنَّ لَهُنَّ Doctor Application, demonstrating the core features and workflows.

[Watch Demo Video on YouTube](https://youtu.be/vsnvrcTbRHM)

---

## Vision & Concept

Hen Lehen is built on the idea of creating a **safe and private healthcare space for women**.  
The Doctor Application focuses on empowering female doctors with tools that are:

- Organized and easy to use  
- Respectful of medical privacy  
- Designed with a soft and feminine visual identity  
- Aligned with real-world medical workflows  

---

## Project Objectives

- Provide a dedicated application for female doctors
- Support online and clinic-based consultations
- Simplify appointment and schedule management
- Enable clinic branch and location management
- Maintain patient data privacy and security
- Apply clean, scalable Flutter architecture

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
| Mobile Development | Flutter |
| Authentication | Firebase Authentication |
| Backend Services | Supabase |
| Database | Supabase |
| Notifications | Firebase |
| State Management | Provider |

---

## High-Level Architecture

```

┌──────────────────────────────────┐
│        Flutter Presentation      │
│   Screens • Widgets • Theme      │
└───────────────┬──────────────────┘
│
State Management
Provider
│
┌───────────────┴──────────────────┐
│        Application Logic         │
│ Auth • Appointments • Chat      │
└───────────────┬──────────────────┘
│
┌───────┴──────────┐
│                  │
┌───────▼────────┐ ┌───────▼────────┐
│   Firebase     │ │   Supabase      │
│ Authentication│ │ Database & API  │
└────────────────┘ └────────────────┘

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

## Authentication & Verification Flow

```

Application Launch
│
Login / Register
│
Pending Verification
│
Doctor Dashboard

```

---

## Core Application Modules

| Module | Description |
|------|-------------|
| Dashboard | Daily overview and statistics |
| Appointments | Manage booking requests |
| Patients | Patient list and history |
| Chat | Online medical consultation |
| Branches | Clinic management |
| Profile | Doctor information |
| Settings | Application configuration |

---

## Consultation Types

| Type | Description | Chat |
|----|-------------|------|
| Online Consultation | In-app medical chat | Enabled |
| Clinic Visit | Physical appointment | Disabled |

---

## Online Consultation Workflow

```

Appointment Confirmed
│
Payment Completed
│
Medical Chat Opened
│
Consultation Completed

```

---

## Clinic Branch Management

Doctors can add and manage multiple clinic branches.

| Field | Description |
|-----|------------|
| Branch Name | Clinic identifier |
| Governorate | Location |
| City | City name |
| Address | Full address |
| Working Days | Weekly schedule |
| Consultation Fee | Visit cost |

---

## Patient Management

Doctors can:
- View patient list
- Search patients by name
- Track visit history
- View last visit date and number of visits

| Data | Purpose |
|----|--------|
| Last Visit | Follow-up |
| Visit Count | Medical history |

---

## UI & UX Design Principles

- Soft feminine color palette
- Calm and professional medical layout
- Light and dark mode support
- Arabic and English localization
- RTL and LTR layout handling
- Reusable and consistent UI components
- Emotionally comfortable user experience

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

Hen Lehen – هُنَّ لَهُنَّ Doctor Application is a well-structured Flutter application that reflects real medical workflows while maintaining a feminine, calm, and professional design language.

The project is suitable for graduation projects, healthcare prototypes, and production-ready MVPs.

---

## License

This project is developed for educational and demonstration purposes as part of the Hen Lehen – هُنَّ لَهُنَّ platform.

قوليلي تحبي إيه ونقفله على أعلى مستوى.
