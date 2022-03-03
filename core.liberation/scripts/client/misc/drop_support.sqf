private ["_pos", "_class", "_veh", "_para", "_text", "_rank", "_cost", "_dist", "_ammo_collected"];

do_action = 0;
air_type = 0;
air_perm = 0;
hintSilent "";
createDialog "liberation_airdrop";
_list_perm=[];

_rank = player getVariable ["GRLIB_Rank", "Private"];
/*
if (_rank in ["Private"]) then {_list_perm = [1601,1602,1603,1604,1605,1606]};
if (_rank in ["Corporal"]) then {_list_perm = [1602,1603,1604,1605,1606]};
if (_rank in ["Sergeant"]) then {_list_perm = [1603,1604,1605]};
if (_rank in ["Captain"]) then {_list_perm = [1604,1605]};
if (_rank in ["Major"]) then {_list_perm = [1605]};
*/

{
	((findDisplay 5205) displayCtrl _x) ctrlEnable false;
} forEach _list_perm;

waitUntil { dialog };
while { dialog && (alive player) && do_action == 0 } do {
	sleep 0.1;
};
closeDialog 0;

if (do_action == 1) then {
	_timer = player getVariable ["AirCoolDown", 0];
	if (_timer > time) exitWith {hint format ["Air Support not ready !\nNext call in %1 min\n\nPlease wait...", round ((_timer - time)/60)]};
	_cost = 0;
	switch (air_type) do {
		case 1 : {_class=selectRandom GRLIB_AirDrop_1;_cost=30};
		case 2 : {_class=selectRandom GRLIB_AirDrop_2;_cost=30};
		case 3 : {_class=selectRandom GRLIB_AirDrop_3;_cost=40};
		case 4 : {_class=selectRandom GRLIB_AirDrop_4;_cost=80};
		case 5 : {_class=selectRandom GRLIB_AirDrop_5;_cost=400};
		case 6 : {_class=selectRandom GRLIB_AirDrop_6;_cost=30};
		case 7 : {_cost=2000};
		case 8 : {_cost=0};
	};

	if (!([_cost] call F_pay)) exitWith {};

	if (air_type == 7) exitWith {[player] remoteExec ["send_aircraft_remote_call", 2]};
	if (air_type == 8) exitWith {[] execVM "addons\TAXI\call_taxi.sqf"};
	[player, _class] remoteExec ["airdrop_remote_call", 2];
	player setVariable ["AirCoolDown", round(time + 5*60)];
};
