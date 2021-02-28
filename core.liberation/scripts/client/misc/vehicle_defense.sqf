params ["_unit", "_role", "_vehicle"];

_vehicle removeAllEventHandlers "IncomingMissile";
_vehicle addEventHandler ["IncomingMissile", {
	params ["_target", "_ammo", "_vehicle", "_instigator"];
	if (vehicle player == _vehicle) then {hintSilent "Incoming Missile !!"};
	_target action ["useWeapon", _target, commander _target, 0];
}];
