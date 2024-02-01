if (!isServer && hasInterface) exitWith {};
params ["_player"];

// Recover Squad
[_player, getPlayerUID _player] spawn load_context;
