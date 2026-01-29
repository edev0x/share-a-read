# Share a Read
Share a Read es una plataforma que permite a los usuarios obtener un libro de forma aleatoria. 
Este repositorio demuestra cómo implementar una aplicación FullStack con Angular y Java + Spring Boot con una arquitectura orientada a eventos.

## Descripción General del Proyecto
Este repositorio contiene la siguiente estructura:
```
.
├── frontend/          # Aplicación web Angular (20+)
├── backend/           # Servicios Java + Spring Boot
├── infrastructure/    # IaC (Terraform)
└── README.md
```

### Diagrama de Arquitectura 🚧
Este es un ejemplo básico de cómo funciona la **aplicación** internamente. Ten en cuenta que este es un proyecto demostrativo y con propósitos educativos, por lo tanto, el diagrama es utilizado únicamente de referencia.

![Texto alternativo](./architecture.png "diagrama de arquitectura (WIP)")

## Frontend
Utiliza `Angular v20+` con **componentes standalone**, `tailwindcss` para los estilos y se comunica con el backend mediante `APIs REST`.

### Características Clave
* Arquitectura orientada a componentes
* UI responsiva con enfoque mobile-first
* Clara separación entre layouts y páginas

## Backend
El backend está compuesto por diferentes microservicios que se construyen como componentes `event-driven`, utilizando `RabbitMQ` como broker de mensjaría y `PostgreSQL` para la persistencia de datos.

## Contribuir
Lineamientos generales:

1. Mantener los cambios enfocados y bien documentados
2. Seguir las convenciones de código existentes
3. Preferir pull requests pequeños e incrementales