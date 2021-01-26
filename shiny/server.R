library(shiny)

function(input, output) {
  output$vrsta <- renderPlot({
    ggplot(tabela2nova %>%
             filter(izobrazevanje == input$izobrazevanje)) + 
      aes(x=leto, y=stevilo, fill=spol) + geom_bar(stat='identity', position='dodge') +
      labs(title='test', x='Leto', y = 'Število') + 
      scale_fill_manual(values=c('lightblue', 'purple')) + theme_minimal()
  })
}