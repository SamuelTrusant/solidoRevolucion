# Sólido de revolución
programa que crea un sólido de revolución.

Autor: Samuel Trujillo Santana.

## Descripción
El programa permite crear un sólido de revolución. El programa muestra inicialmente una pantalla partida por la mitad, con una línea que representa el eje de rotación. El usuario dibujará en el lado derecho el perfil que tendrá el objeto, posteriormente pulsará "enter" y la figura se creará. La aplicación permite una vez creada la figura, moverla con el ratón mantenidendo el botón izquierdo para rotara y el derecho para escalar.

Adicionalmente permite resetear la figura una vez creada o en medio del proceso para empezar de nuevo. Durante la creación del perfil el usuario puede pulsar el botón derecho del ratón para borrar el último punto.

## trabajo realizado
El programa posee técnicamente tres modos: la pantalla de ayuda, el modo creación y el modo vista, y existe una variable entera de nombre "modo" que indica el modo actual:

El modo creación permite ir seleccionando los puntos para ir dibujando el perfil del objeto, el cuál se va mostrando en pantalla. Cada vez que el usuario hace click se guarda la posición X del ratón en una lista y la posición Y en otra. El programa seguirá en este modo hasta que el usuario pulse "enter" para pasar al modo vista.

En la transición entre el modo creación y el modo vista se llama al método createFigure que crea un conjunto de tiras de triángulos en una posición que va rotando hasta dar una vuelta entera.

El modo vista impide seguir dibujando pero permite mover la figura arrastrando el ratón mientras mantienes el botón izquierdo pulsado para rotarla, y el derecho para escalarla.

La pantalla de ayuda indica los controles y se puede llamar en cualquier momento con la tecla 'h' y al pulsar enter volverá al estado anterior del programa.

## Vista del programa funcionando

![](export.gif)

## Referencias

Guión de prácticas de CIU

Referencias Processing https://processing.org/reference/

Librería sound https://processing.org/reference/libraries/sound/

Librería GifAnimation https://github.com/extrapixel/gif-animation
