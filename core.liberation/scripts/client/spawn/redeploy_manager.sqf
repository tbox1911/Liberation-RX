if (player getVariable ["GRLIB_action_inuse", false]) exitWith {};
if (count (attachedObjects player) > 0) then {{detach _x} forEach attachedObjects player};
R3F_LOG_joueur_deplace_objet = objNull;

private _choiceslist = [];
private _standard_map_pos = [];
private _frame_pos = [];
private _spawn_str = "";
private _basenamestr = "BASE CHIMERA";

if (!GRLIB_player_spawned) then {
	waitUntil {sleep 0.2; !isNil "GRLIB_all_fobs" };
	waitUntil {sleep 0.2; !isNil "blufor_sectors" };
	waitUntil {sleep 0.2; !isNil "save_is_loaded" };
	waitUntil {sleep 0.2; !isNil "introDone" };
	waitUntil {sleep 0.2; introDone };
	waitUntil {sleep 0.2; !isNil "cinematic_camera_stop" };
	waitUntil {sleep 0.2; cinematic_camera_stop };
	waitUntil {sleep 0.2; !(isNil "dostartgame")};
	waitUntil {sleep 0.2; dostartgame == 1};
	waitUntil {sleep 0.2; !(isNil "LRX_arsenal_init_done")};
	waitUntil {sleep 0.2; LRX_arsenal_init_done };
};

fullmap = 0;
private _old_fullmap = 0;
waitUntil {
	sleep 0.1;
	( vehicle player == player && alive player && !dialog )
};

createDialog "liberation_deploy";
waitUntil { dialog };
titleText ["","BLACK IN", 5];
((findDisplay 5201) displayCtrl 201) ctrlAddEventHandler [ "mouseButtonDblClick" , { deploy = 1; } ];
private _noesckey = (findDisplay 5201) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
disableUserInput false;
disableUserInput true;
disableUserInput false;
deploy = 0;
private _oldsel = -1;

showCinemaBorder false;
camUseNVG false;
respawn_camera = "camera" camCreate (getposASLW lhd);
respawn_object = "Sign_Arrow_Blue_F" createVehicleLocal (getposASLW lhd);
respawn_object hideObject true;
respawn_camera camSetTarget respawn_object;
respawn_camera cameraEffect ["internal","back"];
respawn_camera camcommit 0;

private _standard_map_pos = ctrlPosition ((findDisplay 5201) displayCtrl 251);
private _frame_pos = ctrlPosition ((findDisplay 5201) displayCtrl 198);

private _is_mobile_respawn = false;
private _loadouts_data = [];
private _loadout_controls = [101,203,205];

if ( GRLIB_player_spawned ) then {
	_saved_loadouts = profileNamespace getVariable ["bis_fnc_saveInventory_data", []];
	_counter = 0;

	if ( GRLIB_enable_arsenal > 0 && !isNil "_saved_loadouts" ) then {
		{
			if ( _counter % 2 == 0 && _counter < 40) then {
				_loadouts_data pushback _x;
			};
			_counter = _counter + 1;
		} foreach _saved_loadouts;
		{ ctrlShow [_x, true] } foreach _loadout_controls;
	};

	lbAdd [ 203, "--"] ;
	{ lbAdd [ 203, _x ]; } foreach _loadouts_data;
	lbSetCurSel [ 203, 0 ];
} else {
	{ ctrlShow [_x, false] } foreach _loadout_controls;
};

while { dialog && alive player && deploy == 0} do {
	if (!alive player) exitWith {};
	_choiceslist = [ [ _basenamestr, getpos lhd ] ];

	for [{_idx=0},{_idx < count GRLIB_all_fobs},{_idx=_idx+1}] do {
		_fobpos = GRLIB_all_fobs select _idx;
		_near_outpost = (_fobpos in GRLIB_all_outposts);
		if (_near_outpost) then {
			_choiceslist = _choiceslist + [[format [ "Outpost %1 - %2", (military_alphabet select _idx),mapGridPosition (GRLIB_all_fobs select _idx) ],GRLIB_all_fobs select _idx]];
		} else {
			_choiceslist = _choiceslist + [[format [ "FOB %1 - %2", (military_alphabet select _idx), mapGridPosition (GRLIB_all_fobs select _idx) ],GRLIB_all_fobs select _idx]];
		};
	};

	_respawn_trucks = [] call F_getMobileRespawns;

	for "_idx" from 0 to ((count _respawn_trucks) -1) do {
		_vehicle = _respawn_trucks select _idx;
		_choiceslist = _choiceslist + [[format ["%1 - %2", [_vehicle] call F_getLRXName, mapGridPosition (getpos _vehicle)], getpos _vehicle, _vehicle]];
	};

	lbClear 201;
	{
		lbAdd [201, (_x select 0)];
	} foreach _choiceslist;

	if ( lbCurSel 201 == -1 ) then { lbSetCurSel [201,0] };

	if ( lbCurSel 201 != _oldsel ) then {
		_oldsel = lbCurSel 201;
		_objectpos = [0,0,0];
		if ( dialog ) then {
			_objectpos = ((_choiceslist select _oldsel) select 1);
		};
		if ( surfaceIsWater _objectpos) then {
			respawn_object setposasl [_objectpos select 0, _objectpos select 1, 15];
		} else {
			respawn_object setpos ((_choiceslist select _oldsel) select 1);
		};
		_startdist = 120;
		_enddist = 120;
		_alti = 35;

		"spawn_marker" setMarkerPosLocal (getpos respawn_object);
		ctrlMapAnimClear ((findDisplay 5201) displayCtrl 251);
		private _transition_map_pos = getpos respawn_object;
		private _fullscreen_map_offset = round (worldsize / 7);
		if (_fullscreen_map_offset < 500) then {_fullscreen_map_offset = 4500};
		if(fullmap % 2 == 1) then {
			_transition_map_pos = [(_transition_map_pos select 0) - _fullscreen_map_offset,  (_transition_map_pos select 1) + (_fullscreen_map_offset * 0.75), 0];
		};
		((findDisplay 5201) displayCtrl 251) ctrlMapAnimAdd [0, 0.3,_transition_map_pos];
		ctrlMapAnimCommit ((findDisplay 5201) displayCtrl 251);

		respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object select 1) + _startdist, (getpos respawn_object select 2) + _alti];
		respawn_camera camcommit 0;
		respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object select 1) - _enddist, (getpos respawn_object select 2) + _alti];
		respawn_camera camcommit 90;
	};

	if ( _old_fullmap != fullmap ) then {
		_old_fullmap = fullmap;
		if ( fullmap % 2 == 1 ) then {
			((findDisplay 5201) displayCtrl 251) ctrlSetPosition [ (_frame_pos select 0) + (_frame_pos select 2), (_frame_pos select 1), (0.6 * safezoneW), (_frame_pos select 3)];
		} else {
			((findDisplay 5201) displayCtrl 251) ctrlSetPosition _standard_map_pos;
		};
		((findDisplay 5201) displayCtrl 251) ctrlCommit 0.2;
		_oldsel = -1;
	};

	uiSleep 0.2;
};

if (dialog && deploy == 1) then {

	// Manage Player Loadout
	if ( !GRLIB_player_spawned ) then {
		// respawn loadout
		if ( !isNil "GRLIB_respawn_loadout" ) then {
			player setUnitLoadout GRLIB_respawn_loadout;
		} else {
			// init loadout
			if ( GRLIB_forced_loadout == 0) then {
				if ( typeOf player in units_loadout_overide ) then {
					private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower (typeOf player)];
					[_path, player] call F_getTemplateFile;
				} else {
					[player, configOf player] call BIS_fnc_loadInventory;
				};
				player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
				GRLIB_backup_loadout = getUnitLoadout player;
			};
		};
		[player] call F_filterLoadout;
		[player] call F_payLoadout;
	};

	// choosen loadout
	if ( (lbCurSel 203) > 0 ) then {
		player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
		GRLIB_backup_loadout = getUnitLoadout player;
		[player, [ profileNamespace, _loadouts_data select ((lbCurSel 203) - 1) ] ] call bis_fnc_loadInventory;
		[player] call F_filterLoadout;
		[player] call F_payLoadout;
	};

	// Redeploy
	_idxchoice = lbCurSel 201;
	_spawn_str = (_choiceslist select _idxchoice) select 0;

	if (((_choiceslist select _idxchoice) select 0) == _basenamestr) then {
		// LHD (Chimera)
		call respawn_lhd;
	} else {
		player setVariable ["GRLIB_action_inuse", true, true];
		private _destpos = zeropos;
		private _destdir = random 360;
		private _destdist = 4;
		if (count (_choiceslist select _idxchoice) == 3) then {
			// Mobile Respawn
			_destpos = (_choiceslist select _idxchoice) select 2;
			_destdist = 6;
			_is_mobile_respawn = true;
		} else {
			// FOB / Outpost
			_destpos = ((_choiceslist select _idxchoice) select 1);
			private _attacked = ([_destpos] call F_sectorOwnership == GRLIB_side_enemy);
			private _near_sign = nearestObjects [_destpos, [FOB_sign], 10] select 0;
			private _near_outpost = (_destpos in GRLIB_all_outposts);
			if (!isNull _near_sign) then {
				_destdir = (getDir _near_sign) + 180;
			};
			_destdist = 12;
			if (_near_outpost) then { _destdist = 8 };
			if (!_near_outpost && _attacked) then {
				_destdir = random 360;
				_destdist = 4;
				_destpos = _destpos vectorAdd [0,0,0.6];
			};
			player setDir (getDir _near_sign);
		};

		private _unit_list = units group player;
		private _my_squad = player getVariable ["my_squad", nil];
		if (!isNil "_my_squad") then {
			{ _unit_list pushBack _x } forEach units _my_squad;
		};
		private _unit_list_redep = [_unit_list, { !(isPlayer _x) && (isNull objectParent _x) && (_x distance2D (getPosATL player)) < 30 && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect;
		player setPos ([_destpos, _destdist, _destdir] call BIS_fnc_relPos);
		[_unit_list_redep] spawn {
			params ["_list"];
			sleep 1;
			{
				_x setPos ([getPos player, 10, random 360] call BIS_fnc_relPos);
				_x doFollow leader player;
				sleep 0.5;
			} forEach _list;
			player setVariable ["GRLIB_action_inuse", false, true];
		};
		GRLIB_player_spawned = ([] call F_getValid);
		cinematic_camera_started = false;
	};
};

respawn_camera cameraEffect ["Terminate","back"];
camDestroy respawn_camera;
deleteVehicle respawn_object;
camUseNVG false;
"spawn_marker" setMarkerPosLocal markers_reset;

if (dialog) then {
	closeDialog 0;
	(findDisplay 5201) displayRemoveEventHandler ["KeyDown", _noesckey];
};

if (alive player && deploy == 1) then {
	if (isNil "_spawn_str") then {_spawn_str = "Somewhere."};
	[_spawn_str, _is_mobile_respawn] spawn spawn_camera;
};

1 fadeSound 1;
10 fadeMusic 0;
sleep 10;
playMusic "";