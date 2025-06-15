disableSerialization;
private [
	"_overlay", "_hide_HUD", "_attacked_string", "_active_sectors_string", "_fob_sector",
	"_color_readiness", "_color_reput", "_reput_icon", "_nearest_active_sector",
	"_server_overloaded", "_zone_size", "_colorzone", "_bar", "_barwidth",
	"_reputation", "_attacked_timer", "_sector_timer", "_capture_size"
];
private _overlayshown = false;
private _sectorcontrols = [201,202,203,244,205];
private _active_sectors_hint = false;
private _uiticks = 0;
GRLIB_ui_notif = "";

//Local to client only
GRLIB_availableMarkers = [];

waituntil {sleep 1; GRLIB_player_spawned};
waituntil {sleep 1; !isNil "resources_infantry"};
waituntil {sleep 1; !isNil "infantry_cap"};
waitUntil {sleep 1; !isNil "sector_timer"};

if (isNil "cinematic_camera_started") then { cinematic_camera_started = false };
if (isNil "halojumping") then { halojumping = false };

if (GRLIB_Commander_mode) then {
	0 spawn {
		_currentCircleMark = "";
		while {true} do {
			if (visibleMap) then {
				_array = ctrlMapMouseOver (findDisplay 12 displayCtrl 51);
				_circleMark = "";
				if (!(_array isEqualTo []) && {_array#0 == "marker" && {(_array#1) in GRLIB_AvailAttackSectors} && {((_array#1) + "av") in GRLIB_availableMarkers}}) then {
					_marker = _array#1;
					_circleMark = _marker + "av";
					if (_currentCircleMark != _circleMark) then {
						[_circleMark,[1.2,1.2],0.009] spawn BIS_fnc_resizeMarker;
						playSoundUI ["a3\ui_f\data\sound\rsccombo\soundexpand.wss", 0.5, 1.2];
						if (_currentCircleMark != "") then {
							[_currentCircleMark,[1,1],0.009] spawn BIS_fnc_resizeMarker;
							playSoundUI ["a3\ui_f\data\sound\rsccombo\soundcollapse.wss", 0.5, 1.2];
						};
					};
				} else {
					if (_currentCircleMark != "") then {
						[_currentCircleMark,[1,1],0.009] spawn BIS_fnc_resizeMarker;
						playSoundUI ["a3\ui_f\data\sound\rsccombo\soundcollapse.wss", 0.5, 1.2];
					};
				};
				_currentCircleMark = _circleMark;
			};
			sleep 0.1;
		};
	};
};

private _color_F = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_friendly >> "color") call BIS_fnc_colorConfigToRGBA;
private _color_E = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_enemy >> "color") call BIS_fnc_colorConfigToRGBA;

while {true} do {
	_hide_HUD = !(shownHUD select 0);
	_overlay_check = (
		GRLIB_player_spawned &&
		isNull (findDisplay 5201) &&
		!cinematic_camera_started &&
		!halojumping &&
		!_hide_HUD &&
		!([player] call PAR_is_wounded)
	);

	if (_overlay_check && !_overlayshown) then {
		"LibUI" cutRsc ["statusoverlay", "PLAIN", 1];
		_overlay = uiNamespace getVariable ['GUI_OVERLAY', objNull];
		_overlayshown = true;
		_uiticks = 0;
	};

	if (!_overlay_check && _overlayshown) then {
		"LibUI" cutRsc ["blank", "PLAIN", 0];
		_overlayshown = false;
	};

	if (!isNil "_overlay") then {
		_fob_sector = false;
		_nearest_active_sector = [GRLIB_sector_size] call F_getNearestSector;
		if (_nearest_active_sector == "") then {
			private _fob_pos = [] call F_getNearestFob;
			if (player distance2D _fob_pos <= GRLIB_fob_range) then {
				_nearest_active_sector = format ["fobmarker%1", (GRLIB_all_fobs find _fob_pos)];
				_fob_sector = true;
			};
		};

		if (_nearest_active_sector == "") then {
			{ (_overlay displayCtrl (_x)) ctrlShow false; } foreach _sectorcontrols;
			"zone_capture" setmarkerposlocal markers_reset;
		};

		_server_overloaded = (opforcap_max || count active_sectors >= GRLIB_max_active_sectors);
		if (!_server_overloaded) then {
			(_overlay displayCtrl (516)) ctrlSetStructuredText parseText " ";
			(_overlay displayCtrl (517)) ctrlShow false;
		};

		if (_overlayshown) then {
			(_overlay displayCtrl (266)) ctrlSetText format ["%1", GRLIB_ui_notif];
			(_overlay displayCtrl (267)) ctrlSetText format ["%1", GRLIB_ui_notif];

			if ((markerPos "opfor_capture_marker") distance2D markers_reset > 100) then {
				_attacked_string = [markerpos "opfor_capture_marker"] call F_getLocationName;
				(_overlay displayCtrl (401)) ctrlShow true;
				(_overlay displayCtrl (402)) ctrlSetText _attacked_string;
				_sector_timer = round (sector_timer - serverTime);
				_attacked_timer = "VULNERABLE";
				if (_sector_timer > 0) then { _attacked_timer = [_sector_timer] call F_secondsToTimer };
				(_overlay displayCtrl (403)) ctrlSetText _attacked_timer;
			} else {
				(_overlay displayCtrl (401)) ctrlShow false;
				(_overlay displayCtrl (402)) ctrlSetText "";
				(_overlay displayCtrl (403)) ctrlSetText "";
			};

			if (_uiticks % 2 == 0) then {
				(_overlay displayCtrl (107)) ctrlSetText format ["%1", (player getVariable ["GREUH_score_count",0])];
				(_overlay displayCtrl (102)) ctrlSetText format ["%1", (player getVariable ["GREUH_ammo_count",0])];
				(_overlay displayCtrl (103)) ctrlSetText format ["%1", (player getVariable ["GREUH_fuel_count",0])];
				(_overlay displayCtrl (101)) ctrlSetText format ["%1/%2", resources_infantry, infantry_cap];
				_reputation = [player] call F_getReput;
				(_overlay displayCtrl (104)) ctrlSetText format ["%1", round(_reputation)];
				(_overlay displayCtrl (105)) ctrlSetText format ["%1%2", round(combat_readiness),"%"];
				(_overlay displayCtrl (106)) ctrlSetText format ["%1", round(resources_intel)];

				_color_readiness = [0.8,0.8,0.8,1];
				if (combat_readiness >= 25) then { _color_readiness = [0.8,0.8,0,1] };
				if (combat_readiness >= 50) then { _color_readiness = [0.8,0.6,0,1] };
				if (combat_readiness >= 75) then { _color_readiness = [0.8,0.3,0,1] };
				if (combat_readiness >= 95) then { _color_readiness = [0.8,0,0,1] };

				(_overlay displayCtrl (105)) ctrlSetTextColor _color_readiness;
				(_overlay displayCtrl (135)) ctrlSetTextColor _color_readiness;

				_color_reput = [0.8,0.8,0.8,1];
				_reput_icon = "res\rep\rep3.paa";
				if (_reputation >= 25) then { _color_reput = [0.8,0.8,0,1]; _reput_icon = "res\rep\rep4.paa" };
				if (_reputation >= 50) then { _color_reput = [0.0,0.6,0,1]; _reput_icon = "res\rep\rep5.paa" };
				if (_reputation >= 75) then { _color_reput = [0.0,0.8,0,1]; _reput_icon = "res\rep\rep6.paa" };
				if (_reputation >= 100) then { _color_reput = [0,0.8,0.6,1]; _reput_icon = "res\rep\rep6.paa" };
				if (_reputation <= -25) then { _color_reput = [0.8,0.8,0,1]; _reput_icon = "res\rep\rep2.paa" };
				if (_reputation <= -50) then { _color_reput = [0.8,0.6,0,1]; _reput_icon = "res\rep\rep1.paa" };
				if (_reputation <= -75) then { _color_reput = [0.8,0.3,0,1]; _reput_icon = "res\rep\rep0.paa" };
				if (_reputation <= -100) then { _color_reput = [0.8,0,0,1]; _reput_icon = "res\rep\rep0.paa" };
				(_overlay displayCtrl (104)) ctrlSetTextColor _color_reput;
				(_overlay displayCtrl (1041)) ctrlSetText (getMissionPath _reput_icon);
			};

			if (_uiticks % 5 == 0) then {
				if (_server_overloaded) then {
					(_overlay displayCtrl (517)) ctrlShow true;

					if (!_active_sectors_hint) then {
						hint localize "STR_OVERLOAD_HINT";
						_active_sectors_hint = true;
					};

					_active_sectors_string = "<t align='right' color='#e0e000'>" + (localize "STR_ACTIVE_SECTORS") + "<br/>";
					{
						_active_sectors_string = _active_sectors_string + (markertext _x) + "<br/>";
					} foreach active_sectors;
					_active_sectors_string = _active_sectors_string + "</t>";
					(_overlay displayCtrl (516)) ctrlSetStructuredText parseText _active_sectors_string;
				};

				(_overlay displayCtrl (244)) ctrlSetBackgroundColor _color_F;
				(_overlay displayCtrl (203)) ctrlSetBackgroundColor _color_E;

				if (!GRLIB_Commander_mode) then {
					if (_nearest_active_sector != "") then {
						_zone_size = GRLIB_capture_size;
						if (_fob_sector) exitWith {
							(_overlay displayCtrl (205)) ctrlSetTextColor _color_F;
							(_overlay displayCtrl (205)) ctrlSetText (markerText _nearest_active_sector);
							{ (_overlay displayCtrl (_x)) ctrlShow true; } foreach _sectorcontrols;
							_bar = _overlay displayCtrl (244);
							_barwidth = 0.084 * safezoneW * 1;
							_bar ctrlSetPosition [(ctrlPosition _bar) select 0,(ctrlPosition _bar) select 1,_barwidth,(ctrlPosition _bar) select 3];
							_bar ctrlCommit 0;
							"zone_capture" setmarkerposlocal (markerpos _nearest_active_sector);
							"zone_capture" setmarkercolorlocal GRLIB_color_friendly;
							"zone_capture" setMarkerSizeLocal [_zone_size,_zone_size];
						};
						if (_nearest_active_sector in sectors_bigtown) then {
							_zone_size = GRLIB_capture_size * 1.4;
						};
						_colorzone = "ColorGrey";
						if (_nearest_active_sector in blufor_sectors) then {
							(_overlay displayCtrl (205)) ctrlSetTextColor _color_F;
							_colorzone = GRLIB_color_friendly
						} else {
							(_overlay displayCtrl (205)) ctrlSetTextColor _color_E;
							_colorzone = GRLIB_color_enemy
						};
						"zone_capture" setmarkerposlocal (markerpos _nearest_active_sector);
						"zone_capture" setmarkercolorlocal _colorzone;

						_capture_size = GRLIB_capture_size;
						if (_nearest_active_sector in sectors_bigtown) then {
							_capture_size = GRLIB_capture_size * 1.4;
						};
						_ratio = [_nearest_active_sector, _capture_size] call F_getForceRatio;
						_barwidth = 0.084 * safezoneW * _ratio;
						_bar = _overlay displayCtrl (244);
						_bar ctrlSetPosition [(ctrlPosition _bar) select 0,(ctrlPosition _bar) select 1,_barwidth,(ctrlPosition _bar) select 3];
						_bar ctrlCommit 1;

						(_overlay displayCtrl (205)) ctrlSetText (markerText _nearest_active_sector);
						{ (_overlay displayCtrl (_x)) ctrlShow true; } foreach _sectorcontrols;

						"zone_capture" setMarkerSizeLocal [_zone_size,_zone_size];
					};
				} else {
					if (!(active_sectors isEqualTo [])) then {
						{
							{
								deleteMarker _x;
							} forEach GRLIB_availableMarkers;
							GRLIB_availableMarkers = [];

							if ( _x in blufor_sectors ) then {
								(_overlay displayCtrl (205)) ctrlSetTextColor _color_F;
							} else {
								(_overlay displayCtrl (205)) ctrlSetTextColor _color_E;
							};

							_capture_size = GRLIB_capture_size;
							if (_x in sectors_bigtown) then {
								_capture_size = GRLIB_capture_size * 1.4;
							};
							_ratio = [_x, _capture_size] call F_getForceRatio;
							_barwidth = 0.084 * safezoneW * _ratio;
							_bar = _overlay displayCtrl (244);
							_bar ctrlSetPosition [(ctrlPosition _bar) select 0,(ctrlPosition _bar) select 1,_barwidth,(ctrlPosition _bar) select 3];
							_bar ctrlCommit 1;

							(_overlay displayCtrl (205)) ctrlSetText (markerText _x);
							{ (_overlay displayCtrl (_x)) ctrlShow true; } foreach _sectorcontrols;
							sleep 3;
						} forEach active_sectors;
					} else {
						_text = "";
						_isCommander = [player] call F_getCommander;
						if (!(GRLIB_AvailAttackSectors isEqualTo [])) then {
							if (GRLIB_Commander_VoteEnabled || _isCommander) then {
								{
									if (!((_x + "av") in GRLIB_availableMarkers)) then {
										_markerstr = createMarkerLocal [_x + "av", getMarkerPos _x];
										_markerstr setMarkerTypeLocal "Select";
										_markerstr setMarkerColorLocal "ColorYellow";
										GRLIB_availableMarkers pushBack _markerstr;
									};
								} forEach GRLIB_AvailAttackSectors;
								if (_isCommander) then {
									//todo: localize
									_text = "Select a sector on the map to attack";
								} else {
									_text = "Vote for a sector on the map to attack";
								};
							} else {
								_text = "Standby for mission";
							};
						} else {
							if (_isCommander) then {
								_text = "Deploy an FOB to start a mission";
							} else {
								_text = "Standby for mission";
							};
						};
						(_overlay displayCtrl (205)) ctrlSetText (_text);
					};
				};
			};
		};
	};

	_uiticks = _uiticks + 1;
	if (_uiticks > 1000) then { _uiticks = 0 };
	uiSleep 1;
};
