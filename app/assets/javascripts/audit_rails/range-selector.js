g1 = new Dygraph(
    document.getElementById("noroll"),
    data_temp,
    {
      customBars: true,
      height: 320,
      title: 'NY Temparature',
      ylabel: 'Temperature (F)',
      // showLabelsOnHighlight: false,
      // drawYAxis: false,
      legend: 'always',
      labelsDivStyles: { 'textAlign': 'right' },
      drawXGrid: false,
      drawYGrid: false,
      showRangeSelector: true,
      rangeSelectorHeight: 70,
      rangeSelectorPlotFillColor: "#e98e4e",
      rangeSelectorPlotStrokeColor: "#e98e4e",
      showRoller: false,
      axisLineColor: '#f2f2f2'
    }
);
