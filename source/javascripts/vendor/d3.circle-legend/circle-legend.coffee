class d3.chart.CircleLegend extends d3.chart.BaseChart

    constructor: ->
        @accessors = {} unless @accessors?
        @accessors.color_scale = d3.scale.category20()
        @accessors.radius = 3
        @accessors.text_value = (d) -> d
        super

    _draw: (element, data, i) ->
                 
        width = $(element)[0].getBBox().width
        # convenience accessors
        color_scale = @color_scale()
        text_value = @text_value()
        radius = @radius()

        font_size = $(element).css('font-size')
        legend_element_height = Math.floor(parseInt(font_size.replace('px','')) * 1.5)
        legend_circle_width = 0.05 * width

        legend_group = d3.select element
            .selectAll ".legends"
            .data [color_scale.domain()]

        legend_group
            .enter()
            .append "g"
            .classed "legends", true
            
        legend_group.exit().remove()

        legends = legend_group.selectAll ".legend"
            .data (d) -> d

        legends.enter()
            .append "g"
            .classed "legend", true

        legends.each (d) ->
            circles = d3.select this
                .selectAll "circle"
                .data [d]

            circles
                .enter()
                .append "circle"
                .classed "legend", true
                .attr "cx", width - legend_circle_width
                .attr "cy", 0.5 * legend_element_height
                .attr "r", radius
                .attr "fill", color_scale

            circles.exit().remove()

            texts = d3.select this
                .selectAll "text"
                .data [d]

            texts
                .enter()
                .append "text"
                .attr "x", width - 1.2 * legend_circle_width
                .attr "y", 0.5 * legend_element_height
                .attr "dy", 0.25 * legend_element_height
                .style "text-anchor", "end"
                .text text_value

            texts.exit().remove()

        legends.attr "transform", (d, i) ->
            "translate(0, #{legend_element_height * i})"

        legends.exit().remove()
