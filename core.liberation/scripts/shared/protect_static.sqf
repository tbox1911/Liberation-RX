params ["_static"];

while { true } do {
	if (!alive _static) exitWith {};

	// Correct static position
	if ((vectorUp _static) select 2 < 0.70) then {
		_static setpos [(getposATL _static) select 0,(getposATL _static) select 1, 0.5];
		_static setVectorUp surfaceNormal position _static;
	};

	sleep 10;
};