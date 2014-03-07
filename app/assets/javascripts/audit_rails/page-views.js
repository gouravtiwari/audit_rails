var data  = JSON.parse( $('div#pageViewsCount').attr('data-visit-count'));

barTip({
        selector:   'div#pageViewsCount',
        data:       data,
        width:      960,
        height:     360,
        margin:     {top: 40, right: 20, bottom: 100, left:100},
        flexRight:  true,
        labelAngle: -60,
        xDomain:    'page',
        yDomain:    'count',
        yAxisText:  'Page Views',
        tipLabel:   '',
        tipValue:   'count',
        tipText:    'Page views'
    });