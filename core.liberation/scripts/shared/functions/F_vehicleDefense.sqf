params ["_vehicle"];

if (!local _vehicle) exitWith {};
if (isNull _vehicle) exitWith {};
if (isNil {_vehicle getVariable "GREUH_vehicle_defense"}) then {
	_vehicle removeAllEventHandlers "IncomingMissile";
	_vehicle addEventHandler ["IncomingMissile", {
		params ["_target", "_ammo", "_vehicle", "_instigator"];
		if (objectParent player == _vehicle) then { hint "Incoming Missile !!" };
		if (_vehicle isKindOf "Air") then {
			_target action ["useWeapon", _target, driver _target, 0];
		} else {
			_target action ["useWeapon", _target, commander _target, 0];
		};
	}];
	_vehicle setVariable ["GREUH_vehicle_defense", true];
};