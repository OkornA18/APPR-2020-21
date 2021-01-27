library(shiny)


shinyServer(function(input, output) {
  
  output$vrsta1 <- renderPlot({
    graf.dijaki <- ggplot(tabela2nova %>%
                             filter(izobrazevanje == input$vrsta1)) +
      aes(x=leto, y=stevilo, fill=spol) +
      geom_col(position="dodge") +
      labs( x='Leto', y = 'Število') + 
      scale_fill_manual(values=c('lightblue', 'purple')) + 
      scale_x_continuous(breaks = seq(2009, 2018, by=1), limits = c(2008,2019)) +
      theme_minimal()
    
    print(graf.dijaki)
  })
  
  output$vrsta2 <- renderPlot({
    graf.diplomanti <- ggplot(tabela3nova %>%
                            filter(izobrazevanje == input$vrsta2)) +
      aes(x=leto, y=stevilo, fill=spol) +
      geom_col(position="dodge") +
      labs( x='Leto', y = 'Število') + 
      scale_fill_manual(values=c('lightblue', 'purple')) + 
      scale_x_continuous(breaks = seq(2009, 2018, by=1), limits = c(2008,2019)) +
      theme_minimal()
    
    print(graf.diplomanti)
  })
  
  
})