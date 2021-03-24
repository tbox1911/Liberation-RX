params ["_unit", "_vehicle"];
private ["_ret","_owner_id","_unit_id","_unitLeader"];

_ret = false;
if (side _vehicle != GRLIB_side_enemy) then {
	_unit_id = getPlayerUID (leader _unit);
	_owner_id = _vehicle getVariable ["GRLIB_vehicle_owner", ""];

	if (_owner_id == "" || _owner_id == _unit_id) then {
		_ret = true;
	};
};
_ret;
