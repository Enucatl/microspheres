$("#menu-close").click(function(t){t.preventDefault(),$("#sidebar-wrapper").toggleClass("active")}),$("#menu-toggle").click(function(t){t.preventDefault(),$("#sidebar-wrapper").toggleClass("active")}),$(function(){$("a[href*=#]:not([href=#])").click(function(){if(location.pathname.replace(/^\//,"")==this.pathname.replace(/^\//,"")||location.hostname==this.hostname){var t=$(this.hash);if(t=t.length?t:$("[name="+this.hash.slice(1)+"]"),t.length)return $("html,body").animate({scrollTop:t.offset().top},1e3),!1}})}),function(){var t=function(t,e){return function(){return t.apply(e,arguments)}};null==d3.chart&&(d3.chart={}),d3.chart.BaseChart=function(){function e(){this.draw=t(this.draw,this),null==this.accessors&&(this.accessors={}),this.accessors.width=100,this.accessors.height=100,this.accessors.margin={top:0,right:0,bottom:0,left:0},this.accessors.x_scale=d3.scale.linear(),this.accessors.y_scale=d3.scale.linear(),this.buildAccessors()}return e.prototype.buildAccessors=function(){var t,e,r,a;r=this.accessors,a=[];for(e in r)t=r[e],null==this[e]&&a.push(function(t){return function(e,r){return t[e]=function(t){return arguments.length?(r=t,this):r}}}(this)(e,t));return a},e.prototype.draw=function(t){var e;return e=this,t.each(function(t,r){return e._draw(this,t,r)})},e.prototype._draw=function(){throw"_draw not implemented!"},e}()}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Axes=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.x_axis=d3.svg.axis(),this.accessors.y_axis=d3.svg.axis(),this.accessors.x_title="x",this.accessors.y_title="y",r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,i,l,o,u,h;return n=this.x_scale(),u=this.y_scale(),r=this.x_axis(),i=this.y_axis(),c=this.x_title(),h=this.y_title(),r.scale(n).orient("bottom"),i.scale(u).orient("left"),l=d3.select(t).selectAll(".y.axis").data([e]),l.enter().append("g").classed("y axis",!0),l.call(i),a=d3.select(t).selectAll(".x.axis").data([e]),a.enter().append("g").classed("x axis",!0),a.attr("transform","translate(0, "+u.range()[0]+")").call(r),s=d3.select(t).select(".x.axis").selectAll("text.label").data([e]),s.enter().append("text").classed("label",!0),s.attr("x",n.range()[1]).attr("dy","2.49em").style("text-anchor","end").text(c),s.exit().remove(),o=d3.select(t).select(".y.axis").selectAll("text.label").data([e]),o.enter().append("text").classed("label",!0),o.attr("transform","rotate(-90)").style("text-anchor","end").attr("dy","1em").text(h),o.exit().remove(),a.exit().remove(),l.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Image=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.original_width=0,this.accessors.original_height=0,this.accessors.color_value=function(t){return t.name},this.accessors.color_scale=d3.scale.linear(),r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,i,l,o,u,h,d,p,_,f,g,y;for(y=this.width(),l=this.height(),_=this.original_width(),p=this.original_height(),d=this.margin(),n=this.color_value(),s=this.color_scale(),a=d3.select(t).selectAll("canvas").data([e]),i=a.enter().append("canvas"),a.attr("width",_).attr("height",p).style("width",y+"px").style("height",l+"px").style("margin-top",d.top+"px").style("margin-left",d.left+"px").style("margin-bottom",d.bottom+"px").style("margin-right",d.right+"px"),s.range(["white","black"]),c=a.node().getContext("2d"),o=c.createImageData(_,p),f=-1,u=0,h=e.length;h>u;u++)g=e[u],r=d3.rgb(s(n(g))),o.data[++f]=r.r,o.data[++f]=r.g,o.data[++f]=r.b,o.data[++f]=255;return c.imageSmoothingEnabled=!1,c.putImageData(o,0,0)},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Colorbar=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.color_scale=d3.scale.linear(),this.accessors.orient="vertical",this.accessors.origin={x:0,y:0},this.accessors.barlength=100,this.accessors.barthickness=50,r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t){var e,r,a,s,n,c,i,l,o,u,h,d,p,_,f,g,y,m,v,x,w,b;return l=this.color_scale(),_=this.margin(),f=this.orient(),g=this.origin(),a=this.barlength(),s=this.barthickness(),n=function(){var t;return t=l.copy(),t.range([0,1]),t.domain([1,10]),Math.abs((t(10)-t(1))/Math.log(10)-(t(10)-t(2))/Math.log(5))<1e-6?"log":Math.abs((t(10)-t(1))/9-(t(10)-t(2))/8)<1e-6?"linear":Math.abs((t(10)-t(1))/(Math.sqrt(10)-1)-(t(10)-t(2))/(Math.sqrt(10)-Math.sqrt(2)))<1e-6?"sqrt":"unknown"},v=n(),"horizontal"===f?(m=[_.left,_.right,_.top,_.bottom],_.top=m[0],_.bottom=m[1],_.left=m[2],_.right=m[3],w="height",p="width",e="bottom",y="x",r="translate (0, "+s+")"):(w="width",p="height",e="right",y="y",r="translate ("+s+", 0)"),x=d3.select(t).selectAll("svg.colorbar").data([g]),h=x.enter().append("svg").classed("colorbar",!0).append("g").classed("colorbar",!0),h.append("g").classed("legend",!0).classed("rect",!0),h.append("g").classed("axis",!0).classed("color",!0),x.attr(w,s+_.left+_.right).attr(p,a+_.top+_.bottom).style("margin-top",g.y-_.top+"px").style("margin-left",g.x-_.left+"px"),b=1e3,o=x.select("g").attr("transform","translate("+_.left+", "+_.top+")"),u=l.copy(),d=d3.range(0,a,a/(u.domain().length-1)),d.push(a),u.range(d.reverse()),i=o.select(".legend.rect").selectAll("rect").data(d3.range(0,a)),i.enter().append("rect").classed("legend",!0).style("opacity",1).style("stroke-thickness",0).transition().duration(b).attr(w,s).attr(p,2).attr(y,function(t){return t}).style("fill",function(t){return l(u.invert(t))}),i.exit().remove(),c=d3.svg.axis().scale(u).orient(e).ticks(5),o.selectAll(".color.axis").attr("transform",r).call(c)},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Bar=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,i,l,o,u,h,d,p;return o=this.width(),c=this.height(),i=this.margin(),h=this.x_value(),p=this.y_value(),u=this.x_scale(),d=this.y_scale(),u.range([0,o]),d.range([c,0]),l=d3.select(t).selectAll("svg").data([e]),n=l.enter().append("svg").append("g"),l.attr("width",o+i.left+i.right).attr("height",c+i.top+i.bottom),s=l.select("g").attr("transform","translate("+i.left+", "+i.top+")"),s.selectAll("g.bars").data([e]).enter().append("g").classed("bars",!0),r=o/e.length,a=s.select("g.bars").selectAll("rect").data(function(t){return t}),a.enter().append("rect").classed("bar",!0),a.attr("x",function(t){return u(h(t))}).attr("y",function(t){return d(p(t))}).attr("width",r).attr("height",function(t){return c-d(p(t))}),a.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Scatter=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.radius=3,this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},this.accessors.color_value=function(t){return t.name},this.accessors.color_scale=d3.scale.category20(),r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,i,l,o,u,h,d,p,_,f,g;return d=this.width(),l=this.height(),o=this.margin(),u=this.radius(),_=this.x_value(),g=this.y_value(),p=this.x_scale(),f=this.y_scale(),n=this.color_value(),s=this.color_scale(),a=e.map(n).filter(function(t,e,r){return r.indexOf(t===e)}),s.domain(a),p.range([0,d]),f.range([l,0]),h=d3.select(t).selectAll("svg").data([e]),i=h.enter().append("svg").append("g"),h.attr("width",d+o.left+o.right).attr("height",l+o.top+o.bottom),c=h.select("g").attr("transform","translate("+o.left+", "+o.top+")"),c.selectAll(".circles").data([e]).enter().append("g").classed("circles",!0),r=c.select(".circles").selectAll(".circle").data(function(t){return t}),r.enter().append("circle").classed("circle",!0),r.attr("r",u).attr("cx",function(t){return p(_(t))}).attr("cy",function(t){return f(g(t))}).style("fill",function(t){return s(n(t))}),r.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Line=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.interpolation="linear",this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},this.accessors.color_value=function(t){return t.name},this.accessors.color_scale=d3.scale.category20(),r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,i,l,o,u,h,d,p,_,f,g;return d=this.width(),i=this.height(),u=this.margin(),l=this.interpolation(),_=this.x_value(),g=this.y_value(),p=this.x_scale(),f=this.y_scale(),s=this.color_value(),a=this.color_scale(),r=e.map(s).filter(function(t,e,r){return r.indexOf(t===e)}),a.domain(r),p.range([0,d]),f.range([i,0]),h=d3.select(t).selectAll("svg").data([e]),c=h.enter().append("svg").append("g"),h.attr("width",d+u.left+u.right).attr("height",i+u.top+u.bottom),n=h.select("g").attr("transform","translate("+u.left+", "+u.top+")"),n.selectAll(".paths").data([e]).enter().append("g").classed("paths",!0),o=n.select(".paths").selectAll(".path").data(function(t){return t}),o.enter().append("path").classed("path",!0),o.attr("stroke",function(t){return a(s(t))}).attr("d",function(t){return d3.svg.line().interpolate(l).x(function(t){return p(_(t))}).y(function(t){return f(g(t))})(t.values)}),o.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.Errorbar=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.x_value=function(t){return t.x},this.accessors.y_value=function(t){return t.y},this.accessors.y_error_value=function(t){return t.ey},r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t,e){var r,a,s,n,c,i,l,o,u;return n=this.width(),s=this.height(),i=this.x_value(),u=this.y_value(),c=this.x_scale(),o=this.y_scale(),l=this.y_error_value(),a=d3.select(t).selectAll(".errorbars").data([e]),a.enter().append("g").classed("errorbars",!0),a.append("defs").append("marker").attr("id","markerCap").attr("markerWidth",6).attr("markerHeight",2).attr("refX",3).attr("refY",0).append("line").attr("x1",0).attr("x2",6).attr("y1",0).attr("y2",0).classed("errorcap",!0),r=a.selectAll(".errorbar").data(function(t){return t}),r.enter().append("line").classed("errorbar",!0).attr("x1",function(t){return c(i(t))}).attr("x2",function(t){return c(i(t))}).attr("y1",function(t){return o(u(t)-l(t))}).attr("y2",function(t){return o(u(t)+l(t))}).style("marker-start","url(#markerCap)").style("marker-end","url(#markerCap)"),r.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){var t=function(t,r){function a(){this.constructor=t}for(var s in r)e.call(r,s)&&(t[s]=r[s]);return a.prototype=r.prototype,t.prototype=new a,t.__super__=r.prototype,t},e={}.hasOwnProperty;d3.chart.CircleLegend=function(e){function r(){null==this.accessors&&(this.accessors={}),this.accessors.color_scale=d3.scale.category20(),this.accessors.radius=3,this.accessors.text_value=function(t){return t},r.__super__.constructor.apply(this,arguments)}return t(r,e),r.prototype._draw=function(t){var e,r,a,s,n,c,i,l,o;return o=$(t)[0].getBBox().width,e=this.color_scale(),l=this.text_value(),i=this.radius(),r=$(t).css("font-size"),s=Math.floor(1.5*parseInt(r.replace("px",""))),a=.05*o,n=d3.select(t).selectAll(".legends").data([e.domain()]),n.enter().append("g").classed("legends",!0),n.exit().remove(),c=n.selectAll(".legend").data(function(t){return t}),c.enter().append("g").classed("legend",!0),c.each(function(t){var r,n;return r=d3.select(this).selectAll("circle").data([t]),r.enter().append("circle").classed("legend",!0).attr("cx",o-a).attr("cy",.5*s).attr("r",i).attr("fill",e),r.exit().remove(),n=d3.select(this).selectAll("text").data([t]),n.enter().append("text").classed("legend",!0).attr("x",o-1.2*a).attr("y",.5*s).attr("dy",.25*s).style("text-anchor","end").text(l),n.exit().remove()}),c.attr("transform",function(t,e){return"translate(0, "+s*e+")"}),c.exit().remove()},r}(d3.chart.BaseChart)}.call(this),function(){$(function(){return window.show_image=function(t){return d3.csv(t,function(t){return{row:parseInt(t.row),pixel:parseInt(t.pixel),absorption:t.A,darkfield:t.B,ratio:t.R}},function(t,e){var r;if(null==t)return r=function(t,r){var a,s,n,c,i,l,o,u,h,d;return l=d3.max(e,function(t){return t.pixel}),i=d3.max(e,function(t){return t.row}),d=$(t).width(),s=.618,n=d*s,c=(new d3.chart.Image).width(d).height(n).original_width(l).original_height(i).color_value(function(t){return t[r]}).margin({bottom:0,left:0,top:0,right:0}),a=(new d3.chart.Colorbar).orient("horizontal").color_scale(c.color_scale()).barlength(c.width()).barthickness(.1*c.height()).margin({bottom:.2*c.height(),left:0,top:0,right:0}),h=e.map(c.color_value()).sort(d3.ascending),u=d3.quantile(h,.05),o=d3.quantile(h,.95),c.color_scale().domain([u,o]).nice(),d3.select(t).datum(e).call(c.draw),d3.select(t).datum([0]).call(a.draw)},r("#absorption-image","absorption"),r("#darkfield-image","darkfield"),r("#ratio-image","ratio")})}})}.call(this),function(){$(function(){return window.show_plots=function(t){return d3.csv(t,function(t){return{absorption:t.A,darkfield:t.B,ratio:t.R,visibility:t.v}},function(t,e){var r;if(null==t)return r=function(t,r){var a,s,n,c,i,l,o;return o=$(t).width(),a=.618,s=o*a,n=(new d3.chart.Bar).width(o).height(s).margin({bottom:100,left:100,top:50,right:50}),l=30,n.x_scale().domain([.8*d3.min(e,function(t){return t[r]}),1.2*d3.max(e,function(t){return t[r]})]).nice(),i=d3.layout.histogram().bins(n.x_scale().ticks(l))(e.map(function(t){return t[r]})),n.y_scale().domain([0,1.1*d3.max(i,function(t){return t.y})]),c=(new d3.chart.Axes).x_scale(n.x_scale()).y_scale(n.y_scale()).x_title(r).y_title("#pixels"),c.y_axis().ticks(4),c.x_axis().ticks(5),d3.select(t).datum(i).call(n.draw),d3.select(t).select("svg").select("g").datum(1).call(c.draw)},r("#absorption-histogram","absorption"),r("#darkfield-histogram","darkfield"),r("#ratio-histogram","ratio"),r("#visibility-histogram","visibility")})}})}.call(this),function(){$(function(){return $("#select-dataset").select2(),$("#select-dataset-plots").select2(),$("#select-dataset").on("change",function(){return window.show_image(this.value),$("#select-dataset-plots").value=this.value}),$("#select-dataset-plots").on("change",function(){return window.show_plots(this.value),$("#select-dataset").value=this.value}),window.show_image($("#select-dataset").val()),window.show_plots($("#select-dataset").val())})}.call(this),function(){$(function(){var t;return t=function(t){var e,r,a,s,n,c,i,l,o,u,h;return a=$(t).data("exp"),o=$(t).data("theo"),h=$(t).width(),n=.618,c=h*n,o=[{sample_thickness:12,values:o.filter(function(t){return 12===t.sample_thickness})},{sample_thickness:45,values:o.filter(function(t){return 45===t.sample_thickness})}],r=function(t){var e;return e="sample thickness "+t.sample_thickness+" mm",t.filter&&"None"!==t.filter&&(e+=", source filter "+t.filter),console.log(e),e},u=(new d3.chart.Scatter).width(h).height(c).x_value(function(t){return t.particle_size}).y_value(function(t){return t.mean_R}).color_value(r).radius(6).margin({bottom:100,left:50,top:50,right:50}),u.x_scale().domain([0,8]),u.y_scale().domain([.8*d3.min(a,u.y_value()),1.2*d3.max(a,u.y_value())]).nice(),l=(new d3.chart.Line).width(h).height(c).x_value(u.x_value()).y_value(u.y_value()).color_value(u.color_value()).color_scale(u.color_scale()).x_scale(u.x_scale()).y_scale(u.y_scale()).margin(u.margin()),e=(new d3.chart.Axes).x_scale(u.x_scale()).y_scale(u.y_scale()).x_title("particle diameter (\u03bcm)").y_title("R"),e.y_axis().ticks(5),s=(new d3.chart.Errorbar).x_scale(u.x_scale()).y_scale(u.y_scale()).x_value(u.x_value()).y_value(u.y_value()).y_error_value(function(t){return t.sd_R}),d3.select(t).datum(a).call(u.draw),d3.select(t).select("svg").select("g").datum(a).call(s.draw),i=(new d3.chart.CircleLegend).color_scale(u.color_scale()).radius(u.radius()).text_value(function(t){return t}),d3.select(t).select("svg").select("g").datum(1).call(e.draw).call(i.draw),d3.select(t).datum(o).call(l.draw),d3.select(t).select("svg").select("g").select(".circles").attr("id","circles-"+t.substring(1)),d3.select(t).select("svg").select("g").append("use").attr("xlink:href","#circles-"+t.substring(1))},t("#summary-plot"),t("#summary-plot-hard-spectrum")})}.call(this),function(){$(function(){var t;return t=function(){var t,e,r,a,s,n;return a="#"+this.id,t=$(this).data("src"),s=$(this).data("var"),n=$(this).data("ytitle"),r=$(this).data("normalize"),e=$(this).data("logarithmic"),d3.csv(t,function(t){return{energy:parseInt(t.energy),value:parseFloat(t[s])}},function(t,s){var c,i,l,o,u,h;if(null==t)return h=$(a).width(),i=.618,l=h*i,null!=r&&(u=d3.sum(s,function(t){return t.value}),s=s.map(function(t){return{energy:t.energy,value:t.value/u}})),o=(new d3.chart.Bar).width(h).height(l).x_value(function(t){return t.energy}).y_value(function(t){return t.value}).margin({bottom:100,left:100,top:50,right:50}),o.x_scale().domain([d3.min(s,o.x_value()),d3.max(s,o.x_value())]),null!=e&&o.y_scale(d3.scale.log()),o.y_scale().domain([d3.min(s,o.y_value()),d3.max(s,o.y_value())]),c=(new d3.chart.Axes).x_scale(o.x_scale()).y_scale(o.y_scale()).x_title("energy (keV)").y_title(n),c.y_axis().ticks(4),d3.select(a).datum(s).call(o.draw),d3.select(a).select("svg").select("g").datum(1).call(c.draw)})},$(".theoretical-histogram").each(t)})}.call(this),function(){$(function(){var t,e;return e="#aggregated",t="data/aggregated.json",d3.json(t,function(t,r){var a,s,n,c,i,l;if(null==t)return l=$(e).width(),s=.618,n=l*s,r=r.map(function(t){return t.values.map(function(e){return e.name=t.name,e})}),r=r.reduce(function(t,e){return t.concat(e)}),r=r.filter(function(t){return t[1]>.05}),i=(new d3.chart.Scatter).width(l).height(n).radius(5).x_value(function(t){return t[1]}).y_value(function(t){return t[2]}).margin({bottom:100,left:50,top:50,right:50}),i.x_scale().domain([0,1]),i.y_scale().domain([1,5]),a=(new d3.chart.Axes).x_scale(i.x_scale()).y_scale(i.y_scale()).x_title("transmission").y_title("R"),a.y_axis().ticks(5),a.x_axis().ticks(5),c=(new d3.chart.CircleLegend).color_scale(i.color_scale()).radius(i.radius()).text_value(function(t){return t.toLowerCase()}),d3.select(e).datum(r).call(i.draw),d3.select(e).select("svg").select("g").datum(1).call(a.draw).call(c.draw)})})}.call(this);