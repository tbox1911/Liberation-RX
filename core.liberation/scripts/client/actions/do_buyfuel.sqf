_cost = 5;

_msg = format ["<t align='center'>Fuel Jerican cost: %1 Ammo<br/>Are you sure ?</t>", _cost];
_result = [_msg, "Warning !", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	_pos = player modelToWorld [0,1,1];
	_can = createVehicle ["Land_CanisterFuel_Red_F", _pos, [], 0, "CAN_COLLIDE"];
	private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
	player setVariable ["GREUH_ammo_count", (_ammo_collected - _cost ), true];
	[_can] spawn R3F_LOG_FNCT_objet_deplacer;
	playSound "rearm";
	hintSilent "Jerican Fuel ready.\nThank you !";
};
