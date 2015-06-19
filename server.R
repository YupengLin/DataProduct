library(ggplot2)
library(shiny)
library(caret)
library(dplyr)
data(mtcars)
shinyServer(function(input, output) {
   para <- data.frame(disp=numeric(0), hp=numeric(0), wt=numeric(0),
                      cyl=numeric(0),am=numeric(0),vs=numeric(0))
  dataInput <- reactive({
   para[1,1] <- input$disp
   para[1,2] <- input$hp
   para[1,3] <- input$wt
   para[1,4] <- as.numeric(input$cyl)
   para[1,5] <- as.numeric(input$am)
   para[1,6] <- as.numeric(input$vs)
#   if(input$am){
#     para[1,5] <- 1
#   }else{
#     para[1,5] <- 0
 #  }
#   if(input$vs){
#     para[1,6] <- 1
#   }else{
#     para[1,6] <- 0
#   }
    para
  })
  
  output$factor_mean <- renderPlot({
    if(input$factor_set == "cyl"){
    
      t <- group_by(mtcars, cyl) %>% summarize(mean=mean(mpg)) 
      qplot(x=cyl, y=mean, data=t, geom="bar", stat="identity",position="dodge")
    } else if(input$factor_set == "gear"){
      t <- group_by(mtcars, gear) %>% summarize(mean=mean(mpg)) 
      qplot(x=gear, y=mean, data=t, geom="bar", stat="identity",position="dodge")
    }else if(input$factor_set == "vs"){
      t <- group_by(mtcars, vs) %>% summarize(mean=mean(mpg)) 
      qplot(x=vs, y=mean, data=t, geom="bar", stat="identity",position="dodge")
    } else if(input$factor_set == "carb"){
      t <- group_by(mtcars, carb) %>% summarize(mean=mean(mpg)) 
      qplot(x=carb, y=mean, data=t, geom="bar", stat="identity",position="dodge")
    }
  })
  
  output$estimate <- renderText({
    modFit <- train(mpg ~ disp + hp + wt + cyl + am + vs, method="glm", data=mtcars)
    prediction <- predict(modFit, dataInput())
    paste("The estimated mpg is ", prediction)
  })
  
})
