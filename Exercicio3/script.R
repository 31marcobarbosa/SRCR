library(neuralnet)
library(hydroGOF)

#dataset<-read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/normal1.csv")
dataset<-read.csv("C:/Users/rj3/Desktop/exaustaoNorm.csv")


trainset<-dataset[1:600,]
testset<-dataset[601:844,]


formula <- ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean

fresults <- neuralnet(formula, trainset, threshold = 0.01 , hidden = c(10,6))

print(fresults)
plot(fresults)

vartest <- subset(testset, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean"))

fresults.results <- compute(fresults, vartest)

resultado <- data.frame(OutputEsperado = testset$ExhaustionLevel, Output = fresults.results$net.result)

resultado$Output <- round(resultado$Output,3)

rmse(c(testset$ExhaustionLevel),c(resultado$Output))