if (!isServer && hasInterface) exitWith {};
params ["_pos", "_sound"];

{
	if (_x distance2D _pos < GRLIB_capture_size) then {
		[_sound] remoteExec ["playSound", owner _x];
	};
} forEach (AllPlayers - (entities "HeadlessClient_F"));