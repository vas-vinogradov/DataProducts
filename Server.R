library(shiny)
library(ggplot2)

data(mtcars)
fit3 <- lm(mpg ~ wt + am + qsec, data=mtcars)  

multiplot <- function(..., plotlist=NULL, cols) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # Make the panel
  plotCols = cols                          # Number of columns of plots
  plotRows = ceiling(numPlots/plotCols) # Number of rows needed, calculated from # of cols
  
  # Set up the page
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(plotRows, plotCols)))
  vplayout <- function(x, y)
    viewport(layout.pos.row = x, layout.pos.col = y)
  
  # Make each plot, in the correct location
  for (i in 1:numPlots) {
    curRow = ceiling(i/plotCols)
    curCol = (i-1) %% plotCols + 1
    print(plots[[i]], vp = vplayout(curRow, curCol ))
  }
  
}


shinyServer
(
  function(input,output)
    {
         
    
         output$mpg<-renderPrint({
           
           wt<-input$wt
           qsec<-input$qsec
           am<-as.numeric(input$am)
           predict.lm(fit3, newdata=data.frame(wt,qsec,am))
           })
         
         output$Plot<-renderPlot({
           wt<-input$wt
           qsec<-input$qsec
           am<-as.numeric(input$am)
           mpg<-predict.lm(fit3, newdata=data.frame(wt,qsec,am))
           
           g1<-ggplot(mtcars, aes(x=wt, y=mpg, colour=am)) + geom_point() + ggtitle("MPG vs Weight")+annotate("point",size = 5, shape = 19, color = "#00FF00", x = wt, y = mpg)
           g2<-ggplot(mtcars, aes(x=qsec, y=mpg, colour=am)) + geom_point() +ggtitle("MPG vs Qsec")+annotate("point",size = 5, shape = 19, color = "#00FF00", x = qsec, y = mpg)
           multiplot(g1, g2, cols = 2)
         })
    }

)
