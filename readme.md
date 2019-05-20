Visualización avanzada para análisis de correspondencias con R
==============================================================

II Seminario Análisis de datos avanzados en Ciencias de la Salud,
Facultad de Ciencias de la Salud de la Universidad Rey Juan Carlos,
Campus de Alcorcón.

Sesión impartida por Emilio López Cano, 24 de mayo de 2018

Las diapositivas del seminario se encuentran en:
<a href="http://emilio.lcano.com/p/seminariourjc18/" class="uri">http://emilio.lcano.com/p/seminariourjc18/</a>

Más ejemplos y explicaciones en mi libro de apuntes [Análisis de datos
con R](http://emilio.lcano.com/b/adr/) (licencia CC)

Para ver esta página con el código renderizado, imágenes, etc, visita:
<a href="https://emilopezcano.github.io/seminario_urjc_2018/readme.html" class="uri">https://emilopezcano.github.io/seminario_urjc_2018/readme.html</a>

Preparando el entorno
---------------------

Descarga e instala R y RStudio en tu sistema, y en ese orden. Puedes
encontrar las instrucciones y los archivos de instalación en las
siguientes direcciones:

-   <a href="http://www.r-project.org" class="uri">http://www.r-project.org</a>

-   <a href="http://www.rstudio.com" class="uri">http://www.rstudio.com</a>

Después de instalar R y RStudio, abre RStudio y ejecuta el siguiente
código en la consola de RStudio:

    install.packages(c("usethis", "readxl", "FactoMineR", "factoextra", 
                       "dplyr", "gplots", "corrplot", "knitr"))
    usethis::use_course("https://goo.gl/p3DU1Y")

En la consola se mostrarán mensajes de confirmación para descargar los
materiales en un fichero zip. Tras confirmar, el fichero se descarga y
descomprime automáticamente en la carpeta de usuario y se abre el
proyecto RStudio con el que trabajaremos, incluido código y datos, que
hay que descomprimir:

    unzip("datos.zip")
