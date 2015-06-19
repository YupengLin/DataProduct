library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Small shiny application"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      
      
      h3("Explore some factors influence mpg"),
      p(" Select one of factors that influences the mpg.
        In the right side of app, you will see the lattice bar plot of selected factor"),
      selectInput("factor_set", "Select a factor:", 
                  choices = list("carb", "gear", "vs","cyl")),
      br(),
      h3("Prediction of mpg"),
      p("Please the specificy the parameter to predict the mpg"),
      sliderInput("disp",
                  "displacement",
                  min = 70,
                  max = 475,
                  value = 200),
      
      sliderInput("hp",
                  "Gross horsepower",
                  min = 50,
                  max = 350,
                  value = 100),
      
      sliderInput("wt",
                  "weight in lb/1000",
                  min = 1.5,
                  max = 6,
                  value = 3),
      radioButtons("cyl", label = h3("Number of cylinders"),
                   choices = list("cyl 4" = 4, "cyl 6" = 6, "cyl 8" = 8), 
                   selected = 4),
      checkboxInput("am", label = "Transmission (0 = automatic, 1 = manual)", value = TRUE),
    checkboxInput("vs", label = "V/S", value = TRUE)
     
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Plot to demonstrate the relation between factors and mpg"),
      plotOutput("factor_mean"),
      br(),
      h3("Numric result of estimation"),
      textOutput("estimate"),
      h3("Helper Documents"),
      p("This shiny application enables user to explore the different factors influencing mpg. Those factors include number of forward gear, number of cylinder and number of carburetors. Besides the visual interaction of factors influencing the mpg, the user can estimate the mpg by themselves. They can enter the weight of carn displacement and type of transmission, the algorithm will feedback the estimated mpg. It is very useful for both customers and car sellers.")
    )
  )
))