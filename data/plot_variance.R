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

print(data)

print(datasets[, .(csv, particle_size, description)])

data = rbindlist(lapply(datasets[, .(csv, particle_size),
        function(row) {
            print(row)
            return(fread(row[, csv])[, particle_size := row[, particle_size]])
        }))

print(data)

#plot = ggplot(summary, aes(colour=description)) + 
    #geom_point(aes(x=particle_size, y=sd_R, group=description), size=2) +
    #geom_errorbar(aes(x=particle_size, ymax=mean_R + sd_R, ymin=mean_R -
                      #sd_R)) +
    #labs(
         #x="particle size (μm)",
         #y="R",
         #colour="")

#width = 7
#factor = 1
#height = width * factor
#X11(width=width, height=height)
#print(plot)
#warnings()
#ggsave(args$output, plot, width=width, height=height, dpi=300)
#invisible(readLines(con="stdin", 1))
