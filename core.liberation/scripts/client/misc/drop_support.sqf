private ["_class","_cost"];
private _timer = player getVariable ["AirCoolDown", 0];
if (_timer > time) exitWith {hint format ["Air Support not ready !\nNext call in %1 min\n\nPlease wait...", round ((_timer - time)/60)]};

do_action = 0;
air_type = 0;
air_perm = 0;
hintSilent "";
createDialog "liberation_airdrop";
waitUntil { dialog };

private _AirDrop_1_cost = GRLIB_AirDrop_1_cost;
private _AirDrop_2_cost = GRLIB_AirDrop_2_cost;
private _AirDrop_3_cost = GRLIB_AirDrop_3_cost;
private _AirDrop_4_cost = GRLIB_AirDrop_4_cost;
private _AirDrop_5_cost = GRLIB_AirDrop_5_cost;
private _AirDrop_6_cost = GRLIB_AirDrop_6_cost;
private _AirDrop_7_cost = GRLIB_AirDrop_7_cost;
private _AirDrop_8_cost = GRLIB_AirDrop_8_cost;

private _rank = player getVariable ["GRLIB_Rank", "Private"];
if (_rank == "Super Colonel") then {
	_AirDrop_1_cost = round (GRLIB_AirDrop_1_cost / 2);
	_AirDrop_2_cost = round (GRLIB_AirDrop_2_cost / 2);
	_AirDrop_3_cost = round (GRLIB_AirDrop_3_cost / 2);
	_AirDrop_4_cost = round (GRLIB_AirDrop_4_cost / 2);
	_AirDrop_5_cost = round (GRLIB_AirDrop_5_cost / 2);
	_AirDrop_6_cost = round (GRLIB_AirDrop_6_cost / 2);
	_AirDrop_7_cost = round (GRLIB_AirDrop_7_cost / 2);
	_AirDrop_8_cost = round (GRLIB_AirDrop_8_cost / 2);
};

private _display = findDisplay 5205;
ctrlSetText [1621, format [localize "STR_QUAD_OFFLOAD", _AirDrop_1_cost]];
ctrlSetText [1622, format [localize "STR_ARMED_OFFLOAD", _AirDrop_2_cost]];
ctrlSetText [1623, format [localize "STR_MRAP", _AirDrop_3_cost]];
ctrlSetText [1624, format [localize "STR_TRUCK", _AirDrop_4_cost]];
ctrlSetText [1625, format [localize "STR_APC", _AirDrop_5_cost]];
ctrlSetText [1626, format [localize "STR_BOAT", _AirDrop_6_cost]];
ctrlSetText [1627, format [localize "STR_AIRSUPREMACY", _AirDrop_7_cost]];
ctrlSetText [1628, format [localize "STR_ARTILLERY", _AirDrop_8_cost]];
ctrlSetText [1630, format [localize "STR_CALL_HELITAXI", GRLIB_AirDrop_Taxi_cost]];

private _list_perm = [];
if (_rank in ["Private"]) then {_list_perm = [1601,1602,1603,1604,1605,1606,1608]};
if (_rank in ["Corporal"]) then {_list_perm = [1602,1603,1604,1605,1606,1608]};
if (_rank in ["Sergeant"]) then {_list_perm = [1603,1604,1605,1608]};
if (_rank in ["Captain"]) then {_list_perm = [1604,1605,1608]};
if (_rank in ["Major"]) then {_list_perm = [1605]};
{ ctrlEnable [_x, false] } forEach _list_perm;

private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
if (GRLIB_mod_preset_taxi == 3 || GRLIB_AirDrop_Taxi_cost > _ammo_collected) then { ctrlEnable [1607, false] };
if (count blufor_air == 0 || _AirDrop_8_cost > _ammo_collected) then { ctrlEnable [1605, false] };
if (count GRLIB_AirDrop_1 == 0 || _AirDrop_1_cost > _ammo_collected) then { ctrlEnable [1600, false] };
if (count GRLIB_AirDrop_2 == 0 || _AirDrop_2_cost > _ammo_collected) then { ctrlEnable [1601, false] };
if (count GRLIB_AirDrop_3 == 0 || _AirDrop_3_cost > _ammo_collected) then { ctrlEnable [1602, false] };
if (count GRLIB_AirDrop_4 == 0 || _AirDrop_4_cost > _ammo_collected) then { ctrlEnable [1603, false] };
if (count GRLIB_AirDrop_5 == 0 || _AirDrop_5_cost > _ammo_collected) then { ctrlEnable [1604, false] };
if (count GRLIB_AirDrop_6 == 0 || _AirDrop_6_cost > _ammo_collected) then { ctrlEnable [1606, false] };
if (_AirDrop_7_cost > _ammo_collected) then { ctrlEnable [1608, false] };

while { dialog && (alive player) && do_action == 0 } do {
	sleep 0.1;
};
closeDialog 0;

if (do_action == 1) then {
	_cost = 0;
	switch (air_type) do {
		case 1 : {_class=selectRandom GRLIB_AirDrop_1; _cost=_AirDrop_1_cost};
		case 2 : {_class=selectRandom GRLIB_AirDrop_2; _cost=_AirDrop_2_cost};
		case 3 : {_class=selectRandom GRLIB_AirDrop_3; _cost=_AirDrop_3_cost};
		case 4 : {_class=selectRandom GRLIB_AirDrop_4; _cost=_AirDrop_4_cost};
		case 5 : {_class=selectRandom GRLIB_AirDrop_5; _cost=_AirDrop_5_cost};
		case 6 : {_class=selectRandom GRLIB_AirDrop_6; _cost=_AirDrop_6_cost};
		case 7 : {_cost=_AirDrop_7_cost};
		case 8 : {_cost=_AirDrop_8_cost};
		case 10 : {_cost=0};
	};
	if (air_type == 10) exitWith {[] execVM "addons\TAXI\call_taxi.sqf"};

	if (air_type == 7) exitWith {
		if ([_cost] call F_pay) then {
			[player] remoteExec ["send_aircraft_remote_call", 2];
			[player, "air_superiority"] remoteExec ["sound_range_remote_call", 2];
			player setVariable ["AirCoolDown", round(time + 20*60)];
		};
	};

	if (air_type == 8) exitWith {
		createDialog "liberation_halo";
		waitUntil { dialog };
		dojump = 0;
		halo_position = getPosATL player;

		"spawn_marker" setMarkerTextLocal (localize "STR_HALO_PARAM_ARTY");
		ctrlSetText [201, toUpper (localize "STR_HALO_PARAM_ARTY")];
		ctrlSetText [202, (localize "STR_HALO_PARAM_ARTY")];

		onMapSingleClick {
			halo_position = _pos;
			true;
		};

		while { dialog && alive player && dojump == 0 } do {
			"spawn_marker" setMarkerPosLocal halo_position;
			sleep 0.2;
		};

		onMapSingleClick "";
		closeDialog 0;

		"spawn_marker" setMarkerPosLocal markers_reset;
		"spawn_marker" setMarkerTextLocal "";

		if ( dojump > 0) then {
			private _count_blu = { _x distance2D halo_position < GRLIB_capture_size } count (units GRLIB_side_friendly);
			private _near_fob = ([halo_position, "FOB", GRLIB_sector_size, true] call F_check_near);
			if (_count_blu > 0 || _near_fob) then {
				hintSilent "Cannot fire!\nToo close from friendly units";
				player setVariable ["AirCoolDown", 0];
			} else {
				if ([_cost] call F_pay) then {
					[player, halo_position] remoteExec ["call_artillery_remote_call", 2];
					[player, "artillery_fire"] remoteExec ["sound_range_remote_call", 2];
					player setVariable ["AirCoolDown", round(time + 20*60)];
				};
			};
		} else {
			player setVariable ["AirCoolDown", 0];
		};
	};

	if ([_cost] call F_pay) then {
		[player, selectRandom ["airdrop_1", "airdrop_2"]] remoteExec ["sound_range_remote_call", 2];
		sleep 2;
		[player, "parasound"] remoteExec ["sound_range_remote_call", 2];
		[player, _class] spawn airdrop_call;
		player setVariable ["AirCoolDown", round(time + 15*60)];
	};
};
