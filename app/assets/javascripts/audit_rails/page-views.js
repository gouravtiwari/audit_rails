var data  = JSON.parse( $('div#pageViewsCount').attr('data-visit-count'));

var margin = {top: 40, right: 20, bottom: 100, left: 40},
    width = 960 - margin.left - margin.right,
    height = 360 - margin.top - margin.bottom;

var x = d3.scale.ordinal().rangeRoundBands([0, width]);
var y = d3.scale.linear().range([height, 0]);

var xAxis = d3.svg.axis().scale(x)
    .orient("bottom").ticks(1).tickSize(0).innerTickSize([0]);

var yAxis = d3.svg.axis().scale(y)
    .orient("left").ticks(5);

var valueline = d3.svg.line()
    .x(function(d) { return x(d.page); })
    .y(function(d) { return y(d.count); });
    
var tip = d3.tip()
  .attr('class', 'd3-tip')
  .offset([-10, 0])
  .html(function(d) {
    return "<strong>Page Views:</strong> <span style='color:red'>" + d.count + "</span>";
  })

var svg = d3.select("div#pageViewsCount")
    .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
    .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

svg.call(tip);

// Get the data

// Scale the range of the data
x.domain(data.map(function(d) { return d.page; }));
y.domain([0, d3.max(data, function(d) { return d.count; })]);

svg.append("path")      // Add the valueline path.
    .attr("d", valueline(data))
    .attr("class", "line")
    .style("stroke", "orange")
    .style("stroke-width", 3)
    .data(data)
    .attr("x", function(d) { return x(d.page); })
    .attr("y", function(d) { return y(d.count); })
    .on('mousemove', tip.show)
    .on('mouseout', tip.hide);

svg.append("g")         // Add the X Axis
    .attr("class", "x axis")
    .call(xAxis)
    .attr("transform", "translate(0," + height + ")")
    .selectAll("text")
    .style("text-anchor", "end")
    .attr("dx", "-1.8em")
    .attr("dy", "-1.15em")
    .attr("transform", function(d) {
                return "rotate(-65, 0, 0)" 
              });

svg.append("g")         // Add the Y Axis
    .attr("class", "y axis")
    .call(yAxis)
    .append('text')
    .attr("transform", "rotate(-90)")
    .attr("y", -40)
    .attr("x", -80)
    .attr("dy", "0.71em")
    .style("text-anchor", "end")
    .text('Page Views');

// svg.selectAll(".line")
//     .data(data)
//   .enter().append("circle")
//     .attr("class", ".line")
//     .attr("x", function(d) { return x(d.user); })
//     .attr("width", x.rangeBand())
//     .attr("y", function(d) { return y(d.count); })
//     .attr("height", function(d) { return height - y(d.count); })
//     .on('mouseover', tip.show)
//     .on('mouseout', tip.hide);

