# Instalar las librerías necesarias si no las tienes
install.packages(c("readxl", "ggplot2", "RColorBrewer"))

# Cargar las librerías
library(readxl)
library(ggplot2)
library(RColorBrewer)

 
# Leer el archivo Excel
#ka14 <- read.table("C:/Users/TuUsuario/Documentos/2_Q_Laboratorio_de_Implementación_I/Experimento_Colaborativo/Equipo/tb_ganancias_KA14.txt", header = TRUE, sep = "\t")
dir_base <- file.path(dirname(rstudioapi::getSourceEditorContext()$path), "")
# Concatenar el directorio con el nombre del archivo
ruta_archivo <- file.path(dir_base, "base para test de wilcoxon.xlsx")
#ruta_archivo <- "ruta/a/tu/archivo.xlsx"  # Cambia esta ruta por la correcta
datos <- read_excel(ruta_archivo)

# Leer la primera hoja del archivo Excel
datos <- read_excel(ruta_archivo, sheet = 1)

# Crear un gráfico de dispersión (scatter plot) por cada modelo
ggplot(datos, aes(x = ganancia, y = modelo, color = modelo)) +
  geom_point(size = 3, alpha = 0.7) +  # Puntos ajustados
  theme_minimal() +
  labs(
    title = "Gráfico de Dispersión de Ganancias por Modelo",
    x = "Ganancia",
    y = "Modelo"
  ) +
  scale_color_brewer(palette = "Blues")  # Escala en tonos de azul

