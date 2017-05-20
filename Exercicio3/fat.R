library(neuralnet)
library(zoo)
library(hydroGOF)


dataset<-read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustao.csv")

#criar novo dataset para a 2 alínea
dataset2<-dataset

#criar novo dataset para a 3 alínea
dataset3<-dataset

#transformar valores de exaustão em 0(não exausto) ou 1(exausto)
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel <= 3] <- 0
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel > 3] <- 1


#divisão dos dados para teste e treino
trainset <- dataset[1:600,]
testset <- dataset[601:844,]
trainset2 <- dataset2[1:600,]
testset2 <- dataset2[601:844,]
trainset3 <- dataset3[1:600,]
testset3 <- dataset3[601:844,]


formula <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean
formula3 <- FatigueLevel ~ Performance.MAMean + Performance.MVMean + Performance.DDCMean 
formula4 <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean 
formula5 <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.DMSMean
formula6 <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.DMSMean + Performance.ADMSLMean



fresults <- neuralnet(formula3, trainset, threshold = 0.1 , hidden = c(5),algorithm='slr',lifesign = "full")



#print(fresults)
plot(fresults)

vartest <- subset(testset, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean"))
vartest3 <- subset(testset, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean"))
vartest4 <- subset(testset, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean" , "Performance.KDTMean"))
vartest5 <- subset(testset, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean" , "Performance.KDTMean" , "Performance.DMSMean"))
vartest6 <- subset(testset, select = c("Performance.MAMean" , "Performance.MVMean" ,"Performance.DDCMean" , "Performance.KDTMean" , "Performance.DMSMean" , "Performance.ADMSLMean"))


fresults.resultados <- compute(fresults, vartest3)


resultados <- data.frame(OutputEsperado = testset$FatigueLevel, Output = fresults.resultados$net.result)


resultados$Output <- round(resultados$Output,2)


rmse(c(testset$FatigueLevel),c(resultados$Output))
