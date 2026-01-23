params ["_unit", "_selection", "_damage", "_killer", "", "", "_instigator"];

if (!(_unit isKindOf "AllVehicles") || (typeOf _unit in list_static_weapons)) exitWith {};

if (count (crew _unit) > 0) then {
	// Eject crew
	private _vehicle_damage = [_unit] call F_getVehicleDamage;
	if (_vehicle_damage >= 0.45 && _damage > 0.1) then {
		private _evac_in_progress = (_unit getVariable ["GRLIB_vehicle_evac", false]);
		if (!_evac_in_progress) then {
			_unit setVariable ["GRLIB_vehicle_evac", true, true];
			{ [_x, false] spawn F_ejectUnit } forEach (crew _unit);
		};
	};
};
