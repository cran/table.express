#' Building 'data.table' expressions with data manipulation verbs
#'
#' A specialization of [`dplyr`][dplyr::dplyr-package] verbs, as well as a set of custom ones, that
#' build expressions that can be used within a [`data.table`][data.table::data.table-package]'s
#' frame.
#'
#' @author Alexis Sarda-Espinosa
#'
#' @importFrom utils globalVariables
#'
#' @note
#'
#' Note that since version 0.3.0, it is not possible to load \pkg{table.express} and \pkg{dtplyr} at
#' the same time, since they define the same `data.table` methods for many \pkg{dplyr} generics.
#'
#' Bearing in mind that `data.table`s are also `data.frame`s, we have to consider that other
#' packages may uses `dplyr` internally without importing `data.table`. Since `dplyr`'s methods are
#' generic, calls to these methods in such packages would fail. The functions in this package try to
#' detect when this happens and delegate to the `data.frame` methods with a warning, which can be
#' safely ignored if you know that the error originates from a package that is not meant to work
#' with `data.table`. To avoid the warning, use `options(table.express.warn.cedta = FALSE)`.
#'
#' This software package was developed independently of any organization or institution that is or
#' has been associated with the author.
#'
#' @example man-roxygen/example-all.R
#'
"_PACKAGE"

# the last one is weird, CHECK says it comes from body_from_clauses, *shrug*
utils::globalVariables(c(".DT_", ".SD", ".COL", "!<-"))

#' @importFrom data.table :=
#' @export
#'
data.table::`:=`

#' @importFrom magrittr %>%
#' @export
#'
magrittr::`%>%`

#' @importFrom magrittr %T>%
#' @export
#'
magrittr::`%T>%`

#' @importFrom rlang !!
#' @export
#'
rlang::`!!`

#' @importFrom rlang !!!
#' @export
#'
rlang::`!!!`

sequential_arg_doc <- function() {
    paste(
        "@param .sequential",
        "If ``TRUE``, each expression in ``...`` is assigned to a nested body within curly braces to allow them to use variables created by previous expressions.",
        "The default is ``FALSE`` because enabling this may turn off some [data.table optimizations][data.table::datatable.optimize]."
    )
}
