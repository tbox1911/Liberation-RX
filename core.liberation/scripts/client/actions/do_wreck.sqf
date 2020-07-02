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

_free_vehicles = [] + vip_vehicles;
{
	_free_vehicles pushBack ( _x select 0 );
} foreach (light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + buildings);

_free_vehicles = _free_vehicles + [
	huron_typename,
	"B_Heli_Transport_01_F",
	"Land_Cargo_HQ_V1_ruins_F",
	"Land_Cargo_Tower_V1_ruins_F",
	"Land_Cargo_House_V1_ruins_F",
	"Land_Cargo_Patrol_V1_ruins_F"
];

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
if (typeOf _vehicle in _free_vehicles) then {
		hintSilent "Thank You !!";
} else {
	_res = [_vehicle] call F_getBounty;
	_bounty = _res select 0;
	_bonus = _res select 1;
	private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
	player setVariable ["GREUH_ammo_count", (_ammo_collected + _bounty), true];
	hintSilent format ["%1\nBonus Score + %2 Pts\nBonus Ammo + %3 !!", name player, _bonus, _bounty];
	[player, _bonus] remoteExec ["addScore", 2];
	player addRating 100;
};
player setVariable ["salvage_wreck", false, true];