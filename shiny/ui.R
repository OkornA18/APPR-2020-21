library(shiny)

shinyUI(fluidPage(
  navbarPage("Analiza izobraževanja",
             tabPanel("Dijaki",
                               titlePanel("Število dijakov v posamezni vrsti izobraževanja"),
                               sidebarPanel(
                                 selectInput(inputId = "vrsta1",
                                             label = "Izberi vrsto izobraževanja",
                                             choices = unique(tabela2nova$izobrazevanje))),
                               mainPanel(plotOutput("vrsta1"))),
             tabPanel("Diplomanti",
                      titlePanel("Število diplomantov v posamezni vrsti izobraževanja"),
                      sidebarPanel(
                        selectInput(inputId = "vrsta2",
                                    label = "Izberi vrsto izobraževanja",
                                    choices = unique(tabela3nova$izobrazevanje))),
                      mainPanel(plotOutput("vrsta2")))
  )))