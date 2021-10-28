// Virtual Garage

createDialog "Traders_Shop";
waitUntil { dialog };

_display = findDisplay 2304;
ctrlEnable [ 120, false ];
ctrlEnable [ 121, false ];

private _cfg = configFile >> "cfgVehicles";
private _sell_list = [];
private _sell_blacklist = [];
private _buy_list = [];
private _buy_blacklist = [];

// Init SELL list
_sell_list = [nearestObjects [player, ["LandVehicle","Air","Ship"], 100], {
	alive _x && (count (crew _x) == 0 || typeOf _x in uavs) &&
	[player, _x] call is_owner &&
	!(typeOf _x in _sell_blacklist)
}] call BIS_fnc_conditionalSelect;

private _sell_list_dlg1 = [];
{_sell_list_dlg1 pushBack [(typeOf _x), round(random 100)]} forEach _sell_list;  // sell veh list

lbClear 110;
{
	_classnamevar = (_x select 0);
	_entrytext = getText (_cfg >> _classnamevar >> "displayName");
	(_display displayCtrl (110)) lnbAddRow [_entrytext, str(_x select 1)];

	_icon = getText ( _cfg >> (_x select 0) >> "icon");
	if(isText  (configFile >> "CfgVehicleIcons" >> _icon)) then {
		_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
	};
	lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0],_icon];

	// if ( (_x select 1) == 0 ) then {
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [1,1,1,1]];
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [1,1,1,1]];
	// } else {
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [0.4,0.4,0.4,1]];
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [0.4,0.4,0.4,1]];
	// };
} foreach _sell_list_dlg1;

// Init BUY list
_buy_list = [opfor_recyclable, {
	!((_x select 0) in _buy_blacklist)
}] call BIS_fnc_conditionalSelect;

private _buy_list_dlg1 = [];
{_buy_list_dlg1 pushBack [_x select 0, _x select 2]} forEach _buy_list;  // buy veh list

lbClear 111;
{
	_classnamevar = (_x select 0);
	_entrytext = getText (_cfg >> _classnamevar >> "displayName");
	(_display displayCtrl (111)) lnbAddRow [_entrytext, str(_x select 1)];

	_icon = getText ( _cfg >> (_x select 0) >> "icon");
	if(isText  (configFile >> "CfgVehicleIcons" >> _icon)) then {
		_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
	};
	lnbSetPicture  [111, [((lnbSize 111) select 0) - 1, 0],_icon];

	// if ( (_x select 1) == 0 ) then {
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [1,1,1,1]];
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [1,1,1,1]];
	// } else {
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 0], [0.4,0.4,0.4,1]];
	// 	(_display displayCtrl (110)) lnbSetColor [[((lnbSize 110) select 0) - 1, 1], [0.4,0.4,0.4,1]];
	// };
} foreach _buy_list_dlg1;

shop_action = 0;
while { dialog && alive player } do {
	// if (_selected_item != -1) then {
	// 	_vehicle = _myveh select _selected_item;
	// 	if ((_vehicle select 1) == 0) then {
	// 		ctrlEnable [ 120, true ];
	// 	} else {
	// 		ctrlEnable [ 121, true ];
	// 	};
	// };

	if (shop_action != 0) then {

		if (shop_action == 1) then {
			_selected_item = lbCurSel 110;
			_vehicle_name = (_display displayCtrl (110)) lnbText [_selected_item,0];
			systemchat format ["do SELL action %1", _vehicle_name];
		};

		if (shop_action == 2) then {
			_selected_item = lbCurSel 111;
			_vehicle_name = (_display displayCtrl (111)) lnbText [_selected_item,0];
			systemchat format ["do BUY action %1", _vehicle_name];
		};

		sleep 1;
		shop_action = 0;
	};

	sleep 0.3;
};
