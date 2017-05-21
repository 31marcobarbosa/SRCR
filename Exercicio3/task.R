library(neuralnet)
library(zoo)
library(hydroGOF)


dataset<-read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustao.csv")


#divisão dos dados para teste e treino
trainset <- dataset[1:600,]
testset <- dataset[601:844,]


formula <- Performance.Task ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean
formula3 <- Performance.Task ~ Performance.KDTMean + Performance.DDCMean + Performance.DMSMean
formula4 <- Performance.Task ~ Performance.KDTMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean
formula5 <- Performance.Task ~ Performance.KDTMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean
formula6 <- Performance.Task ~ Performance.KDTMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + Performance.TBCMean 


fresults <- neuralnet(formula5, trainset, threshold = 0.05 , hidden = c(2,4),algorithm='rprop-',lifesign = "full")


plot(fresults)


vartest <- subset(testset, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean"))
vartest3 <- subset(testset, select = c("Performance.KDTMean" , "Performance.DDCMean" , "Performance.DMSMean"))
vartest4 <- subset(testset, select = c("Performance.KDTMean" , "Performance.DDCMean" , "Performance.DMSMean" , "Performance.AEDMean"))
vartest5 <- subset(testset, select = c("Performance.KDTMean" , "Performance.DDCMean" , "Performance.DMSMean" , "Performance.AEDMean" , "Performance.ADMSLMean"))
vartest6 <- subset(testset, select = c("Performance.KDTMean" , "Performance.DDCMean" , "Performance.DMSMean" , "Performance.AEDMean" , "Performance.ADMSLMean" , "Performance.TBCMean"))


fresults.resultados <- compute(fresults, vartest5)


resultados <- data.frame(OutputEsperado = testset$Performance.Task, Output = fresults.resultados$net.result)


resultados$Output <- round(resultados$Output,2)


rmse(c(testset2$Performance.Task),c(resultados$Output))