# htbmachines-searcher

**Buscador en terminal para la herramienta HTB Machines**

`htbmachines-searcher` es un script Bash para buscar fácilmente información sobre máquinas de Hack The Box directamente desde la terminal. Permite consultar máquinas por nombre, IP, dificultad, sistema operativo, habilidades y acceder a enlaces de resolución, facilitando la navegación y gestión de datos de HTB.

---

## Características principales

- Buscar máquinas por **nombre**, **IP**, **dificultad**, **sistema operativo** y **skills**.
- Mostrar información detallada de cada máquina.
- Actualizar localmente los datos con la información más reciente de la web oficial de HTB Machines.
- Mostrar enlaces a vídeos de resolución de cada máquina.
- Diseño simple y rápido, ejecutado desde la consola.

---

## Uso

```bash
./htbmachines-searcher.sh [opciones]

| Opción | Parámetro                | Descripción                                                             |
| ------ | ------------------------ | ----------------------------------------------------------------------- |
| -n     | `<Nombre de la máquina>` | Buscar una máquina por su nombre                                        |
| -i     | `<IP>`                   | Buscar el nombre de la máquina según la IP                              |
| -d     | `<Dificultad>`           | Buscar máquinas por nivel de dificultad (Fácil, Media, Difícil, Insane) |
| -o     | `<Sistema operativo>`    | Buscar máquinas por sistema operativo (Windows, Linux, etc.)            |
| -s     | `<Skill>`                | Buscar máquinas por skill específica                                    |
| -u     |                          | Actualizar los datos locales descargando la información más reciente    |
| -y     | `<Nombre de la máquina>` | Mostrar el enlace del vídeo de resolución de la máquina                 |
| -h     |                          | Mostrar el panel de ayuda                                               |


## Ejemplos

- **Buscar información de la máquina `Legacy`:**

~~~bash
./htbmachines-searcher.sh -n Legacy
~~~

- **Buscar máquina por IP:**

~~~bash
./htbmachines-searcher.sh -i 10.10.10.1
~~~

- **Mostrar todas las máquinas de dificultad media:**

~~~bash
./htbmachines-searcher.sh -d Media
~~~

- **Actualizar los datos locales:**

~~~bash
./htbmachines-searcher.sh -u
~~~

- **Ver el vídeo de resolución para la máquina `Optimum`:**

~~~bash
./htbmachines-searcher.sh -y Optimum
~~~


