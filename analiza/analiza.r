# 4. faza: Analiza podatkov

#LINEARNA REGRESIJA

library(ggplot2)
library(GGally)

g <- ggplot(tabela_tri_zdruzene, aes(x=skupaj.x, y=skupaj.y)) + geom_point()
graf13 <- g + geom_smooth(method="lm", formula=y ~ x) + labs(x = "Število prebivalcev (v stotisočicah)", y = "Število dijakov", title = "Število dijakov v Sloveniji na leto  \nglede na število prebivalcev v istem letu")


p <- ggplot(tabela_tri_zdruzene, aes(x=skupaj.x, y=skupaj)) + geom_point()
graf14 <- p + geom_smooth(method="lm", formula=y ~ x)+ labs(x = "Število prebivalcev (v stotisočicah)", y = "Število diplomantov", title = "Število diplomantov v Sloveniji na leto  \nglede na število prebivalcev v istem letu")
