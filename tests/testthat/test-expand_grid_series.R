test_that("multiplication works", {

  expect_equal(nrow(expand_by_group(MetadataABA, control_sample, treated_sample, Series)),
               nrow(sample_pair_test))

  expect_equal(calculate_SRratio(TranscriptomeABA, "control_sample", "treated_sample", sample_pair_test, is.logarithmic = TRUE),
               SRratio_test)

  expect_equal(calculate_SRratio(TPMHypoxia, "run_accession..normoxia.", "run_accession..hypoxia.", MetadataHypoxia, is.logarithmic = FALSE),
               logHNratioHypoxia)

  expect_equal(calculate_SRscore(SRratio_test),
               SRscore_test)

  expect_equal(as.numeric(unlist(calculate_SRscore(logHNratioHypoxia)["SR1"])),
               HNscore$HN.score)

  expect_equal(ncol(get_diffexp(sample(SRratio_test[, 1], 1), SRratio_test, MetadataABA)), 1 + ncol(MetadataABA))
})
