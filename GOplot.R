library(GOplot)
#file should have col called genes, term, logFC

df <- read.csv("Table S7 t2.csv")[,c("genes","term","logFC")]

dff <- unique(df[,c("genes","logFC")])
dff$logFC <- as.numeric(dff$logFC)


chord <- chord_dat(data = df, genes = dff, process = unique(df$term))

svg("chord_diagram.svg", width = 20, height = 20)  # Set the dimensions of the SVG file
par(mar = c(1, 1, 1, 1))  # Set margins to make the plot tight
GOChord(chord,space = 0.02, gene.order = 'logFC', gene.space = 0.25, gene.size =6, lfc.min = 1, lfc.max = 100)
dev.off()
