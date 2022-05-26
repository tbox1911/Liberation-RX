// Joh Factions

if (FAC_MSU_ACTIVE) then {
	_fac = group player getVariable ["BIS_dg_fac", true];// gibt "NoFaction" wenn keine Gruppe oder Fraktion festgelegt.
	if (_fac == "NoFaction") exitWith {
		hint "Bitte erstelle eine Gruppe im Groupmanager, und wähle deine Fraktion in den Gruppendetails!";
	};

	

	[] call F_calcUnitsCost;

	_comp_build_lists = compile format ["[[], infantry_units, %1_light_vehicles, %1_heavy_vehicles, %1_air_vehicles, static_vehicles, buildings, support_vehicles, squads];", _fac];
	build_lists = call _comp_build_lists;

};
// END Joh Factions

private [ "_oldbuildtype", "_cfg", "_initindex", "_iscommandant", "_squadname", "_buildpages", "_build_list", "_classnamevar", "_entrytext", "_icon", "_affordable", "_affordable_crew", "_selected_item", "_linked", "_linked_unlocked", "_base_link", "_link_color", "_link_str" ];

if ( ( [ getpos player , 500 , GRLIB_side_enemy ] call F_getUnitsCount ) > 4 ) exitWith { hint localize "STR_BUILD_ENEMIES_NEARBY"; };

if ( isNil "buildtype" ) then { buildtype = 1 };
if ( buildtype > 12 ) then { buildtype = 1 };
if ( isNil "buildindex" ) then { buildindex = -1 };
dobuild = 0;
_oldbuildtype = -1;
_cfg = configFile >> "cfgVehicles";
_initindex = buildindex;

createDialog "liberation_build";
waitUntil { dialog };

_title = localize "STR_BUILD_TITLE";
private _msg = "";
private _score = score player;
private _rank = player getVariable ["GRLIB_Rank", "Private"];

private _iscommandant = false;
if ( _rank == "Colonel" ) then {
	_iscommandant = true;
};
private _iscommander = false;
if ( player == [] call F_getCommander ) then {
	_iscommander = true;
	_iscommandant = true;
};
private _near_outpost = (count (player nearObjects [FOB_outpost, 100]) > 0);
ctrlSetText [1011, format ["%1 - %2", _title, _rank]];
ctrlShow [ 108, _iscommandant ];
ctrlShow [ 1085, _iscommandant ];

_squadname = "";
_buildpages = [
localize "STR_BUILD1",
localize "STR_BUILD2",
localize "STR_BUILD3",
localize "STR_BUILD4",
localize "STR_BUILD5",
localize "STR_BUILD6",
localize "STR_BUILD7",
localize "STR_BUILD8",
localize "STR_BUILD9",
localize "STR_BUILD10",
localize "STR_BUILD11",
localize "STR_BUILD12"

];

while { dialog && alive player && (dobuild == 0 || buildtype == 1)} do {
 	_build_list = [];
	{
		if (_near_outpost && buildtype in [4,5,6,7,12]) exitWith {};
		if (buildtype == 12 ) then {
			_build_list pushback _x;
		} else {
			if ( _score >= (_x select 4) ) then {_build_list pushback _x};
		};
	} forEach (build_lists select buildtype);

	if (_oldbuildtype != buildtype || synchro_done ) then {
		synchro_done = false;
		_oldbuildtype = buildtype;

		lbClear 110;
		{
			ctrlSetText [ 151, _buildpages select ( buildtype - 1) ];
			if ( buildtype != 12 ) then {
				_entrytext = [(_x select 0)] call get_lrx_name;
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
			if(
				((_x select 1 > 0) && ((_x select 1) > (infantry_cap - resources_infantry))) ||
				((_x select 2 > 0) && ((_x select 2) > _ammo_collected)) ||
				((_x select 3 > 0) && ((_x select 3) > (fuel_cap - resources_fuel)))
				) then {
				_affordable = false;
			};

			if (_x select 0 == mobile_respawn) then {
				if (([getPlayerUID player] call F_getMobileRespawnsPlayer) select 1) then {
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
	_bros = allUnits select {(_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1",PAR_Grp_ID]};
	_linked = false;
	_linked_unlocked = true;
	_base_link = "";
	if (dobuild == 0 && _selected_item != -1 && (_selected_item < (count _build_list))) then {
		_build_item = _build_list select _selected_item;
		if (
				((_build_item select 1 == 0 ) || ((_build_item select 1) <= (infantry_cap - resources_infantry))) &&
				((_build_item select 2 == 0 ) || ((_build_item select 2) <= _ammo_collected)) &&
				((_build_item select 3 == 0 ) || ((_build_item select 3) <= (fuel_cap - resources_fuel)))
		) then {
			_affordable = true;
		};

		if (_build_item select 0 == mobile_respawn) then {
			if (([getPlayerUID player] call F_getMobileRespawnsPlayer) select 1) then {
				_affordable = false;
			};
		};

		if ( buildtype != 12 ) then {
			{ if ( ( _build_item select 0 ) == ( _x select 0 ) ) exitWith { _base_link = _x select 1; _linked = true; } } foreach GRLIB_vehicle_to_military_base_links;

			if ( _linked ) then {
				if ( !(_base_link in blufor_sectors) ) then { _linked_unlocked = false };
			};
		};

		if (buildtype == 1 && _build_item select 1 >= 1 && (count (_bros) >= GRLIB_squad_size + GRLIB_squad_size_bonus)) then {
			_squad_full = true;
		};		
	};

	_affordable_crew = _affordable;
	if ( unitcap >= ([] call F_localCap)) then {
		_affordable_crew = false;
		if (buildtype == 1 || buildtype == 12) then {
			_affordable = false;
		};
	};

	ctrlEnable [ 120, _affordable && _linked_unlocked && !(_squad_full) ];
	ctrlShow [ 121, _iscommander && buildtype in [2,3,4,5,6,7,8]];
	ctrlEnable [ 121, _affordable_crew && _linked_unlocked];

	ctrlSetText [131, format [ "%1 : %2/%3" , localize "STR_MANPOWER" , (floor resources_infantry), infantry_cap]] ;
	ctrlSetText [132, format [ "%1 : %2" , localize "STR_AMMO" , (floor  (player getVariable ["GREUH_ammo_count",0]))] ];
	ctrlSetText [133, format [ "%1 : %2/%3" , localize "STR_FUEL" , (floor resources_fuel), fuel_cap] ];
	ctrlSetText [134, format [ "%1 : %2/%3" , localize "STR_UNITCAP" , unitcap, ([] call F_localCap)] ];

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
		sleep 1;
		dobuild = 0;
	};

	sleep 0.1;
};
hintSilent "";
if (!alive player || dobuild != 0) then {closeDialog 0 };
