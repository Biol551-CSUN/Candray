# what is shiny 
# shiwny links the regular website and the code together
  #when is shiny useful
    ##teaching a package (Learn R package)
    ## showing data visualizations to non-experts
    ## streamline certain code-intensive things 
#basics
#Shiny app has 2 components,
  ##UI (userinterface) object dicatetes the appearence of the app, UI f(x) write 
  # HTML, for something to appear, it needs to be in UI
  ##Server, function contains rendering expressions that create the objects to display 

#UI code :
  # The ui type:
    #fluidPage , puts elements in rows that can include columns 
    #navbaarPage , have a navagation bar
  # Layout Elements 
  # Theme information 
  # Output and Inputs objects

#Server : 
  # Rendering functions - build a new object to display every time the inputs change
  # Reactive expressions
    # reactive() - caches reactive objects so yoiu can access them later in the server logic ***
    # eventReactive()- creates reactive objects but only when a specific input changes
    ### lazy functions because they wait for the user to do something
  #Observe expressions : change the ui based on input ie.
    #autopopulate defualat values in a form if a use has a selected a default 
    # change the range for one input based on another input 
    ### eager function 