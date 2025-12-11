test_that("multiplication works", {
  expect_equal(calcSRscore(SRratio_test, threshold = c(-2, 2))$score,
               SRscore_test$score)
  expect_equal(as.numeric(unlist(calcSRscore(logHNratioHypoxia, threshold = c(-1, 1))["score"])),
               HNscore$HN.score)
})
