if (!isServer) exitWith {};
params [ "_my_dog", "_cmd" ];

if (!isNil "_my_dog") then {

	diag_log format ["DBG: DOG %1", _my_dog];
	if (_cmd == "hide") then {_my_dog hideObjectGlobal true};

	if (_cmd == "show") then {_my_dog hideObjectGlobal false};

	if (_cmd == "bark") then {
		{
			if ((_x distance2D _my_dog) <= 100) then {
				[["a3\sounds_f\ambient\animals\dog1.wss", _my_dog, false, getPos _my_dog, 6, 0.8, 0]] remoteExec ["playSound3D", owner _x];
			};
		} forEach allPlayers;
	};

};