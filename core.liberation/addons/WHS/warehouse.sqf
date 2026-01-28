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

createDialog "Warehouse";
waitUntil { dialog };

private _display = findDisplay 2302;
ctrlEnable [ 120, false ];
ctrlEnable [ 121, false ];

gamelogic globalChat "Welcome to the WareHouse!";

private [
	"_control", "_entrytext", "_icon", "_typename",
	"_box_count", "_box_class", "_box_name",
	"_price", "_ammo", "_msg", "_result"
];

load_box = 0;
while { dialog && alive player } do {
	if (_refresh) then {
		_refresh = false;

		// Box outside
		lbClear 110;
		_allbox = getPosATL player nearEntities [[waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename,basic_weapon_typename], 20];
		_mybox = _allbox select { alive _x && isNull attachedTo _x };
		{
			_typename = typeOf _x;
			_entrytext = [_typename] call F_getLRXName;
			lnbAddRow [110, [_entrytext]];
			lnbSetData [110, [((lnbSize 110) select 0) - 1, 0], _typename];
			_icon = getText ( _cfg >> _typename >> "icon");
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
		lbClear 111;
		{
			_typename = _x;
			_box_count = GRLIB_warehouse get _typename;
			_entrytext = [_typename] call F_getLRXName;
			lnbAddRow [111, [_entrytext, str _box_count]];
			lnbSetData [111, [((lnbSize 111) select 0) - 1, 0], _typename];
			_icon = getText ( _cfg >> _typename >> "icon");
			if(isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture [111, [((lnbSize 111) select 0) - 1, 0], _icon];
			_control = _display displayCtrl (111);
			if (_box_count == 0) then {
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [0.4,0.4,0.4,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [0.4,0.4,0.4,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 2], [0.4,0.4,0.4,1]];
			} else {
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [1,1,1,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [1,1,1,1]];
				_control lnbSetColor [[((lnbSize 111) select 0) - 1, 2], [1,1,1,1]];
			};
		} foreach (keys GRLIB_warehouse);

		lbSetCurSel [111, GRLIB_WHS_Selected];
	};

	// load action
	if (lbCurSel 110 != -1) then {
		ctrlEnable [120, true];
	} else {
		ctrlEnable [120, false];
	};

	// unload action
	if (lbCurSel 111 == -1) then {
		ctrlEnable [121, false];
	} else {
		_typename = (lnbData [111, [(lbCurSel 111), 0]]);
		_box_count = GRLIB_warehouse getOrDefault[ _typename, 0];
		_price = [_typename, support_vehicles] call F_getObjectPrice;
		_ammo = ((_price / GRLIB_recycling_percentage) <= (player getVariable ["GREUH_ammo_count", 0]));
		ctrlEnable [121, (_box_count > 0 && _ammo)];
	};

	if (load_box != 0) then {
		// load
		if (load_box == 1) then {
			ctrlEnable [120, false];
			private _box = _mybox select (lbCurSel 110);
			if (isNull _box) exitWith {};
			_box_class = typeOf _box;
			_box_name = [_box_class] call F_getLRXName;
			_price = [_box_class, support_vehicles] call F_getObjectPrice;
			_msg = format [localize "STR_WAREHOUSE_LOAD_MSG", _box_name, _price];
			_result = [_msg, localize "STR_WAREHOUSE_LOAD", true, true] call BIS_fnc_guiMessage;

			if (_result) then {
				hintSilent format ["%1 Stored to Warehouse,\n for %2 AMMO.", _box_name, _price];
				[_box, load_box, player] remoteExec ["warehouse_remote_call", 2];
				playSound "taskSucceeded";
				waitUntil {sleep 0.1; isNull _box };
				_refresh = true;
			};
		};

		// unload
		if (load_box == 2) then {
			ctrlEnable [121, false];
			GRLIB_WHS_Selected = lbCurSel 111;
			_typename = (lnbData [111, [GRLIB_WHS_Selected, 0]]);
			_box_name = [_typename] call F_getLRXName;
			_price = [_typename, support_vehicles] call F_getObjectPrice;
			_price = round (_price / GRLIB_recycling_percentage);
			_msg = format [localize "STR_WAREHOUSE_UNLOAD_MSG", _box_name, _price];
			_result = [_msg, localize "STR_WAREHOUSE_UNLOAD", true, true] call BIS_fnc_guiMessage;

			if (_result) then {
				buildtype = GRLIB_BuildTypeDirect;
				build_unit = [_typename,[],1,[],[],[],[]];
				dobuild = 1;
				closeDialog 0;
				waitUntil { sleep 0.5; dobuild == 0};

				if (build_confirmed == 0) then {
					if ([_price] call F_pay) then {
						[_typename, load_box, player] remoteExec ["warehouse_remote_call", 2];
						hintSilent format ["%1 Taken from Warehouse,\n for %2 AMMO.", _box_name, _price];
						playSound "taskSucceeded";
						_refresh = true;
					} else {
						deleteVehicle build_vehicle;
					};
				};
			};
		};

		load_box = 0;
	};

	sleep 0.3;
};

GRLIB_warehouse_in_use = nil;
publicVariable "GRLIB_warehouse_in_use";
