# 🏫 Campus Booking Facility

> A full-stack facility booking system for the **University of Ghana** campus, built with the **MVC (Model-View-Controller)** architectural pattern.

![NestJS](https://img.shields.io/badge/NestJS-E0234E?style=for-the-badge&logo=nestjs&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![TypeORM](https://img.shields.io/badge/TypeORM-FE0803?style=for-the-badge&logo=typeorm&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [MVC Architecture](#-mvc-architecture-explained)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Database Design](#-database-design)
- [API Endpoints](#-api-endpoints)
- [Frontend Screens](#-frontend-screens)
- [Seed Data](#-seed-data)
- [Getting Started](#-getting-started)
- [Testing with Postman](#-testing-with-postman)
- [Screenshots Walkthrough](#-screenshots-walkthrough)

---

## 🎯 Overview

This project is a **Campus Facility Booking System** that allows users to book facilities on the University of Ghana campus. It demonstrates the use of the **MVC pattern** to structure a real-world web application with:

- 🗄️ A **relational database** (PostgreSQL) for data management
- 🔌 **RESTful API endpoints** using an MVC backend framework (NestJS)
- 📱 A **Flutter frontend** that interacts with the backend through HTTP requests
- 🐳 **Docker Compose** orchestration for seamless deployment

---

## 🏗️ MVC Architecture Explained

The **Model-View-Controller (MVC)** pattern separates the application into three interconnected components, each with a distinct responsibility:

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT (Flutter)                         │
│                         📱 VIEW LAYER                           │
│   Screens: Facilities | Users | Bookings                        │
│   Renders UI and sends HTTP requests to the backend             │
└──────────────────────────┬──────────────────────────────────────┘
                           │ HTTP Requests (GET, POST, PUT, DELETE)
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                    NESTJS BACKEND (API)                          │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              🎮 CONTROLLER LAYER                        │    │
│  │                                                         │    │
│  │  FacilitiesController   UsersController                 │    │
│  │  BookingsController                                     │    │
│  │                                                         │    │
│  │  • Receives HTTP requests and route parameters          │    │
│  │  • Validates input using DTOs (Data Transfer Objects)   │    │
│  │  • Delegates business logic to the Service layer        │    │
│  │  • Returns HTTP responses to the client                 │    │
│  └────────────────────────┬────────────────────────────────┘    │
│                           │ Method calls                        │
│                           ▼                                     │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              ⚙️ SERVICE LAYER (Business Logic)          │    │
│  │                                                         │    │
│  │  FacilitiesService   UsersService                       │    │
│  │  BookingsService                                        │    │
│  │                                                         │    │
│  │  • Contains all business logic and rules                │    │
│  │  • Performs CRUD operations via TypeORM repositories     │    │
│  │  • Handles errors (e.g., NotFoundException)             │    │
│  │  • Returns processed data to the Controller             │    │
│  └────────────────────────┬────────────────────────────────┘    │
│                           │ Repository queries                  │
│                           ▼                                     │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              📦 MODEL LAYER (Entities)                  │    │
│  │                                                         │    │
│  │  Facility Entity   User Entity   Booking Entity         │    │
│  │                                                         │    │
│  │  • Defines the database schema using TypeORM decorators │    │
│  │  • Maps to PostgreSQL tables (facilities, users,        │    │
│  │    bookings)                                            │    │
│  │  • Defines relationships (OneToMany, ManyToOne)         │    │
│  │  • Serves as the single source of truth for data shape  │    │
│  └────────────────────────┬────────────────────────────────┘    │
│                           │ SQL queries (auto-generated)        │
└───────────────────────────┼─────────────────────────────────────┘
                            ▼
                 ┌─────────────────────┐
                 │   🗄️ PostgreSQL     │
                 │     DATABASE        │
                 │                     │
                 │  Tables:            │
                 │  • facilities       │
                 │  • users            │
                 │  • bookings         │
                 └─────────────────────┘
```

### How MVC Maps to This Project

| MVC Component | Implementation | Files | Responsibility |
|:---:|:---:|:---|:---|
| **📦 Model** | TypeORM Entities | `*.entity.ts` | Define database schema, table relationships, and data structure |
| **🎮 Controller** | NestJS Controllers | `*.controller.ts` | Handle HTTP routes, validate input with DTOs, return responses |
| **⚙️ Service** | NestJS Services | `*.service.ts` | Business logic, CRUD operations, error handling |
| **📱 View** | Flutter Screens | `*_screen.dart` | User interface rendering, user interaction, API communication |

### Why MVC?

| Benefit | How It Applies Here |
|:---|:---|
| **🔀 Separation of Concerns** | Each layer has one job — Controllers don't touch the database, Services don't handle HTTP, Models don't contain logic |
| **🧪 Testability** | Services can be unit tested independently of HTTP and database |
| **♻️ Reusability** | The same Service can be used by multiple Controllers or scheduled tasks |
| **📈 Scalability** | New features are added by creating new Module + Controller + Service + Entity sets |
| **👥 Team Collaboration** | Frontend and backend developers can work independently on their layers |

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|:---:|:---:|:---|
| 📱 **Frontend** | Flutter (Dart) | Cross-platform mobile/web UI |
| 🔌 **Backend** | NestJS (TypeScript) | RESTful API with MVC architecture |
| 📦 **ORM** | TypeORM | Object-Relational Mapping for database queries |
| 🗄️ **Database** | PostgreSQL 16 | Relational database for persistent storage |
| 🐳 **DevOps** | Docker Compose | Container orchestration for DB + backend |
| ✅ **Validation** | class-validator | Request body validation via decorators |
| 🔄 **HTTP Client** | http (Dart package) | Frontend-to-backend API communication |

---

## 📂 Project Structure

```
campus-booking-facility/
│
├── 🐳 docker-compose.yml              # Orchestrates PostgreSQL + NestJS
├── 📄 .gitignore                       # Git ignore rules
├── 📄 README.md                        # This file
├── 📬 Campus_Booking_API.postman_collection.json  # Postman test collection
│
├── 🔌 backend/                         # NestJS Backend (API)
│   ├── Dockerfile                      # Docker image for backend
│   ├── package.json                    # Node.js dependencies
│   ├── tsconfig.json                   # TypeScript configuration
│   ├── nest-cli.json                   # NestJS CLI configuration
│   └── src/
│       ├── main.ts                     # App entry point (CORS, validation)
│       ├── app.module.ts               # Root module (TypeORM config, imports)
│       │
│       ├── 🏢 facilities/             # Facilities Feature Module
│       │   ├── facilities.module.ts    #   Module definition
│       │   ├── facilities.controller.ts #  🎮 Controller (HTTP routes)
│       │   ├── facilities.service.ts   #   ⚙️ Service (business logic)
│       │   ├── entities/
│       │   │   └── facility.entity.ts  #   📦 Model (DB schema)
│       │   └── dto/
│       │       ├── create-facility.dto.ts # Input validation (create)
│       │       └── update-facility.dto.ts # Input validation (update)
│       │
│       ├── 👤 users/                  # Users Feature Module
│       │   ├── users.module.ts
│       │   ├── users.controller.ts     #   🎮 Controller
│       │   ├── users.service.ts        #   ⚙️ Service
│       │   ├── entities/
│       │   │   └── user.entity.ts      #   📦 Model
│       │   └── dto/
│       │       ├── create-user.dto.ts
│       │       └── update-user.dto.ts
│       │
│       ├── 📅 bookings/              # Bookings Feature Module
│       │   ├── bookings.module.ts
│       │   ├── bookings.controller.ts  #   🎮 Controller
│       │   ├── bookings.service.ts     #   ⚙️ Service
│       │   ├── entities/
│       │   │   └── booking.entity.ts   #   📦 Model
│       │   └── dto/
│       │       ├── create-booking.dto.ts
│       │       └── update-booking.dto.ts
│       │
│       └── 🌱 seed/                   # Database Seeder
│           ├── seed.module.ts
│           └── seed.service.ts         # Auto-seeds data on first startup
│
└── 📱 frontend/                        # Flutter Frontend (View Layer)
    ├── pubspec.yaml                    # Dart dependencies
    └── lib/
        ├── main.dart                   # App entry point (theme, routing)
        │
        ├── 📦 models/                 # Data Models (mirror backend entities)
        │   ├── facility.dart           #   Facility model + JSON serialization
        │   ├── user.dart               #   User model + JSON serialization
        │   └── booking.dart            #   Booking model + JSON serialization
        │
        ├── 🔗 services/              # API Service Layer
        │   ├── api_service.dart        #   Generic HTTP client (base URL, methods)
        │   ├── facility_service.dart   #   Facility-specific API calls
        │   ├── user_service.dart       #   User-specific API calls
        │   └── booking_service.dart    #   Booking-specific API calls
        │
        └── 📱 screens/               # UI Screens (View)
            ├── home_screen.dart        #   Bottom navigation between tabs
            ├── facilities_screen.dart  #   Facilities CRUD UI
            ├── users_screen.dart       #   Users CRUD UI
            └── bookings_screen.dart    #   Bookings CRUD UI
```

---

## 🗄️ Database Design

### Entity Relationship Diagram

```
┌──────────────────────┐       ┌──────────────────────────────────┐
│     FACILITIES       │       │            USERS                 │
├──────────────────────┤       ├──────────────────────────────────┤
│ 🔑 id       SERIAL  │       │ 🔑 id       SERIAL               │
│ 📝 name     VARCHAR  │       │ 📝 name     VARCHAR              │
│ 📍 location VARCHAR  │       │ 📧 email    VARCHAR (UNIQUE)     │
│ 👥 capacity INTEGER  │       │ 🏷️ role     VARCHAR              │
└──────────┬───────────┘       └───────────────┬──────────────────┘
           │ 1                                  │ 1
           │                                    │
           │ ∞                                  │ ∞
     ┌─────┴────────────────────────────────────┴─────┐
     │                  BOOKINGS                       │
     ├─────────────────────────────────────────────────┤
     │ 🔑 id            SERIAL                        │
     │ 🏢 facility_id   INTEGER (FK → facilities.id)  │
     │ 👤 user_id       INTEGER (FK → users.id)       │
     │ 📅 date          DATE                          │
     │ 🕐 start_time    TIME                          │
     │ 🕐 end_time      TIME                          │
     │ 📊 status        VARCHAR                       │
     └─────────────────────────────────────────────────┘
```

### Table Definitions

#### 🏢 Facilities

| Column | Type | Constraints | Description |
|:---|:---|:---|:---|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing unique identifier |
| `name` | VARCHAR(255) | NOT NULL | Name of the facility |
| `location` | VARCHAR(255) | NOT NULL | Physical location on campus |
| `capacity` | INTEGER | NOT NULL | Maximum number of people |

#### 👤 Users

| Column | Type | Constraints | Description |
|:---|:---|:---|:---|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing unique identifier |
| `name` | VARCHAR(255) | NOT NULL | Full name of the user |
| `email` | VARCHAR(255) | NOT NULL, UNIQUE | University email address |
| `role` | VARCHAR(50) | DEFAULT 'student' | Role: admin, student, or faculty |

#### 📅 Bookings

| Column | Type | Constraints | Description |
|:---|:---|:---|:---|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing unique identifier |
| `facility_id` | INTEGER | FK → facilities(id), ON DELETE CASCADE | Reference to booked facility |
| `user_id` | INTEGER | FK → users(id), ON DELETE CASCADE | Reference to booking user |
| `date` | DATE | NOT NULL | Date of the booking |
| `start_time` | TIME | NOT NULL | Start time of the booking |
| `end_time` | TIME | NOT NULL | End time of the booking |
| `status` | VARCHAR(50) | DEFAULT 'confirmed' | Status: confirmed, pending, or cancelled |

### Relationships

- **Facility → Bookings**: One-to-Many (a facility can have many bookings)
- **User → Bookings**: One-to-Many (a user can have many bookings)
- **Booking → Facility**: Many-to-One (each booking belongs to one facility)
- **Booking → User**: Many-to-One (each booking belongs to one user)

---

## 🔌 API Endpoints

Base URL: `http://localhost:3000`

### 🏢 Facilities — `/facilities`

| Method | Endpoint | Description | Request Body |
|:---:|:---|:---|:---|
| 🟢 GET | `/facilities` | Get all facilities | — |
| 🟢 GET | `/facilities/:id` | Get facility by ID | — |
| 🟡 POST | `/facilities` | Create a new facility | `{ name, location, capacity }` |
| 🔵 PUT | `/facilities/:id` | Update a facility | `{ name?, location?, capacity? }` |
| 🔴 DELETE | `/facilities/:id` | Delete a facility | — |

### 👤 Users — `/users`

| Method | Endpoint | Description | Request Body |
|:---:|:---|:---|:---|
| 🟢 GET | `/users` | Get all users | — |
| 🟢 GET | `/users/:id` | Get user by ID | — |
| 🟡 POST | `/users` | Create a new user | `{ name, email, role? }` |
| 🔵 PUT | `/users/:id` | Update a user | `{ name?, email?, role? }` |
| 🔴 DELETE | `/users/:id` | Delete a user | — |

### 📅 Bookings — `/bookings`

| Method | Endpoint | Description | Request Body |
|:---:|:---|:---|:---|
| 🟢 GET | `/bookings` | Get all bookings (with facility & user details) | — |
| 🟢 GET | `/bookings/:id` | Get booking by ID (with facility & user details) | — |
| 🟡 POST | `/bookings` | Create a new booking | `{ facilityId, userId, date, startTime, endTime, status? }` |
| 🔵 PUT | `/bookings/:id` | Update a booking | `{ facilityId?, userId?, date?, startTime?, endTime?, status? }` |
| 🔴 DELETE | `/bookings/:id` | Delete a booking | — |

**Total: 15 RESTful endpoints** (5 per resource × 3 resources)

---

## 📱 Frontend Screens

The Flutter frontend provides a complete **CRUD interface** for all three resources, organized with a bottom navigation bar.

### 🏢 Facilities Screen

| Feature | Implementation |
|:---|:---|
| **📖 Read (List)** | Loads all facilities from `GET /facilities` and displays them in a scrollable list with name, location, and capacity |
| **➕ Create** | Floating Action Button opens a dialog with text fields for name, location, and capacity |
| **✏️ Update** | Edit icon on each card opens a pre-filled dialog; saves changes via `PUT /facilities/:id` |
| **🗑️ Delete** | Delete icon shows a confirmation dialog before removing via `DELETE /facilities/:id` |

### 👤 Users Screen

| Feature | Implementation |
|:---|:---|
| **📖 Read (List)** | Loads all users from `GET /users` with color-coded role badges (🔵 admin, 🟢 faculty, 🟠 student) |
| **➕ Create** | FAB opens a dialog with fields for name, email, and role |
| **✏️ Update** | Edit icon opens a pre-filled dialog; saves changes via `PUT /users/:id` |
| **🗑️ Delete** | Delete icon shows a confirmation dialog before removing via `DELETE /users/:id` |

### 📅 Bookings Screen

| Feature | Implementation |
|:---|:---|
| **📖 Read (List)** | Loads all bookings from `GET /bookings` with nested facility and user names, color-coded status (🟢 confirmed, 🟠 pending, 🔴 cancelled) |
| **➕ Create** | FAB opens a scrollable dialog with fields for facility ID, user ID, date, start time, end time, and status |
| **✏️ Update** | Edit icon opens a pre-filled dialog; saves changes via `PUT /bookings/:id` |
| **🗑️ Delete** | Delete icon shows a confirmation dialog before removing via `DELETE /bookings/:id` |

### 🎨 UI Theme

- **Primary Color**: Blue (`#1565C0`) — AppBar, buttons, FAB, selected nav items
- **Background**: Light blue-white (`#F5F8FC`)
- **Cards**: White with rounded corners and elevation shadows
- **Success Feedback**: Blue SnackBar notifications
- **Error Feedback**: Red SnackBar notifications

---

## 🌱 Seed Data

The database is automatically populated on first startup with University of Ghana campus data:

### 🏢 Facilities (5 records)

| # | Name | Location | Capacity |
|:---:|:---|:---|:---:|
| 1 | Balme Library | Main Campus, Near Great Hall | 600 |
| 2 | JQB Auditorium | Department of Computer Science, JQB Building | 250 |
| 3 | UGCS Computer Lab | Department of Computer Science, Ground Floor | 80 |
| 4 | Great Hall | Main Campus, University Avenue | 1,500 |
| 5 | New N Block Lecture Hall | Science Campus, N Block | 400 |

### 👤 Users (5 records)

| # | Name | Email | Role |
|:---:|:---|:---|:---:|
| 1 | Nathaniel Adika | nathaniel.adika@ug.edu.gh | admin |
| 2 | Emmanuel Adika | emmanuel.adika@st.ug.edu.gh | student |
| 3 | Grace Adika | grace.adika@ug.edu.gh | faculty |
| 4 | Daniel Adika | daniel.adika@st.ug.edu.gh | student |
| 5 | Priscilla Adika | priscilla.adika@ug.edu.gh | faculty |

### 📅 Bookings (5 records)

| # | Facility | User | Date | Time | Status |
|:---:|:---|:---|:---:|:---:|:---:|
| 1 | Balme Library | Nathaniel Adika | 2026-03-15 | 09:00–12:00 | confirmed |
| 2 | JQB Auditorium | Emmanuel Adika | 2026-03-16 | 14:00–16:00 | confirmed |
| 3 | UGCS Computer Lab | Grace Adika | 2026-03-17 | 08:00–10:00 | pending |
| 4 | Great Hall | Daniel Adika | 2026-03-20 | 10:00–13:00 | confirmed |
| 5 | New N Block Lecture Hall | Nathaniel Adika | 2026-03-22 | 15:00–17:00 | pending |

---

## 🚀 Getting Started

### Prerequisites

- 🐳 [Docker](https://www.docker.com/get-started) & Docker Compose
- 📱 [Flutter SDK](https://flutter.dev/docs/get-started/install) (for the frontend)

### 1️⃣ Start the Backend + Database

```bash
# Clone and navigate to the project
cd campus-booking-facility

# Start PostgreSQL and NestJS backend
docker-compose up --build
```

This will:
- 🗄️ Start a PostgreSQL 16 database on port `5432`
- 🔌 Build and start the NestJS backend on port `3000`
- 🌱 Automatically seed the database with UG campus data

### 2️⃣ Start the Flutter Frontend

```bash
# In a new terminal
cd campus-booking-facility/frontend

# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Or run on a connected device/emulator
flutter run
```

### 3️⃣ Verify Everything Works

```bash
# Test the API
curl http://localhost:3000/facilities
curl http://localhost:3000/users
curl http://localhost:3000/bookings
```

### 🔄 Reset the Database

To wipe all data and re-seed from scratch:

```bash
docker-compose down -v
docker-compose up --build
```

---

## 📬 Testing with Postman

A complete Postman collection is included in the project root:

📄 **`Campus_Booking_API.postman_collection.json`**

### How to Import

1. Open **Postman**
2. Click **Import** (top-left)
3. Select the JSON file from the project root
4. The collection appears with **3 folders** and **27 requests**

### Collection Contents

| Folder | Requests | Description |
|:---|:---:|:---|
| 🏢 Facilities | 9 | Create 5 UG facilities + GET all + GET one + UPDATE + DELETE |
| 👤 Users | 9 | Create 5 Adika family members + GET all + GET one + UPDATE + DELETE |
| 📅 Bookings | 9 | Create 5 bookings + GET all + GET one + UPDATE + DELETE |

> **Tip**: Run the POST requests first to create the data, then test GET, PUT, and DELETE.

---

## 🔧 Key Implementation Details

### Backend — NestJS MVC

- **Modular Architecture**: Each resource (Facilities, Users, Bookings) is a self-contained NestJS module with its own Controller, Service, Entity, and DTOs
- **TypeORM Integration**: `synchronize: true` auto-creates tables from entity definitions; `autoLoadEntities: true` discovers entities from imported modules
- **Validation Pipeline**: Global `ValidationPipe` with `whitelist: true` strips unknown properties and validates request bodies using `class-validator` decorators
- **CORS Enabled**: `app.enableCors()` allows the Flutter frontend to make cross-origin requests
- **Docker Retry Logic**: `retryAttempts: 10` and `retryDelay: 3000` in TypeORM config handles the case where NestJS starts before PostgreSQL is ready
- **Auto-Seeding**: `SeedService` implements `OnModuleInit` to populate data on first startup, skipping if data already exists

### Frontend — Flutter

- **Service Layer Pattern**: A generic `ApiService` handles all HTTP methods; resource-specific services (FacilityService, UserService, BookingService) wrap it with typed methods
- **Platform-Aware Base URL**: Automatically uses `localhost` for web and `10.0.2.2` for Android emulator
- **Stateful Screens**: Each screen uses `FutureBuilder` with manual refresh via `setState` for reactive data loading
- **Full CRUD Dialogs**: Create and Edit share the same dialog (pre-filled for edit mode); Delete shows a confirmation dialog
- **Error Handling**: Try-catch blocks on all API calls with SnackBar feedback for success and failure
- **Material 3 Design**: Blue and white theme with rounded cards, colored avatars, and status badges

---

## 📄 License

This project was developed as part of a university lab assignment demonstrating the **MVC architectural pattern** in full-stack web application development.
