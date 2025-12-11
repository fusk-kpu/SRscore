test_that("multiplication works", {
  expect_equal(nrow(expand_by_group(MetadataABA, "Series", "control_sample", "treated_sample")),
               nrow(sample_pair_test))
})
