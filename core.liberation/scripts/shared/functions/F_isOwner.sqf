params ["_unit", "_vehicle", ["_strict", false]];
if (isNull _vehicle) exitWith { false };
if (side group _vehicle == GRLIB_side_enemy)  exitWith { false };

private _owner_id = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
if (_owner_id in ["server", "public"]) exitWith { false };
if (!GRLIB_permission_vehicles) exitWith { true };

private _unit_id = getPlayerUID (leader _unit);
private _list_owner = ["", _unit_id];
if (_strict) then { _list_owner = [_unit_id] };
(_owner_id in _list_owner || group _unit == group (_owner_id call BIS_fnc_getUnitByUID))
