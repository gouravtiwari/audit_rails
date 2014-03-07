function pageViewsForUser(userName){
    var data  = JSON.parse( $('a[data-user="'+ userName +'"]').attr('data-page-visits'));

    barTip({
            selector:   'div#pageViewsByUser',
            data:       data,
            width:      380,
            height:     360,
            margin:     {top: 40, right: 40, bottom: 100, left:40},
            flexRight:  true,
            labelAngle: -60,
            xDomain:    'page',
            yDomain:    'count',
            yAxisText:  'Page Views',
            tipLabel:   '',
            tipValue:   'count',
            tipText:    'Page views'
        });
}
