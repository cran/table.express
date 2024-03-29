% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VERBS-distinct.R
\name{distinct-table.express}
\alias{distinct-table.express}
\alias{distinct.ExprBuilder}
\alias{distinct.data.table}
\title{Rows with distinct combinations of columns}
\usage{
\method{distinct}{ExprBuilder}(
  .data,
  ...,
  .keep = TRUE,
  .n = 1L,
  .parse = getOption("table.express.parse", FALSE)
)

\method{distinct}{data.table}(.data, ...)
}
\arguments{
\item{.data}{An instance of \link{ExprBuilder}.}

\item{...}{Which columns to use to determine uniqueness.}

\item{.keep}{See details below.}

\item{.n}{Indices of rows to return \emph{for each} unique combination of the chosen columns. See
details.}

\item{.parse}{Logical. Whether to apply \code{\link[rlang:parse_expr]{rlang::parse_expr()}} to obtain the expressions.}
}
\description{
Rows with distinct combinations of columns
}
\details{
If \code{.keep = TRUE} (the default), the columns not mentioned in \code{...} are also kept. However, if
a new column is created in one of the expressions therein, \code{.keep} can also be set to a character
vector containing the names of \emph{all} the columns that should be in the result in addition to the
ones mentioned in \code{...}. See the examples.

The value of \code{.n} is only relevant when \code{.keep} is \emph{not} \code{FALSE}. It is used to subset \code{.SD} in
the built \code{data.table} expression. For example, we could get 2 rows per combination by setting
\code{.n} to \code{1:2}, or get the last row instead of the first by using \code{.N}. If more than one index is
used, and not enough rows are found, some rows will have \code{NA}. Do note that, at least as of
version 1.12.2 of \code{data.table}, only expressions with single indices are internally optimized.

To see more examples, check the
\href{https://asardaes.github.io/table.express/articles/table.express.html}{vignette}, or the
\link{table.express-package} entry.
}
\examples{

data("mtcars")

# compare with .keep = TRUE
data.table::as.data.table(mtcars) \%>\%
    distinct(amvs = am + vs, .keep = names(mtcars))

}
