var data  = JSON.parse( $('div#userViewsCount').attr('data-visit-count'));

barTip({
        selector:   'div#userViewsCount',
        data:       data,
        width:      960,
        height:     360,
        margin:     {top: 40, right: 20, bottom: 100, left:40},
        flexRight:  true,
        labelAngle: -60,
        xDomain:    'user',
        yDomain:    'count',
        yAxisText:  'Page Views',
        tipLabel:   '',
        tipValue:   'count',
        tipText:    'Page views'
    });
