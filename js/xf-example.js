d3.csv('data/xf-test.csv', strToNum, function(data) {
    // console.log(data);

    var xf = crossfilter(data);

    var birthDim = xf.dimension(function(d) {
        return d.birth;
    });

    birthGroup = birthDim.group().reduceCount();

    var yearDim = xf.dimension(function(d) {
        return d.year;
    });

    yearGroup = yearDim.group().reduceCount();


    var birthChart = dc.barChart('#birth');

    birthChart
        .width(500).height(200)
        .dimension(birthDim)
        .group(birthGroup)
        .x(d3.scale.linear().domain([1950, birthDim.top(1)[0].birth]));

var yearChart = dc.barChart('#year');
    
yearChart
        .width(500).height(200)
        .dimension(yearDim)
        .group(yearGroup)
        .x(d3.scale.linear().domain([1950, yearDim.top(1)[0].year]));

    dc.renderAll();

})


function strToNum(d) {
    return {
        key: +d.key,
        year: +d.year,
        numyr: +d.numyr,
        birth: +d.birth
    };
}
