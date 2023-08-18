params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

sleep random 0.3;

//only one wreck at time
if ((player getVariable ["salvage_wreck", false])) exitWith {};
//only one player at time
if ((_vehicle getVariable ["wreck_in_use", false])) exitWith {};
player setVariable ["salvage_wreck", true, true];
_vehicle setVariable ["wreck_in_use", true, true];

// Stop running
AR_active = false;

private _valuable_veh = [] + opfor_air ;
{ _valuable_veh pushBack ( _x select 0 ) } foreach (heavy_vehicles + opfor_recyclable + ind_recyclable);

disableUserInput true;
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
[_vehicle] remoteExec ["clean_vehicle", 2];

private _msg = "";
if (typeOf _vehicle in _valuable_veh) then {
	_res = [_vehicle] call F_getBounty;
	_bounty = _res select 0;
	_bonus = _res select 1;
	[player, _bounty, 2] remoteExec ["ammo_add_remote_call", 2];
	hintSilent format [localize "STR_DO_WRECK", name player, _bonus, _bounty];
	[player, _bonus] remoteExec ["F_addScore", 2];
	player addRating 10;
} else {
	hintSilent "Thank You !!";
};
sleep 0.5;
player setVariable ["salvage_wreck", false, true];
