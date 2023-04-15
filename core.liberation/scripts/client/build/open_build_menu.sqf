private ["_build_list", "_entrytext", "_icon", "_affordable", "_affordable_crew", "_selected_item", "_linked", "_linked_unlocked", "_base_link", "_link_color", "_link_str" ];

if ( ( [ getpos player , 500 , GRLIB_side_enemy ] call F_getUnitsCount ) > 4 ) exitWith { hint localize "STR_BUILD_ENEMIES_NEARBY"; };

if ( isNil "buildtype" ) then { buildtype = 1 };
if ( buildtype > 8 ) then { buildtype = 1 };
if ( isNil "buildindex" ) then { buildindex = -1 };
dobuild = 0;
private _oldbuildtype = -1;
private _refresh = true;
private _cfg = configFile >> "cfgVehicles";
private _initindex = buildindex;

createDialog "liberation_build";
waitUntil { dialog };

private _title = localize "STR_BUILD_TITLE";
private _msg = "";
private _score = [player] call F_getScore;
private _rank = player getVariable ["GRLIB_Rank", "Private"];
private _iscommandant = false;
if ( _rank in ["Colonel", "Super Colonel"] ) then {	_iscommandant = true };
private _iscommander = false;
if ( player == ([] call F_getCommander) ) then { _iscommander = true };
ctrlSetText [1011, format ["%1 - %2", _title, _rank]];
ctrlShow [ 108, _iscommandant ];
ctrlShow [ 1085, _iscommandant ];
if (count squads == 0) then {
	ctrlShow [ 108, false ];
	ctrlShow [ 1085, false ];
};

private _near_outpost = (count (player nearObjects [FOB_outpost, 100]) > 0);
private _has_box = false;
{ if ((_x select 0) == playerbox_typename && (_x select 3) == getPlayerUID player) exitWith {_has_box = true} } foreach GRLIB_garage;
if (count ([entities playerbox_typename, {[player, _x] call is_owner}] call BIS_fnc_conditionalSelect) > 0) then {_has_box = true};

private _squadname = "";
private _buildpages = [
	localize "STR_BUILD1",
	localize "STR_BUILD2",
	localize "STR_BUILD3",
	localize "STR_BUILD4",
	localize "STR_BUILD5",
	localize "STR_BUILD6",
	localize "STR_BUILD7",
	localize "STR_BUILD8"
];

while { dialog && alive player && (dobuild == 0 || buildtype == 1)} do {
 	_build_list = [];
	{
		if (_near_outpost && buildtype in [3,4,8]) exitWith {};
		if (buildtype == 8 ) then {
			_build_list pushback _x;
		} else {
			if ( _score >= (_x select 4) ) then {_build_list pushback _x};
		};
	} forEach (build_lists select buildtype);

	if (_oldbuildtype != buildtype || _refresh) then {
		_refresh = false;
		_oldbuildtype = buildtype;

		lbClear 110;
		{
			ctrlSetText [ 151, _buildpages select ( buildtype - 1) ];
			if ( buildtype != 8 ) then {
				_entrytext = [(_x select 0)] call F_getLRXName;
				((findDisplay 5501) displayCtrl (110)) lnbAddRow [ _entrytext, format [ "%1" ,_x select 1], format [ "%1" ,_x select 2], format [ "%1" ,_x select 3]];

				_icon = getText ( _cfg >> (_x select 0) >> "icon");
				if(isText  (configFile >> "CfgVehicleIcons" >> _icon)) then {
					_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
				};
				lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0],_icon];
			} else {
				if ( ((lnbSize  110) select 0) <= count squads_names ) then {
					_squadname = squads_names select ((lnbSize  110) select 0);
				} else {
					_squadname = "";
				};
				((findDisplay 5501) displayCtrl (110)) lnbAddRow  [_squadname, format [ "%1" ,_x select 1], format [ "%1" ,_x select 2], format [ "%1" ,_x select 3]];
				_icon = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
				lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0],_icon];
			};

			_affordable = true;
			_ammo_collected = player getVariable ["GREUH_ammo_count",0];
			_fuel_collected = player getVariable ["GREUH_fuel_count",0];
			if (
				((_x select 1 > 0) && ((_x select 1) > (infantry_cap - resources_infantry))) ||
				((_x select 2 > 0) && ((_x select 2) > _ammo_collected)) ||
				((_x select 3 > 0) && ((_x select 3) > _fuel_collected))
				) then {
				_affordable = false;
			};

			if ( buildtype == 1 ) then {
				if (_x select 0 in ["Alsatian_Random_F","Fin_random_F"] ) then {
					if (!(isNil {player getVariable ["my_dog", nil]})) then {
						_affordable = false;
					};
				};
			};

			if ( buildtype == 7 ) then {
				if (_x select 0 == mobile_respawn) then {
					if (([getPlayerUID player] call F_getMobileRespawnsPlayer) select 1) then {
						_affordable = false;
					};
				};
				if (_x select 0 == playerbox_typename) then {
					if (_has_box) then {
						_affordable = false;
					};
				};
			};

			if ( buildtype == 8 ) then {
				if (!(isNil {player getVariable ["my_squad", nil]})) then {
					_affordable = false;
				};
			};

			if ( _affordable ) then {
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 0], [1,1,1,1]];
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 1], [1,1,1,1]];
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 2], [1,1,1,1]];
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 3], [1,1,1,1]];
			} else {
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 0], [0.4,0.4,0.4,1]];
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 1], [0.4,0.4,0.4,1]];
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 2], [0.4,0.4,0.4,1]];
				((findDisplay 5501) displayCtrl (110)) lnbSetColor  [[((lnbSize 110) select 0) - 1, 3], [0.4,0.4,0.4,1]];
			};

		} foreach _build_list;

		if (_near_outpost && count (_build_list) == 0) then {
			((findDisplay 5501) displayCtrl (110)) lnbAddRow [ "       Unavailable at Outpost.","-","-","-"];
		};
	};

	if(_initindex != -1) then {
		lbSetCurSel [110, _initindex];
		_initindex = -1;
	};

	_selected_item = lbCurSel 110;
	_affordable = false;
	_squad_full = false;
	_ammo_collected = player getVariable ["GREUH_ammo_count",0];
	_fuel_collected = player getVariable ["GREUH_fuel_count",0];
	_bros = allUnits select {!isPlayer _x && (_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1",PAR_Grp_ID]};
	_linked = false;
	_linked_unlocked = true;
	_base_link = "";
	if (dobuild == 0 && _selected_item != -1 && (_selected_item < (count _build_list))) then {
		_build_item = _build_list select _selected_item;
		if (
				((_build_item select 1 == 0 ) || ((_build_item select 1) <= (infantry_cap - resources_infantry))) &&
				((_build_item select 2 == 0 ) || ((_build_item select 2) <= _ammo_collected)) &&
				((_build_item select 3 == 0 ) || ((_build_item select 3) <= _fuel_collected))
		) then {
			_affordable = true;
		};

		if ( buildtype == 1 ) then {
			if (_build_item select 0 in ["Alsatian_Random_F","Fin_random_F"] ) then {
				if (!(isNil {player getVariable ["my_dog", nil]})) then {
					_affordable = false;
					_refresh = true;
				};
			};
		};

		if ( buildtype == 7 ) then {
			if (_build_item select 0 == mobile_respawn) then {
				if (([getPlayerUID player] call F_getMobileRespawnsPlayer) select 1) then {
					_affordable = false;
					_refresh = true;
				};
			};
			if (_build_item select 0 == playerbox_typename) then {
				if (_has_box) then {
					_affordable = false;
					_refresh = true;
				};
			};
		};

		if ( buildtype == 8 ) then {
			if (!(isNil {player getVariable ["my_squad", nil]})) then {
				_affordable = false;
				_refresh = true;
			};
		};

		if ( buildtype != 8 ) then {
			{ if ( ( _build_item select 0 ) == ( _x select 0 ) ) exitWith { _base_link = _x select 1; _linked = true; } } foreach GRLIB_vehicle_to_military_base_links;

			if ( _linked ) then {
				if ( !(_base_link in blufor_sectors) ) then { _linked_unlocked = false };
			};
		};

		if (buildtype == 1 && _build_item select 1 >= 1 && (count (_bros) >= GRLIB_squad_size + GRLIB_squad_size_bonus || !(player getVariable ["GRLIB_squad_context_loaded", false])) ) then {
			_squad_full = true;
		};
	};

	_affordable_crew = _affordable;
	if ( unitcap >= GRLIB_blufor_cap) then {
		_affordable_crew = false;
		if (buildtype == 1 || buildtype == 8) then {
			_affordable = false;
		};
	};

	ctrlEnable [ 120, _affordable && _linked_unlocked && !(_squad_full) ];
	ctrlShow [ 121, _iscommander && buildtype in [2,3,4,5]];
	ctrlEnable [ 121, _affordable_crew && _linked_unlocked];

	ctrlSetText [131, format [ "%1 : %2/%3", localize "STR_MANPOWER", resources_infantry, infantry_cap] ];
	ctrlSetText [132, format [ "%1 : %2", localize "STR_AMMO", (player getVariable ["GREUH_ammo_count",0])] ];
	ctrlSetText [133, format [ "%1 : %2", localize "STR_FUEL", (player getVariable ["GREUH_fuel_count",0])] ];
	ctrlSetText [134, format [ "%1 : %2/%3", localize "STR_UNITCAP", unitcap, GRLIB_blufor_cap] ];

	_link_color = "#0040e0";
	_link_str = localize "STR_VEHICLE_UNLOCKED";
	if (!_linked_unlocked) then { _link_color = "#e00000"; _link_str = localize "STR_VEHICLE_LOCKED"; };
	if ( _linked ) then {
		((findDisplay 5501) displayCtrl (161)) ctrlSetStructuredText parseText ( "<t color='" + _link_color + "' align='center'>" + _link_str +  "<br/>" + ( markerText _base_link ) + "</t>" );
	} else {
		((findDisplay 5501) displayCtrl (161)) ctrlSetStructuredText parseText "";
	};

	buildindex = _selected_item;

	if(buildtype == 1 && dobuild != 0) then {
		ctrlEnable [120, false];
		ctrlEnable [121, false];
		waitUntil {sleep 0.3; dobuild == 0};
		_refresh = true;
	};

	sleep 0.1;
};
hintSilent "";
if (!alive player || dobuild != 0) then {closeDialog 0 };