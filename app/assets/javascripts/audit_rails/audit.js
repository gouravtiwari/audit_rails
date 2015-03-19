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
    d3.select('svg.legend').remove();
    d3.select("div#pageViewsShareByUser>svg").remove();
    $('a.list-group-item').removeClass('active-item');
    $(this).addClass('active-item');

    $('#userNameToShow').text('Pages viewed by '+user);
    pageViewsForUser(user);
    pageViewsShareByUser(user);
  });


  // Transition effect
  $('li>a').on('click', function(){
    var id = $(this).attr('data-attr-id');
    active(this, id);
    $('.group').hide('fast');
    $('#'+id).show('slow');
  });

  $('#user-clicks-zoomin').on('click', function(){
    $('#user-clicks').show("fast", function(){});
  });
  $('#page-views-zoomin').on('click', function(){
    $('#page-views').show("fast", function(){});
  });
  $('#hourly-views-zoomin').on('click', function(){
    $('#hourly-views').show("fast", function(){});
  });
  $('#user-pages-zoomin').on('click', function(){
    $('#user-pages').show("fast", function(){});
    $('per-user-by-pages-bar').show("fast", function(){});
    $('per-user-by-pages-pie').show("fast", function(){});
  });

  $('#user-clicks-zoomout').on('click', function(){
    $('#user-clicks').effect("puff", 'slow');
  });
  $('#page-views-zoomout').on('click', function(){
    $('#page-views').effect("puff", 'slow');
  });
  $('#hourly-views-zoomout').on('click', function(){
    $('#hourly-views').effect("puff", 'slow');
  });
  $('#user-pages-zoomout').on('click', function(){
    $('#user-pages').effect("puff", 'slow');
    $('per-user-by-pages-bar').effect("puff", 'slow');
    $('per-user-by-pages-pie').effect("puff", 'slow');
  });
});

function active(obj, id){
  var parent = $(obj).parent()
  $(obj).parent().parent().children('li').removeClass('active');
  $(obj).parent().addClass('active');
  $('ul.nav.nav-tabs>li>a>span').addClass('hide');
  $('a[data-attr-id="'+id+'"]>span.badge').removeClass('hide');
}
