(function(){var t=function(t,r){function s(){this.constructor=t}for(var a in r)e.call(r,a)&&(t[a]=r[a]);return s.prototype=r.prototype,t.prototype=new s,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.CircleLegend=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.color_scale=d3.scale.category20(),this.accessors.radius=3,this.accessors.text_value=function(t){return t},r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t){var e,r,s,a,c,n,o,l,i;return i=$(t)[0].getBBox().width,e=this.color_scale(),l=this.text_value(),o=this.radius(),r=$(t).css("font-size"),a=Math.floor(1.5*parseInt(r.replace("px",""))),s=.05*i,c=d3.select(t).selectAll(".legends").data([e.domain()]),c.enter().append("g").classed("legends",!0),c.exit().remove(),n=c.selectAll(".legend").data(function(t){return t}),n.enter().append("g").classed("legend",!0),n.each(function(t){var r,c;return r=d3.select(this).selectAll("circle").data([t]),r.enter().append("circle").classed("legend",!0).attr("cx",i-s).attr("cy",.5*a).attr("r",o).attr("fill",e),r.exit().remove(),c=d3.select(this).selectAll("text").data([t]),c.enter().append("text").attr("x",i-1.2*s).attr("y",.5*a).attr("dy",.25*a).style("text-anchor","end").text(l),c.exit().remove()}),n.attr("transform",function(t,e){return"translate(0, "+a*e+")"}),n.exit().remove()},r}(d3.chart.BaseChart)}).call(this);