
# Instalação  -------------------------------------------------------------

install.packages("dplyr")
install.packages("ggplot2")
install.packages("readr")
install.packages("readxl")


library(dplyr)
library(ggplot2)
library(readr)
library(readxl)

# Importação do Dataset ---------------------------------------------------

base1 <- read_xls("datatran2024.xls")

View(base1)

# Manipulação dos Dados ---------------------------------------------------

# 04 Primeiras linhas 
head(base1,4)

# 04 Últimas linhas 
tail(base1,4)



colMeans(base1[, c("km", "pessoas", "feridos", "feridos_leves", "mortos")], 
         na.rm = TRUE)



# Média dos Valores:
mean(base1$pessoas, na.rm = TRUE)
mean(base1$feridos, na.rm = TRUE)
mean(base1$feridos_leves, na.rm = TRUE)
mean(base1$mortos, na.rm = TRUE)
mean(base1$km, na.rm = TRUE)

# Soma dos Valores:
sum(base1$pessoas, na.rm = TRUE)
sum(base1$feridos, na.rm = TRUE)
sum(base1$mortos, na.rm = TRUE)

# Desvio Padrão (Pessoas)
sd(base1$pessoas, na.rm = TRUE)
# Desvio Padrão (Mortos)
sd(base1$mortos, na.rm = TRUE)
# Desvio Padrão (Feridos)
sd(base1$feridos, na.rm = TRUE)
# Desvio Padrão (Feridos Leves)
sd(base1$feridos_leves, na.rm = TRUE)
# Desvio Padrão (Feridos Graves)
sd(base1$feridos_graves, na.rm = TRUE)


# Valores Máximas (Pessoas)
max(base1$pessoas, na.rm = TRUE)
# Valores Máximas (Mortos)
max(base1$mortos, na.rm = TRUE)
# Valores Máximas (Feridos)
max(base1$feridos, na.rm = TRUE)
# Valores Máximas (Feridos Leves)
max(base1$feridos_leves, na.rm = TRUE)
# Valores Máximas (Feridos Graves)
max(base1$feridos_graves, na.rm = TRUE)



# Valores Mínimos (Pessoas)
min(base1$pessoas, na.rm = TRUE)
# Valores Mínimos (Mortos)
min(base1$mortos, na.rm = TRUE)
# Valores Mínimos (Feridos)
min(base1$feridos, na.rm = TRUE)
# Valores Mínimos (Feridos Leves)
min(base1$feridos_leves, na.rm = TRUE)
# Valores Mínimos (Feridos Graves)
min(base1$feridos_graves, na.rm = TRUE)




# Agrupamento entre Colunas, baseado no UF: 

base1 %>%
  group_by(uf) %>%
  summarise(
    total_pessoas = sum(pessoas, na.rm = TRUE),
    total_feridos = sum(feridos, na.rm = TRUE),
    total_mortos = sum(mortos, na.rm = TRUE),
    media_km = mean(km, na.rm = TRUE)
  )


# Agrupamento entre Colunas, baseado no Causa Acidente: 

base1 %>%
  group_by(causa_acidente) %>%
  summarise(
    total_pessoas = sum(pessoas, na.rm = TRUE),
    total_feridos = sum(feridos, na.rm = TRUE),
    total_mortos = sum(mortos, na.rm = TRUE),
    media_km = mean(km, na.rm = TRUE)
  )


# Agrupamentos por Causa de Acidente 

base1 %>%
  group_by(causa_acidente) %>%
  summarise(
    total_pessoas = sum(pessoas, na.rm = TRUE),
    total_feridos = sum(feridos, na.rm = TRUE),
    total_mortos = sum(mortos, na.rm = TRUE),
    media_km = mean(km, na.rm = TRUE)
  )


# Calculando a Probabilidade de Acidentes por Hora:

prob_hora <- base1 %>%
  group_by(hora_num) %>%
  summarise(acidentes = n()) %>%
  mutate(
    probabilidade = acidentes / sum(acidentes),
    prob_percentual = probabilidade * 100
  )

prob_hora


dist_hora <- base1 %>%
  group_by(hora_num) %>%
  summarise(acidentes = n()) %>%
  mutate(probabilidade = acidentes / sum(acidentes))

hora_pico <- dist_hora %>%
  filter(acidentes == max(acidentes))

hora_pico


# Calculando a Probabilidade de Acidentes por Período: 
base1$periodo <- ifelse(base1$hora_num >= 6 & base1$hora_num < 18,
                        "Dia", "Noite")



dist_periodo <- base1 %>%
  group_by(periodo) %>%
  summarise(acidentes = n()) %>%
  mutate(probabilidade = acidentes / sum(acidentes))

dist_periodo


# Visualização dos Dados --------------------------------------------------

ggplot(dist_hora, aes(x = hora_num, y = acidentes)) +
  geom_col(fill = "steelblue") +
  geom_col(data = hora_pico, fill = "red") +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Distribuição de Acidentes por Hora do Dia",
    subtitle = paste("Hora de maior risco:", hora_pico$hora_num, "h"),
    x = "Hora do Dia",
    y = "Número de Acidentes",
    caption = "Fonte: Base DATATRAN 2024"
  ) +
  theme_minimal(base_size = 14)


ggplot(dist_periodo, aes(x = periodo, y = acidentes, fill = periodo)) +
  geom_col() +
  labs(
    title = "Distribuição de Acidentes: Dia vs Noite",
    x = "Período",
    y = "Número de Acidentes"
  ) +
  theme_minimal(base_size = 10) +
  theme(legend.position = "none") 

library(ggplot2)


ggplot(dist_hora, aes(x = hora_num, y = acidentes)) +
  geom_col(fill = "steelblue") +
  geom_col(data = hora_pico, fill = "red") +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Distribuição de Acidentes por Hora do Dia",
    subtitle = paste("Hora de maior risco:", hora_pico$hora_num, "h"),
    x = "Hora do Dia",
    y = "Número de Acidentes",
    caption = "Fonte: Base DATATRAN 2024"
  ) +
  theme_minimal(base_size = 14)



# Respondendo Insights ----------------------------------------------------


# Classificação de Estados com mais Acidentes: 
acidentes_estado <- base1 %>%
  group_by(uf) %>%
  summarise(total_acidentes = n()) %>%
  arrange(desc(total_acidentes))

acidentes_estado

# Probabilidade de Acidente, considerando a Fase do Dia:
fase_dist <- base1 %>%
  group_by(fase_dia) %>%
  summarise(acidentes = n()) %>%
  mutate(probabilidade = acidentes / sum(acidentes)) %>%
  arrange(desc(acidentes))

fase_dist

# Tipo de Acidentes Predominantes: 
tipo_dist <- base1 %>%
  group_by(tipo_acidente) %>%
  summarise(acidentes = n()) %>%
  arrange(desc(acidentes))

tipo_dist



# Causas Predominantes em Acidentes:
causa_dist <- base1 %>%
  group_by(causa_acidente) %>%
  summarise(acidentes = n()) %>%
  arrange(desc(acidentes))

causa_dist



















library(dplyr)
library(ggplot2)

# Gráfico de Acidentes por Estado: 
graf_estado <- base1 %>%
  group_by(uf) %>%
  summarise(acidentes = n()) %>%
  arrange(desc(acidentes))

ggplot(graf_estado, aes(x = reorder(uf, acidentes), y = acidentes)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Número de Acidentes por Estado",
    x = "Estado (UF)",
    y = "Número de Acidentes",
    caption = "Fonte: DATATRAN 2024"
  ) +
  theme_minimal(base_size = 14)





# Gráfico - Probabilidade de Acidentes por Condição Climática:
graf_clima <- base1 %>%
  group_by(condicao_metereologica) %>%
  summarise(acidentes = n()) %>%
  mutate(probabilidade = acidentes / sum(acidentes))

ggplot(graf_clima, aes(x = reorder(condicao_metereologica, acidentes), 
                       y = probabilidade)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(
    title = "Probabilidade de Acidentes por Condição Climática",
    x = "Condição Climática",
    y = "Probabilidade",
    caption = "Fonte: DATATRAN 2024"
  ) +
  theme_minimal(base_size = 14)


# Gráfico de Distribuição Acidentes Por Fase do Dia:
graf_fase <- base1 %>%
  group_by(fase_dia) %>%
  summarise(acidentes = n())

ggplot(graf_fase, aes(x = fase_dia, y = acidentes, fill = fase_dia)) +
  geom_col() +
  labs(
    title = "Distribuição de Acidentes por Fase do Dia",
    x = "Fase do Dia",
    y = "Número de Acidentes"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")









# Gráfico de Distribuição Por Tipo de Acidentes:
graf_tipo <- base1 %>%
  group_by(tipo_acidente) %>%
  summarise(acidentes = n()) %>%
  arrange(desc(acidentes))

ggplot(graf_tipo[1:10, ], 
       aes(x = reorder(tipo_acidente, acidentes), y = acidentes)) +
  geom_col(fill = "firebrick") +
  coord_flip() +
  labs(
    title = "Top 10 Tipos de Acidentes",
    x = "Tipo de Acidente",
    y = "Número de Ocorrências"
  ) +
  theme_minimal(base_size = 14)


# Gráfico de Distribuição Por Principais Causas de Acidentes:
graf_causa <- base1 %>%
  group_by(causa_acidente) %>%
  summarise(acidentes = n()) %>%
  arrange(desc(acidentes))

ggplot(graf_causa[1:10, ], 
       aes(x = reorder(causa_acidente, acidentes), y = acidentes)) +
  geom_col(fill = "orange") +
  coord_flip() +
  labs(
    title = "Top 10 Causas de Acidentes",
    x = "Causa do Acidente",
    y = "Número de Ocorrências"
  ) +
  theme_minimal(base_size = 14)
