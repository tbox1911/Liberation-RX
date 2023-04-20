params ["_vehicle"];
_vehicle removeAllEventHandlers "IncomingMissile";
_vehicle addEventHandler ["IncomingMissile", {
	params ["_target", "_ammo", "_vehicle", "_instigator"];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	if (objectParent player == _vehicle) then {hintSilent "Incoming Missile !!"};
=======
	if (vehicle player == _vehicle) then {hintSilent "Incoming Missile !!"};
>>>>>>> fed60562 (add vehicle autodefense)
=======
	if (objectParent player == _vehicle) then {hintSilent "Incoming Missile !!"};
>>>>>>> 853c97d0 ( "objectParent" instead of "vehicle")
=======
	if (objectParent player == _vehicle) then {hintSilent "Incoming Missile !!"};
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04
	_target action ["useWeapon", _target, commander _target, 0];
}];
