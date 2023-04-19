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

//gamelogic globalChat localize "STR_SELL_WELCOME";
gamelogic globalChat "Welcome to the WareHouse";

while { dialog && alive player } do {

	if ( _refresh ) then {
        _refresh = false;

        // Box outside
        _control = _display displayCtrl (110);
        lbClear 110;
        _mybox = getPosATL player nearEntities [[waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename], 20];
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
        ctrlEnable [ 120, false ];
        ctrlEnable [ 121, false ];
		_refresh = true;
        sleep 1;
	} else {
        hintSilent "";

        // button
        _selected_item = lbCurSel 110;
        if (_selected_item != -1) then {
            ctrlEnable [ 120, true ];
        } else {
            ctrlEnable [ 120, false ];
        };

        _selected_item = lbCurSel 111;
        if (_selected_item != -1) then {
             if ((GRLIB_warehouse select _selected_item select 1) == 0) then {
                ctrlEnable [ 121, false ];
            } else {
                ctrlEnable [ 121, true ];
            };
        };

        if (load_box != 0) then {
            // load
            if (load_box == 1) then {
                _selected_item = lbCurSel 110;
                _box = _mybox select _selected_item;
                //systemchat format ["store box to warehouse:%1 %2", _box, typeof _box]; 
                [_box, load_box, player] remoteExec ["warehouse_remote_call", 2];
                //[player, _bounty, 0] remoteExec ["ammo_add_remote_call", 2];
	            //[player, _bonus] remoteExec ["F_addScore", 2];
            };

            // unload
            if (load_box == 2) then {
                _price = 0;
                // private _vehicle_name = (_display displayCtrl (111)) lnbText [_selected_item, 0];
                // private _price = parseNumber ((_display displayCtrl (111)) lnbText [_selected_item, 1]);
                // private _msg = format [localize "STR_SHOP_BUY_MSG", _vehicle_name, _price];
                // private _result = [_msg, localize "STR_SHOP_BUY", true, true] call BIS_fnc_guiMessage;
                // if (_result) then {};

                if ([_price] call F_pay) then {
                    _selected_item = lbCurSel 111;
                    _box = GRLIB_warehouse select _selected_item select 0;
                    //systemchat format ["load box from warehouse:%1 %2", _box, 0]; 
                    [_box, load_box, player] remoteExec ["warehouse_remote_call", 2];
				};
            };

            sleep 2;
            _refresh = true;
            load_box = 0;
        };

    };
    sleep 0.3;
};
