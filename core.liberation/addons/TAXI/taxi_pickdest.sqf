params ["_target"];
//add limit ?
if (time < GRLIB_taxi_cooldown) exitWith { hintSilent "Please wait..." };

openMap true;
hintSilent localize "STR_TAXI_SELECT";
_target onMapSingleClick {
	_freepos = _pos findEmptyPosition [0,30, "B_Heli_Transport_01_F"];
	if (surfaceIsWater _pos || count _freepos == 0) exitWith { hintSilent localize "STR_TAXI_WRONG_PLACE" };
	if (vehicle player == _this) then {
		[_this, _freepos] spawn taxi_check_dest;
	};
	onMapSingleClick "";
	openMap false;
	true;
};
