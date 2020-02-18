private ["_pos", "_class", "_veh", "_para", "_text", "_rank", "_cost", "_dist", "_ammo_collected"];

_unit = player;
do_action = 0;
air_type = 0;
air_perm = 0;
hintSilent "";
createDialog "liberation_airdrop";
_list_perm=[];

_rank = _unit getVariable ["GRLIB_Rank", "Private"];
if (_rank in ["Private"]) then {_list_perm = [1601,1602,1603,1604,1605,1606]};
if (_rank in ["Corporal"]) then {_list_perm = [1602,1603,1604,1605,1606]};
if (_rank in ["Sergeant"]) then {_list_perm = [1603,1604,1605]};
if (_rank in ["Captain"]) then {_list_perm = [1604,1605]};
if (_rank in ["Major"]) then {_list_perm = [1605]};

{
	((findDisplay 5205) displayCtrl _x) ctrlEnable false;
} forEach _list_perm;

waitUntil { dialog };
while { dialog && (alive player) && do_action == 0 } do {
	sleep 0.1;
};
closeDialog 0;

if (do_action == 1) then {
	_timer = _unit getVariable ["AirCoolDown", 0];
	if ( _timer >= 1 && !(air_type in [7, 8])) exitWith {hint format ["Air Support not ready !\nNew call in %1 min\n\nPlease wait...", _timer]};
	_cost = 0;
	switch (air_type) do {
		case 1 : {_class=GRLIB_AirDrop_1 call BIS_fnc_selectRandom;_cost=50};
		case 2 : {_class=GRLIB_AirDrop_2 call BIS_fnc_selectRandom;_cost=100};
		case 3 : {_class=GRLIB_AirDrop_3 call BIS_fnc_selectRandom;_cost=200};
		case 4 : {_class=GRLIB_AirDrop_4 call BIS_fnc_selectRandom;_cost=300};
		case 5 : {_class=GRLIB_AirDrop_5 call BIS_fnc_selectRandom;_cost=750};
		case 6 : {_class=GRLIB_AirDrop_6 call BIS_fnc_selectRandom;_cost=250};
		case 7 : {_cost=2000};
		case 8 : {_cost=100};
	};

	if (_cost == 0) exitWith {};
	_ammo_collected = _unit getVariable ["GREUH_ammo_count",0];
	if (_ammo_collected < _cost) exitWith {hint "You dont have enough Ammo !"};
	_unit setVariable ["GREUH_ammo_count", (_ammo_collected - _cost), true];
	playSound "rearm";

	//_unit setVariable ["AirCoolDown", 15, true];
	if (air_type == 7) exitWith {[player] remoteExec ["send_aircraft_remote_call", 2]};
	if (air_type == 8) exitWith {[] execVM "addons\TAXI\call_taxi.sqf"};
	[player, _class] remoteExec ["airdrop_remote_call", 2];
};
