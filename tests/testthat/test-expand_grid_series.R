test_that("multiplication works", {

  expect_equal(nrow(expand_by_group(MetadataABA, "Series", "control_sample", "treated_sample")),
               nrow(sample_pair_test))

  expect_equal(calcSRratio(TranscriptomeABA, "control_sample", "treated_sample", sample_pair_test, is.log = TRUE),
               SRratio_test)

  expect_equal(calcSRratio(TPMHypoxia, "run_accession..normoxia.", "run_accession..hypoxia.", MetadataHypoxia, is.log = FALSE),
               logHNratioHypoxia)

  expect_equal(calcSRscore(SRratio_test),
               SRscore_test)

  expect_equal(as.numeric(unlist(calcSRscore(logHNratioHypoxia)["SR1"])),
               HNscore$HN.score)

  expect_equal(length(find_diffexp(sample(SRratio_test[, 1], 1), SRratio_test, SRscore_test, MetadataABA)), 2)
})
