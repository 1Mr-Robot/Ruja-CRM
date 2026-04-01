# Ruja CRM

Sistema de gestión de pólizas de seguro diseñado para simplificar la administración de agentes, aseguradoras, tipos de póliza y clientes.

> [!NOTE]
> Esta es una versión demo modificada para que los usuarios puedan visitar la página sin tener que iniciar sesión. Esta es la versión que se muestra en ruja-crm.uziel.app

## Descripción

Ruja CRM es un sistema integral para la gestión de pólizas de seguro, desarrollado como proyecto final del equipo 1 del grupo 004 de Taller de Programación Orientada a Objetos. El sistema permite administrar de manera eficiente todos los aspectos relacionados con las pólizas de seguro.

## Características

El sistema ofrece las siguientes funcionalidades principales:

- **Gestión de Pólizas**: Creación, visualización y edición de pólizas de seguro con todos los campos requeridos.
- **Gestión de Clientes**: Administración de clientes asociados a las pólizas.
- **Gestión de Agentes**: Registro y mantenimiento de agentes de seguro.
- **Gestión de Aseguradoras**: Control de aseguradoras disponibles en el sistema.
- **Gestión de Tipos de Póliza**: Administración de los diferentes tipos de pólizas ofrecidas.
- **Reportes**: Generación de reportes detallados sobre pólizas, relaciones entre agentes y aseguradoras, y aseguradoras con sus tipos de póliza correspondientes.

## Arquitectura

El sistema está construido sobre Django 5.2, utilizando una arquitectura web MVT (Modelo-Vista-Template) adaptada al patrón de Django. La estructura del proyecto sigue las convenciones estándar de Django con aplicaciones separadas para cada entidad del negocio.

### Componentes principales

- **Backend**: Django 5.2 con Python 3.13
- **Base de datos**: MySQL
- **Servidor web**: Nginx (para producción)
- **Contenedores**: Docker Compose

### Estructura de datos

El sistema gestiona las siguientes entidades principales:

| Entidad | Descripción |
|---------|-------------|
| Póliza | Documento principal que representa un seguro |
| Cliente | Persona titular de la póliza |
| Agente | Representante que emite las pólizas |
| Aseguradora | Empresa que respalda la póliza |
| Tipo de Póliza | Categoría del seguro (vida, auto, hogar, etc.) |
| Forma de Pago | Métodos de pago disponibles |
| Método de Pago | Detalles específicos de pago |

## Funcionamiento

El sistema proporciona una interfaz web intuitiva para la administración de todos los componentes. Los usuarios pueden:

1. Acceder al panel de control con autenticación
2. Visualizar listados de todas las entidades
3. Crear nuevos registros desde cero
4. Editar información existente
5. Generar reportes consolidados
6. Gestionar relaciones entre entidades (agentes-aseguradoras, aseguradoras-tipos de póliza)

## Requisitos del sistema

- Navegador web moderno
- Conexión a la base de datos MySQL
- Para desarrollo local: Python 3.13
- Para producción: Docker y Docker Compose

## Licencia

Este proyecto fue desarrollado con fines educativos.
