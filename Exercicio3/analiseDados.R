library("leaps")

dados <- read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustaoNorm.csv")


resultado <- regsubsets(Performance.Task ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                        dados,nvmax = 6)

summary(resultado)



#resultado <- regsubsets(ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + 
#                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
#                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
#                        dados,nvmax = 6)


