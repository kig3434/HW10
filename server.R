server <-function(input, output) {
  
  
  output$predtable <- DT::renderDataTable({
    generatepreds(
      depth = input$Depth,
      table = input$Table,
      price = input$Price,
      x = input$X,
      y = input$Y
    ) %>%
      datatable() %>%
      formatPercentage(columns = 'preds', digits = 2)
    
    
  })
  
  
}