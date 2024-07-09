df <- read.csv(file = "TRABALHO_DE_QUINTA_TA_AQUI_PROFF_AJUDOU.csv", 
               header = FALSE, sep = ";", fileEncoding = "latin1")
View(df)

# Ajustar os nomes das colunas
colnames(df) <- df[1, ]
df <- df[-1, ]

# Substituir vírgulas por pontos nas colunas numéricas
df$value_ibovespa <- as.numeric(gsub(",", ".", df$value_ibovespa))
df$value_nikkei <- as.numeric(gsub(",", ".", df$value_nikkei))
df$value_dji <- as.numeric(gsub(",", ".", df$value_dji))

summary(df)

df <- df[,c("value_ibovespa","value_nikkei", "value_dji")]

# Calcular o desvio padrão (volatilidade) de colunas específicas
sd_values <- lapply(df[, c("value_ibovespa", "value_nikkei", "value_dji")], sd, na.rm = TRUE)
sd_values

# Detecção de outliers usando Z-score
z_scores <- sapply(df[, c("value_ibovespa", "value_nikkei", "value_dji")], function(x) (x - mean(x)) / sd(x))
outliers_zscore <- which(abs(z_scores) > 3)

# Visualizando os outliers
boxplot(df[, c("value_ibovespa", "value_nikkei", "value_dji")])
points(df[outliers_zscore, c("value_ibovespa", "value_nikkei", "value_dji")], col = "red", pch = 16)

length(outliers_zscore)

#Média
mean(df$value_ibovespa)
mean(df$value_nikkei)
mean(df$value_dji)

#Matriz de correlação
cor(df)

require(corrplot)
matcor <- cor(df)

# Definindo margens antes dos histogramas
par(mar = c(4, 2, 2, 4))  # Exemplo de valores para margens (bottom, left, top, right)

# Criando os histogramas
par(mfrow = c(3, 1))  # Define layout com 3 linhas e 1 coluna
hist(df$value_ibovespa, main = "Histograma Ibovespa", xlab = "Valor Ibovespa", col = "green")
hist(df$value_nikkei, main = "Histograma Nikkei", xlab = "Valor Nikkei", col = "red")
hist(df$value_dji, main = "Histograma DJI", xlab = "Valor DJI", col = "blue")

# Renomear as colunas diretamente
colnames(df) <- c("IBOV", "NI225", "DJI")
corrplot(matcor, method="number")

# Gráfico de dispersão de IBOV e NI225
plot(df$IBOV, df$NI225, 
     xlab = "IBOV", ylab = "NI225", 
     main = "Gráfico de Dispersão de IBOV e NI225")

# Gráfico de dispersão de IBOV e DJI
plot(df$IBOV, df$DJI, 
     xlab = "IBOV", ylab = "DJI", 
     main = "Gráfico de Dispersão de IBOV e DJI")

# Gráfico de dispersão de IBOV e date
plot(df$IBOV, df$date, 
     xlab = "IBOV", ylab = "Data", 
     main = "Gráfico de Dispersão de IBOV")


#--------------------------------------------------
#Aplicação de regressão linear
# Instalar e carregar pacotes necessários
install.packages("tidyverse")
install.packages("caret")
install.packages("readr")
install.packages("tseries")
install.packages("urca")
install.packages("glmnet")
library(tidyverse)
library(caret)
library(readr)
library(tseries)
library(urca)
library(glmnet)

df <- read.csv(file = "TRABALHO_DE_QUINTA_TA_AQUI_PROFF_AJUDOU.csv", 
               header = FALSE, sep = ";", fileEncoding = "latin1")
View(df)

# Ajustar os nomes das colunas
colnames(df) <- df[1, ]
df <- df[-1, ]

# Substituir vírgulas por pontos nas colunas numéricas
df$value_ibovespa <- as.numeric(gsub(",", ".", df$value_ibovespa))
df$value_nikkei <- as.numeric(gsub(",", ".", df$value_nikkei))
df$value_dji <- as.numeric(gsub(",", ".", df$value_dji))


# Pré-processamento dos dados
df$date <- as.Date(df$date, format="%Y-%m-%d")

# Remover colunas desnecessárias
df <- df[,c("value_ibovespa","value_nikkei", "value_dji")]

# Renomear as colunas
colnames(df) <- c("IBOV", "NI225", "DJI")

# Dividir os dados em conjuntos de treino e teste
set.seed(123)  # Para reprodutibilidade
train_indices <- createDataPartition(df$IBOV, p = 0.8, list = FALSE)
train_data <- df[train_indices, ]
test_data <- df[-train_indices, ]

# Ajustar o modelo de regressão linear
model <- lm(IBOV ~ NI225 + DJI, data = train_data)

# Resumo do modelo
summary(model)

# Fazer previsões no conjunto de teste
predictions <- predict(model, newdata = test_data)

# Avaliar o modelo
actuals <- test_data$IBOV
mse <- mean((predictions - actuals)^2)
rmse <- sqrt(mse)
mae <- mean(abs(predictions - actuals))
mape <- mean(abs((predictions - actuals) / actuals)) * 100
r_squared <- summary(model)$r.squared

cat("RMSE:", rmse, "\n")
cat("MAE:", mae, "\n")
cat("MAPE:", mape, "%\n")
cat("R²:", r_squared, "\n")

# Plotar os valores previstos vs. valores reais
plot(actuals, predictions, 
     xlab = "Valores Reais", ylab = "Valores Previstos", 
     main = "Valores Reais vs. Valores Previstos")
