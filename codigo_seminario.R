params <-
list(dl = FALSE)

## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, comment = NA)
knitr::opts_knit$set(root.dir = "..")


## ---- eval=params$dl-----------------------------------------------------
## download.file("https://raw.githubusercontent.com/emilopezcano/seminario_urjc_2019/master/docs/codigo_seminario.R", "codigo_seminario.R")
## download.file("https://emilopezcano.github.io/seminario_urjc_2019/mass.rds", "mass.rds")


## ------------------------------------------------------------------------
ansiedad <- readRDS("mass.rds")


## ------------------------------------------------------------------------
table(ansiedad$Gender)
table(ansiedad$`I find math interesting.`, ansiedad$Gender)


## ------------------------------------------------------------------------
barplot(table(ansiedad$`I find math interesting.`), las = 2)


## ------------------------------------------------------------------------
mosaicplot(Gender ~ `I find math interesting.`, data = ansiedad, las = 1)


## ---- message=FALSE------------------------------------------------------
freqs <- table(ansiedad$`I find math interesting.`, ansiedad$`Mathematics makes me feel nervous.`)
library(gplots)
balloonplot(freqs, label = FALSE, show.margins = FALSE, ylab = "Interesantes",
            xlab = "Nervios",
            main = "Interesantes vs. nervioso")


## ------------------------------------------------------------------------
chisq.test(freqs)


## ------------------------------------------------------------------------
chisq.test(ansiedad$`I get uptight during math tests.`, ansiedad$Gender)


## ---- message=FALSE------------------------------------------------------
ansiedad.1 <- table(ansiedad$`I get uptight during math tests.`, ansiedad$`Math is one of my favorite subjects.`)

library(FactoMineR)
analisis <- CA(ansiedad.1, graph = FALSE)
analisis


## ------------------------------------------------------------------------
summary(analisis)


## ---- message=FALSE------------------------------------------------------
library(factoextra)
fviz_screeplot(analisis, addlabels = TRUE, ylim = c(0, 50))


## ------------------------------------------------------------------------
fviz_screeplot(analisis, addlabels = TRUE, ylim = c(0, 50)) +
 geom_hline(yintercept=25, linetype=2, color="red")


## ------------------------------------------------------------------------
fviz_cos2(analisis, choice = "row", axes = 1:2)


## ---- message=0----------------------------------------------------------
library(corrplot)
corrplot(get_ca_row(analisis)$cos2, is.corr=FALSE)


## ---- message=0----------------------------------------------------------
library(corrplot)
corrplot(get_ca_row(analisis)$contrib, is.corr=FALSE)


## ---- message=FALSE, fig.height=4----------------------------------------
library(gridExtra)
p1 <- fviz_contrib(analisis, choice = "row", axes = 1, top = 10)
# Contributions of rows to dimension 2
p2 <- fviz_contrib(analisis, choice = "row", axes = 2, top = 10)
grid.arrange(p1, p2, nrow = 1)


## ---- message=FALSE, fig.height=5----------------------------------------
fviz_ca_row(analisis, col.row = "contrib", 
                  alpha.row = "cos2",
                  gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                  repel = TRUE)


## ------------------------------------------------------------------------
fviz_cos2(analisis, choice = "col", axes = 1:2)


## ---- message=0----------------------------------------------------------
corrplot(get_ca_col(analisis)$cos2, is.corr=FALSE)


## ---- message=0----------------------------------------------------------
corrplot(get_ca_col(analisis)$contrib, is.corr=FALSE)


## ---- message=FALSE, fig.height=4----------------------------------------
p1 <- fviz_contrib(analisis, choice = "col", axes = 1, top = 10)
# Contributions of rows to dimension 2
p2 <- fviz_contrib(analisis, choice = "col", axes = 2, top = 10)
grid.arrange(p1, p2, nrow = 1)


## ---- message=FALSE, fig.height=5----------------------------------------
fviz_ca_col(analisis, col.col = "contrib", 
                  alpha.col = "cos2",
                  gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                  repel = TRUE)


## ------------------------------------------------------------------------
fviz_ca_biplot(analisis, repel = TRUE)


## ------------------------------------------------------------------------
fviz_ca_biplot(analisis, 
               map = "rowprincipal", 
               arrows = c(TRUE, TRUE),
               repel = TRUE)


## ------------------------------------------------------------------------
dimdesc(analisis, axes = 1:2)


## ------------------------------------------------------------------------
ansiedad.1
ansiedad.2 <- table(ansiedad$`I get uptight during math tests.`, ansiedad$Gender)
ansiedad.3 <- cbind(ansiedad.1, ansiedad.2)


## ------------------------------------------------------------------------
analisis.2 <- CA(ansiedad.3, col.sup =  6:7, graph = FALSE)


## ------------------------------------------------------------------------
fviz_ca_biplot(analisis.2, repel = TRUE)


## ------------------------------------------------------------------------
colnames(ansiedad) <- c("G", "interesting", "uptight", "future", "blank", "life",
                        "worry", "sink", "challenging", "nervous", "more", 
                        "uneasy", "favorite", "enjoy", "confused")
for(i in 2:15){
  levels(ansiedad[, i]) <- 1:5
}
levels(ansiedad$G) <- c("F", "M")


## ------------------------------------------------------------------------
analisis.3 <- MCA(ansiedad, graph = FALSE)
analisis.3


## ------------------------------------------------------------------------
summary(analisis.3)


## ---- fig.width=10, fig.height=10, out.width="100%"----------------------
fviz_mca_biplot(analisis.3, repel = TRUE)


## ------------------------------------------------------------------------
fviz_mca_ind(analisis.3, repel = TRUE)


## ------------------------------------------------------------------------
fviz_mca_var(analisis.3, choice = "var", repel = TRUE)


## ---- message=FALSE, warning=FALSE---------------------------------------
gdata <- data.frame(item = "Tenso", 
                    respuesta = rownames(analisis$row$coord),
                    analisis$row$coord[, 1:2], 
                    cos2 = rowSums(analisis$row$cos2[, 1:2]),
                    contrib =rowSums(analisis$row$contrib[, 1:2]))
gdata <- rbind(gdata, 
               data.frame(item = "Favorita", 
                          respuesta = rownames(analisis$col$coord),
                          analisis$col$coord[, 1:2],  
                          cos2 = rowSums(analisis$col$cos2[, 1:2]),
                          contrib =rowSums(analisis$col$contrib[, 1:2])))


library(plotly)
plot_ly(gdata, 
        type = "scatter", 
        x = ~Dim.1, 
        y = ~Dim.2, mode = "text",
        text = ~respuesta,
        color = ~item)

