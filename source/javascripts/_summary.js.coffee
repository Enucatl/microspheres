$ ->
    draw_summary = (placeholder) ->
        data = $(placeholder).data("exp")
        prediction = $(placeholder).data("theo")
        width = $(placeholder).width()
        factor = 0.618
        height = width * factor
        prediction = [{
            sample_thickness: 12
            values: prediction.filter (d) -> d.sample_thickness == 12
        },{
            sample_thickness: 45
            values: prediction.filter (d) -> d.sample_thickness == 45
        }]

        color_value = (d) ->
            text = "sample thickness #{d.sample_thickness} mm"
            text += ", source filter #{d.filter}" if d.filter
            return text

        scatter = new d3.chart.Scatter()
            .width width
            .height height
            .x_value (d) -> d.particle_size
            .y_value (d) -> d.mean_R
            .radius 6
            .color_value color_value
            .margin {
                bottom: 100
                left: 50
                top: 50
                right: 50
            }

        scatter.x_scale()
            .domain [0, 8]
        scatter.y_scale()
            .domain [
                0.8 * d3.min data, scatter.y_value()
                1.2 * d3.max data, scatter.y_value()
            ]
            .nice()

        line = new d3.chart.Line()
            .width width
            .height height
            .x_value scatter.x_value()
            .y_value scatter.y_value()
            .color_value scatter.color_value()
            .color_scale scatter.color_scale()
            .x_scale scatter.x_scale()
            .y_scale scatter.y_scale()
            .margin scatter.margin()

        axes = new d3.chart.Axes()
            .x_scale scatter.x_scale()
            .y_scale scatter.y_scale()
            .x_title "particle diameter (μm)"
            .y_title "R"

        axes.y_axis().ticks(5)

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
            .datum prediction
            .call line.draw

        d3.select placeholder
            .select "svg"
            .select "g"
            .datum data
            .call errorbars.draw

        legend = new d3.chart.CircleLegend()
            .color_scale scatter.color_scale()
            .radius scatter.radius()
            .text_value (d) -> d

        d3.select placeholder
            .select "svg"
            .select "g"
            .datum 1
            .call axes.draw
            .call legend.draw

        # redraw circles on top of errorbars
        # http://stackoverflow.com/a/26277417
        d3.select placeholder
            .select "svg"
            .select "g"
            .select ".circles"
            .attr "id", "circles-#{placeholder.substring(1)}"
        d3.select placeholder
            .select "svg"
            .select "g"
            .append "use"
            .attr "xlink:href", "#circles-#{placeholder.substring(1)}"

        console.log scatter.color_scale().domain()

    draw_summary "#summary-plot"
    draw_summary "#summary-plot-hard-spectrum"
