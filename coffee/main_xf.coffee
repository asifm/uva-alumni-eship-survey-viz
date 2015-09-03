processData = (d) ->
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

d3.csv('data/alum_xf.csv', processData, (data) -> 
    
    data = crossfilter(data)
    dim = {}

    dim.birth = data.dimension (d) -> d.birth
    dim.entrepreneur = data.dimension (d) -> d.entrepreneur
    dim.founder = data.dimension (d) -> d.founder
    dim.early_emp = data.dimension (d) -> d.early_emp
    dim.board_member = data.dimension (d) -> d.board_member
    dim.investor = data.dimension (d) -> d.investor
    dim.family_ent = data.dimension (d) -> d.family_ent
    dim.first_fd_age = data.dimension (d) -> d.first_fd_age
    dim.gender = data.dimension (d) -> d.gender
    dim.instate = data.dimension (d) -> d.instate
    dim.inv_innov = data.dimension (d) -> d.inv_innov
    dim.inv_uva = data.dimension (d) -> d.inv_uva
    dim.last_deg = data.dimension (d) -> d.last_deg
    dim.last_field = data.dimension (d) -> d.last_field
    dim.race = data.dimension (d) -> d.race
    dim.resistat = data.dimension (d) -> d.resistat
    dim.small_bus_exp = data.dimension (d) -> d.small_bus_exp
    dim.venture_nums = data.dimension (d) -> d.venture_nums

    

)

