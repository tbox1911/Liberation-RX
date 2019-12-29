params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if ( !isNull _vehicle ) then {
	_vehicle allowDamage false;
	_vehicle setpos [(getposATL _vehicle) select 0,(getposATL _vehicle) select 1, 0.5];
	_vehicle setVectorUp surfaceNormal position _vehicle;
	sleep 3;
	_vehicle allowDamage true;
};