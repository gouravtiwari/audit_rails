var data  = JSON.parse( $('div#userViewsCount').attr('data-visit-count'));

var right = d3.max([20, (900 - data.length * 50)]);
var margin = {top: 40, right: right, bottom: 100, left: 40},
    width = 960 - margin.left - margin.right,
    height = 360 - margin.top - margin.bottom;

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var tip = d3.tip()
  .attr('class', 'd3-tip')
  .offset([-10, 0])
  .html(function(d) {
    return "<strong>Page Views:</strong> <span style='color:red'>" + d.count + "</span>";
  })

var svg = d3.select("div#userViewsCount").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

svg.call(tip);

x.domain(data.map(function(d) { return d.user; }));
y.domain([0, d3.max(data, function(d) { return d.count; })]);

svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
    .selectAll("text")
    .style("text-anchor", "end")
    .attr("dx", "-.8em")
    .attr("dy", ".15em")
    .attr("transform", function(d) {
                return "rotate(-65)" 
                });

svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)
  .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", -40)
    .attr("x", -80)
    .attr("dy", "0.71em")
    .style("text-anchor", "end")
    .text("Page Views");

svg.selectAll(".bar")
    .data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("x", function(d) { return x(d.user); })
    .attr("width", x.rangeBand())
    .attr("y", function(d) { return y(d.count); })
    .attr("height", function(d) { return height - y(d.count); })
    .on('mouseover', tip.show)
    .on('mouseout', tip.hide);
