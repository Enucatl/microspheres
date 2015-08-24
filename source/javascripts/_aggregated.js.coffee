$ ->
    placeholder = "#aggregated"
    dataset = "data/aggregated.json"
    d3.json dataset, (error, data) ->
        return if error?
        width = $(placeholder).width()
        factor = 0.618
        height = width * factor

        data = data.map (a) ->
            a.values.map (e) ->
                e.name = a.name
                e
        data = data.reduce (a, b) -> a.concat b
        data = data.filter (d) -> d[1] > 0.05

        scatter = new d3.chart.Scatter()
            .width width
            .height height
            .radius 5
            .x_value (d) -> d[1]
            .y_value (d) -> d[2]
            .margin {
                bottom: 100
                left: 50
                top: 50
                right: 50
            }

        scatter.x_scale().domain [0, 1]
        scatter.y_scale().domain [1, 5]

        axes = new d3.chart.Axes()
            .x_scale scatter.x_scale()
            .y_scale scatter.y_scale()
            .x_title "transmission"
            .y_title "R"

        axes.y_axis().ticks(5)
        axes.x_axis().ticks(5)

        legend = new d3.chart.CircleLegend()
            .color_scale scatter.color_scale()
            .radius scatter.radius()
            .text_value (d) -> d.toLowerCase()

        d3.select placeholder
            .datum data
            .call scatter.draw

        d3.select placeholder
            .select "svg"
            .select "g"
            .datum 1
            .call axes.draw
            .call legend.draw
