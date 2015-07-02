$ ->
    dataset = "data/S00044_S00063.csv"
    d3.csv dataset,
        (d) ->
            row: parseInt d.row
            pixel: parseInt d.pixel
            absorption: d.A
            darkfield: d.B
            ratio: d.R
        , (error, data) ->
            return if error?
            create_image = (placeholder, color_value) ->
                original_width = d3.max data, (d) -> d.pixel
                original_height = d3.max data, (d) -> d.row
                width = $(placeholder).width()
                factor = 0.618
                height = width * factor

                image = new d3.chart.Image()
                    .width width
                    .height height
                    .original_width original_width
                    .original_height original_height
                    .color_value (d) -> d[color_value]
                    .margin {
                        bottom: 0
                        left: 0
                        top: 0
                        right: 0
                        }

                colorbar = new d3.chart.Colorbar()
                    .orient "horizontal"
                    .color_scale image.color_scale()
                    .barlength image.width()
                    .barthickness 0.1 * image.height()
                    .margin {
                        bottom: 0.2 * image.height()
                        left: 0
                        top: 0
                        right: 0
                        }

                sorted = data.map image.color_value()
                    .sort d3.ascending
                scale_min = d3.quantile sorted, 0.05
                scale_max = d3.quantile sorted, 0.95
                image.color_scale()
                    .domain [scale_min, scale_max]
                    .nice()

                d3.select placeholder
                    .datum data
                    .call image.draw
                d3.select placeholder
                    .datum [0]
                    .call colorbar.draw

            create_image "#absorption-image", "absorption"
            create_image "#darkfield-image", "darkfield"
            create_image "#ratio-image", "ratio"
