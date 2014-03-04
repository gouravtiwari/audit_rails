$(function() {
    $('#ui-datepicker-div').addClass('theme1');
    $( "#analytics_range_begin" ).datepicker({
      changeMonth: true,
      changeYear: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#analytics_range_end" ).datepicker( "option", "minDate", selectedDate );
      },
      dateFormat: 'yy-mm-dd'
    });
    $( "#analytics_range_end" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      changeYear: true,
      numberOfMonths: 1,
      onClose: function( selectedDate ) {
        $( "#analytics_range_begin" ).datepicker( "option", "maxDate", selectedDate );
      },
      dateFormat: 'yy-mm-dd'
    });
  });