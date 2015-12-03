#!/usr/bin/env Rscript

library(ggplot2)
library(argparse)
library(data.table)
library(jsonlite)

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
    panel.border = element_blank()
))

parser <- ArgumentParser(description='weighted fit')
parser$add_argument('summary', nargs=1)
args <- parser$parse_args()

energy <- 60  # keV

dt <- data.table(particle_size=seq(0.1, 8, len=1000))
dt[, structure := structure.factor(particle_size)]

plot <- ggplot(dt, aes(x=particle_size, y=structure)) +
    geom_line() +
    labs(
         x="particle size (μm)",
         y="structure factor S"
         )

width = 10
factor = 0.618
height = width * factor
X11(width=width, height=height)
print(plot)
invisible(readLines(con="stdin", 1))
