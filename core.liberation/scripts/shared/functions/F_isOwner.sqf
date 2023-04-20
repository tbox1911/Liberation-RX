params ["_unit", "_vehicle"];

private _ret = false;
if (side _vehicle != GRLIB_side_enemy) then {
	private _unit_id = getPlayerUID (leader _unit);
	private _owner_id = _vehicle getVariable ["GRLIB_vehicle_owner", ""];

	if (_owner_id == "" || _owner_id == _unit_id) then {
		_ret = true;
	};
};
_ret;
