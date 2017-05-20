library("leaps")

dados <- read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustao.csv")
dados2 <- dados
dados3 <- dados



dados2$ExhaustionLevel[dados2$ExhaustionLevel <= 3] <- 1
dados2$ExhaustionLevel[dados2$ExhaustionLevel > 3] <- 2


dados3$ExhaustionLevel[dados3$ExhaustionLevel == 1] <- 1
dados3$ExhaustionLevel[dados3$ExhaustionLevel == 2] <- 2
dados3$ExhaustionLevel[dados3$ExhaustionLevel == 3] <- 3
dados3$ExhaustionLevel[dados3$ExhaustionLevel == 4] <- 4
dados3$ExhaustionLevel[dados3$ExhaustionLevel == 5] <- 4
dados3$ExhaustionLevel[dados3$ExhaustionLevel == 6] <- 4
dados3$ExhaustionLevel[dados3$ExhaustionLevel == 7] <- 4



resultadoTk <- regsubsets(Performance.Task ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                        dados,nvmax = 8)


resultadoFt <- regsubsets(ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                          dados,nvmax = 8)


resultadoFt2 <- regsubsets(ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + 
                            Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                            Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                          dados2,nvmax = 8)

resultadoFt3 <- regsubsets(ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + 
                             Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                             Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                           dados3,nvmax = 8)




#summary(resultadoTk)
#summary(resultadoFt)
#summary(resultadoFt2)
summary(resultadoFt3)




