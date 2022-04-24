// check if building is recyclable by player
params ["_vehicle"];
private _ret = false;
private _find = { if ((_x select 0) == typeOf _vehicle) exitWith { (_x select 4) }} foreach buildings; 

if (_find <= score player) then { _ret = true };
_ret;