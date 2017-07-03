#!/usr/bin/env Rscript

library(ggplot2)
library(data.table)
library(argparse)
library(rjson)

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

commandline_parser = ArgumentParser(
        description="merge the datasets into one data.table")
commandline_parser$add_argument('source', nargs=1)
commandline_parser$add_argument('output', nargs=1)
args = commandline_parser$parse_args()

summary = readRDS(args$source)

summaryplot = ggplot(summary) + 
    geom_point(aes(x=size, y=mean_R), size=2) +
    geom_errorbar(aes(x=size, ymax=mean_R + sd_R, ymin=mean_R - sd_R)) +
    labs(
         x="particle size (μm)",
         y="R")

print(summaryplot)

width = 7
factor = 0.618
height = width * factor
ggsave(args$output, summaryplot, width=width, height=height, dpi=300)

invisible(readLines(con="stdin", 1))
