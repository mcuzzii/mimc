
# Input answer key
answer_key <- read.csv("/Users/marcustornea/Desktop/Ateneo/MIMC/finals_answer_key.csv")

# Input score sheet
score_sheet <- read.csv("/Users/marcustornea/Desktop/Ateneo/MIMC/finals_example.csv")

# Isolate answer key data to only the Finals row.
answer_key <- answer_key[answer_key$X == "Finals", ]
answer_key <- answer_key[ , !is.na(answer_key)]

# Identify columns in the score sheet with the actual answers.
ss_answer_cols = score_sheet[1, ] %>%
  as.character() %>%
  as.numeric() %>%
  is.na() %>%
  `!` %>%
  which()

# Clean the score sheet data so it has a readable header. This code is subject to change.
score_sheet[1, ss_answer_cols] <- paste("Q.",
                                        as.character(score_sheet[1, ss_answer_cols]),
                                        sep = "")
score_sheet[1, is.na(score_sheet[1, ])] <- "Total.Score"
names(score_sheet) <- score_sheet[1, ]
score_sheet <- score_sheet[-1, ]

# Convert score sheet answers into boolean values (true = correct).
score_sheet <- score_sheet %>%
  dplyr::mutate(Total.Score = (Q.1 == answer_key$Q.1) +
                  (Q.2 == answer_key$Q.2) +
                  (Q.3 == answer_key$Q.3) +
                  (Q.4 == answer_key$Q.4) +
                  (Q.5 == answer_key$Q.5) +
                  2 * (Q.6 == answer_key$Q.6) +
                  2 * (Q.7 == answer_key$Q.7) +
                  2 * (Q.8 == answer_key$Q.8) +
                  2 * (Q.9 == answer_key$Q.9) +
                  2 * (Q.10 == answer_key$Q.10) +
                  3 * (Q.11 == answer_key$Q.11) +
                  3 * (Q.12 == answer_key$Q.12) +
                  3 * (Q.13 == answer_key$Q.13) +
                  3 * (Q.14 == answer_key$Q.14) +
                  3 * (Q.15 == answer_key$Q.15) +
                  3 * (Q.16 == answer_key$Q.16) +
                  3 * (Q.17 == answer_key$Q.17) +
                  3 * (Q.18 == answer_key$Q.18) +
                  3 * (Q.19 == answer_key$Q.19) +
                  3 * (Q.20 == answer_key$Q.20))

# Write final score sheet.
write.csv(score_sheet, "/Users/marcustornea/Desktop/Ateneo/MIMC/final_score_sheet.csv")
