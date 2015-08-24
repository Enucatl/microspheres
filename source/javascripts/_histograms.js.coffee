$ ->
    window.show_plots = (dataset) ->
        d3.csv dataset,
            (d) ->
                absorption: d.A
                darkfield: d.B
                ratio: d.R
                visibility: d.v
            , (error, data) ->
                return if error?
                create_histogram = (placeholder, color_value) ->
                    width = $(placeholder).width()
                    factor = 0.618
                    height = width * factor

                    histogram = new d3.chart.Bar()
                        .width width
                        .height height
                        .margin {
                            bottom: 100
                            left: 100
                            top: 50
                            right: 50
                            }

                    n_bins = 30

                    histogram.x_scale()
                        .domain [
                            0.8 * d3.min data, (d) -> d[color_value]
                            1.2 * d3.max data, (d) -> d[color_value]
                        ]
                        .nice()

                    histogram_data = d3.layout.histogram()
                        .bins(histogram.x_scale().ticks(n_bins))(
                            data.map (d) -> d[color_value])
                    histogram.y_scale().domain [0, 1.1 * d3.max histogram_data, (d) -> d.y]

                    histogram_axes = new d3.chart.Axes()
                        .x_scale histogram.x_scale()
                        .y_scale histogram.y_scale()
                        .x_title color_value
                        .y_title "#pixels"

                    histogram_axes.y_axis().ticks(4)
                    histogram_axes.x_axis().ticks(5)

                    d3.select placeholder
                        .datum histogram_data
                        .call histogram.draw

                    d3.select placeholder
                        .select "svg"
                        .select "g"
                        .datum 1
                        .call histogram_axes.draw

                create_histogram "#absorption-histogram", "absorption"
                create_histogram "#darkfield-histogram", "darkfield"
                create_histogram "#ratio-histogram", "ratio"
                create_histogram "#visibility-histogram", "visibility"
