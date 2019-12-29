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
	if ( _timer >= 1 ) exitWith {hint format ["Air Support not ready !\nNew call in %1 min\n\nPlease wait...", _timer]};
	_cost = 0;
	switch (air_type) do {
		case 1 : {_class=["I_Quadbike_01_F","I_G_Offroad_01_F","I_G_Quadbike_01_F","C_Offroad_01_F","B_G_Offroad_01_F"] call BIS_fnc_selectRandom;_cost=50};
		case 2 : {_class=["I_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","I_C_Offroad_02_LMG_F"] call BIS_fnc_selectRandom;_cost=100};
		case 3 : {_class=["I_MRAP_03_hmg_F","I_MRAP_03_hmg_F","B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F"] call BIS_fnc_selectRandom;_cost=200};
		case 4 : {_class=["B_Truck_01_transport_F","B_Truck_01_covered_F","I_Truck_02_covered_F","I_Truck_02_transport_F"] call BIS_fnc_selectRandom;_cost=300};
		case 5 : {_class=["I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F","B_APC_Wheeled_01_cannon_F"] call BIS_fnc_selectRandom;_cost=750};
		case 6 : {_class=["C_Boat_Civil_01_F","C_Boat_Transport_02_F","B_Boat_Transport_01_F","I_C_Boat_Transport_02_F"] call BIS_fnc_selectRandom;_cost=250};
		case 7 : {_cost=2000};
	};

	if (_cost == 0) exitWith {};
	_ammo_collected = _unit getVariable ["GREUH_ammo_count",0];
	if (_ammo_collected < _cost) exitWith {hint "You dont have enough Ammo !"};

	_unit setVariable ["GREUH_ammo_count", (_ammo_collected - _cost), true];
	//_unit setVariable ["AirCoolDown", 15, true];
	if (air_type == 7) exitWith {[player] remoteExec ["send_aircraft_remote_call", 2]};
	[player, _class] remoteExec ["airdrop_remote_call", 2];
};
