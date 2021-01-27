# 4. faza: Analiza podatkov

#LINEARNA REGRESIJA

library(ggplot2)
library(GGally)
library(mgcv)

g <- ggplot(tabela_tri_zdruzene, aes(x=skupaj.x, y=skupaj.y)) + geom_point()
kv <- lm(data=tabela_tri_zdruzene, skupaj.y ~ skupaj.x + I(skupaj.x^2))
graf13 <- g + geom_smooth(method="lm", formula=y ~ x) + labs(x = "Število prebivalcev (v stotisočicah)", y = "Število dijakov", title = "Število dijakov v Sloveniji na leto  \nglede na število prebivalcev v istem letu")


p <- ggplot(tabela_tri_zdruzene, aes(x=skupaj.x, y=skupaj)) + geom_point()
kv <- lm(data=tabela_tri_zdruzene, skupaj ~ skupaj.x + I(skupaj.x^2))
graf14 <- p + geom_smooth(method="lm", formula=y ~ x)+ labs(x = "Število prebivalcev (v stotisočicah)", y = "Število diplomantov", title = "Število diplomantov v Sloveniji na leto  \nglede na število prebivalcev v istem letu")
