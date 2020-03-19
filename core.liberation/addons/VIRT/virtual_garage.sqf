// Virtual Garage

private _cfg = configFile >> "cfgVehicles";
private _myveh = [];
private _myveh_lst = [];
private _max_vehicle = 5;
private _recycleable_blacklist = [];
{_recycleable_blacklist pushBack ( _x select 0 )} foreach (static_vehicles);

private _refresh = true;
load_veh = 0;

createDialog "VIRT_vehicle_garage";
waitUntil { dialog };

while { dialog && alive player } do {
	_display = findDisplay 2301;

	if ( _refresh ) then {
		_refresh = false;

		_myveh_lst = [nearestObjects [player, ["LandVehicle","Air","Ship"], 200], {
			(_x distance lhd) >= 1000 &&
			_x getVariable ["GRLIB_vehicle_owner", ""] == getPlayerUID player &&
			!(typeOf _x in _recycleable_blacklist)
		}] call BIS_fnc_conditionalSelect;

		_myveh = [];
		{_myveh pushBack [(typeOf _x), 0]} forEach _myveh_lst;  // veh list outside

		_i = 0;
		{
			if (getPlayerUID player == _x select 2) then {_myveh pushBack [(_x select 0), 1, _i]}; // veh list inside + index
			_i = _i + 1;
		} forEach GRLIB_garage; 	// [_veh_class, _veh_color, player_id]

		lbClear 110;
		{
			_classnamevar = (_x select 0);
			_entrytext = getText (_cfg >> _classnamevar >> "displayName");
			_loctext = "";
			if (_x select 1 == 0 ) then {_loctext = "OUT" } else {_loctext = "IN"};
			(_display displayCtrl (110)) lnbAddRow [_entrytext, _loctext];

			_icon = getText ( _cfg >> (_x select 0) >> "icon");
			if(isText  (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0],_icon];

			if ( (_x select 1) == 0 ) then {
				(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [1,1,1,1]];
				(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [1,1,1,1]];
			} else {
				(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [0.4,0.4,0.4,1]];
				(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [0.4,0.4,0.4,1]];
			};
		} foreach _myveh;
	};

	// Enable Button
	private _selected_item = lbCurSel 110;
	private _load = false;
	private _unload = false;
	if (_selected_item != -1) then {
		_vehicle = _myveh select _selected_item;
		if ((_vehicle select 1) == 0) then {
			_load = true;
		} else {
			_unload = true;
		};
	};
	ctrlEnable [ 120, _load ];
	ctrlEnable [ 121, _unload ];

	if (load_veh != 0) then {

		private _vehicle = objNull;
		private _color = "";
		private	_vehicle_name = (_display displayCtrl (110)) lnbText [_selected_item,0];

		if (load_veh == 1) then {
			if (count ([GRLIB_garage, {(getPlayerUID player == _x select 2)}] call BIS_fnc_conditionalSelect) >= _max_vehicle) then {
				hintSilent (format ["Garage is Full !!\nMax %1 vehicles.", _max_vehicle]);
			} else {
				private _result = ["<t align='center'>Vehicle's content will be LOST !!<br/>Are you sure ?</t>", "Warning !", true, true] call BIS_fnc_guiMessage;
				if (_result) then {
					_vehicle = _myveh_lst select _selected_item;
					ctrlEnable [ 120, false ];
					[player, _vehicle, load_veh] remoteExec ["vehicle_garage_remote_call", 2];
					hintSilent (format ["Vehicle %1\nLoaded in Garage.", _vehicle_name]);
				};
			};
		};

		if (load_veh == 2) then {
			_vehicle = (_myveh select _selected_item) select 2;
			ctrlEnable [ 121, false ];
			[player, _vehicle, load_veh] remoteExec ["vehicle_garage_remote_call", 2];
			hintSilent (format ["Vehicle %1\nUnloaded from Garage.", _vehicle_name]);
			closeDialog 0;
		};

		sleep 1;
		_refresh = true;
		load_veh = 0;
	};

	sleep 0.1;
};
