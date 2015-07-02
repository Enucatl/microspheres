d3.axes
=======

xy axes as a reusable d3.js component.
This component doesn't force the creation of an svg element, make sure it
exists already!

Example
-------

A d3.line plot [with axes](http://enucatl.github.io/pilatus-experiments/2015/03/11/visibility.html)
and [source code](https://github.com/Enucatl/pilatus-experiments/blob/gh-pages/js/visibility.coffee#L25)

Add axes to a bar chart:

```coffeescript
plot = new d3.chart.Bar()
    .width width
    .height height
    .margin
        left: 0.10 * width
        top: 0
        bottom: 0.15 * height
        right: 0.05 * width
    .x_value (d) -> d.x
    .y_value (d) -> d.y

axes = new d3.chart.Axes()
    .x_title "x"
    .y_title "y"
    .x_scale plot.x_scale()
    .y_scale plot.y_scale()

d3.json "data.json", (error, data) ->
    if error?
        console.warn error
        return
    
    d3.select "#plot"
        .datum data
        .call plot.draw

    d3.select "#spectrum-plot"
        .select "svg"
        .select "g"
        .datum 1
        .call axes.draw

```


Depends on
----------

my [base chart component](https://github.com/Enucatl/d3.base.chart)
