# Movies 
Este bloque contiene la estructura necesaria para construir un proyecto Flutter, cuenta con las mejores prácticas y herramientas de desarrollo, además las tecnologías más populares del desarrollo mobile en Flutter

## Información general

El proyecto consta de una aplicación que muestra un listado de películas usando el api [TheMovieDB](https://developers.themoviedb.org/3/getting-started/introduction), al dar tap en alguna de ellas muestra un detalle de la misma.


### Requerimientos

* Versión de Flutter: 3.7.8
* Versión de Dart: 2.19.5
* Versión Mínima Android SDK: 21
* Versión Android Target SDK: 33
* Versión Mínima OS: 11.0
* [API](https://developers.themoviedb.org/3/getting-started/introduction) The movie DB
* Se debe crear un proyecto en firebase y agregar los archivos de configuración al proyecto Flutter, se recomienda el uso de [firebaseCLI](https://firebase.google.com/docs/flutter/setup?hl=es-419&platform=android)
* Al abrir la aplicación se debe busca la información de manera local
* Si no se encuentra información de manera local se procede a buscar mediante el servicio web
* Si la información encontrada localmente fue almacenada hace más de un dia, debe buscarse en el servicio web y persistir la nueva información encontrada

## Funcionalidades
_Puedes hacer lo siguiente en la aplicación_

### Lista de películas más recientes
La aplicación te muestra las películas más recientes.

### Información detallada de una película
La aplicación te muestra fecha de estreno, poster, resumen de la películas y calificación.

## Arquitectura
Se propuso como arquitectura para el proyecto una arquitectura limpia usando DDD (enfocada en el modelo de dominio) y en el apartado de aplicación se usa BLoC 

Se usa el diseño guiado por el dominio ya que provee una estructura de prácticas y terminologías para tomar decisiones de diseño que enfoquen y aceleren el manejo de dominios complejos en los proyectos de software. 


## Estructura del proyecto
Se identifican 3 módulos
* App - Como capa de presentación
* Domain - Como capa de dominio donde encontramos nuestras reglas de negocio y nuestros servicios 
* Infrastructure - Como capa más externa donde encontramos los detalles (Base Datos, Cliente Http, etc).


## Ambientes
Gracias a injectable podemos trabajar con ambientes, productivo, desarrollo, entre otros. Cambiando la implementación de los repositorios. Con ello podríamos cambiar la url ya sea que tengamos un ambiente de desarrollo, productivo, etc.

Para ejecutar estos ambientes seria por medio de la terminal:

Para ambiente productivo: 
```sh
flutter run --dart-define=app.flavor=prod
```
Para ambiente desarrollo: 
```sh
flutter run --dart-define=app.flavor=dev
```

Cuando ejecutamos la app, sin colocar el ambiente que queremos, por defecto lanzará el ambiente productivo.

## Construido con
### [Http](https://pub.dev/packages/http) - Cliente HTTP
Como cliente HTTP para el consumo de servicios Rest se usó http ya que facilita este trabajo en aplicaciones flutter y es desarrollada y mantenida por ellos.
Se agregó un Timeout en cliente Http de 10 segundos. Esto puede cambiar según la necesidad de proyecto.

Versión: 0.13.5
### [Drift](https://drift.simonbinder.eu/) - Persistencia de datos
Para la base de datos se usó Drfit ya que es una biblioteca de persistencias que nos brinda una capa de abstracción para SQLite permitiendo acceder a la base de datos fácilmente.

Versión: 2.5.0
### [Injectable](https://pub.dev/packages/injectable) - Inyección de dependencias
Para realizar la inyección de dependencias se usó la librería por medio de etiquetas y auto generación de código, junto con [GetIt](https://pub.dev/packages/get_it).

Versión: 2.1.0
### [GetIt](https://pub.dev/packages/injectable) - Localizador de servicios
Integrado con [Injectable](https://pub.dev/packages/injectable) permite realizar inyección de dependencias.

Versión: 7.2.0
### [Shared Preferences](https://pub.dev/packages/shared_preferences) - Shared preferences
Es un envoltorio específico para cada plataforma (Android - Shared Preferences y iOS - NSUserDefaults), que permite almacenar variables primitivas con datos no sensibles del usuario usando un mapa de llave-valor.

Versión: 2.0.18
### [Path](https://pub.dev/packages/path) y [Path Provider](https://pub.dev/packages/path_provider) - Manipulación de rutas
Para manipular y acceder a rutas del sistema de archivos. Principalmente usado para la ubicación de la base de datos local.

Versión Path: 1.8.2
Versión Path Provider: 2.0.0
### [Equatable](https://pub.dev/packages/equatable) - Comparación de objetos
Para mejorar la comparación de objetos y evitar posibles errores por diferencia de referencias para objetos con los mismos atriubutos.

Versión: 2.0.5
### [Flutter BLoC](https://pub.dev/packages/flutter_bloc) - Para manejar el estado de las vistas
Para almacenar y administrar datos relacionados con la IU de manera optimizada para los ciclos de vida.

Versión: 8.0.0
### [internet_connection_checker](https://pub.dev/packages/internet_connection_checker) -internet connection checker
Una biblioteca de Pure Dart Utility que verifica si hay una conexión a Internet activa al abrir un socket en una lista de direcciones específicas, cada una con un puerto y un tiempo de espera individuales.

version: 1.0.0+1
### [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) - Flutter Secure Storage
Es una biblioteca usada para guardar datos de forma segura usando keychain para iOS y keyStore para android.

Versión: 8.0.0
### [Firebase Analytics](https://pub.dev/packages/firebase_analytics) - Firebase Analytics
Google Analytics es una solución de medición de apps, que proporciona estadísticas sobre el uso de las apps y la participación de los usuarios.

Version 10.2.0
### [Firebase Core](https://pub.dev/packages/firebase_core) - Firebase Core
Un complemento de Flutter para usar Firebase Core API, que permite conectarse a varias aplicaciones de Firebase.

Version 2.8.0
### [Firebase Crashlytics](https://pub.dev/packages/firebase_crashlytics) - Firebase Crashlytics
Un complemento de Flutter para usar la API de Firebase Crashlytics.

Version 3.1.0
### [Firebase Auth](https://pub.dev/packages/firebase_auth) - Firebase Auth
Un complemento de Flutter para usar la API de autenticación de Firebase.

Version 4.3.0

### [Mocktail](https://pub.dev/packages/mocktail) - Crear Mocks de objetos en Testing
Permite la creación de objetos dobles de prueba en pruebas unitarias automatizadas con el propósito de desarrollo basado en pruebas o desarrollo basado en comportamiento. No necesita generación de código.

Versión: 0.3.0
### [Bloc Test](https://pub.dev/packages/bloc_test) - Para realizar pruebas a nuestros BLoCs
Una biblioteca para poder testear nuestros BLoCs.

Versión: 9.1.1
### [Very Good Analysis](https://pub.dev/packages/very_good_analysis) - Very Good Analysis
Es una herramienta con reglas definidas para analizar el código con el fin de encontrar errores de sintaxis, código incorrecto o malas prácticas, siguiendo las mejores prácticas para el lenguaje Dart.

Versión: 3.1.0
### [json annotation](https://pub.dev/packages/json_annotation) - json annotation
Define las anotaciones utilizadas por json_serializable para crear código para la serialización y deserialización de JSON.

Versión: 4.8.0
### [json serializable](https://pub.dev/packages/json_serializable) - json serializable
Proporciona constructores de Dart Build System para manejar JSON.
Los constructores generan código cuando encuentran miembros anotados con clases definidas en package:json_annotation.

Versión: 6.6.1


**Nota:** Se recomienda actualizar las versiones de las dependencias del bloque al iniciar un nuevo proyecto.

## Versión

**Version name :** 1.0

## Recomendaciones
* Verificar en los archivos analysis_options.yaml de cada módulo las reglas usadas para el análisis de código que más se adapten a tu proyecto.
* Establecer un correo electrónico para mensajes de fallo en post -> failure en el archivo Jenkisfile
* Convertir el modelo de Movie (Domain) en un agregado y crear su Factory o Data Builder correspondiente.
* Crear Test Data Builder de Movie DTO y su Factory correspondiente.
* Actualmente se muestran errores técnicos al usuario.
## Retos a futuro
* Internalización a los mensajes que vengan en las excepciones.
