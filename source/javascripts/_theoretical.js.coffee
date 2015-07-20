$ ->
    create_histogram = ->
        placeholder = "##{this.id}"
        dataset = $(this).data "src"
        variable = $(this).data "var"
        y_title = $(this).data "ytitle"
        normalize = $(this).data "normalize"
        logarithmic = $(this).data "logarithmic"
        d3.csv dataset,
            (d) ->
                energy: parseInt d.energy
                value: parseFloat d[variable]
            , (error, data) ->
                return if error?
                width = $(placeholder).width()
                factor = 0.618
                height = width * factor

                #normalize
                if normalize?
                    total = d3.sum data, (d) -> d.value
                    data = data.map (d) ->
                        energy: d.energy
                        value: d.value / total

                histogram = new d3.chart.Bar()
                    .width width
                    .height height
                    .x_value (d) -> d.energy
                    .y_value (d) -> d.value
                    .margin {
                        bottom: 50
                        left: 50
                        top: 50
                        right: 50
                    }

                histogram.x_scale()
                    .domain [
                        d3.min data, histogram.x_value()
                        d3.max data, histogram.x_value()
                    ]

                #set log scale
                if logarithmic?
                    histogram.y_scale d3.scale.log()

                histogram.y_scale()
                    .domain [
                        d3.min data, histogram.y_value()
                        d3.max data, histogram.y_value()
                    ]

                axes = new d3.chart.Axes()
                    .x_scale histogram.x_scale()
                    .y_scale histogram.y_scale()
                    .x_title "energy (keV)"
                    .y_title y_title

                d3.select placeholder
                    .datum data
                    .call histogram.draw

                d3.select placeholder
                    .select "svg"
                    .select "g"
                    .datum 1
                    .call axes.draw

    $(".theoretical-histogram").each create_histogram
