function data_temp(elementId) {
  var counts = JSON.parse($('#'+elementId).attr('data-count'));
  var str='';
  var head = '';

  for(var dateStr in counts){
    if(dateStr == 'Date'){
      head = dateStr + ',' + counts[dateStr] + '\n';
    }else{
      str = str + dateStr + ',' + counts[dateStr] + ';' + counts[dateStr] + ';' + counts[dateStr] + '\n';
    }
  }

  return head + str;
}

g1 = new Dygraph(
    document.getElementById("noroll"),
    data_temp("noroll"),
    {
      customBars: true,
      height: 320,
      title: 'Page Views',
      ylabel: '',
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
