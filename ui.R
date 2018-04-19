ui <- fluidPage(
  
titlePanel("Predicting DM cuts"),
sidebarLayout(
  sidebarPanel(
    sliderInput("Depth", label = "Depth:", value = 60.3, min = 43, max = 79, step = .1),
    
    sliderInput("Table", label = "Table:", value = 60, min = 43, max = 95, step = .5),
    
    sliderInput("Price", label = "Price:", value = 2500, min = 325, max = 19000, step = 25),
    
    sliderInput("X", label = "X:", value = 5.75, min = 0, max = 12, step = .25),
    
    sliderInput("Y", label = "Y:", value = 5.27, min = 0, max = 12, step = .25)
    
    
  ),
  mainPanel(
    DT::dataTableOutput("predtable")
  )
 )
)

