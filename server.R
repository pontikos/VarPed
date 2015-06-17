
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(kinship2)

shinyServer(function(input, output) {
  data <- reactive({
    #browser()
    print(str(input))
    inFile <- input$file
    if (is.null(inFile)) return(NULL)
    #input <- "/cluster/project8/vyp/AdamLevine/2015linkage/pairwise/A.pro"
    #d <- read.table(inFile$datapath,header=F,sep="\t")
    d <- read.csv(inFile$datapath,check.names=FALSE)
    d <- d[order(d[,'ID']),]
    rownames(d) <- d[,'ID']
    ped <- pedigree(id=d[,'ID'],dadid=d[,'Father'],momid=d[,'Mother'],aff=as.numeric(d[,'Affection']),sex=as.numeric(d[,'Gender']),missid="0")
    print(colnames(d)[!c(colnames(d) %in% c('ID','Father','Mother','Gender','Affection'))])
    #,ID,22_16157762_C_T
    cols <- c('0'='black','1'='darkgreen','2'='red',' '='gray')
    geno <- d[,6]
    geno[is.na(geno)] <- ' '
    print(geno)
    return(list(ped=ped,col=cols[geno]))
  })
  output$plot<- renderPlot({
    d <- data()
    if (is.null(d)) return(NULL)
    par(xpd=T)
    plot(d$ped,cex=0.6,col=d$col)
  },width=5000,height=2000)
})


