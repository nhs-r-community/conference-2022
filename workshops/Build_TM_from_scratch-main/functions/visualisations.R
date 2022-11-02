library(ggplot2)
library(dplyr)
library(tidyr)


histoplotter <- function(data, y,
                         boxplot_fill='bisque',
                         boxplot_color='black',
                         chart_x_axis_lbl='Treatment',
                         chart_y_axis_lbl='Parameter',
                         point_transparency=0.2,
                         box_fill_transparency=0.4,
                         chart_title=NULL){

  .y <- enquo(y)

  plot <- data %>%
    gather(var, val, -!!.y) %>%
    ggplot(aes(x = !!.y, y = val)) +
    geom_jitter(aes(color=factor(!!.y)), alpha=point_transparency) +
    geom_boxplot(fill=boxplot_fill, color=boxplot_color, alpha=box_fill_transparency) +
    facet_wrap(~ var, scales = "free_y") +
    guides(color='none') +
    labs(
      x = chart_x_axis_lbl,
      y = chart_y_axis_lbl,
      title = chart_title) +
    theme(legend.position='none')

  return (plot)

}
