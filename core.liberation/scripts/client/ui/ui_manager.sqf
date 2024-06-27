disableSerialization;
private [ 
	"_overlay", "_hide_HUD", "_attacked_string", "_active_sectors_string",
	"_color_readiness", "_color_reput", "_reput_icon", "_nearest_active_sector",
	"_zone_size", "_colorzone", "_bar", "_barwidth", "_reputation"
];
private _overlayshown = false;
private _sectorcontrols = [201,202,203,244,205];
private _active_sectors_hint = false;
private _uiticks = 0;
GRLIB_ui_notif = "";

waituntil {sleep 1; GRLIB_player_spawned};
waituntil {sleep 1; !isNil "resources_infantry"};
waituntil {sleep 1; !isNil "infantry_cap"};

if ( isNil "cinematic_camera_started" ) then { cinematic_camera_started = false };
if ( isNil "halojumping" ) then { halojumping = false };

while { true } do {
	_hide_HUD = !(shownHUD select 0);

	if ( alive player && !dialog && !_overlayshown && !cinematic_camera_started && !halojumping && !_hide_HUD) then {
		"LibUI" cutRsc ["statusoverlay", "PLAIN", 1];
		_overlayshown = true;
		_uiticks = 0;
	};

	if ( ( !alive player || dialog || cinematic_camera_started || _hide_HUD) && _overlayshown) then {
		"LibUI" cutRsc ["blank", "PLAIN", 0];
		_overlayshown = false;
	};

	if ( _overlayshown ) then {
		_overlay = uiNamespace getVariable ['GUI_OVERLAY', objNull];
		(_overlay displayCtrl (266)) ctrlSetText format [ "%1", GRLIB_ui_notif ];
		(_overlay displayCtrl (267)) ctrlSetText format [ "%1", GRLIB_ui_notif ];

		if ((markerPos "opfor_capture_marker") distance2D markers_reset > 100 ) then {
			_attacked_string = [ markerpos "opfor_capture_marker" ] call F_getLocationName;
			(_overlay displayCtrl (401)) ctrlShow true;
			(_overlay displayCtrl (402)) ctrlSetText _attacked_string;
			_attacked_timer = [sector_timer] call F_secondsToTimer;
			if (sector_timer == 0) then { _attacked_timer = "VULNERABLE" };
			(_overlay displayCtrl (403)) ctrlSetText _attacked_timer;
		} else {
			(_overlay displayCtrl (401)) ctrlShow false;
			(_overlay displayCtrl (402)) ctrlSetText "";
			(_overlay displayCtrl (403)) ctrlSetText "";
		};

		if ( _uiticks % 5 == 0 ) then {
			(_overlay displayCtrl (107)) ctrlSetText format [ "%1", (player getVariable ["GREUH_score_count",0]) ];
			(_overlay displayCtrl (102)) ctrlSetText format [ "%1", (player getVariable ["GREUH_ammo_count",0]) ];
			(_overlay displayCtrl (103)) ctrlSetText format [ "%1", (player getVariable ["GREUH_fuel_count",0]) ];
			(_overlay displayCtrl (101)) ctrlSetText format [ "%1/%2", resources_infantry, infantry_cap ];
			_reputation = [player] call F_getReput;
			(_overlay displayCtrl (104)) ctrlSetText format [ "%1", round(_reputation) ];
			(_overlay displayCtrl (105)) ctrlSetText format [ "%1%2", round(combat_readiness),"%" ];
			(_overlay displayCtrl (106)) ctrlSetText format [ "%1", round(resources_intel) ];

			_color_readiness = [0.8,0.8,0.8,1];
			if ( combat_readiness >= 25 ) then { _color_readiness = [0.8,0.8,0,1] };
			if ( combat_readiness >= 50 ) then { _color_readiness = [0.8,0.6,0,1] };
			if ( combat_readiness >= 75 ) then { _color_readiness = [0.8,0.3,0,1] };
			if ( combat_readiness >= 100 ) then { _color_readiness = [0.8,0,0,1] };

			(_overlay displayCtrl (105)) ctrlSetTextColor _color_readiness;
			(_overlay displayCtrl (135)) ctrlSetTextColor _color_readiness;

			_color_reput = [0.8,0.8,0.8,1];
			_reput_icon = "res\rep\rep3.paa";
			if ( _reputation >= 25 ) then { _color_reput = [0.8,0.8,0,1]; _reput_icon = "res\rep\rep4.paa" };
			if ( _reputation >= 50 ) then { _color_reput = [0.0,0.6,0,1]; _reput_icon = "res\rep\rep5.paa" };
			if ( _reputation >= 75 ) then { _color_reput = [0.0,0.8,0,1]; _reput_icon = "res\rep\rep6.paa" };
			if ( _reputation >= 100 ) then { _color_reput = [0,0.8,0.6,1]; _reput_icon = "res\rep\rep6.paa" };
			if ( _reputation <= -25 ) then { _color_reput = [0.8,0.8,0,1]; _reput_icon = "res\rep\rep2.paa" };
			if ( _reputation <= -50 ) then { _color_reput = [0.8,0.6,0,1]; _reput_icon = "res\rep\rep1.paa" };
			if ( _reputation <= -75 ) then { _color_reput = [0.8,0.3,0,1]; _reput_icon = "res\rep\rep0.paa" };
			if ( _reputation <= -100 ) then { _color_reput = [0.8,0,0,1]; _reput_icon = "res\rep\rep0.paa" };
			(_overlay displayCtrl (104)) ctrlSetTextColor _color_reput;
			(_overlay displayCtrl (1041)) ctrlSetText (getMissionPath _reput_icon);
		};

		if ( _uiticks % 25 == 0 ) then {
			if (opforcap >= GRLIB_opfor_cap || count active_sectors >= GRLIB_max_active_sectors) then {
				(_overlay displayCtrl (517)) ctrlShow true;

				if ( !_active_sectors_hint ) then {
					hint localize "STR_OVERLOAD_HINT";
					_active_sectors_hint = true;
				};

				_active_sectors_string = "<t align='right' color='#e0e000'>" + (localize "STR_ACTIVE_SECTORS") + "<br/>";
				{
					_active_sectors_string = _active_sectors_string + (markertext _x) + "<br/>";
				} foreach active_sectors;
				_active_sectors_string = _active_sectors_string + "</t>";
				(_overlay displayCtrl (516)) ctrlSetStructuredText parseText _active_sectors_string;
			} else {
				(_overlay displayCtrl (516)) ctrlSetStructuredText parseText " ";
				(_overlay displayCtrl (517)) ctrlShow false;
			};

			_nearest_active_sector = [ GRLIB_sector_size ] call F_getNearestSector;
			if ( _nearest_active_sector != "" ) then {
				_zone_size = GRLIB_capture_size;
				if ( _nearest_active_sector in sectors_bigtown ) then {
					_zone_size = GRLIB_capture_size * 1.4;
				};

				"zone_capture" setmarkerposlocal (markerpos _nearest_active_sector);
				_colorzone = "ColorGrey";
				_sectorSide = ([ markerpos _nearest_active_sector, _zone_size ] call F_sectorOwnership);
				if ( _sectorSide == GRLIB_side_friendly ) then { _colorzone = GRLIB_color_friendly };
				if ( _sectorSide == GRLIB_side_enemy ) then { _colorzone = GRLIB_color_enemy };
				if ( _sectorSide == GRLIB_side_resistance ) then { _colorzone = GRLIB_color_friendly };
				"zone_capture" setmarkercolorlocal _colorzone;

				private _color_F = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_friendly >> "color") call BIS_fnc_colorConfigToRGBA;
				private _color_E = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_enemy >> "color") call BIS_fnc_colorConfigToRGBA;
				(_overlay displayCtrl (244)) ctrlSetBackgroundColor _color_F;
				(_overlay displayCtrl (203)) ctrlSetBackgroundColor _color_E;
				if ( _nearest_active_sector in blufor_sectors ) then {
					(_overlay displayCtrl (205)) ctrlSetTextColor _color_F;
				} else {
					(_overlay displayCtrl (205)) ctrlSetTextColor _color_E;
				};

				_ratio = [_nearest_active_sector] call F_getForceRatio;
				_barwidth = 0.084 * safezoneW * _ratio;
				_bar = _overlay displayCtrl (244);
				_bar ctrlSetPosition [(ctrlPosition _bar) select 0,(ctrlPosition _bar) select 1,_barwidth,(ctrlPosition _bar) select 3];
				_bar ctrlCommit 1;

				(_overlay displayCtrl (205)) ctrlSetText (markerText _nearest_active_sector);
				{ (_overlay displayCtrl (_x)) ctrlShow true; } foreach _sectorcontrols;

				"zone_capture" setMarkerSizeLocal [ _zone_size,_zone_size ];
			} else {
				{ (_overlay displayCtrl (_x)) ctrlShow false; } foreach _sectorcontrols;
				"zone_capture" setmarkerposlocal markers_reset;
			};
		};

	};
	_uiticks = _uiticks + 1;
	if ( _uiticks > 1000 ) then { _uiticks = 0 };
	uiSleep 0.25;
};
