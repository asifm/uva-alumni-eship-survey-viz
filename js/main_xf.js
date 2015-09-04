// Generated by CoffeeScript 1.9.3
var process_data;

process_data = function(d) {
  var data;
  data = {
    birth: +d.birth,
    entrepreneur: +d.entrepreneur,
    founder: +d.founder,
    early_emp: +d.early_emp,
    board_member: +d.board_member,
    investor: +d.investor,
    family_ent: +d.family_ent,
    first_fd_age: +d.first_fd_age,
    gender: d.gender,
    instate: +d.instate,
    inv_innov: d.inv_innov,
    inv_uva: d.inv_uva,
    last_deg: d.last_deg,
    last_field: d.last_field,
    last_gradyr: +d.last_gradyr,
    last_job_ind: d.last_job_ind,
    race: d.race,
    resistat: d.resistat,
    small_bus_exp: +d.small_bus_exp,
    venture_nums: +d.venture_nums,
    key_0: +d.key_0
  };
  return data;
};

d3.csv('data/alum_xf.csv', process_data, function(data) {
  var basic_num_format, chart, dim, grp, xf;
  xf = crossfilter(data);
  dim = {};
  dim.birth = xf.dimension(function(d) {
    return d.birth;
  });
  dim.entrepreneur = xf.dimension(function(d) {
    if (d.entrepreneur === 1) {
      return "Entrepreneur";
    } else {
      return "Not entrepreneur";
    }
  });
  dim.founder = xf.dimension(function(d) {
    if (d.founder === 1) {
      return "Founder";
    } else {
      return "Not founder";
    }
  });
  dim.early_emp = xf.dimension(function(d) {
    if (d.early_emp === 1) {
      return "Early employee";
    } else {
      return "Not early employee";
    }
  });
  dim.board_member = xf.dimension(function(d) {
    return d.board_member;
  });
  dim.investor = xf.dimension(function(d) {
    return d.investor;
  });
  dim.family_ent = xf.dimension(function(d) {
    return d.family_ent;
  });
  dim.first_fd_age = xf.dimension(function(d) {
    return d.first_fd_age;
  });
  dim.gender = xf.dimension(function(d) {
    if (d.gender === "") {
      return null;
    } else {
      return d.gender;
    }
  });
  dim.instate = xf.dimension(function(d) {
    return d.instate;
  });
  dim.inv_innov = xf.dimension(function(d) {
    return d.inv_innov;
  });
  dim.inv_uva = xf.dimension(function(d) {
    return d.inv_uva;
  });
  dim.last_deg = xf.dimension(function(d) {
    return d.last_deg;
  });
  dim.last_field = xf.dimension(function(d) {
    return d.last_field;
  });
  dim.race = xf.dimension(function(d) {
    if (d.race === "") {
      return null;
    } else {
      return d.race;
    }
  });
  dim.resistat = xf.dimension(function(d) {
    return d.resistat;
  });
  dim.small_bus_exp = xf.dimension(function(d) {
    return d.small_bus_exp;
  });
  dim.venture_nums = xf.dimension(function(d) {
    return d.venture_nums;
  });
  grp = {};
  grp.birth = dim.birth.group();
  grp.gender = dim.gender.group();
  grp.entrepreneur = dim.entrepreneur.group();
  grp.founder = dim.founder.group();
  grp.early_emp = dim.early_emp.group();
  grp.race = dim.race.group();
  chart = {};
  chart.birthBar = dc.barChart('#birth');
  chart.genderPie = dc.pieChart('#gender');
  chart.entrepreneurPie = dc.pieChart('#entrepreneur');
  chart.founderPie = dc.pieChart('#founder');
  chart.earlyempPie = dc.pieChart('#early-emp');
  chart.raceRow = dc.rowChart('#race');
  chart.birthBar.width(600).height(300).dimension(dim.birth).group(grp.birth).x(d3.scale.linear().domain([1930, 1995])).elasticY(true).renderHorizontalGridLines(true).renderVerticalGridLines(true);
  chart.raceRow.width(600).height(300).dimension(dim.race).group(grp.race).ordering(function(d) {
    return d.value;
  }).elasticX(true);
  basic_num_format = d3.format(".0f");
  chart.birthBar.xAxis().tickFormat(function(v) {
    return basic_num_format(v);
  });
  chart.genderPie.width(300).height(300).dimension(dim.gender).group(grp.gender).radius(150);
  chart.entrepreneurPie.dimension(dim.entrepreneur).group(grp.entrepreneur);
  chart.founderPie.dimension(dim.founder).group(grp.founder);
  chart.earlyempPie.dimension(dim.early_emp).group(grp.early_emp);
  return dc.renderAll();
});
