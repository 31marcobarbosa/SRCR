library("leaps")

dados <- read.csv("C:/Users/rj3/OneDrive/Documentos/GitHub/SRCR/Exercicio3/exaustaoNorm.csv")

resultado <- regsubsets(ExhaustionLevel ~ Performance.KDTMean + Performance.MAMean + 
                          Performance.MVMean + Performance.TBCMean + Performance.DDCMean + 
                          Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean,
                        dados,nvmax = 6)

summary(resultado)





#library("arules")
#library("matrix")
#arules
#x1 <- discretize(dados$LTI, method = "frequency",categories = 4)
#plot(x1)

#dados$income <- as.numeric(discretize(dados$income, method = "frequency",categories = 4))


#leaps