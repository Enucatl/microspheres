$ ->
    placeholder = "#summary-plot"
    data = $(placeholder).data("src")
    width = $(placeholder).width()
    factor = 0.618
    height = width * factor

    scatter = new d3.chart.Scatter()
        .width width
        .height height
        .x_value (d) -> d.thickness
        .y_value (d) -> d.mean_R
        .color_value (d) -> d.file

    d3.select placeholder
        .datum data
        .call scatter.draw
