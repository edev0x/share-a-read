# Share a Read
Share a Read is a platform that enables users to have a book randomly matched and show up how to implement a FullStack application with Angular and Java with SpringBoot with an Event Driven architecture.

## Project Overview
This repository contains the following structure:
```
.
├── frontend/          # Angular (20+) web application
├── backend/           # Java + Spring Boot services
├── infrastructure/    # IaC (Terraform)
└── README.md
```

### Architecture Diagram 🚧
This is a basic example of how the **application** works under the hood. Keep in mind that this is a `demo` project and the diagram is only used for reference. 

![Alt text](./architecture.png "architecture diagram (WIP)")

## Frontend
Uses `Angular v20+` with **standalone components**, `tailwindcss` for styling and communicates via `REST APIs` to the backend.


### Key Characteristics
* Component-driven architecture
* Responsive, mobile-first UI
* Clear separation between layouts and pages

## Backend
The backend is comprised of different microservices that are built based as `event-driven` components using `RabbitMQ` as the message broker, also uses `PostgreSQL` to persist the data.


## Contributing
General guidelines:

1. Keep changes focused and well-documented
2. Follow existing coding conventions
3. Prefer small, incremental pull requests