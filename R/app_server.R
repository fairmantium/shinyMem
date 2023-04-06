#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # When Button is Pushed, Query Uniprot
  uniprotCall <- shiny::eventReactive(input$submitUniprot, {

    df <- getUniprotJson(uniprot_id = input$uniprotInput)

  })

  # Put in Table
  output$outputUniprotTable <- DT::renderDT({
    req(uniprotCall)

    # Make Datatable Object
    DT::datatable(
      uniprotCall(),
      class = 'stripe',
      rownames = FALSE,
      filter = 'top',
      options = list(
        pageLength = 5,
        autoWidth = TRUE,
        searching = TRUE,
        searchHighlight = TRUE,
        scrollX = TRUE
      )
    )

  })

}
