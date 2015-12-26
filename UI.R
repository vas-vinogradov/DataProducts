library(shiny)

shinyUI
(
  pageWithSidebar
    (
    headerPanel("Car mpg prediction"),
      #input parameters for model.
      sidebarPanel
      (
        sliderInput("qsec",
                  "1/4 mile time:",
                  min = 14,
                  max = 30,
                  value = 22),
        sliderInput("wt",
                  "Weight (lb/1000):",
                  min = 1.5,
                  max = 5.5,
                  value = 3),
        radioButtons("am", "Transmission type:",
                   c("Manual" = "1",
                     "Automatic" = "0"
                     ))
      ),
      #Simple output:header.value,Plot
      mainPanel
      (
        h1("MPG prediction"),
        helpText(   a("Click Here for help",href="help.html",target="_blank") ),
        verbatimTextOutput('mpg'),
        plotOutput("Plot")
      )
    )
)
