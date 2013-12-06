function pageViewsShareByUser(userName) {
    var margin = {
        top: 40,
        right: 40,
        bottom: 40,
        left: 40
    },
    width = 500 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom,
    inner = 90,
    radius = 180, //radius
    color = d3.scale.category20c(); //builtin range of colors

    var data  = JSON.parse( $('a[data-user="'+ userName +'"]').attr('data-page-visits'));
    var total = d3.sum(data, function (d) {
        return d3.sum(d3.values(d));
    });
    var div = d3.select("body").append("div")
        .attr("class", "tooltip")
        .style("opacity", 0);

    var vis = d3.select("div#pageViewsShareByUser")
                .append("svg:svg") //create the SVG element inside the <body>    
                .data([data]) //associate our data with the document
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("svg:g") //make a group to hold our pie chart
                .attr("transform", "translate(" + radius * 1.5 + "," + radius * 1.5 + ")");
    var textTop = vis.append("text")
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .attr("class", "textTop")
                .text("TOTAL")
                .attr("y", -10),
        textBottom = vis.append("text")
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .attr("class", "textBottom")
                .text(total + " Views")
                .attr("y", 10);

    var arc = d3.svg.arc()
                .innerRadius(inner)
                .outerRadius(radius);
    var arcOver = d3.svg.arc()
                .innerRadius(inner + 5)
                .outerRadius(radius + 5);

    var pie = d3.layout.pie() //this will create arc data for us given a list of values
                .value(function (d) {
                    return d.count;
                }); //we must tell it out to access the value of each element in our data array

    var arcs = vis.selectAll("g.slice") //this selects all <g> elements with class slice (there aren't any yet)
                .data(pie) //associate the generated pie data (an array of arcs, each having startAngle, endAngle and value properties) 
                .enter() //this will create <g> elements for every "extra" data element that should be associated with a selection. The result is creating a <g> for every object in the data array
                .append("svg:g") //create a group to hold each slice (we will have a <path> and a <text> element associated with each slice)
                .attr("class", "slice") //allow us to style things in the slices (like text)
                .on('mousemove', function (d, i) {
                    d3.select(this).select("path").transition()
                    .duration(200)
                    .attr("d", arcOver);
                    
                    textTop.text(d3.select(this).datum().data.page)
                    .attr("y", -10);
                textBottom.text(d3.select(this).datum().data.count + " Views")
                    .attr("y", 10);
                    
                    div.transition()
                    .duration(200)
                    .style("opacity", 0.9);
                    div.html("<strong>Page Views:</strong> <span style='color:red'>" + d.data.count + "</span>")
                    .style("left", (d3.event.pageX - 57) + "px")
                    .style("top", (d3.event.pageY - 50) + "px")
                    .style("z-index", 10000)
                })
                .on("mouseout", function (d) {
                    d3.select(this).select("path").transition()
                    .duration(100)
                    .attr("d", arc);
        
                    textTop.text("TOTAL")
                    .attr("y", -10);
                    textBottom.text(total + " Views");
                    
                    div.transition()
                    .duration(500)
                    .style("opacity", 0);
    });

    arcs.append("svg:path")
        .attr("fill", function (d, i) {
            return color(i);
        }) //set the color for each slice to be chosen from the color function defined above
        .attr("d", arc); //this creates the actual SVG path using the associated data (pie) with the arc drawing function
    
    var legend = d3.select("div#pageViewsShareByUser").append("svg")
        .attr("class", "legend")
        .attr("width", radius)
        .attr("height", radius * 2)
        .selectAll("g")
        .data(data)
        .enter().append("g")
        .attr("transform", function (d, i) {
        return "translate(0," + i * 20 + ")";
    });
    
    legend.append("rect")
        .attr("width", 18)
        .attr("height", 18)
        .style("fill", function (d, i) {
        return color(i);
    });
    
    legend.append("text")
        .attr("x", 24)
        .attr("y", 9)
        .attr("dy", ".35em")
        .text(function (d) {
            return d.page;
        });
}
