private [  "_unitname", "_primary_mags", "_secondary_mags", "_vehstring" ];

GRLIB_squadaction = -1;
GRLIB_squadconfirm = -1;

private _membercount = -1;
private _memberselection = -1;
private _selectedmember = objNull;
private _cfgVehicles = configFile >> "cfgVehicles";
private _cfgWeapons = configFile >> "cfgWeapons";
private _firstloop = true;
private _isvehicle = false;
private _rename_controls = [521,522,523,524,525,526,527];
private _resupplied = false;
private _renamed = false;

createDialog "liberation_squad";
waitUntil { dialog };

{ ctrlShow [_x, false] } foreach _rename_controls;
private _targetobject = "Sign_Sphere100cm_F" createVehicleLocal [ 0, 0, 0 ];
hideObject _targetobject;

private _squad_camera = "camera" camCreate (getpos player);
_squad_camera cameraEffect ["internal","back", "rtt"];
_squad_camera camSetTarget  _targetobject;
_squad_camera camcommit 0;
"rtt" setPiPEffect [0];

while { dialog && alive player } do {
	if ( count PAR_AI_bros != _membercount || _renamed ) then {

		_membercount = count PAR_AI_bros;

		lbClear 101;
		{
			if ( alive _x ) then {
				_unitname =  format ["%1. %2", [ _x ] call F_getUnitPositionId, name _x];
				if (isPlayer _x) then {
					_unitname = [_x] call get_player_name;
				};
				lbAdd [ 101, _unitname ];
			};
		} foreach PAR_AI_bros;

		if ( _firstloop ) then {
			lbSetCurSel [ 101, 0 ];
			_firstloop = false;
		};
	};

	_selectedmember = objNull;
	if ( lbCurSel 101 != -1 && (count PAR_AI_bros > lbCurSel 101 ) ) then {
		_selectedmember = PAR_AI_bros select (lbCurSel 101);
	};

	if ( !(isNull _selectedmember) ) then {
			"spawn_marker" setMarkerPosLocal (getpos _selectedmember);
			ctrlMapAnimClear ((findDisplay 5155) displayCtrl 100);
			((findDisplay 5155) displayCtrl 100) ctrlMapAnimAdd [0, 0.3, getpos _selectedmember];
			ctrlMapAnimCommit ((findDisplay 5155) displayCtrl 100);
	};

	if ( !(isNull _selectedmember) ) then {
		if ( _memberselection != lbCurSel 101 || _resupplied || _renamed || ( ( vehicle _selectedmember == _selectedmember && _isvehicle ) || ( vehicle _selectedmember != _selectedmember && !_isvehicle ) ) ) then {
			_memberselection = lbCurSel 101;
			_resupplied = false;

			if (vehicle _selectedmember == _selectedmember) then {
				_targetobject attachTo [ _selectedmember, [0, 10, 0.05], "neck" ];
				_squad_camera attachTo [ _selectedmember, [0, 0.25, 0.05], "neck" ];
				_isvehicle = false;
			} else {
				_targetobject attachTo [ vehicle _selectedmember, [0, 20, 2]];
				_squad_camera attachTo [ vehicle _selectedmember, [0, 0, 2]];
				_isvehicle = true;
			};
			_squad_camera camcommit 0;

			_unitname = format ["%1. %2", [ _selectedmember ] call F_getUnitPositionId, name _selectedmember];
			if (isPlayer _selectedmember) then {
				_unitname = [_selectedmember] call get_player_name;
			};
			ctrlSetText [ 201, _unitname];

			ctrlSetText [ 202, format ["%1 (%2)", getText (_cfgVehicles >> (typeof _selectedmember) >> "displayName"), rank _selectedmember] ];
			ctrlSetText [ 203, format ["%1 %2%3", localize 'STR_HEALTH', round (100 - ((damage _selectedmember) * 100)), '%' ] ];

			((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,1,1,1];
			if ( damage _selectedmember > 0.4 ) then { ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,1,0,1]; };
			if ( damage _selectedmember > 0.6 ) then { ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,0.5,0,1]; };
			if ( damage _selectedmember > 0.8 ) then { ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,0,0,1]; };

			ctrlSetText [ 204, format ["%1 %2m", localize 'STR_DISTANCE', round (player distance _selectedmember) ] ];

			if ( primaryWeapon _selectedmember != "") then {
				ctrlSetText [ 205, format ["%1: %2", localize 'STR_PRIMARY_WEAPON', getText (_cfgWeapons >> (primaryWeapon _selectedmember) >> "displayName") ] ];

				_primary_mags = 0;
				if ( count primaryWeaponMagazine _selectedmember > 0 ) then {
					_primary_mags = 1;
					{ if ( ( _x select 0 ) == ( ( primaryWeaponMagazine _selectedmember ) select 0 ) ) then { _primary_mags = _primary_mags + 1; } } foreach (magazinesAmmo _selectedmember);
				};

				ctrlSetText [ 206, format ["%1: %2", localize 'STR_AMMO', _primary_mags ] ];
			} else {
				ctrlSetText [ 205, format ["%1: %2", localize 'STR_PRIMARY_WEAPON', localize 'STR_NONE' ] ];
				ctrlSetText [ 206, format ["%1: %2", localize 'STR_AMMO', 0 ] ];
			};

			if ( secondaryWeapon _selectedmember != "") then {
				ctrlSetText [ 207, format ["%1: %2", localize 'STR_SECONDARY_WEAPON', getText (_cfgWeapons >> (secondaryWeapon _selectedmember) >> "displayName") ] ];

				_secondary_mags = 0;
				if ( count secondaryWeaponMagazine _selectedmember > 0 ) then {
					_secondary_mags = 1;
					{ if ( ( _x select 0 ) == ( ( secondaryWeaponMagazine _selectedmember ) select 0 ) ) then { _secondary_mags = _secondary_mags + 1; } } foreach (magazinesAmmo _selectedmember);
				};

				ctrlSetText [ 208, format ["%1: %2", localize 'STR_AMMO', _secondary_mags ] ];
			} else {
				ctrlSetText [ 207, format ["%1: %2", localize 'STR_SECONDARY_WEAPON', localize 'STR_NONE' ] ];
				ctrlSetText [ 208, format ["%1: %2", localize 'STR_AMMO', 0 ] ];
			};
			ctrlSetText [ 216, format ["Loadout Price: %1 Ammo", ([_selectedmember] call F_loadoutPrice)] ];

			if ( vehicle _selectedmember == _selectedmember ) then {
				ctrlSetText [ 209, "" ];
			} else {
				_vehstring = localize 'STR_PASSENGER';
				if (driver vehicle _selectedmember == _selectedmember ) then { _vehstring = localize 'STR_DRIVER'; };
				if (gunner vehicle _selectedmember == _selectedmember ) then { _vehstring = localize 'STR_GUNNER'; };
				if (commander vehicle _selectedmember == _selectedmember ) then { _vehstring = localize 'STR_COMMANDER'; };
				_vehstring = _vehstring + format [ " (%1)", getText (_cfgVehicles >> (typeof vehicle _selectedmember) >> "displayName") ];
				ctrlSetText [ 209, _vehstring ];
			};
		};
	} else {
		{ ctrlSetText [ _x, "" ] } foreach [ 201, 202, 203, 204, 205, 206, 207, 208, 209, 216 ];
		GRLIB_squadconfirm = -1;
		GRLIB_squadaction = -1;
	};

	if ( GRLIB_squadaction == -1 ) then {
		ctrlEnable [ 213, false ];
		ctrlEnable [ 214, false ];
		if ( !(isPlayer _selectedmember) && (vehicle _selectedmember == _selectedmember) && (side _selectedmember == GRLIB_side_friendly) ) then {
			ctrlEnable [ 210, true ];
			ctrlEnable [ 215, true ];
			if ( leader group player == player ) then {
				ctrlEnable [ 211, true ];
			};
			ctrlEnable [ 212, false ]; //ReplaceButton disabled
			ctrlEnable [ 217, true ];
		} else {
			ctrlEnable [ 210, false ];
			ctrlEnable [ 215, false ];
			ctrlEnable [ 211, false ];
			ctrlEnable [ 212, false ];
			ctrlEnable [ 217, false ];
		};
	} else {
		ctrlEnable [ 210, false ];
		ctrlEnable [ 215, false ];
		ctrlEnable [ 211, false ];
		ctrlEnable [ 212, false ];
		ctrlEnable [ 217, false ];
		ctrlEnable [ 213, true ];
		ctrlEnable [ 214, true ];
	};

	if( GRLIB_squadconfirm == 0 ) then {
		GRLIB_squadconfirm = -1;
		GRLIB_squadaction = -1;
	};

	if ( GRLIB_squadconfirm == 1 ) then {
		GRLIB_squadconfirm = -1;

		if ( GRLIB_squadaction == 1 ) then {
			private _ai_rank = (GRLIB_rank_level find (rank _selectedmember));
			private _pl_rank = (GRLIB_rank_level find (rank player));
			private _ai_score = _selectedmember getVariable ["PAR_AI_score", nil];
			if (!isNil "_ai_score") then {
				if (_ai_rank < _pl_rank) then {
					private _cost = (_ai_score * 15);
					private _msg = format ["<t align='center'>Promote %1 for %2 Ammo<br/>Are you sure ?</t>", name _selectedmember, _cost];
					private _result = [_msg, "Warning !", true, true] call BIS_fnc_guiMessage;
					if (_result) then {
						if (!([_cost] call F_pay)) exitWith {};
						_selectedmember setVariable ["PAR_AI_score", 0];
						hint localize 'STR_PROMOTE_OK';
						waitUntil {sleep 0.3; _selectedmember getVariable ["PAR_AI_score", 0] !=0 };
						_resupplied = true;
					};
				} else {
					hint localize 'STR_PROMOTE_KO';
				};
			};
		};

		if (GRLIB_squadaction == 2) then {
			private _ai_rank = 1 + (GRLIB_rank_level find (rank _selectedmember));
			private _refund = [_selectedmember] call F_loadoutPrice;
			if (_ai_rank > 1 ) then {
				_refund = round (_refund * (_ai_rank * 0.7));
			};
			[player, _refund, 0] remoteExec ["ammo_add_remote_call", 2];
			playSound "taskSucceeded";
			if (_ai_rank > 1 ) then {
				gamelogic globalChat format ["Soldier rank %2 Refund: %1, Thank you !", _refund, _ai_rank];
			} else {
				gamelogic globalChat format ["Soldier Refund: %1, Thank you !", _refund];
			};
			PAR_AI_bros = PAR_AI_bros - [_selectedmember];
			deleteVehicle _selectedmember;
			_resupplied = true;
			hint localize 'STR_REMOVE_OK';
		};

		if (GRLIB_squadaction == 3) then {
		};

		if (GRLIB_squadaction == 4) then {
			if ((player distance _selectedmember) < 30) then {
				private _price_ai = [_selectedmember] call F_loadoutPrice;
				private _price = [player] call F_loadoutPrice;
				private _cost = 0 max (_price - _price_ai);
				if ([_cost] call F_pay) then {
					_selectedmember setUnitLoadout (getUnitLoadout player);
					hintSilent format ["Loadout copied, Price: %1\nThank you !", _cost];
				};
			} else {
				hintSilent "Unit too far from you.";
			};
		};

		if (GRLIB_squadaction == 5) then {
			unitname = "";
			_name = name _selectedmember;
			{ ctrlShow [_x, true] } foreach _rename_controls;
			ctrlSetText [527, _name];
			waitUntil {uiSleep 0.1; ((GRLIB_squadaction == -1) || (unitname != "") || !(dialog) || !(alive player)) };

			if (unitname != "") then {
				_p2 = (unitname splitString " ") select 0;
				_p1 = (unitname splitString " ") select 1;
				if (isNil "_p1") then {_p1 = ""};
				_selectedmember setName [unitname, _p1, _p2];
				gamelogic globalChat format ["Renaming %1 to %2", _name, unitname];
				_renamed = true;
			};
			{ ctrlShow [_x, false] } foreach _rename_controls;
		};

		GRLIB_squadaction = -1;
	};
	uiSleep 0.1;
};

"spawn_marker" setMarkerPosLocal markers_reset;
_squad_camera cameraEffect ["terminate","back"];
camDestroy _squad_camera;
deleteVehicle _targetobject;
uiSleep 3;
hintSilent "";