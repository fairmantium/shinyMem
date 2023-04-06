#' uniprotQuery
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
getUniprotJson <- function(uniprot_id) {

  url <- paste0("https://www.uniprot.org/uniprot/", uniprot_id, ".json")
  res <- httr::GET(url)
  content <- httr::content(res, as = "text")
  json_data <- jsonlite::fromJSON(content)

  # Sequence
  uniprotSeq <- json_data$sequence$value

  # Get The Domains
  uniprotFeatures <- json_data$features |>
    dplyr::filter(type %in% c("Topological domain", "Transmembrane")) |>
    dplyr::mutate(start = location$start$value,
                  end = location$end$value) |>
    dplyr::transmute(Type = type,
                     Description = description,
                     Start = start,
                     End = end
                     )

  # Go Through All Rows
  cutSequences <- as.character()

  for (n in c(1:nrow(uniprotFeatures))) {
    rowData <- uniprotFeatures[n, ]
    cutSequences <- c(cutSequences, substr(uniprotSeq, rowData$Start, rowData$End))
  }

  uniprotFeatures$Sequence <- cutSequences

  return(uniprotFeatures)

}
