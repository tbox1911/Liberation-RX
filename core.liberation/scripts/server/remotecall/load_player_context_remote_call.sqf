if (!isServer && hasInterface) exitWith {};
params ["_player"];

if (isNil "_player") exitWith {};
if (isNull _player) exitWith {};

// Recover Player
[_player, getPlayerUID _player] spawn load_player_context;
