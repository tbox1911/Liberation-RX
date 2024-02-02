if (!isServer && hasInterface) exitWith {};
params [ "_pos"];

if (isNil "_pos") exitWith {};

private _player = ([_pos, 3] call F_getNearbyPlayers) select 0;
if !(isNil "_player") then {
	[_player, 1] call F_addScore;
	["Deactivating the mine +1XP!"] remoteExec ["hintSilent", owner _player];
};
