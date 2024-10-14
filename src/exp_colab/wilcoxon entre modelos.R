# Buscamos path de los resultados de los tres modelos con file.choose(), cargamos los archivos y creamos datasets separados
# para los tres modelos distintos

#path <- file.choose()
#datos <- read.csv(path)
# Leer el archivo Excel
#ka14 <- read.table("C:/Users/TuUsuario/Documentos/2_Q_Laboratorio_de_Implementación_I/Experimento_Colaborativo/Equipo/tb_ganancias_KA14.txt", header = TRUE, sep = "\t")
dir_base <- file.path(dirname(rstudioapi::getSourceEditorContext()$path), "")
# Concatenar el directorio con el nombre del archivo
ruta_archivo <- file.path(dir_base, "base para test de wilcoxon.xlsx")
#ruta_archivo <- "ruta/a/tu/archivo.xlsx"  # Cambia esta ruta por la correcta
datos <- read_excel(ruta_archivo)

modelo_KA14 <- datos[datos$modeloname=="KA14",]
modelo_KA15 <- datos[datos$modeloname=="KA15",]
modelo_KA16 <- datos[datos$modeloname=="KA16",]
modelo_KA17 <- datos[datos$modeloname=="KA17",]
options(scipen = 999)


# Comparamos la línea de mejor ganancia promedio de nuestro modelo_KA16 (2200 envíos) con el resto de las líneas para ver
# si es realmente la mejor. Usamos Wilcoxon.

comparacion_modelo_KA16 <- data.frame(envios=NA,pvalue=NA)
r <- 1

for (i in c(1600,1700,1800,1900,2000,2100,2200)){
  comparacion_modelo_KA16[r,1] <- i
  comparacion_modelo_KA16[r,2] <- wilcox.test(modelo_KA16[modelo_KA16$corte==2200,'ganancia'],
                                              modelo_KA16[modelo_KA16$corte==i,'ganancia'],paired = T)$p.value
  r <- r+1
}

comparacion_modelo_KA16
################################################


# De acuerdo a la evidencia muestral, no podemos afirmar que los 2200 envíos son realmente mejores que 2100,
# 2000 y 1900. No obstante, siendo que debemos elegir alguna línea, nos quedaremos con 2200 porque
# tiene el mayor promedio


# Comparamos nuestro modelo_KA16 con 2200 envíos contra el modelo del workflow base.

comparacion_2200_vs_modeloBase <- data.frame(envios=NA,pvalue=NA)

r <- 1

for (i in c(1600,1700,1800,1900,2000,2100,2200)){
  comparacion_2200_vs_modeloBase[r,1] <- i
  comparacion_2200_vs_modeloBase[r,2] <- wilcox.test(modelo_KA16[modelo_KA16$corte==2200,'ganancia'],
                                                     modelo_KA17[modelo_KA17$corte==i,'ganancia'],paired = F)$p.value
  r <- r+1
}
comparacion_2200_vs_modeloBase

# Podemos observar que nuestro modelo con 2200 envíos siempre es superior al modelo del workflow base (KA17).

################################################


# Comparamos nuestro modelo_KA16 con 2200 envíos contra el modelo KA15.

comparacion_2200_vs_KA15 <- data.frame(envios=NA,pvalue=NA)

r <- 1

for (i in c(1600,1700,1800,1900,2000,2100,2200)){
  comparacion_2200_vs_KA15[r,1] <- i
  comparacion_2200_vs_KA15[r,2] <- wilcox.test(modelo_KA16[modelo_KA16$corte==2200,'ganancia'],
                                                     modelo_KA15[modelo_KA15$corte==i,'ganancia'],paired = F)$p.value
  r <- r+1
}
comparacion_2200_vs_KA15

# Podemos observar que nuestro modelo con 2200 envíos siempre es superior al modelo_KA15.

################################################

comparacion_2200_vs_KA14 <- data.frame(envios=NA,pvalue=NA)

r <- 1

for (i in c(1600,1700,1800,1900,2000,2100,2200)){
  comparacion_2200_vs_KA14[r,1] <- i
  comparacion_2200_vs_KA14[r,2] <- wilcox.test(modelo_KA16[modelo_KA16$corte==2200,'ganancia'],
                                               modelo_KA14[modelo_KA14$corte==i,'ganancia'],paired = F)$p.value
  r <- r+1
}
comparacion_2200_vs_KA14

# Podemos observar que nuestro modelo con 2200 envíos siempre es superior al modelo_KA14, con excepción de 2100 envíos.

