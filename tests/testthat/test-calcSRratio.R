test_that("multiplication works", {
  expect_equal(calcSRratio(TranscriptomeABA, "control_sample", "treated_sample", sample_pair_test, is.log2 = TRUE),
               SRratio_test)
  expect_equal(calcSRratio(TPMHypoxia, "run_accession..normoxia.", "run_accession..hypoxia.", MetadataHypoxia, is.log2 = FALSE),
               logHNratioHypoxia)
})
