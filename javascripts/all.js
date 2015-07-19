$("#menu-close").click(function(t){t.preventDefault(),$("#sidebar-wrapper").toggleClass("active")}),$("#menu-toggle").click(function(t){t.preventDefault(),$("#sidebar-wrapper").toggleClass("active")}),$(function(){$("a[href*=#]:not([href=#])").click(function(){if(location.pathname.replace(/^\//,"")==this.pathname.replace(/^\//,"")||location.hostname==this.hostname){var t=$(this.hash);if(t=t.length?t:$("[name="+this.hash.slice(1)+"]"),t.length)return $("html,body").animate({scrollTop:t.offset().top},1e3),!1}})}),function(){var t=function(t,e){return function(){return t.apply(e,arguments)}};null==d3.chart&&(d3.chart={}),d3.chart.BaseChart=function(){function e(){this.draw=t(this.draw,this),null==this.accessors&&(this.accessors={}),this.accessors.width=100,this.accessors.height=100,this.accessors.margin={top:0,right:0,bottom:0,left:0},this.accessors.x_scale=d3.scale.linear(),this.accessors.y_scale=d3.scale.linear(),this.buildAccessors()}return e.prototype.buildAccessors=function(){var t,e,r,a;r=this.accessors,a=[];for(e in r)t=r[e],null==this[e]&&a.push(function(t){return function(e,r){return t[e]=function(t){return arguments.length?(r=t,this):r}}}(this)(e,t));return a},e.prototype.draw=function(t){var e;return e=this,t.each(function(t,r){return e._draw(this,t,r)})},e.prototype._draw=function(){throw"_draw not implemented!"},e}()}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Axes=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.x_axis=d3.svg.axis(),this.accessors.y_axis=d3.svg.axis(),this.accessors.x_title="x",this.accessors.y_title="y",r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,o,i,l,u,h;return n=this.x_scale(),u=this.y_scale(),r=this.x_axis(),o=this.y_axis(),c=this.x_title(),h=this.y_title(),r.scale(n).orient("bottom"),o.scale(u).orient("left"),i=d3.select(t).selectAll(".y.axis").data([e]),i.enter().append("g").classed("y axis",!0),i.call(o),a=d3.select(t).selectAll(".x.axis").data([e]),a.enter().append("g").classed("x axis",!0),a.attr("transform","translate(0, "+u.range()[0]+")").call(r),s=d3.select(t).select(".x.axis").selectAll("text.label").data([e]),s.enter().append("text").classed("label",!0),s.attr("x",n.range()[1]).attr("dy","2.49em").style("text-anchor","end").text(c),s.exit().remove(),l=d3.select(t).select(".y.axis").selectAll("text.label").data([e]),l.enter().append("text").classed("label",!0),l.attr("transform","rotate(-90)").style("text-anchor","end").attr("dy","1em").text(h),l.exit().remove(),a.exit().remove(),i.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Image=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.original_width=0,this.accessors.original_height=0,this.accessors.color_value=function(t){return t.name},this.accessors.color_scale=d3.scale.linear(),r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,o,i,l,u,h,d,p,f,_,g,y;for(y=this.width(),i=this.height(),f=this.original_width(),p=this.original_height(),d=this.margin(),n=this.color_value(),s=this.color_scale(),a=d3.select(t).selectAll("canvas").data([e]),o=a.enter().append("canvas"),a.attr("width",f).attr("height",p).style("width",y+"px").style("height",i+"px").style("margin-top",d.top+"px").style("margin-left",d.left+"px").style("margin-bottom",d.bottom+"px").style("margin-right",d.right+"px"),s.range(["white","black"]),c=a.node().getContext("2d"),l=c.createImageData(f,p),_=-1,u=0,h=e.length;h>u;u++)g=e[u],r=d3.rgb(s(n(g))),l.data[++_]=r.r,l.data[++_]=r.g,l.data[++_]=r.b,l.data[++_]=255;return c.imageSmoothingEnabled=!1,c.putImageData(l,0,0)},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Colorbar=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.color_scale=d3.scale.linear(),this.accessors.orient="vertical",this.accessors.origin={x:0,y:0},this.accessors.barlength=100,this.accessors.barthickness=50,r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t){var e,r,a,s,n,c,o,i,l,u,h,d,p,f,_,g,y,m,v,x,w,b;return i=this.color_scale(),f=this.margin(),_=this.orient(),g=this.origin(),a=this.barlength(),s=this.barthickness(),n=function(){var t;return t=i.copy(),t.range([0,1]),t.domain([1,10]),Math.abs((t(10)-t(1))/Math.log(10)-(t(10)-t(2))/Math.log(5))<1e-6?"log":Math.abs((t(10)-t(1))/9-(t(10)-t(2))/8)<1e-6?"linear":Math.abs((t(10)-t(1))/(Math.sqrt(10)-1)-(t(10)-t(2))/(Math.sqrt(10)-Math.sqrt(2)))<1e-6?"sqrt":"unknown"},v=n(),"horizontal"===_?(m=[f.left,f.right,f.top,f.bottom],f.top=m[0],f.bottom=m[1],f.left=m[2],f.right=m[3],w="height",p="width",e="bottom",y="x",r="translate (0, "+s+")"):(w="width",p="height",e="right",y="y",r="translate ("+s+", 0)"),x=d3.select(t).selectAll("svg.colorbar").data([g]),h=x.enter().append("svg").classed("colorbar",!0).append("g").classed("colorbar",!0),h.append("g").classed("legend",!0).classed("rect",!0),h.append("g").classed("axis",!0).classed("color",!0),x.attr(w,s+f.left+f.right).attr(p,a+f.top+f.bottom).style("margin-top",g.y-f.top+"px").style("margin-left",g.x-f.left+"px"),b=1e3,l=x.select("g").attr("transform","translate("+f.left+", "+f.top+")"),u=i.copy(),d=d3.range(0,a,a/(u.domain().length-1)),d.push(a),u.range(d.reverse()),o=l.select(".legend.rect").selectAll("rect").data(d3.range(0,a)),o.enter().append("rect").classed("legend",!0).style("opacity",1).style("stroke-thickness",0).transition().duration(b).attr(w,s).attr(p,2).attr(y,function(t){return t}).style("fill",function(t){return i(u.invert(t))}),o.exit().remove(),c=d3.svg.axis().scale(u).orient(e).ticks(5),l.selectAll(".color.axis").attr("transform",r).call(c)},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Bar=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,o,i,l,u,h,d,p;return l=this.width(),c=this.height(),o=this.margin(),h=this.x_value(),p=this.y_value(),u=this.x_scale(),d=this.y_scale(),u.range([0,l]),d.range([c,0]),i=d3.select(t).selectAll("svg").data([e]),n=i.enter().append("svg").append("g"),i.attr("width",l+o.left+o.right).attr("height",c+o.top+o.bottom),s=i.select("g").attr("transform","translate("+o.left+", "+o.top+")"),s.selectAll("g.bars").data([e]).enter().append("g").classed("bars",!0),r=l/e.length,a=s.select("g.bars").selectAll("rect").data(function(t){return t}),a.enter().append("rect").classed("bar",!0),a.attr("x",function(t){return u(h(t))}).attr("y",function(t){return d(p(t))}).attr("width",r).attr("height",function(t){return c-d(p(t))}),a.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Scatter=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.radius=3,this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},this.accessors.color_value=function(t){return t.name},this.accessors.color_scale=d3.scale.category20(),r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,o,i,l,u,h,d,p,f,_,g;return d=this.width(),i=this.height(),l=this.margin(),u=this.radius(),f=this.x_value(),g=this.y_value(),p=this.x_scale(),_=this.y_scale(),n=this.color_value(),s=this.color_scale(),a=e.map(n).filter(function(t,e,r){return r.indexOf(t===e)}),s.domain(a),p.range([0,d]),_.range([i,0]),h=d3.select(t).selectAll("svg").data([e]),o=h.enter().append("svg").append("g"),h.attr("width",d+l.left+l.right).attr("height",i+l.top+l.bottom),c=h.select("g").attr("transform","translate("+l.left+", "+l.top+")"),c.selectAll(".circles").data([e]).enter().append("g").classed("circles",!0),r=c.select(".circles").selectAll(".circle").data(function(t){return t}),r.enter().append("circle").classed("circle",!0),r.attr("r",u).attr("cx",function(t){return p(f(t))}).attr("cy",function(t){return _(g(t))}).style("fill",function(t){return s(n(t))}),r.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Line=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.interpolation="linear",this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},this.accessors.color_value=function(t){return t.name},this.accessors.color_scale=d3.scale.category20(),r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,o,i,l,u,h,d,p,f,_,g;return d=this.width(),o=this.height(),u=this.margin(),i=this.interpolation(),f=this.x_value(),g=this.y_value(),p=this.x_scale(),_=this.y_scale(),s=this.color_value(),a=this.color_scale(),r=e.map(s).filter(function(t,e,r){return r.indexOf(t===e)}),a.domain(r),p.range([0,d]),_.range([o,0]),h=d3.select(t).selectAll("svg").data([e]),c=h.enter().append("svg").append("g"),h.attr("width",d+u.left+u.right).attr("height",o+u.top+u.bottom),n=h.select("g").attr("transform","translate("+u.left+", "+u.top+")"),n.selectAll(".paths").data([e]).enter().append("g").classed("paths",!0),l=n.select(".paths").selectAll(".path").data(function(t){return t}),l.enter().append("path").classed("path",!0),l.attr("stroke",function(t){return a(s(t))}).attr("d",function(t){return d3.svg.line().interpolate(i).x(function(t){return p(f(t))}).y(function(t){return _(g(t))})(t.values)}),l.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Errorbar=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},this.accessors.y_error_value=function(t){return t.ey},r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,o,i,l,u;return n=this.width(),s=this.height(),o=this.x_value(),u=this.y_value(),c=this.x_scale(),l=this.y_scale(),i=this.y_error_value(),a=d3.select(t).selectAll(".errorbars").data([e]),a.enter().append("g").classed("errorbars",!0),a.append("defs").append("marker").attr("id","markerCap").attr("markerWidth",6).attr("markerHeight",2).attr("refX",3).attr("refY",0).append("line").attr("x1",0).attr("x2",6).attr("y1",0).attr("y2",0).classed("errorcap",!0),r=a.selectAll(".errorbar").data(function(t){return t}),r.enter().append("line").classed("errorbar",!0).attr("x1",function(t){return c(o(t))}).attr("x2",function(t){return c(o(t))}).attr("y1",function(t){return l(u(t)-i(t))}).attr("y2",function(t){return l(u(t)+i(t))}).style("marker-start","url(#markerCap)").style("marker-end","url(#markerCap)"),r.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.CircleLegend=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.color_scale=d3.scale.category20(),this.accessors.radius=3,this.accessors.text_value=function(t){return t},r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t){var e,r,a,s,n,c,o,i,l;return l=$(t)[0].getBBox().width,e=this.color_scale(),i=this.text_value(),o=this.radius(),r=$(t).css("font-size"),s=Math.floor(1.5*parseInt(r.replace("px",""))),a=.05*l,n=d3.select(t).selectAll(".legends").data([e.domain()]),n.enter().append("g").classed("legends",!0),n.exit().remove(),c=n.selectAll(".legend").data(function(t){return t}),c.enter().append("g").classed("legend",!0),c.each(function(t){var r,n;return r=d3.select(this).selectAll("circle").data([t]),r.enter().append("circle").classed("legend",!0).attr("cx",l-a).attr("cy",.5*s).attr("r",o).attr("fill",e),r.exit().remove(),n=d3.select(this).selectAll("text").data([t]),n.enter().append("text").attr("x",l-1.2*a).attr("y",.5*s).attr("dy",.25*s).style("text-anchor","end").text(i),n.exit().remove()}),c.attr("transform",function(t,e){return"translate(0, "+s*e+")"}),c.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){$(function(){return window.show_image=function(t){return d3.csv(t,function(t){return{row:parseInt(t.row),pixel:parseInt(t.pixel),absorption:t.A,darkfield:t.B,ratio:t.R}},function(t,e){var r;if(null==t)return r=function(t,r){var a,s,n,c,o,i,l,u,h,d;return i=d3.max(e,function(t){return t.pixel}),o=d3.max(e,function(t){return t.row}),d=$(t).width(),s=.618,n=d*s,c=(new d3.chart.Image).width(d).height(n).original_width(i).original_height(o).color_value(function(t){return t[r]}).margin({bottom:0,left:0,top:0,right:0}),a=(new d3.chart.Colorbar).orient("horizontal").color_scale(c.color_scale()).barlength(c.width()).barthickness(.1*c.height()).margin({bottom:.2*c.height(),left:0,top:0,right:0}),h=e.map(c.color_value()).sort(d3.ascending),u=d3.quantile(h,.05),l=d3.quantile(h,.95),c.color_scale().domain([u,l]).nice(),d3.select(t).datum(e).call(c.draw),d3.select(t).datum([0]).call(a.draw)},r("#absorption-image","absorption"),r("#darkfield-image","darkfield"),r("#ratio-image","ratio")})}})}.call(this),function(){$(function(){return window.show_plots=function(t){return d3.csv(t,function(t){return{absorption:t.A,darkfield:t.B,ratio:t.R,visibility:t.v}},function(t,e){var r;if(null==t)return r=function(t,r){var a,s,n,c,o,i,l;return l=$(t).width(),a=.618,s=l*a,n=(new d3.chart.Bar).width(l).height(s).margin({bottom:50,left:50,top:50,right:50}),i=30,n.x_scale().domain([.8*d3.min(e,function(t){return t[r]}),1.2*d3.max(e,function(t){return t[r]})]).nice(),o=d3.layout.histogram().bins(n.x_scale().ticks(i))(e.map(function(t){return t[r]})),n.y_scale().domain([0,1.1*d3.max(o,function(t){return t.y})]),c=(new d3.chart.Axes).x_scale(n.x_scale()).y_scale(n.y_scale()).x_title(r).y_title("#pixels"),d3.select(t).datum(o).call(n.draw),d3.select(t).select("svg").select("g").datum(1).call(c.draw)},r("#absorption-histogram","absorption"),r("#darkfield-histogram","darkfield"),r("#ratio-histogram","ratio"),r("#visibility-histogram","visibility")})}})}.call(this),function(){$(function(){return $("#select-dataset").select2(),$("#select-dataset-plots").select2(),$("#select-dataset").on("change",function(){return window.show_image(this.value),$("#select-dataset-plots").value=this.value}),$("#select-dataset-plots").on("change",function(){return window.show_plots(this.value),$("#select-dataset").value=this.value}),window.show_image($("#select-dataset").val()),window.show_plots($("#select-dataset").val())})}.call(this),function(){$(function(){var t,e,r,a,s,n,c,o,i,l,u;return o="#summary-plot",e=$(o).data("exp"),i=$(o).data("theo"),u=$(o).width(),a=.618,s=u*a,i=[{sample_thickness:12,values:i.filter(function(t){return 12===t.sample_thickness})},{sample_thickness:45,values:i.filter(function(t){return 45===t.sample_thickness})}],l=(new d3.chart.Scatter).width(u).height(s).x_value(function(t){return t.particle_size}).y_value(function(t){return t.mean_R}).color_value(function(t){return t.sample_thickness}).margin({bottom:50,left:50,top:50,right:50}),l.x_scale().domain([0,8]),l.y_scale().domain([.8*d3.min(e,l.y_value()),1.2*d3.max(e,l.y_value())]).nice(),c=(new d3.chart.Line).width(u).height(s).x_value(l.x_value()).y_value(l.y_value()).color_value(l.color_value()).color_scale(l.color_scale()).x_scale(l.x_scale()).y_scale(l.y_scale()).margin({bottom:50,left:50,top:50,right:50}),t=(new d3.chart.Axes).x_scale(l.x_scale()).y_scale(l.y_scale()).x_title("diameter (\u03bcm)").y_title("ratio of the logarithms"),r=(new d3.chart.Errorbar).x_scale(l.x_scale()).y_scale(l.y_scale()).x_value(l.x_value()).y_value(l.y_value()).y_error_value(function(t){return t.sd_R}),d3.select(o).datum(e).call(l.draw),d3.select(o).datum(i).call(c.draw),d3.select(o).select("svg").select("g").datum(e).call(r.draw),n=(new d3.chart.CircleLegend).color_scale(l.color_scale()).width(u).text_value(function(t){return"sample thickness "+t+" mm"}),d3.select(o).select("svg").select("g").datum(1).call(t.draw).call(n.draw),d3.select(o).select("svg").select("g").select(".circles").attr("id","circles"),d3.select(o).select("svg").select("g").append("use").attr("xlink:href","#circles")})}.call(this);