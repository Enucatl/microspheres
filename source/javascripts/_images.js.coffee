$ ->
    dataset = "data/S00044_S00063.csv"
    placeholder = "#absorption"
    d3.csv dataset,
        (d) ->
            row: parseInt d.row
            pixel: parseInt d.pixel
            absorption: d.A
            darkfield: d.B
            ratio: d.R
        , (error, data) ->
            return if error?
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
                .color_value (d) -> d.absorption

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
