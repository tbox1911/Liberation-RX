_unit = _this select 0;
_condition = _this select 1;

_list = position _unit nearEntities ["MAN",10];
_list;
{ 
  [_x] call ACE_medical_treatment_fnc_fullHealLocal; 
  sleep 0.1; 
 } foreach _list;