// LRX Warehouse
// by pSiKO

params ["_owner", "_caller", "_actionId", "_arguments"];

private _cfg = configFile >> "cfgVehicles";
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
        lbSetCurSel [110, -1];
        _mybox = getPosATL player nearEntities [[waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename,basic_weapon_typename], 20];
        {
            _entrytext = [typeOf _x] call F_getLRXName;
            _control lnbAddRow [_entrytext];
            _icon = getText ( _cfg >> (typeOf _x) >> "icon");
            if(isText  (configFile >> "CfgVehicleIcons" >> _icon)) then {
                _icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
            };
            lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
        } foreach _mybox;

        // Box inside
        _control = _display displayCtrl (111);
        lbClear 111;
        lbSetCurSel [111, -1];
        {
            _entrytext = [(_x select 0)] call F_getLRXName;
            _control lnbAddRow [_entrytext, str (_x select 1)];
            _icon = getText ( _cfg >> (_x select 0) >> "icon");
            if(isText  (configFile >> "CfgVehicleIcons" >> _icon)) then {
                _icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
            };
            lnbSetPicture  [111, [((lnbSize 111) select 0) - 1, 0], _icon];
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
        //_control lbSetCurSel 0;
    };

	if ( !isNil "GRLIB_warehouse_in_use" ) then {
		hintSilent "Warehouse is busy !!\nPlease wait...";
        ctrlEnable [120, false];
        ctrlEnable [121, false];
		_refresh = true;
        sleep 1;
	} else {
        hintSilent "";

        // button
        _selected_item = lbCurSel 110;
        if (_selected_item != -1) then {
            ctrlEnable [120, true];
        } else {
            ctrlEnable [120, false];
        };

        _selected_item = lbCurSel 111;
        if (_selected_item != -1) then {
             if ((GRLIB_warehouse select _selected_item select 1) == 0) then {
                ctrlEnable [121, false];
            } else {
                ctrlEnable [121, true];
            };
        };

        if (load_box != 0) then {
            // load
            if (load_box == 1) then {
                ctrlEnable [120, false];
                _box = _mybox select (lbCurSel 110);
                _box_name = [typeOf _box] call F_getLRXName;
                _price = support_vehicles select {(_x select 0) == (typeOf _box)} select 0 select 2;
                _msg = format [localize "STR_WAREHOUSE_LOAD_MSG", _box_name, _price];
			    _result = [_msg, localize "STR_WAREHOUSE_LOAD", true, true] call BIS_fnc_guiMessage;
			    if (_result && !(isNull _box) && alive _box) then {
                    hintSilent format ["%1 Stored to Warehouse,\n for %2 AMMO.", _box_name, _price];
                    [_box, load_box, player] remoteExec ["warehouse_remote_call", 2];
                    playSound "taskSucceeded";
                    sleep 1;
                };
            };

            // unload
            if (load_box == 2) then {
                ctrlEnable [121, false];
                _box = GRLIB_warehouse select (lbCurSel 111) select 0;
                _box_name = [_box] call F_getLRXName;
                _price = support_vehicles select {(_x select 0) == (_box)} select 0 select 2;
                _msg = format [localize "STR_WAREHOUSE_UNLOAD_MSG", _box_name, _price];
                _result = [_msg, localize "STR_WAREHOUSE_UNLOAD", true, true] call BIS_fnc_guiMessage;

                if (_result) then {
                    if ((GRLIB_warehouse select (lbCurSel 111) select 1) <= 0) exitWith {};
                    buildtype = 9;
                    build_unit = [_box,[],1,[],[],[]];
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
                    sleep 1;
                };
            };

            _refresh = true;
            load_box = 0;
        };
    };
    sleep 0.3;
};
