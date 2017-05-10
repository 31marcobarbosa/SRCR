library(neuralnet)
library(hydroGOF)


dataset3<-read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustaoNorm.csv")

trainset3 <- dataset3[1:600,]
testset3 <- dataset3[601:844,]


#transformar valores de exaustão
dataset3$FatigueLevel[dataset3$FatigueLevel == 0] <- 0
dataset3$FatigueLevel[dataset3$FatigueLevel == 0.166666667] <- 0.33
dataset3$FatigueLevel[dataset3$FatigueLevel == 0.333333333] <- 0.66
dataset3$FatigueLevel[dataset3$FatigueLevel == 0.500000000] <- 1
dataset3$FatigueLevel[dataset3$FatigueLevel == 0.666666667] <- 1
dataset3$FatigueLevel[dataset3$FatigueLevel == 0.833333333] <- 1
dataset3$fatigueLevel[dataset3$FatigueLevel == 1] <- 1


formula <- ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean
form <- ExhaustionLevel ~ Performance.DDCMean + Performance.DMSMean + Performance.ADMSLMean + Performance.TBCMean + Performance.MVMean


fresults3 <- neuralnet(formula, trainset3, threshold = 0.1 , hidden = c(12), algorithm='rprop+')


vartest3 <- subset(testset3, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean"))


fresults3.results <- compute(fresults3, vartest3)


resultado3 <- data.frame(OutputEsperado = testset3$ExhaustionLevel, Output = fresults3.results$net.result)


resultado3$Output <- round(resultado3$Output,2)


rmse(c(testset3$ExhaustionLevel),c(resultado3$Output))
