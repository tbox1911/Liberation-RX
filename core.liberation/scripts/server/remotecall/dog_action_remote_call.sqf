if (!isServer && hasInterface) exitWith {};
params [ "_unit", "_cmd" ];

_my_dog = _unit getVariable ["my_dog", nil];
if (!isNil "_my_dog") then {

	if (_cmd == "hide") then {_my_dog hideObjectGlobal true};

	if (_cmd == "show") then {_my_dog hideObjectGlobal false};

	if (_cmd == "bark") then {
		{
			if ((_x distance2D _my_dog) <= 200) then {
				[["a3\sounds_f\ambient\animals\dog1.wss", _my_dog, false, getPosASL _my_dog, 2, 0.8, 0]] remoteExec ["playSound3D", owner _x];
			};
		} forEach allPlayers;
	};

};