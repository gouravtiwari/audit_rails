$(document).on("click", 'a.visit-site', function() {
	params = { audit: { url: this.href, app_id: $("a.visit-site").attr("data-app-id") } };
	$.post("/audit_rails/audits", params);
	window.open(this.href);
	return false;
});

$(document).ready(function(){
  var firstUser = $('a[data-user]')
  if(firstUser[0] != undefined){
    var user = firstUser.attr('data-user');
    $('a[data-user="'+user+'"]').addClass('active-item');

    $('#userNameToShow').text('Pages viewed by '+user);
    pageViewsForUser(user);
    pageViewsShareByUser(user);
  }

  $('a[data-user]').on('click', function(){
    var user = $(this).attr('data-user');
    d3.select("div#pageViewsByUser>svg").remove();
    d3.select("div#pageViewsShareByUser>svg").remove();
    $('a.list-group-item').removeClass('active-item');
    $(this).addClass('active-item');

    $('#userNameToShow').text('Pages viewed by '+user);
    pageViewsForUser(user);
    pageViewsShareByUser(user);
  });

  // Hiding all elements except first chart
  $('.group').hide();
  $('#user-clicks').show();

  // Transition effect
  $('li>a').on('click', function(){
    var id = $(this).attr('data-attr-id');
    active(this, id);
    $('.group').hide('fast');
    $('#'+id).show('slow');
  });
});

function active(obj, id){
  var parent = $(obj).parent()
  $(obj).parent().parent().children('li').removeClass('active');
  $(obj).parent().addClass('active');
  $('ul.nav.nav-tabs>li>a>span').addClass('hide');
  $('a[data-attr-id="'+id+'"]>span.badge').removeClass('hide');
}
