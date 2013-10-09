$(function() {
    $( "#analytics_range_begin" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 3,
      onClose: function( selectedDate ) {
        $( "#analytics_range_end" ).datepicker( "option", "minDate", selectedDate );
      },
      dateFormat: 'yy-mm-dd'
    });
    $( "#analytics_range_end" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 3,
      onClose: function( selectedDate ) {
        $( "#analytics_range_begin" ).datepicker( "option", "maxDate", selectedDate );
      },
      dateFormat: 'yy-mm-dd'
    });
  });