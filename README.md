# Gestión de Clústeres de Kubernetes con Vagrant

Este script en Bash te permite administrar clústeres de Kubernetes utilizando Vagrant. Proporciona una manera sencilla de crear, iniciar, detener y eliminar clústeres, todo ello a través de una interfaz de línea de comandos intuitiva.

## Requisitos Previos

- [Vagrant](https://www.vagrantup.com/downloads)
- [Vagrant-pluging](vagrant plugin install vagrant-disksize)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Instalación y Uso

1. **Clonar el Repositorio**: Clona este repositorio en tu máquina local:

    ```bash
    git clone https://github.com/b14nc0/spellbook8s.git
    ```

2. **Configurar el Directorio**: Abre el archivo `speelbook.sh` y asegúrate de establecer la variable `DIR_VAGRANT` al directorio donde deseas gestionar tus clústeres.

3. **Permitir la Ejecución del Script**: Haz que el script sea ejecutable:

    ```bash
    chmod +x speelbook.sh
    ```

4. **Ejecutar el Script**: Ejecuta el script para iniciar la interfaz de línea de comandos:

    ```bash
    ./speelbook.sh
    ```

5. **Seleccionar una Opción**: Selecciona la opción deseada del menú para gestionar tus clústeres de Kubernetes.

## Opciones del Menú

- **Menu K8S**: Gestiona clústeres de Kubernetes.
- **Admin APPs**: Espacio reservado para administrar aplicaciones (en construcción).
- **Salir**: Sale del script.

## Contribución

Si encuentras algún problema o tienes alguna sugerencia de mejora, no dudes en [crear un issue](https://github.com/b14nc0/spellbook8s.git/issues).

## Notas

- Este script asume la presencia de Vagrant y VirtualBox en tu sistema.
- Asegúrate de revisar el script y modificarlo según tus necesidades antes de usarlo en un entorno de producción.
