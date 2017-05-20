library(neuralnet)
library(zoo)
library(hydroGOF)


dataset<-read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustao.csv")

#criar novo dataset para a 2 alínea
dataset2<-dataset

#criar novo dataset para a 3 alínea
dataset3<-dataset

#transformar valores de exaustão em 1(não exausto) ou 2(exausto)
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel <= 3] <- 1
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel > 3] <- 2

#transformar valores de exaustão na escala mais adequada
dataset3$ExhaustionLevel[dataset3$ExhaustionLevel == 1] <- 1
dataset3$ExhaustionLevel[dataset3$ExhaustionLevel == 2] <- 2
dataset3$ExhaustionLevel[dataset3$ExhaustionLevel == 3] <- 3
dataset3$ExhaustionLevel[dataset3$ExhaustionLevel == 4] <- 4
dataset3$ExhaustionLevel[dataset3$ExhaustionLevel == 5] <- 4
dataset3$ExhaustionLevel[dataset3$ExhaustionLevel == 6] <- 4
dataset3$ExhaustionLevel[dataset3$ExhaustionLevel == 7] <- 4



#divisão dos dados para teste e treino
trainset <- dataset[1:600,]
testset <- dataset[601:844,]
trainset2 <- dataset2[1:600,]
testset2 <- dataset2[601:844,]
trainset3 <- dataset3[1:600,]
testset3 <- dataset3[601:844,]


formula <- ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean
formula3 <- ExhaustionLevel ~ Performance.MAMean + Performance.MVMean + Performance.DDCMean 
formula4 <- ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean 
formula5 <- ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.DMSMean
formula6 <- ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.DMSMean + Performance.ADMSLMean



#fresults <- neuralnet(formula3, trainset, threshold = 0.1 , hidden = c(5),algorithm='slr',lifesign = "full")
fresults <- neuralnet(formula3, trainset3, threshold = 0.1 , hidden = c(20),algorithm='rprop-',lifesign = "full")


#print(fresults)
plot(fresults)

vartest <- subset(testset2, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean"))
vartest3 <- subset(testset2, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean"))
vartest4 <- subset(testset2, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean" , "Performance.KDTMean"))
vartest5 <- subset(testset2, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean" , "Performance.KDTMean" , "Performance.DMSMean"))
vartest6 <- subset(testset2, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean" , "Performance.KDTMean" , "Performance.DMSMean" , "Performance.ADMSLMean"))


fresults.resultados <- compute(fresults, vartest3)


resultados <- data.frame(OutputEsperado = testset3$ExhaustionLevel, Output = fresults.resultados$net.result)


resultados$Output <- round(resultados$Output,2)


rmse(c(testset2$ExhaustionLevel),c(resultados$Output))
