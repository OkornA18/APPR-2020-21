# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(tmap)

povprecje.dijakovindiplomantov.po.regijah <- tabela1nova %>% group_by(regija,kategorija) %>% summarise(povprecje=sum(stevilo)/10)
seznam <- split(povprecje.dijakovindiplomantov.po.regijah, povprecje.dijakovindiplomantov.po.regijah$kategorija)
povprecje.dijakov.po.regijah <- seznam[[1]]
povprecje.diplomantov.po.regijah <- seznam[[2]]
povprecje.dijakov.po.regijah <- povprecje.dijakov.po.regijah[-12,] %>% select(-"kategorija")
povprecje.diplomantov.po.regijah <- povprecje.diplomantov.po.regijah[-12,] %>% select(-"kategorija")

# GRAF POVPRECJA DIJAKOV IN DIPLOMANTOV PO REGIJAH

graf_povprecja_po_regijah <- ggplot(povprecje.dijakovindiplomantov.po.regijah, aes(x=regija, y=povprecje, fill=kategorija)) +
  geom_col(position = 'dodge')  + 
  coord_flip() +
  labs(x = "Regija", y = "Povprečno število", title = "Povprečno število dijakov in diplomantov na leto \nv posameznih statističnih regijah") +
  scale_fill_discrete(name = "Kategorija", labels = c("število dijakov", "število diplomantov")) + 
  scale_fill_brewer()

# TORTNI DIAGRAM DIPLOMANTOV GLEDE NA NACIN STUDIJA s knjižnjico plotrix

# f <- tabela4nova %>% group_by(studij) %>% summarise(vsota=sum(stevilo))
#tortnidiagram <- ggplot(f) + aes(x="", y = vsota,fill=studij) + geom_col(width=1) + coord_polar(theta="y") + xlab("") + ylab("") + scale_fill_discrete(name = "Študij", labels = c("izredni", "rednii")) +
#  ggtitle("Razmerje med diplomanti na izrednem in rednem študiju")

chem <- c('izredni','redni')
vol <- c(208787,708342)
png(file = "pie.jpg")
tortni <- pie3D(vol,labels = chem,explode = 0.1, main = 'Razmerje med diplomanti na izrednem ter rednem študiju',col=c('purple','lightblue',clockwise = T))
dev.off()

# ZEMLJEVIDA POVPREČNEGA DELEŽA DIPLOMANTOV IN DIJAKOV V ODSTOTKIH GLEDE NA ŠTEVILO PREBIVALCEV V POSAMEZNI REGIJI V DESETIH LETIH

povprecjedipl <- skupnatabela2 %>% group_by(regija) %>% summarise(povprecje=sum(delez)/10)
graf8 <- povprecjedipl %>% ggplot(aes(x=povprecje, y=regija, fill = regija)) + geom_col()

zemljevida <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1")
zemljevida$NAME_1[zemljevida$NAME_1 == "GoriĹˇka"] <- "Goriška"
zemljevida$NAME_1[zemljevida$NAME_1 == "KoroĹˇka"] <- "Koroška"
zemljevida$NAME_1[zemljevida$NAME_1 == "Notranjsko-kraĹˇka"] <- "Notranjsko-kraška"
zemljevida$NAME_1[zemljevida$NAME_1 == "Obalno-kraĹˇka"] <- "Obalno-kraška"
zemljevid2 <- tm_shape(merge(zemljevida, povprecjedipl, by.x="NAME_1", by.y="regija" )) + 
  tm_polygons("povprecje",title="Delež",palette="Purples")+ tm_style("grey") + tm_layout(main.title="Povprečni delež diplomantov po regijah \nv zadnjih desetih letih glede na \nštevilo prebivalcev v posamezni regiji") + tm_text(text='NAME_1', size=0.6)

povprecjedij <- skupnatabela %>% group_by(regija) %>% summarise(povprecje=sum(delez)/10)
zemljevida2 <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1")

zemljevida2$NAME_1[zemljevida2$NAME_1 == "GoriĹˇka"] <- "Goriška"
zemljevida2$NAME_1[zemljevida2$NAME_1 == "KoroĹˇka"] <- "Koroška"
zemljevida2$NAME_1[zemljevida2$NAME_1 == "Notranjsko-kraĹˇka"] <- "Notranjsko-kraška"
zemljevida2$NAME_1[zemljevida2$NAME_1 == "Obalno-kraĹˇka"] <- "Obalno-kraška"

zemljevid3 <- tm_shape(merge(zemljevida2, povprecjedij, by.x="NAME_1", by.y="regija" )) + 
  tm_polygons("povprecje",title="Delež",palette="Blues")+
  tm_style("grey") +
  tm_layout(main.title="Povprečni delež dijakov po regijah \nv zadnjih desetih letih glede na \nštevilo prebivalcev v posamezni regiji")+ tm_text(text='NAME_1', size=0.6)


# ZEMLJEVID POVPRECJA DIPLOMANTOV PO REGIJAH, KI GA NA KONCU NISEM UPORABILA, KER JE ZEMLJEVID2 BOLJŠI NAČIN PRIKAZOVANJA

zemljevid <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1")

zemljevid$NAME_1[zemljevid$NAME_1 == "GoriĹˇka"] <- "Goriška"
zemljevid$NAME_1[zemljevid$NAME_1 == "KoroĹˇka"] <- "Koroška"
zemljevid$NAME_1[zemljevid$NAME_1 == "Notranjsko-kraĹˇka"] <- "Notranjsko-kraška"
zemljevid$NAME_1[zemljevid$NAME_1 == "Obalno-kraĹˇka"] <- "Obalno-kraška"

zemljevid1 <- tm_shape(merge(zemljevid, povprecje.diplomantov.po.regijah, by.x="NAME_1", by.y="regija" )) + 
  tm_polygons("povprecje",title="Povprečje",palette="Purples") +
  tm_style("grey") +
  tm_layout(title="Povprečno število diplomantov po regijah v zadnjih desetih letih")

# GRAF POVPRECJA DIJAKOV GLEDE NA VRSTO IZOBRAZEVANJA IN SPOL (TO SEM KASNEJE PRIKAZALA V SHINYJU)

podatki5 <- tabela2nova %>% group_by(izobrazevanje, spol) %>% summarise(povprecje=sum(stevilo)/10)
graf5 <- ggplot(podatki5, aes(x=izobrazevanje, y=povprecje, fill = spol)) +
  geom_col(position = 'dodge')  + 
  coord_flip() + 
  labs(x = "Vrsta izobraževanja", y = "Povprečno število", title = "Povprečno število moških in žensk na leto v \nposameznih vrstah izobraževanj v \nzadnjih desetih letih") +
  scale_fill_discrete(name = "Spol", labels = c("moški", "ženski")) + 
  scale_fill_brewer()

# GRAF POVPRECJA DIPLOMANTOV GLEDE NA VRSTO IZOBRAZEVANJA IN SPOL (TO SEM KASNEJE PRIKAZALA V SHINYJU)

podatki6 <- tabela3nova %>% group_by(izobrazevanje, spol) %>% summarise(povprecje=sum(stevilo)/10)
graf6 <- ggplot(podatki6, aes(x=izobrazevanje, y=povprecje, fill = spol)) +
  geom_col(position = 'dodge')  + 
  coord_flip() +
  labs(x = "Vrsta izobraževanja", y = "Povprečno število", title = "Povprečno število diplomantov na leto  \nposameznih vrstah izobraževanj v \nzadnjih desetih letih") +
  scale_fill_discrete(name = "Spol", labels = c("moški", "ženski")) +
  scale_fill_brewer()











# POISKUSI
#graf2 <- ggplot(povprecje.diplomantov.po.regijah, aes(regija, povprecje, group = 1)) + geom_col() + coord_flip() +
#  labs(x = "Regija", y = "Povprecje", 
#       title = "Povprečno število diplomantov po regijah v zadnjih desetih letih")
#m <- tabela2nova %>% group_by(izobrazevanje, spol) %>% summarise(povprecje=sum(stevilo)/10) %>%filter(spol == "moski") %>% select(-"spol")
#z <- tabela2nova %>% group_by(izobrazevanje, spol) %>% summarise(povprecje=sum(stevilo)/10) %>%filter(spol == "zenski")%>% select(-"spol")
#graf3 <- ggplot(m, aes(izobrazevanje, povprecje, group = 1)) + geom_col() + coord_flip() + labs(x = "Vrsta izobraževanja", y = "Število moških", 
#                                                                                                title = "Povprečno število moških v \nposameznih vrstah izobraževanj v \nzadnjih desetih letih")
#graf4 <- ggplot(z, aes(izobrazevanje, povprecje, group = 1)) + geom_col() + coord_flip()+ labs(x = "Vrsta izobraževanja", y = "Število žensk", 
#                                                                                               title = "Povprečno število žensk v \nposameznih vrstah izobraževanj v \nzadnjih desetih letih")
#v graf5 združimo graf3 in graf4
