context("  Anti join")

test_that("Anti join works.", {
    expected <- lhs[!rhs, on = "x"]
    ans <- lhs %>% start_expr %>% anti_join(rhs, "x") %>% end_expr
    expect_identical(ans, expected)

    expected <- paypal[!website, on = .(payment_id = session_id)]
    ans <- paypal %>% start_expr %>% anti_join(website, payment_id = session_id) %>% end_expr
    expect_identical(ans, expected)

    lhs <- data.table::setkey(data.table::copy(lhs), x)

    expected <- lhs[!rhs]
    ans <- lhs %>% start_expr %>% anti_join(rhs) %>% end_expr
    expect_identical(ans, expected)
})

test_that("Nesting expressions in anti_join's y works.", {
    nested <- data.table::copy(lhs)[x == "a"]
    expected <- lhs[!nested, on = "x"]
    ans <- lhs %>% start_expr %>% anti_join(nest_expr(filter(x == "a")), x) %>% end_expr
    expect_identical(ans, expected)
})

test_that("Eager anti_join works.", {
    expected <- lhs[!rhs, on = "x"]
    ans <- lhs %>% anti_join(rhs, "x")
    expect_identical(ans, expected)

    expected <- lhs[!rhs, .(y, v), on = "x"]
    ans <- lhs %>% anti_join(rhs, "x", .expr = TRUE) %>% select(y, v)
    expect_identical(ans, expected)
})

test_that("anti_join can delegate to data.frame method when necessary.", {
    .enclos <- rlang::env(asNamespace("rex"),
                          lhs = data.table::copy(lhs),
                          rhs = data.table::copy(rhs))

    .fn <- rlang::set_env(new_env = .enclos, function() {
        anti_join(rhs, lhs, by = c("x", "v"))
    })

    expect_warning(ans <- .fn(), "table.express")
    expect_equal(ans, dplyr:::anti_join.data.frame(rhs, lhs, by = c("x", "v")))

    .expr <- substitute(anti_join(data.table::as.data.table(rhs), data.table::as.data.table(lhs), x, v), .enclos)
    ans_from_workaround <- eval(.expr, envir = asNamespace("rex"))
    expect_equal(ans_from_workaround, anti_join(rhs, lhs, x, v))
})
