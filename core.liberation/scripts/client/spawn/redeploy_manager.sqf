if (count (attachedObjects player) > 0) exitWith {};
if (player getVariable ["GRLIB_action_inuse", false]) exitWith {};
private _choiceslist = [];
private _standard_map_pos = [];
private _frame_pos = [];
private _spawn_str = "";
private _basenamestr = "Operation Base";

if (!GRLIB_player_spawned) then {
	waitUntil {sleep 0.2; !isNil "GRLIB_all_fobs" };
	waitUntil {sleep 0.2; !isNil "blufor_sectors" };
	waitUntil {sleep 0.2; !isNil "save_is_loaded" };
	waitUntil {sleep 0.2; !isNil "introDone" };
	waitUntil {sleep 0.2; introDone };
	waitUntil {sleep 0.2; !isNil "cinematic_camera_stop" };
	waitUntil {sleep 0.2; cinematic_camera_stop };
};

fullmap = 0;
_old_fullmap = 0;

createDialog "liberation_deploy";
waitUntil { dialog };
titleText ["","BLACK IN", 5];
((findDisplay 5201) displayCtrl 201) ctrlAddEventHandler [ "mouseButtonDblClick" , { deploy = 1; } ];
_noesckey = (findDisplay 5201) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
disableUserInput false;
disableUserInput true;
disableUserInput false;
deploy = 0;
_oldsel = -999;

showCinemaBorder false;
camUseNVG false;
respawn_camera = "camera" camCreate (getposASLW lhd);
respawn_object = "Sign_Arrow_Blue_F" createVehicleLocal (getposASLW lhd);
respawn_object hideObject true;
respawn_camera camSetTarget respawn_object;
respawn_camera cameraEffect ["internal","back"];
respawn_camera camcommit 0;

_standard_map_pos = ctrlPosition ((findDisplay 5201) displayCtrl 251);
_frame_pos = ctrlPosition ((findDisplay 5201) displayCtrl 198);

_saved_loadouts = profileNamespace getVariable "bis_fnc_saveInventory_data";
_loadouts_data = [];
_counter = 0;

/*
if ( GRLIB_enable_arsenal && !isNil "_saved_loadouts" ) then {
	{
		if ( _counter % 2 == 0 ) then {
			_loadouts_data pushback _x;
		};
		_counter = _counter + 1;
	} foreach _saved_loadouts;
};
*/

lbAdd [ 203, "--"] ;
{ lbAdd [ 203, _x ]; } foreach _loadouts_data;
lbSetCurSel [ 203, 0 ];

while { dialog && alive player && deploy == 0} do {
	_choiceslist = [ [ _basenamestr, getpos lhd ] ];

	for [{_idx=0},{_idx < count GRLIB_all_fobs},{_idx=_idx+1}] do {
		_fobpos = GRLIB_all_fobs select _idx;
		_near_outpost = (count (_fobpos nearObjects [FOB_outpost, 100]) > 0);
		if (_near_outpost) then {
			_choiceslist = _choiceslist + [[format [ "Outpost %1 - %2", (military_alphabet select _idx),mapGridPosition (GRLIB_all_fobs select _idx) ],GRLIB_all_fobs select _idx]];
		} else {
			_choiceslist = _choiceslist + [[format [ "FOB %1 - %2", (military_alphabet select _idx), mapGridPosition (GRLIB_all_fobs select _idx) ],GRLIB_all_fobs select _idx]];
		};
	};

	_respawn_trucks = [] call F_getMobileRespawns;

	for "_idx" from 0 to ((count _respawn_trucks) -1) do {
		private _name = format ["(%1)", name ([(_respawn_trucks select _idx) getVariable ["GRLIB_vehicle_owner", ""]] call BIS_fnc_getUnitByUID)];
		if (isNil "_name") then {_name = ""};
		_choiceslist = _choiceslist + [[format [ "%1 - %2 %3", localize "STR_RESPAWN_TRUCK", mapGridPosition (getpos (_respawn_trucks select _idx)), _name], getpos (_respawn_trucks select _idx), (_respawn_trucks select _idx)]];
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
		private _fullscreen_map_offset = 4000;
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
	_idxchoice = lbCurSel 201;
	_spawn_str = (_choiceslist select _idxchoice) select 0;

	if (((_choiceslist select _idxchoice) select 0) == _basenamestr) then {
		call respawn_lhd;
	} else {
		_player_pos = getPos player;
		if (count (_choiceslist select _idxchoice) == 3) then {
			_truck = (_choiceslist select _idxchoice) select 2;
			player setpos ([_truck, 5 + floor(random 3), random 360] call BIS_fnc_relPos);
		} else {
			_destpos = ((_choiceslist select _idxchoice) select 1);
			player setpos [((_destpos select 0) + 5) - floor(random 10),((_destpos select 1) + 5) - floor(random 10),0.3];
		};

		_unit_list = units group player;
		_my_squad = player getVariable ["my_squad", nil];
		if (!isNil "_my_squad") then {
			{ _unit_list pushBack _x } forEach units _my_squad;
		};
		_unit_list_redep = [_unit_list, { _x != player && vehicle _x == _x && (_x distance2D _player_pos) < 40 && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect;
		[_unit_list_redep] spawn {
			params ["_list"];
			{
				sleep 0.3;
				_x setpos ([position player, 5 + floor(random 3), random 360] call BIS_fnc_relPos);
				_x doFollow leader player;
			} forEach _list;
		};
		GRLIB_player_spawned = ([] call F_getValid);
		cinematic_camera_started = false;
	};

	GRLIB_loadout_overide = nil;
	if ( (lbCurSel 203) > 0 ) then {
		GRLIB_backup_loadout = [player] call F_getLoadout;
		player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
		[player, [ profileNamespace, _loadouts_data select ((lbCurSel 203) - 1) ] ] call bis_fnc_loadInventory;
		[player] call F_filterLoadout;
		[player] call F_payLoadout;
		GRLIB_loadout_overide = true;
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
	[_spawn_str] spawn spawn_camera;
};
