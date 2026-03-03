📊 Análise de Acidentes Rodoviários – DATATRAN 2024

📌 Objetivo

Este projeto tem como objetivo analisar o padrão de ocorrência de acidentes rodoviários no Brasil utilizando a base de dados DATATRAN 2024, por meio da linguagem R.

A análise busca responder às seguintes questões:

- Qual foi o estado com maior número de acidentes?
- Qual a probabilidade de um acidente ocorrer em condições climáticas claras?
- Como a fase do dia influencia a ocorrência de acidentes?
- Quais são os tipos de acidentes predominantes e suas principais causas?

---
🗂 Base de Dados

Os dados utilizados são provenientes do sistema DATATRAN (Polícia Rodoviária Federal), contendo registros detalhados sobre acidentes em rodovias federais brasileiras.

Principais variáveis analisadas:

- `uf` – Estado da ocorrência
- `horario` – Horário do acidente
- `fase_dia` – Fase do dia
- `condicao_metereologica` – Condição climática
- `tipo_acidente` – Tipo do acidente
- `causa_acidente` – Causa principal
- `pessoas`, `feridos`, `mortos` – Indicadores de severidade

---

🛠 Tecnologias Utilizadas

- R
- dplyr
- ggplot2
- readxl

---

📈 Principais Resultados

🔹 Distribuição Geográfica
Foi identificado o estado com maior concentração de acidentes, possivelmente associado ao fluxo rodoviário e extensão da malha federal.

🔹 Condições Climáticas
A maior parte dos acidentes ocorreu sob céu claro, indicando que volume de tráfego pode ter maior impacto do que condições adversas.

🔹 Fase do Dia
Observou-se variação significativa na ocorrência de acidentes entre períodos do dia, com destaque para horários de maior risco.

🔹 Tipologia e Causas
Colisões traseiras e causas associadas à falta de atenção aparecem entre as mais recorrentes, sugerindo forte influência comportamental.

---

📊 Exemplos de Análises Realizadas

- Probabilidade empírica de acidentes por hora
- Distribuição por estado
- Comparação dia vs noite
- Ranking dos principais tipos de acidentes
- Ranking das principais causas

---

📂 Estrutura do Projeto
