class d3.chart.Errorbar extends d3.chart.BaseChart

    constructor: ->
        @accessors = {} unless @accessors?
        @accessors.x_value = (d) -> d.x
        @accessors.y_value = (d) -> d.y
        @accessors.y_error_value = (d) -> d.ey
        super

    _draw: (element, data, i) ->
                 
        # convenience accessors
        width = @width()
        height = @height()
        x_value = @x_value()
        y_value = @y_value()
        x_scale = @x_scale()
        y_scale = @y_scale()
        y_error_value = @y_error_value()

        g = d3.select element
            .selectAll ".errorbars"
            .data [data]

        g.enter()
            .append "g"
            .classed "errorbars", true

        g.append "defs"
            .append "marker"
            .attr "id", "markerCap"
            .attr "markerWidth", 6
            .attr "markerHeight", 2
            .attr "refX", 3
            .attr "refY", 0
            .append "line"
            .attr "x1", 0
            .attr "x2", 6
            .attr "y1", 0
            .attr "y2", 0
            .classed "errorcap", true

        # update errorbars
        errorbars = g.selectAll ".errorbar"
            .data (d) -> d

        errorbars
            .enter()
            .append "line"
            .classed "errorbar", true
            .attr "x1", (d) -> x_scale x_value d
            .attr "x2", (d) -> x_scale x_value d
            .attr "y1", (d) -> y_scale(y_value(d) - 0.5 * y_error_value(d))
            .attr "y2", (d) -> y_scale(y_value(d) + 0.5 * y_error_value(d))
            .style "marker-start", "url(#markerCap)"
            .style "marker-end", "url(#markerCap)"

        errorbars
            .exit()
            .remove()
