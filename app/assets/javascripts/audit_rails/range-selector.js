function data_temp(elementId) {
  var counts = JSON.parse($('#'+elementId).attr('data-count'));
  var str='';
  var head = '';

  for(var dateStr in counts){
    if(dateStr == 'Date'){
      head = head + dateStr + ',' + counts[dateStr] + '\n';
    }else{
      str = str + dateStr + ',' + counts[dateStr] + '\n';
    }
  }

  return head + str;
}

function updateDateRange(startDate, endDate){
  $('#analytics_range_begin').val(startDate);
  $('#analytics_range_end').val(endDate);
}

g1 = new Dygraph(
    document.getElementById("noroll"),
    data_temp("noroll"),
    {
      height: 150,
      title: '',
      ylabel: '',
      // showLabelsOnHighlight: false,
      // drawYAxis: false,
      legend: 'always',
      labelsDivStyles: { 'textAlign': 'right' },
      drawXGrid: false,
      drawYGrid: false,
      showRangeSelector: true,
      rangeSelectorHeight: 50,
      rangeSelectorPlotFillColor: "#e98e4e",
      rangeSelectorPlotStrokeColor: "#e98e4e",
      showRoller: false,
      axisLineColor: '#f2f2f2',
      drawCallback: function(g) {
        if (g.dateWindow_ != undefined) {
          var startDate = $.datepicker.formatDate('yy-mm-dd',new Date(g.dateWindow_[0]));
          var endDate = $.datepicker.formatDate('yy-mm-dd',new Date(g.dateWindow_[1]));
          updateDateRange(startDate, endDate);
        }
      }
    }
);
