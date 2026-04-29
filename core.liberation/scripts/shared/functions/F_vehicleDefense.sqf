params ["_vehicle"];

if (!local _vehicle) exitWith {};
if (isNull _vehicle) exitWith {};

if (isNil {_vehicle getVariable "GREUH_vehicle_defense"}) then {
	_vehicle setVariable ["GREUH_vehicle_defense", true, true];
	_vehicle removeAllEventHandlers "IncomingMissile";
	_vehicle addEventHandler ["IncomingMissile", {
		params ["_target", "_ammo", "_vehicle", "_instigator"];

		if (count (crew _target) == 0) exitWith {};
		if (objectParent player == _target) then {
			gamelogic globalChat format ["Warning! Incoming Missile (%1)!!", _ammo];
		};

		if (_target isKindOf "Air") then {
			_target action ["useWeapon", _target, driver _target, 0];
		} else {
			_target action ["useWeapon", _target, driver _target, 1];
			_target action ["useWeapon", _target, gunner _target, 10];
			_target action ["useWeapon", _target, commander _target, 0];
			_target action ["useWeapon", _target, commander _target, 5];
		};

		if (typeOf _target in opfor_troup_transports_heli) then {
			private _evac_in_progress = (_target getVariable ["GRLIB_vehicle_evac", false]);
			private _cargo = (crew _target) select { assignedVehicleRole _x select 0 == "cargo" };
			if (count _cargo > 0 && !_evac_in_progress) then {
				_target setVariable ["GRLIB_vehicle_evac", true, true];
				[_cargo] spawn {
					params ["_cargo"];
					private _leader = _cargo select 0;
					{ [_x, false] spawn F_ejectUnit; sleep 0.5 } forEach _cargo;

					private _target = [getPos _leader, GRLIB_spawn_min] call F_getNearestBlufor;
					if (isNull _target) then {
						{ deleteVehicle _x } forEach _cargo;
					} else {
						[group _leader, _target] spawn battlegroup_ai;
					};
				};
			};
		};
	}];
};