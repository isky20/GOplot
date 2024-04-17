library(GOplot)
library(tidyr)

term <- list()
#file should have col called genes, term, logFC
for (i in list.files(pattern = ".csv")) {
  print(i)
  df1 <- read.csv(i)[,c("genes","term")]
  term[[i]] <- df1$term
}

terms <- unique(unlist(term))

colors <- c("coral", "blue", "mediumvioletred", "sandybrown",
            "salmon", "lavender", "paleturquoise", "orchid", "tan",
            "steelblue", "peru", "thistle", "slateblue",
            "rosybrown", "orange", "lightseagreen",
            "lightslategray", "lightskyblue", "lightsteelblue",
            "lightgreen", "lightblue", "pink",
            "yellow", "cyan", "brown", "#CC99FF",
            "#FFFFCC", "purple", "magenta",
            "lightgray", "turquoise", 
            "tomato", "mediumorchid", "cornflowerblue", 
            "gold", "skyblue",
            "lightyellow", "linen", "palegreen", "hotpink", "peachpuff",
            "seashell", "lavenderblush", "mintcream", "honeydew", "ivory")[1:length(terms)]

dcolor <- data.frame(terms=terms,color= colors)



ST <- "TTR"   #Enter file ID (file ID.csv)
df <- read.csv(paste(ST,"csv", sep = ".")) #file has three columns genes, terms and logFC 
  
  
# Extract unique genes and process terms
dff <- unique(df[, c("genes", "logFC")])
chord <- chord_dat(data = df, genes = dff, process = unique(df$term))
  
  # Select terms for coloring
l <- head(colnames(chord), -1)
indices <- match(dcolor$term, l, nomatch = 0)
sub_df <- dcolor[indices != 0, ]
sub_df <- sub_df[match(l, sub_df$term), ]
  
# Generate plot
svg(paste(ST,"svg", sep = "."), width = 20, height = 20)
par(mar = c(1, 1, 1, 1))
GOChord(chord, space = 0.02, gene.order = 'logFC',
          gene.space = 0.25, gene.size = 6,
          lfc.min = min(df$logFC), 
          lfc.max = max(df$logFC),
          lfc.col = "red", 
          ribbon.col = c(sub_df$color))
dev.off()
  
