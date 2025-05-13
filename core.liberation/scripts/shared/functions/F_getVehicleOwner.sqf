params ["_vehicle"];

private _owner = "";
private _owner_id = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
if (_owner_id != "") then {
	{
		if ( (_x select 0) == _owner_id) exitWith {
			_owner = (_x select 5);
		};
	} forEach GRLIB_player_scores;
} else {
	_owner = "No Owner";
};
if (_owner == "") then { _owner = _owner_id };

_owner;