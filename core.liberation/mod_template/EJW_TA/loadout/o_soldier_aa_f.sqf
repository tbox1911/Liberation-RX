_unit = _this select 0;

private _militia_uniforms = [ 
  "U_Afghan01",
  "U_Afghan02",
  "U_Afghan03",
  "U_Afghan04",
  "U_Afghan05",
  "U_Afghan06"
];

removeUniform _unit;
_unit forceAddUniform (selectRandom _militia_uniforms);
