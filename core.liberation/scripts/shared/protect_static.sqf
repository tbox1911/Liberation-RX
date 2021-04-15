params ["_static"];

if (!(typeOf _static in opfor_statics + static_vehicles + ind_statics)) exitWith {};

while { alive _static } do {
	// No damage
	_static allowDamage false;

	// OPFor infinite Ammo
	if (side _static == GRLIB_side_enemy) then {
		//_ammo = [_veh] call F_getVehicleAmmoDef;
		_static setVehicleAmmo 1;
	};

	// Correct static position
	if ((vectorUp _static) select 2 < 0.70) then {
		_static setpos [(getposATL _static) select 0,(getposATL _static) select 1, 0.5];
		_static setVectorUp surfaceNormal position _static;
	};

	sleep 5;
};