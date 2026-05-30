# Tutor Center Management System (TCMS)

## Overview

Tutor Center Management System (TCMS) is a comprehensive web-based application designed to streamline and digitalize the management and daily operations of tutoring centers.

The system provides an integrated platform for managing students, parents, tutors, classes, schedules, attendance records, homework assignments, session feedback, payment requests, and notifications. By centralizing these processes, TCMS helps improve operational efficiency, enhance communication among stakeholders, and ensure effective academic management.

---

# Key Features

## Administrator

* Manage user accounts and system roles
* Manage tutors, students, and parents
* Create and manage classes
* Assign tutors to classes
* Manage schedules and teaching sessions
* Review and approve payment requests
* Monitor attendance records and session feedback
* Access reports and statistical dashboards
* Manage and distribute system notifications

---

## Tutor

* View assigned classes and schedules
* Perform session check-in and check-out
* Submit post-session feedback
* Create and manage homework assignments
* Review and grade student submissions
* Submit payment requests
* Receive notifications and system updates

---

## Student

* Access enrolled class information
* View assigned homework
* Submit homework online
* Review grades and tutor feedback
* Receive notifications and announcements

---

## Parent

* Monitor student attendance and learning progress
* View homework assignments and academic results
* Receive important notifications from the tutoring center

---

# Installation Guide

## 1. Clone the Repository

```bash
git clone https://github.com/ThienTT2005/TutorCenterManagementSystem.git
cd TutorCenterManagementSystem
```

## 2. Create the Database

```sql
CREATE DATABASE tcms;
```

## 3. Configure Database Connection

Update the database configuration in:

```properties
application.properties
```

Example:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/tcms
spring.datasource.username=root
spring.datasource.password=your_password
```

## 4. Initialize the Database

Execute the following script:

```text
data.sql
```

## 5. Build the Project

```bash
mvn clean install
```

## 6. Run the Application

```bash
mvn spring-boot:run
```

Alternatively, run the application directly from your IDE.

Access the application at:

```text
http://localhost:8080
```

---

# System Roles

| Role    | Description          |
| ------- | -------------------- |
| ADMIN   | System Administrator |
| TUTOR   | Tutor / Instructor   |
| PARENT  | Parent               |
| STUDENT | Student              |

---

# Core Business Rules

* Tutors are required to perform both check-in and check-out for every teaching session.
* Attendance validity is calculated automatically based on predefined business rules.
* Session feedback must be submitted within the specified time frame.
* Only valid teaching sessions are eligible for payment processing.
* Students can submit homework assignments online.
* Tutors can evaluate submissions and provide grades and feedback.
* The system automatically generates notifications for important events and activities.

---

# Development Team

Tutor Center Management System (TCMS)

* Vu Ngoc Diep
* Tran Thu Thien
* Nguyen Thi Uyen

---

# License

This project was developed for educational, academic, and research purposes.
