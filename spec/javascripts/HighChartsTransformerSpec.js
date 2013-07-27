describe("Highcharts Transformer", function () {
    it("should be transform data into highcharts time series format", function () {
        expect(window.transformToHighChartsSeries([])).toEqual([]);
        expect(window.transformToHighChartsSeries([
            {
                name: "Deadlift",
                data: [
                    {date: {year: 2013, month: 2, day: 12}, weight: 100}
                ]
            }
        ])).toEqual([
                {
                    name: "Deadlift",
                    data: [
                        [Date.UTC(2013, 1, 12), 100]
                    ]
                }
            ]);
    });
});