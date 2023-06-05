params ["_unit", "_vehicle"];
if (isNull _vehicle) exitWith { false };

private _ret = false;
if (side group _vehicle != GRLIB_side_enemy) then {
	private _unit_id = getPlayerUID (leader _unit);
	private _owner_id = _vehicle getVariable ["GRLIB_vehicle_owner", ""];

	if (_owner_id == "" || _owner_id == _unit_id || group _unit == group (_owner_id call BIS_fnc_getUnitByUID)) then {
		_ret = true;
	};
};
_ret;
