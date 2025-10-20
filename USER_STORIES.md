# 📖 User Stories - Authentication Module

This document details all user stories for the Authentication Module based on the official requirements document.

---

## Module: Auth

### Priority Legend
- 🔴 **High**: Critical features for MVP
- 🟡 **Medium**: Important but not blocking
- 🟢 **Low**: Nice to have

---

## HU_001_FE/BE: Elementos de identificación 🔴

### User Story
**Como** usuario de la app  
**Quiero** poder identificar dentro de mis aplicaciones a ForeverUSinlove  
**Para** acceder rápidamente a la aplicación

### Acceptance Criteria

#### Happy Path
1. ✅ La app debe mostrar el logo propio del proyecto
   - Nota: Si el cliente cuenta con un favicon en una página web paralela, ambos logos deben ser sinérgicos
2. ✅ El nombre de la aplicación debe ser visible e iniciar con letra capitular
3. ✅ Se debe presentar una splash screen que transicione al usuario del icono a la app
4. ✅ El usuario debe observar la pantalla de bienvenida con las opciones:
   - Login
   - Crear cuenta
   - Cambiar contraseña
5. ✅ Se debe pedir acceso a los siguientes permisos:
   - Notificaciones
   - Cámara
   - Ubicación

#### Design Details
- La splash screen debe ser responsive ante distintos tipos de celular
- Transición limpia sin cambios de tamaño o proporción
- La app no debe permitir la rotación de la pantalla nativa del celular

#### Error Handling
- **Sin permisos de notificaciones**: "Verifica tus permisos"
- **Sin permisos de cámara**: Mensaje al intentar FaceID o subir fotos
- **Sin permisos de ubicación**: Inhabilitar filtro por zona ft o km
- **Sin conexión desde splash**: "¡Ups! Something was wrong. Check your conexión."

---

## HU_002_FE/BE: Crear cuenta 🔴

### User Story
**Como** usuario de la app  
**Quiero** registrarme en la plataforma  
**Para** poder acceder a todas las funcionalidades del marketplace

### Acceptance Criteria

#### Step 1: Información Personal

**Progress Bar**: Posición 1

**Campos del formulario**:

| Campo | Tipo | Validación | Max Length |
|-------|------|------------|------------|
| Nombre(s) | Alfanumérico | Requerido | 25 caracteres |
| Apellido(s) | Alfanumérico | Requerido | 25 caracteres |
| Número de celular | Numérico | Requerido, 10 dígitos | 10 caracteres |
| Correo | Email | Requerido, formato válido | 100 caracteres |
| Fecha de nacimiento | Fecha | Requerido, 18+ años | 8 caracteres |
| Género | Radio button | Requerido | - |
| Intereses | Radio button | Requerido | - |
| Contraseña | Alfanumérico | Requerido, 8+ chars | 25 caracteres |
| Confirmar contraseña | Alfanumérico | Debe coincidir | 25 caracteres |

**Opciones de Género**: Man, Woman, No Binari  
**Opciones de Intereses**: Man, Woman, Man and Woman

**Características adicionales**:
- ✅ Botón de "ojito" para ocultar/desocultar contraseñas
- ✅ Checkbox para aceptar términos y condiciones y políticas de tratamiento de datos
- ✅ Enlaces a "términos y condiciones de uso" y "políticas de tratamiento de datos"
- ✅ Botón "Continuar" se habilita cuando todos los campos están completos
- ✅ Mensaje informativo sobre requisitos de contraseña:
  - "La contraseña debe tener al menos 8 caracteres incluyendo una mayúscula, una minúscula y un número"
  - **Nota**: No se requieren caracteres especiales (especialmente útil para personas de edad avanzada)

#### Step 2: Verificación OTP

**Progress Bar**: Posición 2

**Campos del formulario**:

| Campo | Tipo | Validación | Length |
|-------|------|------------|--------|
| Código de verificación | Numérico | Requerido | 4 caracteres |

**Comportamiento**:
- ✅ El usuario recibe código por SMS/Email
- ✅ Formato del mensaje: "¡Hola! Tu código de verificación en ForeverUSinlove es: 1234"
- ✅ Código expira en 10 minutos
- ✅ Botón "Reenviar código" se activa después de 30 segundos
- ✅ Mensaje de cuenta regresiva: "Podrás reenviar el código en 30 s."
- ✅ Mensaje de éxito al reenviar:
  - SMS: "Te hemos enviado un nuevo código de validación por SMS/OTP"
  - Email: "Te hemos enviado un nuevo correo de validación"
- ✅ Si validación exitosa → Activar botón "Crear cuenta"
- ✅ Al crear cuenta exitosamente → Redirigir al home

**Nota importante**: Si el usuario abandona el proceso en este paso, deberá reiniciar desde cero ya que la cuenta no se creó.

#### Design Details
- Botón se activa solo cuando campos obligatorios estén completos
- Contraseña con icono para ocultar/desocultar
- Mensajes de error en rojo debajo de cada campo
- Mensajes de éxito en verde
- Diseño responsive para dispositivos móviles
- Campos de texto con límite visual establecido
- Botón "Crear cuenta" debe tener color que resalte

#### Error Handling

| Condición | Mensaje |
|-----------|---------|
| Menor de 18 años | "Se requiere ser mayor de 18 años" |
| Campo vacío | "Este campo es obligatorio" |
| Número inválido (formato o extensión) | "El número no es válido" |
| Email inválido | "El correo no es válido" |
| Código incorrecto/incompleto | "El código no es válido" |
| Error al crear cuenta | "¡Ups! Se presentó un error al realizar esta acción, inténtalo de nuevo" |
| Error al enviar código | "Hubo un error al enviar tu código de verificación. Por favor, inténtalo más tarde" |
| Número ya registrado | "El número ya se encuentra registrado" (Solo si finalizó proceso OTP) |
| Código expirado | "El código ha expirado. Inténtalo de nuevo" |
| Contraseña no cumple requisitos | Resaltar requisitos en rojo |
| Contraseñas no coinciden | "Las contraseñas no coinciden" |

**Notas adicionales**:
- Todo popup debe tener opción de cerrarse con X
- Campos numéricos no deben permitir comas, puntos o guiones (especialmente Android)
- Usuario con cuenta eliminada debe poder crear cuenta nueva con mismo número

---

## HU_003_BE/FE: Verificar identidad 🔴

### User Story
**Como** usuario de ForeverUSinlove  
**Quiero** verificar mi identidad mediante reconocimiento facial (Face ID) y fotos de mi DNI por ambos lados  
**Para** garantizar la autenticidad de mi cuenta y la seguridad dentro de la plataforma

### Acceptance Criteria

#### Step 3: Face ID Verification

**Progress Bar**: Posición 3

**Características**:
- ✅ Opción "Omitir" disponible con advertencia sobre repercusiones
- ✅ Modal de confirmación con botones "Cancelar" y "Continuar"
- ✅ Flujo guiado con cámara activa
- ✅ Sistema captura automáticamente el rostro
- ✅ Validación de coincidencias con datos del documento
- ✅ Interfaz clara con progreso (1/3 Captura de rostro, 2/3 Frente del documento, 3/3 Reverso del documento)
- ✅ Botones para repetir captura en caso de:
  - Baja iluminación
  - Desenfoque
  - Movimiento excesivo
- ✅ Marco ovalado o guía visual para posición correcta
- ✅ Mensajes de éxito/error
- ✅ Botón "Continuar" activado cuando FaceID es correcto

#### Step 4: ID Verification

**Características**:
- ✅ Opción "Omitir" disponible con advertencia
- ✅ Subida o captura en tiempo real de fotos DNI (anverso y reverso)
- ✅ Validaciones automáticas:
  - Nitidez
  - Tamaño
  - Orientación
- ✅ Bloqueo de avance si:
  - No se detecta rostro humano
  - Fotos no cumplen parámetros de legibilidad
- ✅ Iconografía diferenciada para Face ID vs Fotos DNI
- ✅ Alertas si:
  - Usuario sube dos veces la misma imagen
  - Interrumpe cámara durante proceso
- ✅ Manejo de errores de cámara con flujo de reintento
- ✅ Validación de datos DNI vs cuenta registrada
- ✅ Envío seguro por HTTPS (sin almacenamiento local sin cifrar)
- ✅ Botón "Continuar" activado cuando verificación es correcta

#### Design Details
- Loader durante verificación de rostro o DNI
- Opción de previsualización de imagen
- Opción de tomar nueva captura/foto
- Mensajes de éxito y error generalizados

#### Error Handling - Face ID

| Error | Descripción |
|-------|-------------|
| Conexión | Fallo de conexión o tiempo de espera agotado |
| Detección rostro | No se reconoce cara humana o está fuera del marco |
| Coincidencia | Baja similitud entre rostro capturado y foto DNI |

#### Error Handling - ID Verification

| Error | Descripción |
|-------|-------------|
| Foto borrosa | Poca iluminación o movimiento durante captura |
| Documento ilegible | Reflejos, enfoque incorrecto, baja resolución |
| Foto mal encuadrada | Invertida, cortada o texto fuera del encuadre |
| Subida duplicada | Usuario carga dos veces el mismo lado del DNI |
| Formato no soportado | Archivo no permitido o tamaño excesivo |
| Error servidor | Problema al procesar o validar imágenes |
| Lectura fallida | No se pueden leer datos del DNI automáticamente |
| Desincronización | Usuario avanza sin completar paso anterior |
| Interrupción proceso | Cierre accidental o pérdida de conexión |
| Error biométrico | Diferencias por expresión o accesorios (gafas, barba) |
| Timeout validación | Tiempo excesivo genera abandono |
| Bloqueo interfaz | Fallo al cambiar de cámara (frontal/trasera) |
| Orientación | Desalineación de rostro o documento |
| Servicio externo | Error en validación o reconocimiento facial |
| Documento diferente | Usuario intenta verificar con documento no registrado |
| Fallo seguridad | Error en cifrado o envío HTTPS |

---

## HU_004_BE/FE: Subir imágenes 🔴

### User Story
**Como** usuario de la app  
**Quiero** poder subir imágenes al crear mi perfil que sean validadas por los sistemas de verificación de identidad

### Acceptance Criteria

#### Omisión de verificación

**Progress Bar**: Posición 4

Si el usuario omitió verificación de identidad:
- ✅ Mensaje de alerta indicando necesidad de verificar identidad para subir fotos
- ✅ Modal con botones "Cancelar" y regresar a verificación
- ✅ Si cancela → Enviar a encuesta de personalidad

#### Subir imagen

**Requisitos**:
- ✅ Mínimo 2 imágenes, máximo 6 imágenes
- ✅ Formatos: .jpg, .jpeg, .png, .webp
- ✅ Tamaño máximo: 5 MB por imagen
- ✅ Sistema compara fotos con recurso FaceID para verificar identidad
- ✅ Vista previa de cada imagen antes de guardar
- ✅ Opción para eliminar imagen cargada
- ✅ Orden de carga (primera = imagen principal)
- ✅ Confirmación visual al cargar exitosamente
- ✅ Previsualización con opción de reordenar (drag & drop o flechas)
- ✅ Impedir avance si no hay al menos 2 imágenes verificadas

#### Design Details
- Área visible con botón "Subir imágenes"
- Opción arrastrar y soltar archivos
- Indicador de progreso durante carga
- Permitir reordenar imágenes arrastrándolas
- Íconos claros para eliminar/reemplazar
- Layout en rejilla (grid) para hasta 4 imágenes en miniaturas
- Resaltar imagen principal
- Diseño responsive móvil/escritorio

#### Error Handling

| Condición | Mensaje |
|-----------|---------|
| Formato no permitido | "Formato no permitido. Solo se aceptan .jpg, .jpeg, .png y .webp" |
| Tamaño excedido | "El archivo excede el peso máximo permitido (5 MB)" |
| Más de 6 imágenes | "Solo se pueden subir hasta 6 imágenes" |
| No pasa verificación FaceID | Alerta específica |
| Pérdida de conexión | Mensaje de error y opción de reintentar |
| Sin imágenes cargadas | "Debes cargar al menos dos imagenes" |

---

## HU_005_FE/BE: Onboarding Profile 🔴

### User Story
**Como** usuario de la app  
**Debo** poder responder cuestionarios de personalidad con diferentes tipos de preguntas  
**Para** que el sistema pueda analizar mis respuestas y ofrecerme resultados personalizados o coincidencias basadas en mi perfil

### Acceptance Criteria

**Progress Bar**: Posición 5

**Características del cuestionario**:
- ✅ Pantalla dedicada con título, descripción y número total de preguntas
- ✅ Página 1: Opción de omitir con advertencia sobre disminución de sinergia para matchs
- ✅ Modal con botones "Cancelar" y "Continuar"
- ✅ Barra/indicador de progreso
- ✅ Preguntas en orden lógico, una por una o por secciones
- ✅ Botones visibles "Siguiente" y "Anterior"
- ✅ Tipos de campos:
  - Texto libre
  - Numérico
  - Opción múltiple (checkbox)
  - Opción única (radio button)
  - Listas desplegables (dropdown)
- ✅ Validación de preguntas obligatorias
- ✅ Guardado de progreso en tiempo real
- ✅ Pantalla resumen con respuestas elegidas
- ✅ Si todos los datos obligatorios completos → Opción de finalizar onboarding
- ✅ Mensaje de éxito
- ✅ Redirección al home

#### Design Details
- Mensajes claros de confirmación al finalizar
- Elementos de entrada con suficiente tamaño táctil
- Tipografía legible y contrastes adecuados
- Permitir revisar y editar respuestas antes de enviar
- Advertencias visuales si intenta avanzar sin responder obligatorias
- Límite de caracteres en campos de texto

#### Error Handling
- Evitar bloqueos/reinicios por error de red (recuperación automática)
- Alertar valores inválidos en campos numéricos
- Mensajes de error para límite de caracteres
- Prevenir envío múltiple (doble clic en botón envío)
- Mensaje claro en caso de fallo servidor
- Opción de salir con confirmación
- Datos cifrados para privacidad
- Compatibilidad con diferentes tamaños de pantalla y SO

---

## HU_006_FE/BE: Iniciar sesión 🔴

### User Story
**Como** un usuario registrado  
**Quiero** poder iniciar sesión en la aplicación de manera fácil y segura  
**Para** acceder a mi cuenta y gestionar mis datos

### Acceptance Criteria

**Opciones de inicio de sesión**:
- ✅ Continue with phone number
- ✅ Continue with email

**Formulario según elección**:

| Campo | Tipo | Validación | Max Length |
|-------|------|------------|------------|
| Número de celular / Correo | Celular o Email | Requerido | 10 (celular) / 100 (email) |
| Contraseña | Alfanumérico | Requerido | 25 caracteres |

**Características adicionales**:
- ✅ Botón "ojito" para ocultar/desocultar contraseña
- ✅ Todos los campos obligatorios
- ✅ Botón habilitado cuando campos completos
- ✅ Si credenciales correctas → Redirigir al home
- ✅ Opciones de inicio con Google y Facebook
- ✅ Si Google/Facebook y no tiene cuenta → Redirigir a Step 1 de registro
- ✅ Checkbox "Recuérdame" para guardar información post registro

#### Design Details
- Diseño responsive móvil
- Enlace "¿Olvidaste tu contraseña?" debajo del formulario
- Enlace "Crear cuenta" si no tiene cuenta
- Textos contenidos dentro de campos definidos

#### Error Handling

| Condición | Mensaje |
|-----------|---------|
| Campo vacío | "Este campo es obligatorio" |
| Celular/contraseña incorrectos | "El número de celular y/o la contraseña no son válidos" |
| OAuth no funcional | "¡Ups! Al parecer no se ha podido realizar esta acción. Intenta más tarde" |
| "Recuérdame" falla | "¡Ups! No logramos acceder a tu cuenta. Inténtalo de nuevo más tarde o haz Log In nuevamente" |
| Error acceso perfil | "¡Ups! Se presentó un error al realizar esta acción, inténtalo de nuevo" |

**Notas**:
- Mensaje de error aplica para números inválidos y no registrados (incluyendo usuarios que no finalizaron OTP)
- Usuarios eliminados deben poder crear cuenta nueva e iniciar sesión

---

## HU_007_FE/BE: Recuperar contraseña 🔴

### User Story
**Como** un usuario registrado  
**Quiero** poder recuperar mi contraseña si la olvido  
**Para** poder restablecer mi acceso a la aplicación

### Acceptance Criteria

#### Paso 1: Identificación

Acceso desde "¿Olvidaste tu contraseña?" en login

**Campos**:

| Campo | Tipo | Validación | Max Length |
|-------|------|------------|------------|
| Número de celular / Correo | Celular o Email | Requerido | 10 (celular) / 100 (email) |

- ✅ Botón "Continuar" se habilita cuando campo completo

#### Paso 2: Verificación OTP

- ✅ Sistema valida que número/correo esté registrado
- ✅ Envío de código de 4 dígitos
- ✅ Mensaje indica que es de ForeverUSinlove
- ✅ Código expira en 10 minutos
- ✅ **Nota**: Usuarios sin proceso OTP completado = no registrado

#### Paso 3: Ingreso de código

- ✅ Campo para código de verificación
- ✅ Si código correcto → Redirigir a pantalla nueva contraseña

#### Paso 4: Nueva contraseña

**Campos**:

| Campo | Tipo | Validación | Max Length |
|-------|------|------------|------------|
| Contraseña | Alfanumérico | Requerido | 25 caracteres |
| Confirmación contraseña | Alfanumérico | Debe coincidir | 25 caracteres |

- ✅ Botón "ojito" para ocultar/desocultar
- ✅ Botón "Restablecer contraseña" habilitado cuando campos completos
- ✅ Mensaje de éxito: "Tu contraseña ha sido restablecida con éxito, ya puedes iniciar sesión nuevamente"
- ✅ Botón "Iniciar sesión" → Redirige a login

**Reenvío de código**:
- ✅ Esperar 30 segundos para activar "Reenviar código"
- ✅ Mensaje de éxito: "Te hemos enviado un nuevo código de validación por SMS"
- ✅ Validar con código más reciente (anular anteriores)

#### Design Details
- Diseño responsive móvil
- Campos obligatorios, botón habilitado al completar
- Mensaje informativo: "La contraseña debe tener al menos 8 caracteres, incluyendo una mayúscula, una minúscula y un número"

#### Error Handling

| Condición | Mensaje |
|-----------|---------|
| Campo vacío | "Este campo es obligatorio" |
| Número inválido | "El número no es válido" |
| Email inválido | "El correo no es válido" |
| Número no registrado | "El Número no es válido" (incluye usuarios sin OTP completado) |
| Email no registrado | "El correo no es válido" (incluye usuarios sin OTP completado) |
| Error recuperación | "¡Ups! Se presentó un error al realizar esta acción, inténtalo de nuevo" |
| Error envío código | "Se presentó un error al realizar esta acción, inténtalo de nuevo" |
| Código expirado | "El código no es válido" |
| Código incorrecto/incompleto | "El código no es válido" |
| Contraseña no cumple requisitos | Resaltar requisitos en rojo |
| Contraseñas no coinciden | "Las contraseñas no coinciden" |

**Notas adicionales**:
- Todo popup debe tener X para cerrar
- Campos numéricos sin comas, puntos o guiones (especialmente Android)
- Al recuperar contraseña, "Recuérdame" debe estar sin seleccionar
- Si usuario pierde número de teléfono → Contactar administrador de ForeverUSinlove

---

## Summary

Este módulo de autenticación incluye:

- ✅ 7 historias de usuario completas
- ✅ Proceso de registro de 6 pasos
- ✅ Verificación de identidad con Face ID y DNI
- ✅ Sistema de OTP con SMS/Email
- ✅ Login tradicional + OAuth (Google/Facebook)
- ✅ Recuperación de contraseña
- ✅ Validaciones exhaustivas
- ✅ Manejo completo de errores
- ✅ UX optimizada para adultos mayores

**Estado**: 🚧 Pendiente de aprobación UI/UX

**Próximos pasos**: 
1. Aprobación de diseños
2. Implementación de pantallas
3. Integración con backend
4. Testing exhaustivo
