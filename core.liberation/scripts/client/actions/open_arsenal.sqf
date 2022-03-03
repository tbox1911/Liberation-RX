load_loadout = 0;
edit_loadout = 0;
respawn_loadout = 0;
load_from_player = -1;
exit_on_load = 0;

GRLIB_backup_loadout = [player] call F_getLoadout;
player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];

private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
private _saved_loadouts = profileNamespace getVariable "bis_fnc_saveInventory_data";
private _loadouts_data = [];
private _counter = 0;

/*
if ( !isNil "_saved_loadouts" ) then {
	private _grp = createGroup [GRLIB_side_friendly, true];
	private _unit = _grp createUnit ["B_Survivor_F", [0,0,0], [], 0, "NONE"];
	private _max_loadout = 24;
	{
		if ( _counter % 2 == 0 && _max_loadout > 0) then {
			[_unit, [profileNamespace, _x]] call bis_fnc_loadInventory;
			_price = [_unit] call F_loadoutPrice;
			_loadouts_data pushback [_x, _price];
			_max_loadout = _max_loadout - 1;
		};
		_counter = _counter + 1;
	} foreach _saved_loadouts;
	deleteVehicle _unit;
};
*/

createDialog "liberation_arsenal";
waitUntil { dialog };
ctrlEnable [ 202, false ];
ctrlEnable [ 203, false ];
ctrlEnable [ 204, false ];

if ( count _loadouts_data > 0 ) then {
	lbClear 201;
	{
		((findDisplay 5251) displayCtrl (201)) lnbAddRow [format [ "%1" ,_x select 0], format [ "%1" ,_x select 1]];

 		if ( (_x select 1) <= _ammo_collected ) then {
			((findDisplay 5251) displayCtrl (201)) lnbSetColor  [[((lnbSize 201) select 0) - 1, 0], [1,1,1,1]];
			((findDisplay 5251) displayCtrl (201)) lnbSetColor  [[((lnbSize 201) select 0) - 1, 1], [1,1,1,1]];
		} else {
			((findDisplay 5251) displayCtrl (201)) lnbSetColor  [[((lnbSize 201) select 0) - 1, 0], [0.4,0.4,0.4,1]];
			((findDisplay 5251) displayCtrl (201)) lnbSetColor  [[((lnbSize 201) select 0) - 1, 1], [0.4,0.4,0.4,1]];
		};

	} foreach _loadouts_data ;

	if ( lbSize 201 > 0 ) then {
		lbSetCurSel [ 201, 0 ];
	};
};

private _loadplayers = [];
{
	if ( !(name _x in [ "HC1", "HC2", "HC3" ]) )  then {
		_loadplayers pushback [ name _x, _x ];
	};
} foreach ( allPlayers - [ player ] );

if ( count _loadplayers > 0 ) then {
	{
		private _nextplayer = _x select 1;
		private _namestr = "";
		if(count (squadParams _nextplayer) != 0) then {
			_namestr = "[" + ((squadParams _nextplayer select 0) select 0) + "] ";
		};
		_namestr = _namestr + name _nextplayer;

		lbAdd [ 203, _namestr ];
		lbSetCurSel [ 203, 0 ];
	} foreach _loadplayers;
	ctrlEnable [ 203, true ];
	ctrlEnable [ 204, true ];
};

((findDisplay 5251) displayCtrl 201) ctrlAddEventHandler [ "mouseButtonDblClick" , { exit_on_load = 1; load_loadout = 1; } ];

while { dialog && (alive player) && edit_loadout == 0 } do {

	private _cur_sel = (lbCurSel 201);
	if (_cur_sel != -1) then {
		private _selected_loadout = _loadouts_data select _cur_sel;
		if ((_selected_loadout select 1) <= _ammo_collected) then {
			ctrlEnable [ 202, true ];
		} else {
			ctrlEnable [ 202, false ];
		};
	};

	if ( load_loadout > 0 ) then {
		private _selected_loadout = _loadouts_data select _cur_sel;
		private _loaded_loadout = (_selected_loadout select 0);
		[player, [profileNamespace, _loaded_loadout]] call bis_fnc_loadInventory;
		hint format [ localize "STR_HINT_LOADOUT_LOADED", _loaded_loadout];
		if ( exit_on_load == 1 ) then {
			closeDialog 0;
		};
		load_loadout = 0;
	};

	if ( respawn_loadout > 0 ) then {
		GRLIB_respawn_loadout = [ player, ["repetitive"] ] call F_getLoadout;
		hint localize "STR_MAKE_RESPAWN_LOADOUT_HINT";
		respawn_loadout = 0;
	};

	if ( load_from_player >= 0 ) then {
		private _playerselected = ( _loadplayers select load_from_player ) select 1;
		if ( alive _playerselected ) then {
      		[player, [_playerselected, ["repetitive"]] call F_getLoadout] call F_setLoadout;
			hint format [ localize "STR_LOAD_PLAYER_LOADOUT_HINT", name _playerselected ];
		};
		load_from_player = -1;
	};
	sleep 0.1;
};

if ( edit_loadout > 0 ) then {
	closeDialog 0;
	waitUntil {!dialog};
	_box = missionNamespace getVariable ["myLARsBox", objNull];
	if (GRLIB_ACE_enabled) then {
		[_box, true] call ace_arsenal_fnc_initBox;
		[_box, blacklisted_weapon] call ace_arsenal_fnc_removeVirtualItems;
		[_box, player, false] call ace_arsenal_fnc_openBox;
	} else {
		if (GRLIB_limited_arsenal) then {
			_savedCargo = _box getVariable [ "bis_addVirtualWeaponCargo_cargo", [] ];
			_savedMissionCargo = missionNamespace getVariable [ "bis_addVirtualWeaponCargo_cargo", [] ];
			waitUntil {!isNil {_box getVariable "LARs_arsenal_Liberation_cargo"} };
			_cargo = _box getVariable "LARs_arsenal_Liberation_cargo";
			_box setVariable [ "bis_addVirtualWeaponCargo_cargo", _cargo ];
			missionNamespace setVariable [ "bis_addVirtualWeaponCargo_cargo", _cargo ];

			['Open',[nil,_box]] call BIS_fnc_arsenal;

			_box setVariable [ "LARs_arsenalClosedID", [ missionNamespace, "arsenalClosed", compile format[ "
				%1 setVariable [ 'bis_addvirtualWeaponCargo_cargo', %2 ];
				missionNamespace setVariable [ 'bis_addvirtualWeaponCargo_cargo', %3 ];
				[ missionNamespace, 'arsenalClosed', %1 getVariable 'LARs_arsenalClosedID' ] call BIS_fnc_removeScriptedEventHandler;
				%1 setVariable [ 'LARs_arsenalClosedID', nil ];
			", _box, _savedCargo, _savedMissionCargo ] ]call BIS_fnc_addScriptedEventHandler ];
		} else {
			["Open", [true]] call BIS_fnc_arsenal;
		};
	};
};

//filter and pay loadout
[player] call F_filterLoadout;
[player] call F_payLoadout;
