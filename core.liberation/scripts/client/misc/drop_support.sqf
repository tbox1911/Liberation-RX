private ["_class","_cost","_AirDrop_1_cost","_AirDrop_2_cost","_AirDrop_3_cost","_AirDrop_4_cost","_AirDrop_5_cost","_AirDrop_6_cost","_AirDrop_7_cost"];
private _timer = player getVariable ["AirCoolDown", 0];
if (_timer > time) exitWith {hint format ["Air Support not ready !\nNext call in %1 min\n\nPlease wait...", round ((_timer - time)/60)]};

do_action = 0;
air_type = 0;
air_perm = 0;
hintSilent "";
createDialog "liberation_airdrop";
waitUntil { dialog };

private _rank = player getVariable ["GRLIB_Rank", "Private"];
if (_rank == "Super Colonel") then {
	_AirDrop_1_cost = round (GRLIB_AirDrop_1_cost / 2);
	_AirDrop_2_cost = round (GRLIB_AirDrop_2_cost / 2);
	_AirDrop_3_cost = round (GRLIB_AirDrop_3_cost / 2);
	_AirDrop_4_cost = round (GRLIB_AirDrop_4_cost / 2);
	_AirDrop_5_cost = round (GRLIB_AirDrop_5_cost / 2);
	_AirDrop_6_cost = round (GRLIB_AirDrop_6_cost / 2);
	_AirDrop_7_cost = round (GRLIB_AirDrop_7_cost / 2);
} else {
	_AirDrop_1_cost = GRLIB_AirDrop_1_cost;
	_AirDrop_2_cost = GRLIB_AirDrop_2_cost;
	_AirDrop_3_cost = GRLIB_AirDrop_3_cost;
	_AirDrop_4_cost = GRLIB_AirDrop_4_cost;
	_AirDrop_5_cost = GRLIB_AirDrop_5_cost;
	_AirDrop_6_cost = GRLIB_AirDrop_6_cost;
	_AirDrop_7_cost = GRLIB_AirDrop_7_cost;
};

private _display = findDisplay 5205;
ctrlSetText [1621, format [localize "STR_QUAD_OFFLOAD", _AirDrop_1_cost]];
ctrlSetText [1622, format [localize "STR_ARMED_OFFLOAD", _AirDrop_2_cost]];
ctrlSetText [1623, format [localize "STR_MRAP", _AirDrop_3_cost]];
ctrlSetText [1624, format [localize "STR_TRUCK", _AirDrop_4_cost]];
ctrlSetText [1625, format [localize "STR_APC", _AirDrop_5_cost]];
ctrlSetText [1626, format [localize "STR_BOAT", _AirDrop_6_cost]];
ctrlSetText [1627, format [localize "STR_AIRSUPREMACY", _AirDrop_7_cost]];
ctrlSetText [1628, format [localize "STR_CALL_HELITAXI", GRLIB_AirDrop_Taxi_cost]];

private _list_perm = [];
if (_rank in ["Private"]) then {_list_perm = [1601,1602,1603,1604,1605,1606]};
if (_rank in ["Corporal"]) then {_list_perm = [1602,1603,1604,1605,1606]};
if (_rank in ["Sergeant"]) then {_list_perm = [1603,1604,1605]};
if (_rank in ["Captain"]) then {_list_perm = [1604,1605]};
if (_rank in ["Major"]) then {_list_perm = [1605]};
{ ctrlEnable [_x, false] } forEach _list_perm;

while { dialog && (alive player) && do_action == 0 } do {
	sleep 0.1;
};
closeDialog 0;

if (do_action == 1) then {
	_cost = 0;
	switch (air_type) do {
		case 1 : {_class=selectRandom GRLIB_AirDrop_1;_cost=_AirDrop_1_cost};
		case 2 : {_class=selectRandom GRLIB_AirDrop_2;_cost=_AirDrop_2_cost};
		case 3 : {_class=selectRandom GRLIB_AirDrop_3;_cost=_AirDrop_3_cost};
		case 4 : {_class=selectRandom GRLIB_AirDrop_4;_cost=_AirDrop_4_cost};
		case 5 : {_class=selectRandom GRLIB_AirDrop_5;_cost=_AirDrop_5_cost};
		case 6 : {_class=selectRandom GRLIB_AirDrop_6;_cost=_AirDrop_6_cost};
		case 7 : {_cost=_AirDrop_7_cost};
		case 8 : {_cost=0};
	};
	if (air_type == 8) exitWith {[] execVM "addons\TAXI\call_taxi.sqf"};
	if (!([_cost] call F_pay)) exitWith {};
	player setVariable ["AirCoolDown", round(time + 15*60)];
	if (air_type == 7) exitWith {[player] remoteExec ["send_aircraft_remote_call", 2]};
	[player, _class] remoteExec ["airdrop_remote_call", 2];
};
