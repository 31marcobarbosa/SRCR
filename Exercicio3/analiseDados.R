library("leaps")

dados <- read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustao.csv")



resultado <- regsubsets(Performance.Task ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                        dados,nvmax = 6)


resultado2 <- regsubsets(FatigueLevel ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                          dados,nvmax = 6)

summary(resultado)

summary(resultado2)




