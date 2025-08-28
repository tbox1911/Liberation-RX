params ["_vehicle"];

if (!local _vehicle) exitWith {};
if (isNull _vehicle) exitWith {};

if (isNil {_vehicle getVariable "GREUH_vehicle_defense"}) then {
	_vehicle removeAllEventHandlers "IncomingMissile";
	_vehicle addEventHandler ["IncomingMissile", {
		params ["_target", "_ammo", "_vehicle", "_instigator"];
		if (objectParent player == _vehicle) then {
			gamelogic globalChat format ["Warning! Incoming Missile (%1)!!", _ammo];
		};
		if (_vehicle isKindOf "Air") then {
			_target action ["useWeapon", _target, driver _target, 0];
		} else {		
			_target action ["useWeapon", _target, driver _target, 1];
			_target action ["useWeapon", _target, gunner _target, 10];
			_target action ["useWeapon", _target, commander _target, 0];
			_target action ["useWeapon", _target, commander _target, 5];
		};
		if (typeOf _vehicle in opfor_troup_transports_heli) then {
			private _grp = grpNull; 
			{ 
				if (assignedVehicleRole _x select 0 == "cargo") then {
					_grp = group _x;
					[_x, false] spawn F_ejectUnit;
				};
				sleep 0.2;
			} forEach (crew _vehicle);
			if !(isNull _grp) then {
				private _next_objective = [getPos _vehicle, GRLIB_spawn_min] call F_getNearestBlufor;
				if (!isNil "_next_objective") then {
					[_grp, _next_objective] spawn battlegroup_ai;
				};
			};
		};
	}];
	_vehicle setVariable ["GREUH_vehicle_defense", true];
};