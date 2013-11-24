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
    $('#userNameToShow').text('Pages viewed by '+user);
    $('a[data-user="'+user+'"]').addClass('active-item');
    pageViewsForUser(user);
  }

  $('a[data-user]').on('click', function(){
    var user = $(this).attr('data-user');
    d3.select("div#pageViewsByUser>svg").remove();
    $('a.list-group-item').removeClass('active-item');
    $(this).addClass('active-item');
    $('#userNameToShow').text('Pages viewed by '+user);
    pageViewsForUser($(this).attr('data-user'));
  });
});
