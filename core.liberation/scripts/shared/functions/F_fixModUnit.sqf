params ["_unit"];

// CUP fix units
switch (typeOf _unit) do {
  case "CUP_I_RACS_Medic": { _unit setUnitTrait ["Medic", true] };
  case "CUP_I_RACS_Engineer": { _unit setUnitTrait ["Engineer", true] };
  default {};
};
