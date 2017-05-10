library(neuralnet)
library(hydroGOF)


dataset2<-read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustaoNorm.csv")

trainset2 <- dataset2[1:600,]
testset2 <- dataset2[601:844,]


#transformar valores de exaustão em 0(não exausto) ou 1(exausto)
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel <= 0.6] <- 0
dataset2$ExhaustionLevel[dataset2$ExhaustionLevel > 0.6] <- 1


formula <- ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean
form <- ExhaustionLevel ~ Performance.DDCMean + Performance.DMSMean + Performance.ADMSLMean + Performance.TBCMean + Performance.MVMean


fresults2 <- neuralnet(formula, trainset2, threshold = 0.1 , hidden = c(12), algorithm='rprop+')


vartest2 <- subset(testset2, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean"))


fresults2.results <- compute(fresults2, vartest2)


resultado2 <- data.frame(OutputEsperado = testset2$ExhaustionLevel, Output = fresults2.results$net.result)


resultado2$Output <- round(resultado2$Output,0)


rmse(c(testset2$ExhaustionLevel),c(resultado2$Output))
