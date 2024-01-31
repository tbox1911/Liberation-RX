// Rearm each turret's standard weapons and pylons

scriptName _fnc_scriptName;

private _veh = param [0,objNull,[objNull]];
private _fill = param [1,true,[false]];

if (isServer) then {
	{[_veh,_fill,_x] remoteExecCall ["DALE_fnc_pylonRearmRemote",_veh turretOwner _x];} forEach ([[-1]] + allTurrets _veh);
} else {
	_this remoteExecCall [_fnc_scriptName,2];
};