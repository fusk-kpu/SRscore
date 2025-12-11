test_that("multiplication works", {
  expect_equal(length(find_diffexp(sample(SRratio_test[, 1], 1), SRratio_test, SRscore_test, MetadataABA)), 2)
})
