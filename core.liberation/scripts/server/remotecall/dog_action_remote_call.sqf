if (!isServer && hasInterface) exitWith {};
params [ "_unit", "_cmd", "_tone" ];

_my_dog = _unit getVariable ["my_dog", nil];
if (!isNil "_my_dog") then {
	if (_cmd == "hide") then {_my_dog hideObjectGlobal true};
	if (_cmd == "show") then {_my_dog hideObjectGlobal false};
};