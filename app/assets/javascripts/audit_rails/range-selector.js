g1 = new Dygraph(
    document.getElementById("noroll"),
    data_temp,
    {
      customBars: true,
      height: 70,
      title: '',
      ylabel: '',
      showLabelsOnHighlight: false,
      drawYAxis: false,
      labelsDivStyles: { 'textAlign': 'right' },
      showRangeSelector: true,
      rangeSelectorHeight: 70,
      rangeSelectorPlotFillColor: "#e98e4e",
      rangeSelectorPlotStrokeColor: "#e98e4e",
      showRoller: false,
      axisLineColor: '#f2f2f2'
    }
);
