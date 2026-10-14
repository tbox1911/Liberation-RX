if (!isServer && hasInterface) exitWith {};
params ["_fob_pos"];

[_fob_pos] call fob_destroy;
