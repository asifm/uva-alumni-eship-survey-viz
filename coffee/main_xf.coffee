total_obs = 16247

basic_num_format = d3.format ".0f"
k_num_format = d3.format "s"
percent_num_format = d3.format ",.1%"

process_data = (d) ->
    data = 
        birth: +d.birth
        entrepreneur: +d.entrepreneur
        founder: +d.founder
        early_emp: +d.early_emp
        board_member: +d.board_member
        investor: +d.investor
        family_ent: +d.family_ent
        first_venture_age: +d.first_venture_age
        gender: d.gender
        instate: +d.instate
        inv_innov: d.inv_innov
        inv_uva: d.inv_uva
        last_deg: d.last_deg
        last_field: d.last_field
        last_gradyr: +d.last_gradyr
        last_job_ind: d.last_job_ind
        race: d.race
        small_bus_exp: +d.small_bus_exp
        venture_nums: +d.venture_nums   
        key_0: +d.key_0
    data

AddXAxis = (chartToUpdate, displayText) ->
    chartToUpdate.svg()
        .append("text")
        .attr("class", "x-axis-label")
        .attr("text-anchor", "middle")
        .attr("x", chartToUpdate.width()/2)
        .attr("y", chartToUpdate.height()-1.5)
        .text(displayText)

d3.csv('data/alum_xf.csv', process_data, (data) -> 
    
    xf = crossfilter(data)
    dim = {}

    dim.birth = xf.dimension (d) -> d.birth
    dim.gender = xf.dimension (d) -> d.gender
    dim.entrepreneur = xf.dimension (d) -> if d.entrepreneur is 1 then "Yes"  else "No"
    dim.founder = xf.dimension (d) -> if d.founder is 1 then "Yes" else "No"
    dim.early_emp = xf.dimension (d) -> if d.early_emp is 1 then "Yes" else "No"
    dim.board_member = xf.dimension (d) ->if  d.board_member is 1 then "Yes" else "No"
    dim.investor = xf.dimension (d) -> if d.investor is 1 then "Yes" else "No"
    dim.first_venture_age = xf.dimension (d) -> d.first_venture_age
    dim.family_ent = xf.dimension (d) -> if d.family_ent is 1 then "Yes" else "No"
    dim.instate = xf.dimension (d) -> if d.instate is 1 then "Yes"  else "No"
    dim.inv_innov = xf.dimension (d) -> if d.inv_innov is "" then "Not involved at all" else d.inv_innov
    dim.inv_uva = xf.dimension (d) -> if d.inv_uva is "" then "Not involved at all" else d.inv_uva
    dim.last_deg = xf.dimension (d) -> if d.last_deg is "" then "No information" else d.last_deg
    dim.last_field = xf.dimension (d) -> if d.last_field is "" then "No information" else d.last_field
    dim.race = xf.dimension (d) -> d.race
    dim.small_bus_exp = xf.dimension (d) -> if d.small_bus_exp is 1 then "Yes" else "No"
    dim.venture_nums = xf.dimension (d) -> d.venture_nums
    
    grp = {}
    grp.entrepreneur = dim.entrepreneur.group()
    grp.founder= dim.founder.group()
    grp.early_emp = dim.early_emp.group()
    grp.board_member = dim.board_member.group()
    grp.investor= dim.investor.group()
    
    grp.gender = dim.gender.group()
    grp.race = dim.race.group()
    grp.instate = dim.instate.group()

    grp.birth = dim.birth.group((d) -> Math.floor(d / 5) * 5) #
    grp.first_venture_age = dim.first_venture_age.group((d) -> Math.floor(d / 5) * 5)
    
    grp.small_bus_exp = dim.small_bus_exp.group()
    grp.family_ent = dim.family_ent.group()
    grp.inv_innov = dim.inv_innov.group()
    grp.inv_uva = dim.inv_uva.group()
    
    grp.last_deg = dim.last_deg.group()
    grp.last_field = dim.last_field.group()
    
    grp.venture_nums = dim.venture_nums.group()


    chart = {}
    chart.founderPie = dc.pieChart '#founder'
    chart.earlyempPie = dc.pieChart '#early-emp'
    chart.investorPie = dc.pieChart "#investor"
    chart.boardMemberPie = dc.pieChart "#board-member"
    chart.entrepreneurPie = dc.pieChart '#entrepreneur'
    
    chart.genderPie = dc.pieChart '#gender'
    chart.instatePie = dc.pieChart '#instate'
    chart.raceRow = dc.rowChart '#race'

    chart.birthBar = dc.barChart '#birth'
    chart.firstVentureBar = dc.barChart "#first-venture"

    chart.smallBusPie = dc.pieChart '#small-bus-exp'
    chart.familyEntPie = dc.pieChart "#family-ent"
    chart.invInnovRow = dc.rowChart '#inv-innov'
    chart.invUvaRow = dc.rowChart '#inv-uva'

    chart.lastDegRow = dc.rowChart '#last-deg'
    chart.lastFieldRow = dc.rowChart '#last-field'

    chart.numVentRow = dc.rowChart '#num-vent'

    chart.founderPie
        .width 150
        .height 150
        .radius 75
        .dimension dim.founder
        .group grp.founder
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"

    chart.earlyempPie
        .width 150
        .height 150
        .radius 75
        .dimension dim.early_emp
        .group grp.early_emp
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"
    
    chart.investorPie
        .width 150
        .height 150
        .radius 75
        .dimension dim.investor
        .group grp.investor
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"
    
    chart.boardMemberPie
        .width 150
        .height 150
        .radius 75
        .dimension dim.board_member
        .group grp.board_member
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"
    
     chart.entrepreneurPie
        .width 200
        .height 200
        .radius 100
        .dimension dim.entrepreneur
        .group grp.entrepreneur
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"
    
    chart.genderPie
        .width 200
        .height 200
        .radius 100
        .dimension dim.gender
        .group grp.gender
        # .colors(d3.scale.category10())
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"
    
    chart.instatePie
        .width 200
        .height 200
        .radius 100
        .dimension dim.instate
        .group grp.instate
        # .colors(d3.scale.category10())
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"

    chart.raceRow
        .width 550
        .height 200
        .dimension dim.race
        .group(grp.race)
        .elasticX(true)
        .cap 5
        .othersGrouper false
        # .colors ['#9e9ac8']
        .colors(d3.scale.category10())
        .xAxis().tickFormat (v) -> 
            k_num_format v


    chart.birthBar
        .width 500
        .height 250
        .dimension dim.birth
        .group grp.birth
        .x d3.scale.linear().domain([1930, 1995])
        .xUnits -> 13
        .elasticY true
        .renderHorizontalGridLines true
        .renderVerticalGridLines true
        .margins {top: 20, right: 20, bottom: 30, left: 50}
        .xAxis().tickFormat (v) -> 
            basic_num_format v
        
    chart.firstVentureBar
        .width 450
        .height 250
        .dimension dim.first_venture_age
        .group grp.first_venture_age
        .x d3.scale.linear().domain([15, 75])
        .xUnits -> 12
        .elasticY true
        .renderHorizontalGridLines true
        .renderVerticalGridLines true
        .margins {top: 20, right: 20, bottom: 30, left: 50}
        # .yAxisLabel "Number of alumni", 30
        # .xAxisLabel "Age at first venture"


    chart.smallBusPie
        .width 200
        .height 200
        .radius 100
        .dimension dim.small_bus_exp
        .group grp.small_bus_exp
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"


    chart.familyEntPie
        .width 150
        .height 150
        .radius 75
        .dimension dim.family_ent
        .group grp.family_ent
        .label (d) -> 
            "#{d.data.key} #{Math.round((d.endAngle - d.startAngle) / Math.PI * 50)}%"

    chart.invUvaRow
        .width 400
        .height 180
        .dimension dim.inv_uva
        .group grp.inv_uva
        .elasticX true
        .colors(d3.scale.category10())
        .xAxis().tickFormat (v) -> 
            k_num_format v

    chart.invInnovRow
        .width 400
        .height 180
        .dimension dim.inv_innov
        .group grp.inv_innov
        .elasticX true      
        .colors(d3.scale.category10())
        .xAxis().tickFormat (v) -> 
            k_num_format v
    
    chart.lastDegRow
        .width 500
        .height 300
        .dimension dim.last_deg
        .group grp.last_deg
        .elasticX true 
        # .colors ['#b5cf6b']
        # .colors(d3.scale.category10())
        .xAxis().tickFormat (v) -> 
            k_num_format v

    chart.lastFieldRow
        .width 500
        .height 300
        .dimension dim.last_field
        .group grp.last_field
        .elasticX true       
        .cap 8
        # .turnOnControls true
        # .colors(d3.scale.category10())
        # .colors ['#b3e2cd', '#fdcdac', '#cbd5e8', '#f4cae4', '#e6f5c9', '#fff2ae', '#f1e2cc', '#cccccc', '#d9d9d9', '#bc80bd']
        # .colors ['#b5cf6b']
        .xAxis().tickFormat (v) -> 
            k_num_format v

    chart.numVentRow
        .width 400
        .height 200
        .dimension dim.venture_nums
        .group grp.venture_nums
        .elasticX true
        .cap 4
        .othersLabel "More"
        .colors(d3.scale.category10())
        .xAxis().tickFormat (v) -> 
            k_num_format v
    
    dc.renderAll()

    reset_all = ->
        dc.filterAll()
        dc.redrawAll()

    $(".reset-all").click(reset_all)

    $("#reset-first-venture").click -> 
        chart.firstVentureBar.filterAll()
        dc.redrawAll()

    $("#reset-birth").click -> 
        chart.birthBar.filterAll()
        dc.redrawAll()

    $("#reset-race").click -> 
        chart.raceRow.filterAll()
        dc.redrawAll()

    $("#reset-inv-uva").click -> 
        chart.invUvaRow.filterAll()
        dc.redrawAll()

    $("#reset-inv-innov").click -> 
        chart.invInnovRow.filterAll()
        dc.redrawAll()

    $("#reset-last-deg").click -> 
        chart.lastDegRow.filterAll()
        dc.redrawAll()

    $("#reset-last-field").click -> 
        chart.lastFieldRow.filterAll()
        dc.redrawAll()

    $("#reset-num-vent").click -> 
        chart.numVentRow.filterAll()
        dc.redrawAll()

    write_stat =  -> 
        $('#stat').text percent_num_format(xf.groupAll().reduceCount().value() / total_obs)

    chart.founderPie.on "filtered", write_stat
    chart.earlyempPie.on "filtered", write_stat
    chart.investorPie.on "filtered", write_stat
    chart.boardMemberPie.on "filtered", write_stat
    chart.entrepreneurPie.on "filtered", write_stat
    
    chart.genderPie.on "filtered", write_stat
    chart.instatePie.on "filtered", write_stat
    chart.raceRow.on "filtered", write_stat

    chart.birthBar.on "filtered", write_stat
    chart.firstVentureBar.on "filtered", write_stat

    chart.smallBusPie.on "filtered", write_stat
    chart.familyEntPie.on "filtered", write_stat
    chart.invInnovRow.on "filtered", write_stat
    chart.invUvaRow.on "filtered", write_stat

    chart.lastDegRow.on "filtered", write_stat
    chart.lastFieldRow.on "filtered", write_stat

    chart.numVentRow.on "filtered", write_stat
)

   
# todo: add number of alumni selected when filter applied