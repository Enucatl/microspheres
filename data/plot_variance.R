#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)
library(ggplot2)

theme_set(theme_bw(base_size=12) + theme(
    legend.key.size=unit(1, 'lines'),
    text=element_text(face='plain', family='CM Roman'),
    legend.title=element_text(face='plain'),
    axis.line=element_line(color='black'),
    axis.title.y=element_text(vjust=0.1),
    axis.title.x=element_text(vjust=0.1),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.key = element_blank(),
    legend.position = "top",
    legend.direction = "vertical",
    panel.border = element_blank()
))

parser <- ArgumentParser(description='plot fit prediction')
parser$add_argument('source', nargs=1)
parser$add_argument('output', nargs=1)
args <- parser$parse_args()

datasets = fread(args$source)
setkey(datasets, csv)

read_table = function(row) {
    input = as.list(row)
    dt = fread(input$csv)[,
        `:=`(
            description = input$description,
            particle_size = input$particle_size
            )
        ]
}

min_visibility = 0.06
dt = rbindlist(apply(datasets, 1, read_table))[v > min_visibility]
dt[, sd_R_pixel := sd(R), by=c("pixel", "description", "particle_size")]
dt[, sd_R := sd(R), by=c("description", "particle_size")]

print(dt)


plot = ggplot(dt, aes(colour=description)) + 
    geom_histogram(aes(x=sd_R, group=description), alpha=0.5, size=2) +
    labs(
         x="pixel",
         y="sd(R)",
         colour="")

width = 7
factor = 1
height = width * factor
X11(width=width, height=height)
print(plot)
warnings()
ggsave(args$output, plot, width=width, height=height, dpi=300)
invisible(readLines(con="stdin", 1))
