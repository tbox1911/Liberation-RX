// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"]; 
private ["_box"];

_box = createVehicle [_type, _pos, [], 5, "None"];
_box setDir random 360;
_box addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

if (isNil "_locked") then { _locked = false};

if (_locked) then {
	_box setVariable ["R3F_LOG_disabled", true, true];
	//_box allowDamage false; 
} else {
	_box setVariable ["R3F_LOG_disabled", false, true];
	//_box allowDamage true; 
};
_box;
