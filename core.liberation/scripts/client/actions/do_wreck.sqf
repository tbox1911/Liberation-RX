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

private _valuable_veh = opfor_air + ["O_Heli_Attack_02_dynamicLoadout_F", "O_Heli_Light_02_dynamicLoadout_F", "I_Heli_light_03_dynamicLoadout_F"];
{ _valuable_veh pushBack ( _x select 0 ) } foreach (heavy_vehicles + opfor_recyclable + ind_recyclable);

disableUserInput true;
player playMove 'ainvpknlmstpslaywrfldnon_medic';
for "_i" from 1 to 3 do {
	playSound "repair";
	sleep 2;
};
disableUserInput false;
disableUserInput true;
disableUserInput false;
if (round (getPosASL player select 2) <= -1) then {player switchmove ""};

if (lifeState player == 'incapacitated' || vehicle player != player) exitWith {
	_vehicle setVariable ["wreck_in_use", false, true];
	player setVariable ["salvage_wreck", false, true];
};
[_vehicle] remoteExec ["clean_vehicle", 2];
[_vehicle] remoteExec ["deleteVehicle", 2];

private _msg = "";
if (typeOf _vehicle in _valuable_veh) then {
	_res = [_vehicle] call F_getBounty;
	_bounty = _res select 0;
	_bonus = _res select 1;
	private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
	player setVariable ["GREUH_ammo_count", (_ammo_collected + _bounty), true];
	hintSilent format ["%1\nBonus Score + %2 Pts\nBonus Ammo + %3 !!", name player, _bonus, _bounty];
	[player, _bonus] remoteExec ["addScore", 2];
	player addRating 100;
} else {
	hintSilent "Thank You !!";
};
sleep 0.5;
player setVariable ["salvage_wreck", false, true];