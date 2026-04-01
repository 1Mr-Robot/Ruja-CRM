# Guía de Contribución Técnica

Esta guía contiene toda la información técnica necesaria para configurar, desarrollar y ejecutar el proyecto.

## Requisitos previos

- Python 3.13
- Docker y Docker Compose
- MySQL (para desarrollo local sin Docker)
- Git

## Estructura del proyecto

```
Ruja-CRM/
├── ProyectoTPOO/          # Configuración principal de Django
│   ├── settings.py        # Configuración del proyecto
│   └── ...
├── core/                  # Aplicación principal
├── db.sql                 # Script de inicialización de base de datos
├── docker-compose.yml     # Configuración de servicios
├── nginx/
│   └── default.conf       # Configuración de Nginx
├── requirements.txt       # Dependencias Python
├── .env                   # Variables de entorno
└── .env.example           # Plantilla de variables de entorno
```

## Configuración del entorno de desarrollo

### 1. Clonar el repositorio

```bash
git clone https://github.com/1Mr-Robot/Ruja-CRM.git
```

### 2. Crear entorno virtual

```bash
python -m venv venv
```

### 3. Activar el entorno virtual

**PowerShell:**
```powershell
.\venv\Scripts\Activate.ps1
```

**CMD:**
```cmd
venv\Scripts\activate
```

### 4. Instalar dependencias

```bash
pip install -r requirements.txt
```

### 5. Configurar variables de entorno

Copiar `.env.example` a `.env` y configurar los valores necesarios:

```bash
cp .env.example .env
```

Variables principales:

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `DEBUG` | Modo debug | `True` |
| `SECRET_KEY` | Clave secreta de Django | `your-secret-key-here` |
| `ALLOWED_HOSTS` | Hosts permitidos | `localhost,127.0.0.1` |
| `DB_NAME` | Nombre de la base de datos | `ruja` |
| `DB_USER` | Usuario de la base de datos | `user` |
| `DB_PASSWORD` | Contraseña de la base de datos | `super_secure_password` |
| `DB_HOST` | Host de la base de datos | `localhost` |
| `DB_PORT` | Puerto de la base de datos | `3306` |

### 6. Ejecutar migraciones

Si se usa la base de datos gestionada por Django:

```bash
python manage.py migrate
```

### 7. Crear superusuario

```bash
python manage.py createsuperuser
```

### 8. Ejecutar el servidor de desarrollo

```bash
python manage.py runserver
```

El servidor estará disponible en `http://127.0.0.1:8000`

## Ejecución con Docker Compose

### Configuración inicial

1. Asegurarse de tener Docker y Docker Compose instalados
2. Configurar el archivo `.env` con las variables deseadas

Ejemplo de configuración para Docker Compose:

```env
# Django settings
DEBUG=False
SECRET_KEY=your-secret-key-here
ALLOWED_HOSTS=localhost,127.0.0.1
CSRF_TRUSTED_ORIGINS=http://localhost:8001
HTTPS=False

# Superuser
SUPERUSER_USERNAME=admin
SUPERUSER_EMAIL=admin@example.com
SUPERUSER_PASSWORD=admin123

# Database
DB_NAME=ruja
DB_USER=user
DB_PASSWORD=super_secure_password
DB_HOST=db
DB_PORT=3306

# MySQL
MYSQL_DATABASE=ruja
MYSQL_USER=user
MYSQL_PASSWORD=super_secure_password
MYSQL_ROOT_PASSWORD=very_strong_root_password
```

**Nota:** Si se modifican los valores de la base de datos en el `.env`, es necesario eliminar los contenedores y volúmenes existentes para que se apliquen los cambios.

### Construir y ejecutar

```bash
docker-compose up --build
```

### Servicios disponibles

| Servicio | Puerto | Descripción |
|----------|--------|-------------|
| Nginx | 8006 | Servidor web (entrada principal) |
| Django | 8000 | Aplicación backend |
| MySQL | 3309 | Base de datos |

### Comandos útiles de Docker Compose

```bash
# Detener servicios
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v

# Ver logs
docker-compose logs -f web

# Recrear servicios
docker-compose up --build --force-recreate
```

## Base de datos

### Base de datos de prueba (Clever Cloud)

El proyecto tiene disponible una base de datos remota de pruebas. Las credenciales se encuentran en el archivo `.env.example`:

```
Host: blbobicm5ybh67kjinxc-mysql.services.clever-cloud.com
Puerto: 3306
Usuario: uxxuzbyn4sknuup3
Contraseña: HWnbIzeSH3zcsx97Bu3M
Base de datos: blbobicm5ybh67kjinxc
```

### Modelos con `managed = False`

Las siguientes tablas fueron creadas manualmente y Django no puede modificarlas directamente:

| Tabla |
|-------|
| agente |
| aseguradora |
| cliente |
| detalleAgAs |
| detalleAsTP |
| formaPago |
| generoCliente |
| metodoPago |
| poliza |
| tipoPoliza |

Para que Django pueda manejar estas tablas, cambiar `managed = False` a `managed = True` en los modelos correspondientes y ejecutar:

```bash
python manage.py makemigrations
python manage.py migrate
```

### Importar base de datos existente

El archivo `db.sql` contiene la estructura de la base de datos de prueba. Para importarlo:

```bash
# Con Docker
docker-compose exec db mysql -u user -p ruja < db.sql

# Directamente desde MySQL
mysql -h blbobicm5ybh67kjinxc-mysql.services.clever-cloud.com -P 3306 -u uxxuzbyn4sknuup3 -p blbobicm5ybh67kjinxc < db.sql
```

## Configuración de producción

### Variables de entorno necesarias

```env
DEBUG=False
SECRET_KEY=<clave-segura-generada>
ALLOWED_HOSTS=<dominio-produccion>
CSRF_TRUSTED_ORIGINS=https://<dominio-produccion>
HTTPS=True

DB_NAME=ruja
DB_USER=user
DB_PASSWORD=<contraseña-segura>
DB_HOST=db
DB_PORT=3306
```

### Puertos expuesto

- **8006**: Puerto de entrada via Nginx
- **3309**: MySQL

### Archivos estáticos y media

Docker Compose configura volúmenes para:
- `/app/staticfiles` - Archivos estáticos de Django
- `/app/media` - Archivos subidos por usuarios

## Configuración de desarrollo en VS Code

1. Seleccionar el intérprete de Python del entorno virtual: `F1 > Python: Select Interpreter`
2. Instalar extensiones recomendadas:
   - Python (Microsoft)
   - Django
   - Djaneiro
3. Configurar Pylint para Django en `Settings`:

```json
"pylint.args": ["--load-plugins", "pylint_django"]
```

## Comandos útiles de Django

```bash
# Crear migraciones
python manage.py makemigrations

# Aplicar migraciones
python manage.py migrate

# Recolectar archivos estáticos
python manage.py collectstatic

# Crear superusuario
python manage.py createsuperuser

#-shell interactivo
python manage.py shell

# Ver URLS disponibles
python manage.py show_urls
```