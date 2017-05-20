library("leaps")

dados <- read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustao.csv")
dados2 <- dados
dados3 <- dados



resultadoTk <- regsubsets(Performance.Task ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                        dados,nvmax = 8)


resultadoFt <- regsubsets(ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                          dados,nvmax = 8)

summary(resultadoTk)
#summary(resultadoFt)




