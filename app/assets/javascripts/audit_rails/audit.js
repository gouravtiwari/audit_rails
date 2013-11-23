$(document).on("click", 'a.visit-site', function() {
	params = { audit: { url: this.href, app_id: $("a.visit-site").attr("data-app-id") } };
	$.post("/audit_rails/audits", params);
	window.open(this.href);
	return false;
});

$(document).ready(function(){
  var firstUser = $('a[data-user]')
  if(firstUser[0] != undefined){
    pageViewsForUser(firstUser.attr('data-user'));
  }

  $('a[data-user]').on('click', function(){
    d3.select("div#pageViewsByUser>svg").remove();
    pageViewsForUser($(this).attr('data-user'));
  });
});
