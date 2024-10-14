# Instalar las librerías necesarias si no las tienes
install.packages(c("readxl", "ggplot2", "RColorBrewer" ))

# Cargar las librerías
library(readxl)
library(ggplot2)
library(RColorBrewer)  # Paleta de colores

# Leer el archivo Excel
#ka14 <- read.table("C:/Users/TuUsuario/Documentos/2_Q_Laboratorio_de_Implementación_I/Experimento_Colaborativo/Equipo/tb_ganancias_KA14.txt", header = TRUE, sep = "\t")
dir_base <- file.path(dirname(rstudioapi::getSourceEditorContext()$path), "")
# Concatenar el directorio con el nombre del archivo
ruta_archivo <- file.path(dir_base, "base para test de wilcoxon.xlsx")
#ruta_archivo <- "ruta/a/tu/archivo.xlsx"  # Cambia esta ruta por la correcta
datos <- read_excel(ruta_archivo)

# Verificar la estructura del archivo (opcional)
head(datos)

# Visualizar un boxplot para la distribución de ganancias por modelo
ggplot(datos, aes(x = modelo, y = ganancia, fill = modelo)) +
  geom_boxplot() +
  theme_minimal() +
  labs(
    title = "Distribución de Ganancias por Modelo",
    x = "Modelo",
    y = "Ganancia"
  ) +
  scale_fill_brewer(palette = "Blues")  # Escala de colores en tonos de azul

