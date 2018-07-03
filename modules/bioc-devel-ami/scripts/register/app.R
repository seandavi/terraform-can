#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(digest)
fdir = '/tmp'
blacklist_users=c('shiny','root','ubuntu')
userlist = setdiff(dir('/home',all.files = FALSE),blacklist_users)
ipaddr = httr::content(httr::GET('checkip.amazonaws.com'),type='text')

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Get me an R login"),
   
   # Sidebar with a slider input for number of bins 
   fluidPage(
     textInput('p1',label = 'Your email'),
     textInput('p2',label = 'Your email again'),
      actionButton('go', label = "Get my login info", icon = NULL, width = NULL),
      htmlOutput('def')
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  x = reactive({
    if (input$go == 0)
      return()
    
    if((input$p1 == input$p2) & (nchar(input$p1)>5)) {
      u1 = tolower(input$p1)
      fname = file.path(fdir,paste0('userabc_',digest(u1,'md5')))
      message(fname)
      if(file.exists(fname)) {
        a=readLines(fname)
      } else {
        allfnames = dir(fdir,pattern='userabc_',full.names = TRUE)
        usednames = c('',sapply(allfnames,readLines))
        a = sample(setdiff(userlist,usednames),1)
        writeLines(a,fname)
      }
      return(a)
    }
    else {
       if(nchar(input$p1)<6) return('make sure to use a longer email')
      return('Your emails do not match. Try again.')
    }
  })
   
   output$def <- renderUI({
     if (input$go == 0)
       return()
     
     isolate({tagList(
       tags$h1(paste("Your username is:",x())),
       tags$h1(paste("Your password is:",x()))
       )})
   })
}

# Run the application 
shinyApp(ui = ui, server = server)