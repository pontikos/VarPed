
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Uploading Files"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Upload the pedigree."),
      helpText("Default max. file size is 5MB"),
      tags$hr(),
      br()
    ),
    mainPanel( plotOutput('plot'), width='100%' )
  )
))
 
