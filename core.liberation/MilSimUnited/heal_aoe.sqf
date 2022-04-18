_list = position _this nearEntities ["MAN",10];
_list;
{ 
  [_x] call ACE_medical_treatment_fnc_fullHealLocal; 
  sleep 0.1; 
 } foreach _list;