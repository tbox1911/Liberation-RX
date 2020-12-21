params ["_static"];

// No damage
_static allowDamage false;

// OPFor infinite Ammo
if (typeOf _static in opfor_statics) then {
	_static addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
};

while { alive _static } do {

	// Correct static position
	if ((vectorUp _static) select 2 < 0.70) then {
		_static setpos [(getposATL _static) select 0,(getposATL _static) select 1, 0.5];
		_static setVectorUp surfaceNormal position _static;
	};

	sleep 10;
};