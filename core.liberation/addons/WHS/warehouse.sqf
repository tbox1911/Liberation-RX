// LRX Warehouse
// by pSiKO

params ["_owner", "_caller", "_actionId", "_arguments"];

if (!isNil "GRLIB_warehouse_in_use") exitWith {
	if (isNull GRLIB_warehouse_in_use || !alive GRLIB_warehouse_in_use) then {
		GRLIB_warehouse_in_use = nil;
		publicVariable "GRLIB_warehouse_in_use";
		hintSilent "Retry...";
	} else {
		hintSilent format ["Warehouse is used by %1.\nPlease wait...", name GRLIB_warehouse_in_use];
	};
	sleep 2;
};
GRLIB_warehouse_in_use = player;
publicVariable "GRLIB_warehouse_in_use";

private _cfg = configFile >> "cfgVehicles";
private _allbox = [];
private _mybox = [];
private _refresh = true;
load_box = 0;

createDialog "Warehouse";
waitUntil { dialog };

private _display = findDisplay 2302;
ctrlEnable [ 120, false ];
ctrlEnable [ 121, false ];

gamelogic globalChat "Welcome to the WareHouse!";

while { dialog && alive player } do {
	if ( _refresh ) then {
		_refresh = false;

		// Box outside
		_control = _display displayCtrl (110);
		lbClear 110;
		_allbox = getPosATL player nearEntities [[waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename,basic_weapon_typename], 20];
		_mybox = _allbox select { alive _x && isNull attachedTo _x };
		{
			_entrytext = [typeOf _x] call F_getLRXName;
			_control lnbAddRow [_entrytext];
			_icon = getText ( _cfg >> (typeOf _x) >> "icon");
			if(isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture [110, [((lnbSize 110) select 0) - 1, 0], _icon];
		} foreach _mybox;
		if (count _mybox > 0) then {
			lbSetCurSel [110, 0];
		} else {
			lbSetCurSel [110, -1];
		};

		// Box inside
		_control = _display displayCtrl (111);
		lbClear 111;
		{
			_entrytext = [(_x select 0)] call F_getLRXName;
			_control lnbAddRow [_entrytext, str (_x select 1)];
			_icon = getText ( _cfg >> (_x select 0) >> "icon");
			if(isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture [111, [((lnbSize 111) select 0) - 1, 0], _icon];
			if ( (_x select 1) == 0 ) then {
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [0.4,0.4,0.4,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [0.4,0.4,0.4,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 2], [0.4,0.4,0.4,1]];
			} else {
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [1,1,1,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [1,1,1,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 2], [1,1,1,1]];
			};
		} foreach GRLIB_warehouse;
		if (count GRLIB_warehouse > 0) then {
			lbSetCurSel [111, 0];
		} else {
			lbSetCurSel [111, -1];
		};
	};

	// button
	if (lbCurSel 110 == -1) then {
		ctrlEnable [120, false];
	} else {
		ctrlEnable [120, true];
	};

	if (lbCurSel 111 == -1 || (GRLIB_warehouse select (lbCurSel 111) select 1) == 0) then {
		ctrlEnable [121, false];
	} else {
		ctrlEnable [121, true];
	};

	if (load_box != 0) then {
		// load
		if (load_box == 1) then {
			ctrlEnable [120, false];
			_box = _mybox select (lbCurSel 110);
			if (isNull _box) exitWith {};
			private _box_class = typeOf _box;
			private _box_name = [_box_class] call F_getLRXName;
			private _price = [_box_class, support_vehicles] call F_getObjectPrice;
			private _msg = format [localize "STR_WAREHOUSE_LOAD_MSG", _box_name, _price];
			private _result = [_msg, localize "STR_WAREHOUSE_LOAD", true, true] call BIS_fnc_guiMessage;

			if (_result) then {
				hintSilent format ["%1 Stored to Warehouse,\n for %2 AMMO.", _box_name, _price];
				[_box, load_box, player] remoteExec ["warehouse_remote_call", 2];
				playSound "taskSucceeded";
				waitUntil {sleep 0.1; isNull _box };
			};
		};

		// unload
		if (load_box == 2) then {
			ctrlEnable [121, false];
			private _box = GRLIB_warehouse select (lbCurSel 111) select 0;
			private _box_name = [_box] call F_getLRXName;
			private _price = [_box, support_vehicles] call F_getObjectPrice;
			private _price = round (_price / GRLIB_recycling_percentage);
			private _msg = format [localize "STR_WAREHOUSE_UNLOAD_MSG", _box_name, _price];
			private _result = [_msg, localize "STR_WAREHOUSE_UNLOAD", true, true] call BIS_fnc_guiMessage;

			if (_result) then {
				if ((GRLIB_warehouse select (lbCurSel 111) select 1) <= 0) exitWith {};
				buildtype = GRLIB_BuildTypeDirect;
				build_unit = [_box,[],1,[],[],[],[]];
				dobuild = 1;
				closeDialog 0;
				waitUntil { sleep 0.5; dobuild == 0};

				if (build_confirmed == 0) then {
					if (!([_price] call F_pay)) then {
						deleteVehicle build_vehicle;
					} else {
						[_box, load_box, player] remoteExec ["warehouse_remote_call", 2];
						hintSilent format ["%1 Taken from Warehouse,\n for %2 AMMO.", _box_name, _price];
						playSound "taskSucceeded";
					};
				};
			};
		};

		_refresh = true;
		load_box = 0;
	};

	sleep 0.5;
};

GRLIB_warehouse_in_use = nil;
publicVariable "GRLIB_warehouse_in_use";
