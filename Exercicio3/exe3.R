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
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel <= 3] <- 0
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel > 3] <- 1

#transformar valores de exaustao numa escala adequada
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel == 1] <- 1
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel == 2] <- 2
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel == 3] <- 3
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel == 4] <- 4
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel == 5] <- 4
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel == 6] <- 4
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel == 7] <- 4



#dados de treino entre as linhas 1 e 600, inclusive
trainset<-dataset[1:600,]
trainset<-dataset2[1:600,]
trainset<-dataset3[1:600,]

#dados de teste entre as linhas 601 e 844, inclusive
testset<-dataset[601:844,]
testset<-dataset2[601:844,]
testset<-dataset3[601:844,]