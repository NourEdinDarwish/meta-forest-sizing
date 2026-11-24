library(meta)

ma <- metagen(
  TE = c(0.2, 0.4, 0.3, 0.1, 0.5, 0.25),
  seTE = c(0.1, 0.2, 0.15, 0.12, 0.2, 0.11),
  studlab = paste("Study", LETTERS[1:6])
)

dir.create("results", showWarnings = FALSE)
forest(ma, filename = "results/forest.pdf")
forest(ma, filename = "results/forest.png")
