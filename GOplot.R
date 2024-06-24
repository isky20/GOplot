library(GOplot)
library(tidyr)

# Initialize a list to store terms
term <- list()

# Loop through all CSV files in the directory
for (i in list.files(pattern = ".csv")) {
  print(i)  # Print the name of the file being processed
  df1 <- read.csv(i)[,c("genes","term")]  # Read the CSV file and select 'genes' and 'term' columns
  term[[i]] <- df1$term  # Store the terms in the list
}

# Get unique terms from all files
terms <- unique(unlist(term))

# Define a vector of colors
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

# Create a dataframe with terms and their corresponding colors
dcolor <- data.frame(terms = terms, color = colors)

# Specify the file ID (without the .csv extension)
ST <- "TTR"

# Read the specified CSV file
df <- read.csv(paste(ST, "csv", sep = "."))  # File should have columns 'genes', 'terms', and 'logFC'

# Extract unique genes and their logFC values
dff <- unique(df[, c("genes", "logFC")])

# Prepare data for chord plot
chord <- chord_dat(data = df, genes = dff, process = unique(df$term))

# Select terms for coloring
l <- head(colnames(chord), -1)
indices <- match(dcolor$terms, l, nomatch = 0)
sub_df <- dcolor[indices != 0, ]
sub_df <- sub_df[match(l, sub_df$terms), ]

# Generate the chord plot
svg(paste(ST, "svg", sep = "."), width = 20, height = 20)
par(mar = c(1, 1, 1, 1))
GOChord(chord, space = 0.02, gene.order = 'logFC',
        gene.space = 0.25, gene.size = 6,
        lfc.min = min(df$logFC), 
        lfc.max = max(df$logFC),
        lfc.col = "red", 
        ribbon.col = c(sub_df$color))
dev.off()

