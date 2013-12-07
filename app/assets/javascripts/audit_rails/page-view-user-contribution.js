function pageViewsShareByUser(userName) {
    data  = JSON.parse( $('a[data-user="'+ userName +'"]').attr('data-page-visits'));
    donutTip({
        selector:       'div#pageViewsShareByUser',
        data:           data,
        width:          500,
        height:         500,
        margin:         {top: 40, right: 40, bottom: 40, left:40},
        flexRight:      true,
        innerRadius:    90,
        outerRadius:    180,
        color:          d3.scale.category20c(),
        xDomain:        'page',
        yDomain:        'count',
        tipLabel:       '',
        tipValue:       'count',
        tipText:        'Page Views',
        totalLabel:     'Views'
    });
}
