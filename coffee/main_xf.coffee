process_data = (d) ->
    data = 
        birth: +d.birth
        entrepreneur: +d.entrepreneur
        founder: +d.founder
        early_emp: +d.early_emp
        board_member: +d.board_member
        investor: +d.investor
        family_ent: +d.family_ent
        first_fd_age: +d.first_fd_age
        gender: d.gender
        instate: +d.instate
        inv_innov: d.inv_innov
        inv_uva: d.inv_uva
        last_deg: d.last_deg
        last_field: d.last_field
        last_gradyr: +d.last_gradyr
        last_job_ind: d.last_job_ind
        race: d.race
        resistat: d.resistat
        small_bus_exp: +d.small_bus_exp
        venture_nums: +d.venture_nums
        key_0: +d.key_0
    data

d3.csv('data/alum_xf.csv', process_data, (data) -> 
    
    xf = crossfilter(data)
    dim = {}

    dim.birth = xf.dimension (d) -> d.birth
    dim.entrepreneur = xf.dimension (d) -> if d.entrepreneur == 1 then "Entrepreneur"  else "Not entrepreneur"
    dim.founder = xf.dimension (d) -> if d.founder == 1 then "Founder" else "Not founder"
    dim.early_emp = xf.dimension (d) -> if d.early_emp == 1 then "Early employee" else "Not early employee"
    dim.board_member = xf.dimension (d) -> d.board_member
    dim.investor = xf.dimension (d) -> d.investor
    dim.family_ent = xf.dimension (d) -> d.family_ent
    dim.first_fd_age = xf.dimension (d) -> d.first_fd_age
    dim.gender = xf.dimension (d) -> if d.gender == "" then null else d.gender
    dim.instate = xf.dimension (d) -> d.instate
    dim.inv_innov = xf.dimension (d) -> d.inv_innov
    dim.inv_uva = xf.dimension (d) -> d.inv_uva
    dim.last_deg = xf.dimension (d) -> d.last_deg
    dim.last_field = xf.dimension (d) -> d.last_field
    dim.race = xf.dimension (d) -> if d.race == "" then null else d.race
    dim.resistat = xf.dimension (d) -> d.resistat
    dim.small_bus_exp = xf.dimension (d) -> d.small_bus_exp
    dim.venture_nums = xf.dimension (d) -> d.venture_nums
    
    grp = {}
    grp.birth = dim.birth.group()
    grp.gender = dim.gender.group()
    grp.entrepreneur = dim.entrepreneur.group()
    grp.founder= dim.founder.group()
    grp.early_emp = dim.early_emp.group()
    grp.race = dim.race.group()


    chart = {}
    chart.birthBar = dc.barChart '#birth'
    chart.genderPie = dc.pieChart '#gender'
    chart.entrepreneurPie = dc.pieChart '#entrepreneur'
    chart.founderPie = dc.pieChart '#founder'
    chart.earlyempPie = dc.pieChart '#early-emp'
    chart.raceRow = dc.rowChart '#race'

    chart.birthBar
        .width 600
        .height 300
        .dimension dim.birth
        .group grp.birth
        .x d3.scale.linear().domain([1930, 1995])
        .elasticY(true) # Is this a good idea?
        .renderHorizontalGridLines(true)
        .renderVerticalGridLines(true)
    
    chart.raceRow
        .width 600
        .height 300
        .dimension dim.race
        .group grp.race
        .ordering (d) -> d.value
        .elasticX(true)

    basic_num_format = d3.format(".0f")
    
    chart.birthBar
        .xAxis().tickFormat (v) -> 
            basic_num_format v


    chart.genderPie
        .width 300
        .height 300
        .dimension dim.gender
        .group grp.gender
        .radius 150

    # todo: choose a good color palette 
    # http://design-seeds.com/search
    # http://www.colourlovers.com/palettes
    # http://paletton.com/
    # Use shades of blue maybe?
    # chart.genderPie.colors ['#FFEFAA', '#D4C06A', '#806B15', '#554500'] 

    chart.entrepreneurPie
        .dimension dim.entrepreneur
        .group grp.entrepreneur

    chart.founderPie
        .dimension dim.founder
        .group grp.founder

    chart.earlyempPie
        .dimension dim.early_emp
        .group grp.early_emp

    dc.renderAll()
)

