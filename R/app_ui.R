#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic

    # Start bs4Dash Dashboard Page
    bs4Dash::dashboardPage(
      title = "shinyMem",

      fullscreen = TRUE,
      scrollToTop = TRUE,

      # Dashboard Header
      header = bs4Dash::dashboardHeader(
        title = bs4Dash::dashboardBrand(
          title = "shinyMem v0.9.0"
        ),
        border = TRUE
      ),

      # Dashboard Sidebar
      sidebar = bs4Dash::dashboardSidebar(
        elevation = 3,
        minified = TRUE
      ),

      # Dashboard Body
      body = bs4Dash::dashboardBody(

        shiny::fluidRow(

          bs4Dash::bs4Card(
            title = "Uniprot Input",
            status = "primary",
            width = 12,

            shiny::fluidRow(
              bs4Dash::column(
                width = 12,

                shiny::textInput(
                  inputId = "uniprotInput",
                  label = "Give Me A Uniprot ID",
                  width = "100%",
                  value = "P19438",
                  placeholder = "P01375"
                )
              )
            ),

            shiny::fluidRow(
              bs4Dash::column(
                width = 2,

                bs4Dash::actionButton(
                  inputId = "submitUniprot",
                  label = "Submit",
                  width = "100%",
                  status = "primary"
                )
              ),

              bs4Dash::column(
                width = 10
              )
            )
          )
        ),

        shiny::fluidRow(

          bs4Dash::bs4Card(
            title = "Output Table",
            status = "primary",
            width = 12,

            # Output Data Table Checking
            shinycustomloader::withLoader(
              DT::dataTableOutput(
                outputId = "outputUniprotTable",
                width = "100%"
              ),
              type = "html",
              loader = "dnaspin"
            )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "shinyMem"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
