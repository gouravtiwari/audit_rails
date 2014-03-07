function pageViewsShareByUser(userName) {
    data  = JSON.parse( $('a[data-user="'+ userName +'"]').attr('data-page-visits'));
    donutTip({
        selector:       'div#pageViewsShareByUser',
        data:           data,
        width:          300,
        height:         300,
        margin:         {top: 20, right: 0, bottom: 20, left:40},
        flexRight:      true,
        innerRadius:    60,
        outerRadius:    110,
        color:          d3.scale.category20c(),
        xDomain:        'page',
        yDomain:        'count',
        tipLabel:       '',
        tipValue:       'count',
        tipText:        'Page Views',
        totalLabel:     'Views',
        legend:         false
    });
}
