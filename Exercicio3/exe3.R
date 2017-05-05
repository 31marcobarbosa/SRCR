# comando de instalação dos packages
#install.packages("neuralnet")
#install.packages("hydroGOF")

#import das librabrias
library(neuralnet)
library(hydroGOF)

#efetuar a leitura de um dataset para identificar os 7 níveis de exaustão
dataset<-read.csv("C:\\Users\\rj3\\OneDrive\\Documentos\\GitHub\\SRCR\\Exercicio3\\exaustao.csv")

#efetuar a leitura de um dataset para identificar a existência ou não de exaustão
dataset2<-dataset

#efetuar a leitura de um dataset para escolher a melhor escala de exaustão
dataset3<-dataset

#transformar valores de exaustão em 0(não exausto) ou 1(exausto)
dataset2$FatigueLevel[dataset2$FatigueLevel <= 3] <- 0
dataset2$FatigueLevel[dataset2$FatugueLevel > 3] <- 1

#transformar valores de exaustao numa escala adequada
dataset3$FatigueLevel[dataset3$FatigueLevel == 1] <- 1
dataset3$FatigueLevel[dataset3$FatigueLevel == 2] <- 2
dataset3$FatigueLevel[dataset3$FatigueLevel == 3] <- 3
dataset3$FatigueLevel[dataset3$FatigueLevel == 4] <- 4
dataset3$FatigueLevel[dataset3$FatigueLevel == 5] <- 4
dataset3$FatigueLevel[dataset3$FatigueLevel == 6] <- 4
dataset3$fatigueLevel[dataset3$FatigueLevel == 7] <- 4


#dados de treino entre as linhas 1 e 600, inclusive
trainset<-dataset[1:600,]
trainset<-dataset2[1:600,]
trainset<-dataset3[1:600,]

#dados de teste entre as linhas 601 e 844, inclusive
testset<-dataset[601:844,]
testset<-dataset2[601:844,]
testset<-dataset3[601:844,]

#definir camadas de entrada e sa�da da RNA
formula01 <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean

#treinar a rede neuronal


#imprimir a rede neuronal


#definir variaveis de input


#testar a rede com novos casos


#imprimir resultados


#imprimir resultados arredondados


#calcular o RMSE
