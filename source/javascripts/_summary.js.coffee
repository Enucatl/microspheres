$ ->
    placeholder = "#summary-plot"
    data = $(placeholder).data("src")
    width = $(placeholder).width()
    factor = 0.618
    height = width * factor

    scatter = new d3.chart.Scatter()
        .width width
        .height height
        .x_value (d) -> d.particle_size
        .y_value (d) -> d.mean_R
        .color_value (d) -> d.file
        .margin {
            bottom: 50
            left: 50
            top: 50
            right: 50
        }

    scatter.x_scale()
        .domain [0, 10]
    scatter.y_scale()
        .domain [
            0.8 * d3.min data, scatter.y_value()
            1.2 * d3.max data, scatter.y_value()
        ]
        .nice()

    axes = new d3.chart.Axes()
        .x_scale scatter.x_scale()
        .y_scale scatter.y_scale()
        .x_title "diameter (μm)"
        .y_title "ratio of the logarithms"

    errorbars = new d3.chart.Errorbar()
        .x_scale scatter.x_scale()
        .y_scale scatter.y_scale()
        .x_value scatter.x_value()
        .y_value scatter.y_value()
        .y_error_value (d) -> d.sd_R

    d3.select placeholder
        .datum data
        .call scatter.draw

    d3.select placeholder
        .select "svg"
        .select "g"
        .datum data
        .call errorbars.draw

    d3.select placeholder
        .select "svg"
        .select "g"
        .datum 1
        .call axes.draw

    # redraw circles on top of errorbars
    # http://stackoverflow.com/a/26277417
    d3.select placeholder
        .select "svg"
        .select "g"
        .select ".circles"
        .attr "id", "circles"
    d3.select placeholder
        .select "svg"
        .select "g"
        .append "use"
        .attr "xlink:href", "#circles"
