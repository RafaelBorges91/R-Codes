
install.packages("dplyr")
install.packages("ggplot2")
install.packages("readr")

# Carregar bibliotecas
library(dplyr)
library(ggplot2)
library(readr)
library(readxl)

base2 <- read_xls("datatran2024.xls")

View(base2)

# Definindo as variáveis: 
tabela_clima <- table(base2$condicao_metereologica,
                      base2$fase_dia)

teste_chi <- chisq.test(tabela_clima)

teste_chi
print(teste_chi)

# Intervalo de Confiança:

t.test(base2$veiculos, conf.level = 0.95)

# Correlação:
cor.test(base2$veiculos, base2$feridos)




















