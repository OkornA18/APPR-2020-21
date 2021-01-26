library(shiny)

fluidPage(
  selectInput(inputId = 'izobrazevanje', label = 'Izberite vrsto izobrazevanja',
              choices = unique(tabela2nova$izobrazevanje), 
              selected = unique(tabela2nova$izobrazevanje)[1]),
  plotOutput('vrste')
)