params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

//only one wreck at time
if ((player getVariable ["salvage_wreck", false])) exitWith {};
//only one player at time
if ((_vehicle getVariable ["wreck_in_use", false])) exitWith {};
player setVariable ["salvage_wreck", true, true];
_vehicle setVariable ["wreck_in_use", true, true];

// Stop running
AR_active = false;

private _valuable_veh = opfor_recyclable apply { _x select 0 };
private _bounty = 0;
private _bonus = 0;
if (typeOf _vehicle in _valuable_veh) then {
	_res = [_vehicle] call F_getBounty;
	_bounty = _res select 0;
	_bonus = _res select 1;
};

disableUserInput true;
player setDir (player getDir _vehicle);
player playMove 'ainvpknlmstpslaywrfldnon_medic';
playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_repair.wss", _vehicle];
sleep 5;
disableUserInput false;
disableUserInput true;
disableUserInput false;

if (round (getPosASL player select 2) <= -1) then {player switchmove ""};

if (lifeState player == 'INCAPACITATED' || !isNull objectParent player) exitWith {
	_vehicle setVariable ["wreck_in_use", false, true];
	player setVariable ["salvage_wreck", false, true];
};

deleteVehicle _vehicle;
sleep 0.5;

if ((_bonus + _bounty) > 0) then {
	[player, _bounty, 2] remoteExec ["ammo_add_remote_call", 2];
	hintSilent format [localize "STR_DO_WRECK", name player, _bonus, _bounty];
	[player, _bonus] remoteExec ["F_addScore", 2];
} else {
	hintSilent "Thank You !!";
};

sleep 0.5;
player setVariable ["salvage_wreck", false, true];
