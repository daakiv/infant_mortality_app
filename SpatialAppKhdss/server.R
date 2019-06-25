#server.R
library(shiny)
library(devtools)
library(ggsn)
library(ggplot2)
library(foreign)
library(ggmap)## calls map from google.
library(maptools)# needed to read the shapefile into R
library(RColorBrewer)
library(rgdal)



shinyServer(function(input, output) {
  
  observe({
    file1 = input$file1
    file2 = input$file2
    if (is.null(file1) || is.null(file2)) {
      return(NULL)
    }
    data1 = read.csv(file1$datapath)
    previouswd <- getwd()
    uploaddirectory <- dirname(file2$datapath[1])
    setwd(uploaddirectory)
    
    for(i in 1:nrow(file2)){
      file.rename(file2$datapath[i], file2$name[i])
    }
    setwd(previouswd)
    
    data2 <- readOGR(paste(uploaddirectory, file2$name[grep(pattern="*.shp$", file2$name)], sep="/"))#,  delete_null_obj=TRUE)
    
    #data2 = readOGR(file2$datapath)
    ###reading and exporting the shape file
  #  data2 <- maptools::readShapePoly( file2$datapath,IDvar="Adj_ID", proj4string=CRS("+proj=longlat +ellps=clrk66"))
    
    shapefile2 <- fortify(data2)


    mapdata <- ggplot(aes(x =long,y =lat, group = id),data = shapefile2,linetype=1,size=1,alpha=0.9)+
    geom_polygon(fill="gray", colour="black") + theme_bw() +
    theme(axis.text=element_text(size=16,face="bold"),legend.title=element_text(size=16,face="bold"),
            axis.title=element_text(size=16,face="bold"))  + theme(axis.text=element_text(size=13),
                                                                   axis.title=element_text(size=22,  face="bold")) + theme_bw() +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"),
            panel.border = element_rect(colour="white")) +
      geom_point(data=data1,aes(x=longitude,y=latitude),size=1.2, colour="red")+
      xlab("Longitude") + ylab("Latitude")
    
    

    
    output$mapPlot <- renderPlot({
      mapdata
     # plot(data2)
    })
  })
  
})