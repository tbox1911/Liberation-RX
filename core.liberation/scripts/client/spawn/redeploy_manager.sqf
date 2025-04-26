waitUntil {sleep 0.1; !(isNil "dostartgame")};
waitUntil {sleep 0.1; dostartgame == 1};

if (player getVariable ["GRLIB_action_inuse", false]) exitWith {};
if (count (attachedObjects player) > 0) then {{detach _x} forEach attachedObjects player};
R3F_LOG_joueur_deplace_objet = objNull;

private _standard_map_pos = [];
private _frame_pos = [];
private _spawn_str = "";
private _basenamestr = "BASE CHIMERA";

fullmap = 0;
private _old_fullmap = 0;
waitUntil {
	sleep 0.1;
	(vehicle player == player && alive player && !dialog)
};

createDialog "liberation_deploy";
waitUntil { dialog };
titleText ["","BLACK IN", 5];
((findDisplay 5201) displayCtrl 201) ctrlAddEventHandler ["mouseButtonDblClick", { deploy = 1; }];
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
private _mobile = false;
private _loadouts_data = [];
private _loadout_controls = [101,203,205];

if (GRLIB_player_spawned) then {
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

private _choiceslist = [[_basenamestr, getPosATL lhd]];
for "_idx" from 0 to (count GRLIB_all_fobs - 1) do {
	_fobpos = GRLIB_all_fobs select _idx;
	_near_outpost = (_fobpos in GRLIB_all_outposts);
	if (_near_outpost) then {
		_choiceslist append [[format [ "Outpost %1 - %2", (military_alphabet select _idx),mapGridPosition (GRLIB_all_fobs select _idx) ],GRLIB_all_fobs select _idx]];
	} else {
		_choiceslist append [[format [ "FOB %1 - %2", (military_alphabet select _idx), mapGridPosition (GRLIB_all_fobs select _idx) ],GRLIB_all_fobs select _idx]];
	};
};

private _mobile_respawn_list = [] call F_getMobileRespawns;
_mobile_respawn_list = ([_mobile_respawn_list, [player], {_input0 distance2D _x}, 'ASCEND'] call BIS_fnc_sortBy);
private ["_vehicle", "_player"];
for "_idx" from 0 to ((count _mobile_respawn_list) -1) do {
	_vehicle = _mobile_respawn_list select _idx;
	_player = (_vehicle getVariable ["GRLIB_vehicle_owner", ""]) call BIS_fnc_getUnitByUID;
	_choiceslist append [[format ["%1 - %2 #%3", [_vehicle] call F_getLRXName, [_player] call get_player_name, _idx], getPos _vehicle, _vehicle]];
};

lbClear 201;
{
	lbAdd [201, (_x select 0)];
} foreach _choiceslist;
lbSetCurSel [201, 0];

while { dialog && alive player && deploy == 0} do {
	if (!alive player) exitWith {};

	if ( lbCurSel 201 != _oldsel ) then {
		_oldsel = lbCurSel 201;
		_objectpos = (_choiceslist select _oldsel) select 1;
		_startdist = 120;
		_enddist = 120;
		_alti = 35;

		if ( isNil "_objectpos" ) then { _objectpos = zeropos };

		if ( surfaceIsWater _objectpos ) then {
			respawn_object setposasl [_objectpos select 0, _objectpos select 1, _alti];
		} else {
			respawn_object setpos ((_choiceslist select _oldsel) select 1);
		};

		"spawn_marker" setMarkerPosLocal (getPosATL respawn_object);
		ctrlMapAnimClear ((findDisplay 5201) displayCtrl 251);
		private _transition_map_pos = getPosATL respawn_object;
		private _fullscreen_map_offset = round (worldsize / 7);
		if (_fullscreen_map_offset < 500) then {_fullscreen_map_offset = 4500};
		if(fullmap % 2 == 1) then {
			_transition_map_pos = [(_transition_map_pos select 0) - _fullscreen_map_offset,  (_transition_map_pos select 1) + (_fullscreen_map_offset * 0.75), 0];
		};
		((findDisplay 5201) displayCtrl 251) ctrlMapAnimAdd [0, 0.3,_transition_map_pos];
		ctrlMapAnimCommit ((findDisplay 5201) displayCtrl 251);

		respawn_camera camSetPos [(getPosATL respawn_object select 0) - 70, (getPosATL respawn_object select 1) + _startdist, (getPosATL respawn_object select 2) + _alti];
		respawn_camera camcommit 0;
		respawn_camera camSetPos [(getPosATL respawn_object select 0) - 70, (getPosATL respawn_object select 1) - _enddist, (getPosATL respawn_object select 2) + _alti];
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

private _idxchoice = lbCurSel 201;
private _loadoutchoice = lbCurSel 203;
respawn_camera cameraEffect ["Terminate","back"];
camDestroy respawn_camera;
deleteVehicle respawn_object;
camUseNVG false;
"spawn_marker" setMarkerPosLocal markers_reset;
(findDisplay 5201) displayRemoveEventHandler ["KeyDown", _noesckey];
closeDialog 0;
if (!alive player) exitWith {};

private _sleep = 2;
if (GRLIB_deployment_cinematic) then { _sleep = 7 };
cinematic_camera_started = false;
titleText ["","BLACK IN", 5];

if (deploy == 1) then {
	player setVariable ["GRLIB_action_inuse", true, true];

	// choosen loadout
	if ( _loadoutchoice > 0 ) then {
		GRLIB_backup_loadout = getUnitLoadout player;
		[player, [profileNamespace, _loadouts_data select (_loadoutchoice - 1)]] call bis_fnc_loadInventory;
		[player] call F_filterLoadout;
		[player] call F_payLoadout;
	};

	// Redeploy
	_spawn_str = (_choiceslist select _idxchoice) select 0;
	if ( _spawn_str == _basenamestr) then {
		// LHD (Chimera)
		player setPosATL ((getPosATL lhd) vectorAdd [floor(random 5), floor(random 5), 1]);
		[_spawn_str, false] spawn spawn_camera;
	} else {
		private _destpos = [];
		private _destdir = random 360;
		private _destdist = 4;
		if (count (_choiceslist select _idxchoice) == 3) then {
			// Mobile Respawn
			_destpos = (_choiceslist select _idxchoice) select 2;
			_destdist = 6;
			_mobile = true;
		} else {
			// FOB / Outpost
			_destpos = (_choiceslist select _idxchoice) select 1;
			_destdist = 12;
		};
		if (_destpos distance2D zeropos < 300) exitWith {};
		if (isNil "_spawn_str") then {_spawn_str = "Somewhere."};
		[_spawn_str, _mobile] spawn spawn_camera;
		[_destpos, _destdist, _mobile] call do_redeploy;
	};
};

if (player distance2D (markerPos GRLIB_respawn_marker) < GRLIB_capture_size) then {
	_spawn_str = _basenamestr;
	player setPosATL ((getPosATL lhd) vectorAdd [floor(random 5), floor(random 5), 1]);
};

sleep _sleep;
player setVariable ["GRLIB_action_inuse", false, true];
GRLIB_player_spawned = ([] call F_getValid);
