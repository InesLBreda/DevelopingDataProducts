library(shiny); library(DT); library(ggplot2)

shinyServer(function(input, output) {

    output$mytable = DT::renderDataTable({
        trees
    })
    
    output$plot2 <- renderPlot({
        if(input$x=='Girth'){
            x<- trees[, 1]
            name <- "Girth (inches)"
            }
        if(input$x=='Height'){
            x<- trees[, 2]
            name <- "Height (ft)"
        }
        if(input$x=='Volume'){
            x<- trees[, 3]
            name <- "Volume (cubic ft)"
        }
        data <- data.frame(x)
        ggplot(data, aes(y= x, x = as.factor(1)))+
            geom_boxplot(fill = "darkgreen")+
            scale_y_continuous(name = name) +
            scale_x_discrete(name = "") +
            ggtitle("Your Boxplot")+
            theme_bw()
            
        })
    
    model <- reactive({
        brushed_data <- brushedPoints(trees, input$brush1,
                                      xvar = "Girth", yvar = "Volume")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(Volume ~ Girth, data = brushed_data)
    })

    output$slopeOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][2]
        }
    })

    output$intOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][1]
        }
    })

    output$plot1 <- renderPlot({
        plot(trees$Girth, trees$Volume, xlab = "Girth",
             ylab = "Volume", main = "Tree Measurements",
             cex = 1.5, pch = 16, bty = "n")
        if(!is.null(model())){
            abline(model(), col = "darkgreen", lwd = 2, lty= 2)
        }
    })
})