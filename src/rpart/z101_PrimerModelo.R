# Arbol elemental con libreria  rpart
# Debe tener instaladas las librerias  data.table ,  rpart  y  rpart.plot
# Correr en Google Cloud con RStudio

# cargo las librerias que necesito
require("data.table")
require("rpart")
require("rpart.plot")

# Aqui se debe poner la carpeta de la materia de SU computadora local
#setwd("/home/alejandra_anconetani/datasets") # Establezco el Working Directory
setwd("~/buckets/b1") # Establezco el Working Directory
##script_paht<- file.path(dirname(rstudioapi::getSourceEditorContext()$path), "")
# cargo el dataset pequeno vivencial del disco local
dataset <- fread("~/buckets/b1/datasets/vivencial_dataset_pequeno.csv")
##dataset <- fread("/home/alejandra_anconetani/datasets/vivencial_dataset_pequeno.csv")

dtrain <- dataset[foto_mes == 202107] # defino donde voy a entrenar
dapply <- dataset[foto_mes == 202109] # defino donde voy a aplicar el modelo

# genero el modelo,  aqui se construye el arbol
# quiero predecir clase_ternaria a partir de el resto de las variables
## iniciales del script LAB
param <- list(
  "cp" = -0.3,
  "minsplit" = 0,
  "minbucket" = 1,
  "maxdepth" = 3
)
## los que voy cambiando para las pruebas 
param <- list(
  "cp" = -0.3,
  "minsplit" = 800,
  "minbucket" = 340,
  "maxdepth" = 30
)

## AA 20-08-2024 

modelo <- rpart(
  formula = "clase_ternaria ~ .",
  data = dtrain, # los datos donde voy a entrenar
  xval = 0,
  control = param
##  cp = -0.5, # esto significa no limitar la complejidad de los splits
##  minsplit = 900, # minima cantidad de registros para que se haga el split
## minbucket = 440, # tamaño minimo de una hoja
## maxdepth = 5  # profundidad maxima del arbol
)
## xval es el parametro de CrossValidation con 0 no lo ejecuta
# grafico el arbol
prp(modelo,
    extra = 101, digits = -5,
    branch = 1, type = 4, varlen = 0, faclen = 0
)
## agregado por AA para imprimir el modelo 
##plotcp (modelo)  

# aplico el modelo a los datos nuevos
prediccion <- predict(
    object = modelo,
    newdata = dapply,
    type = "prob"
)
 
# prediccion es una matriz con TRES columnas,
# llamadas "BAJA+1", "BAJA+2"  y "CONTINUA"
# cada columna es el vector de probabilidades

# agrego a dapply una columna nueva que es la probabilidad de BAJA+2
dapply[, prob_baja2 := prediccion[, "BAJA+2"]]

# solo le envio estimulo a los registros
#  con probabilidad de BAJA+2 mayor  a  1/40
dapply[, Predicted := as.numeric(prob_baja2 > 1 / 40)]

# genero el archivo para Kaggle
# primero creo la carpeta donde va el experimento
dir.create("./exp/")
dir.create("./exp/KA2001")

# solo los campos para Kaggle
fwrite(dapply[, list(numero_de_cliente, Predicted)],
        file = "./exp/KA2001/K101_007_viv.csv",
        sep = ","
)

