params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[
	[_vehicle],
{
	params ["_vehicle"];
	_vehicle allowDamage false;
	sleep 1;
	_vehicle setpos [(getposATL _vehicle) select 0,(getposATL _vehicle) select 1, 0.5];
	_vehicle setVectorUp surfaceNormal position _vehicle;
	sleep 4;
	_vehicle allowDamage true;
}] remoteExec ["bis_fnc_call", 2];
