window.transformToHighChartsSeries = function (data) {
    return _.map(data, function (liftObject) {
        var newObject = {};
        newObject.name = liftObject.name;
        newObject.data = _.map(liftObject.data, function (record) {
            return [Date.UTC(record.date.year, record.date.month - 1, record.date.day), record.weight];
        });
        return newObject;
    });
};