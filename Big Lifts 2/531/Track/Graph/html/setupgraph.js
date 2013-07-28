window.setupGraph = function (data) {
    $('#container').highcharts({
        chart: {
            type: 'line',
            marginRight: 50,
            marginBottom: 25
        },
        credits: {
            enabled: false
        },
        title: {
            text: 'Estimated Maxes',
            x: -20 //center
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%b %Y',
                week: '%b %e \'%y',
                day: '%e %b'
            }
        },
        yAxis: {
            title: {
                text: 'Weight'
            },
            plotLines: [
                {
                    value: 0,
                    width: 1,
                    color: '#808080'
                }
            ]
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -10,
            y: 100,
            borderWidth: 0
        },
        series: data
    });
};