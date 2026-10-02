# UNPHU-SSIANO — Buscador de destinos de demostración

Fecha: 30 de septiembre de 2026. Incremento de E03, paso 02.
Base registrada antes del buscador: commit `5646686` de la rama
`feat/inicio-ssiano`.

## Avance anterior comprobado

La pantalla de inicio y la pantalla inicial de MAP se visualizaron en el emulador
el 28 de septiembre. El 30 de septiembre se confirmó, antes de este cambio:

- `flutter analyze`: `No issues found!`, en 4,1 segundos.
- `flutter test`: `+1: All tests passed!`, en 13 segundos.
- Repositorio sin cambios pendientes; la rama y la referencia local de origin
  apuntaban a `5646686`.

Estos resultados corresponden al paso 01, anterior al buscador.

## Cambio del paso 02

En `lib/main.dart`, la clase `CampusMapPage` pasa a ser un `StatefulWidget`.
Su estado conserva el texto de búsqueda y filtra cinco destinos ficticios que
permanecen en memoria. El inicio de la aplicación conserva su diseño.

La búsqueda coincide con fragmentos del nombre o código, ignora mayúsculas y
espacios al principio o al final. Una consulta vacía muestra todos los destinos.
El botón Limpiar búsqueda vacía el campo y restablece la lista. El contador de
resultados y el mensaje sin coincidencias describen el estado actual.

El catálogo usa exclusivamente Edificio A, Edificio B, Biblioteca, Aula A-101 y
Aula B-202 como datos de demostración. Los avisos de la pantalla y de cada
resultado identifican que son ficticios; no representan el directorio de UNPHU.
Las tarjetas presentan resultados. La selección de destino, los detalles y las
rutas se desarrollarán en incrementos posteriores.

## Aplicación del cambio

1. Abrir el archivo `C:\Users\jesus\develop\unphu_ssiano\lib\main.dart`.
2. Sustituir la clase final `CampusMapPage` por `CampusMapPage` y
   `_CampusMapPageState` del paso 02. También se incluye el archivo completo de
   referencia, reconstruido a partir del diff suministrado por Jesús.
3. Actualizar `test/widget_test.dart` con la prueba de navegación ajustada y la
   prueba nueva de búsqueda.
4. Guardar esta guía en `docs` dentro del proyecto.
5. Ejecutar, desde la carpeta del proyecto:

```powershell
dart format lib/main.dart test/widget_test.dart
flutter analyze
flutter test
```

Se esperan dos pruebas superadas. Si algún comando falla, revisar su salida
antes de guardar el siguiente commit.

6. Desde el 30 de septiembre, Jesús eligió su Samsung como dispositivo principal
   para el desarrollo. Conectarlo por USB, autorizar la depuración en su PC y
   comprobar que aparece con `flutter devices`. Detener una ejecución anterior
   con `q` en su terminal antes de iniciar la siguiente:

```powershell
flutter run -d RFCY90LHZBH
```

El identificador corresponde al Samsung conectado por USB en la comprobación
del 30 de septiembre. Si cambia el dispositivo o el tipo de conexión, usar el
identificador que muestre `flutter devices`.

## Casos de comprobación

| Acción | Resultado esperado |
| --- | --- |
| Abrir MAP sin escribir | Aviso de demostración y cinco destinos. |
| Escribir `  AULA  ` | Dos aulas y contador de dos resultados. |
| Escribir `a-101` | Solo Aula A-101 y contador de un resultado. |
| Escribir `zzzz` | Cero resultados y mensaje sin coincidencias. |
| Pulsar Limpiar búsqueda | Campo vacío y cinco resultados. |
| Volver al inicio | Pantalla inicial conservada. |

## Verificación registrada el 30 de septiembre de 2026

La captura del emulador aportada por Jesús muestra el buscador, el aviso de
destinos ficticios, el contador de cinco resultados y las cinco tarjetas.

Después, la salida de `flutter devices` confirmó la conexión del Samsung
SM A366E, Android 16 (API 36), arquitectura android-arm64. Jesús informó que
la aplicación se instaló, abrió y funcionó en ese teléfono. También confirmó
que completó satisfactoriamente las cuatro acciones manuales solicitadas:

| Acción en el Samsung | Resultado confirmado por Jesús |
| --- | --- |
| Escribir `AULA` | Aparecen las dos aulas. |
| Escribir `a-101` | Aparece únicamente Aula A-101. |
| Escribir `zzzz` | Aparecen cero resultados y el mensaje sin coincidencias. |
| Pulsar la X del buscador | El campo queda vacío y vuelven los cinco destinos. |

Esta confirmación manual no incluye una comprobación específica de espacios
externos en la consulta, navegación de regreso, rendimiento o accesibilidad.

El análisis estático y las dos pruebas automatizadas del paso 02 están
pendientes de registrar: todavía no se ha recibido su salida. Los resultados
del paso 01 consignados al comienzo pertenecen a la versión anterior.

Flutter y Dart no están instalados en el entorno que preparó estos archivos;
las verificaciones de ejecución se realizan en el equipo de Jesús.
El identificador del commit del buscador está pendiente de confirmar.

## Cierre del incremento

Antes del commit, registrar los resultados reales de `flutter analyze` y
`flutter test` del paso 02. Se esperan un análisis sin incidencias y dos pruebas
superadas. Guardar juntos `lib/main.dart`, `test/widget_test.dart` y esta guía.
Después, registrar el identificador del commit en la bitácora de avances.

El siguiente incremento previsto permitirá seleccionar un destino y consultar
sus detalles, manteniendo la búsqueda al volver a la lista. Los datos seguirán
identificados como ficticios hasta disponer de información verificada del campus.

## Conceptos utilizados

`onChanged` recibe el texto introducido; `setState` solicita actualizar la
interfaz. `where` selecciona las coincidencias. El controlador permite limpiar
el campo y se libera en `dispose` cuando se retira la pantalla.

Referencias:

- https://docs.flutter.dev/cookbook/forms/text-field-changes
- https://api.flutter.dev/flutter/widgets/State/setState.html
