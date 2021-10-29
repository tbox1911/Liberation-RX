// LRX Trader Shop
// by pSiKO

createDialog "Traders_Shop";
waitUntil { dialog };

_display = findDisplay 2304;
//ctrlEnable [ 120, false ];
//ctrlEnable [ 121, false ];

private _cfg = configFile >> "cfgVehicles";
private _sell_list = [];
private _sell_blacklist = [];
private _classname_box = [
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	A3W_BoxWps
];
private _classname_barrel = [
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename
];

private _getPrice = {
	params ["_class"];
	private _ret = SHOP_list select { (_x select 0) == _class } select 0 select 2;
	if (isNil "_ret") then { _ret = 1 };
	_ret;
};

// Init SELL list

private _sell_classnames = ["LandVehicle","Air","Ship"];
{ _sell_classnames pushBack _x } foreach _classname_box + _classname_barrel;

_sell_list = [nearestObjects [player, _sell_classnames, 100], {
	alive _x && (count (crew _x) == 0 || typeOf _x in uavs) &&
	[player, _x] call is_owner &&
	!(typeOf _x in _sell_blacklist)
}] call BIS_fnc_conditionalSelect;

private _sell_list_dlg1 = [];
{
	private _classname = typeOf _x;
	private _price = [_classname] call _getPrice;
	
	if (_classname in _classname_box) then {
		_price = round ((_price * GRLIB_recycling_percentage) / 1.5);
	};
	if (_classname in _classname_barrel) then {
		_price = round ((_price * GRLIB_recycling_percentage) * 1.5);
	};
	
	_price = round (_price * SHOP_ratio);	//shop ratio
	_sell_list_dlg1 pushBack [_classname, _price];
} forEach _sell_list;

lbClear 110;
{
	_classnamevar = (_x select 0);
	_entrytext = getText (_cfg >> _classnamevar >> "displayName");
	if (count _entrytext > 25) then { _entrytext = _entrytext select [0,25] };	
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
private _buy_list_static = [
	[Arsenal_typename, 0, 67],
	[medicalbox_typename, 0, 60],
	[fuelbarrel_typename, 0, 150],
	["Box_NATO_WpsLaunch_F", 0, 140]
];
private _buy_blacklist = [];

private _buy_list = [opfor_recyclable, {
	(_x select 3) >= 2 && (_x select 3) <= 15 &&
	!((_x select 0) in _buy_blacklist)
}] call BIS_fnc_conditionalSelect;

private _buy_list_dlg1 = [];
{
	private _price = round ((_x select 2) * (1 + SHOP_ratio));	//shop ratio
	_buy_list_dlg1 pushBack [_x select 0, _price];
} forEach _buy_list_static + _buy_list;

lbClear 111;
{
	_classnamevar = (_x select 0);
	_entrytext = getText (_cfg >> _classnamevar >> "displayName");
	if (count _entrytext > 25) then { _entrytext = _entrytext select [0,25] };
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
			_vehicle_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];
			_price =  (_display displayCtrl (110)) lnbText [_selected_item, 1];
			systemchat format ["do SELL action %1 for %2", _vehicle_name, _price];
		};

		if (shop_action == 2) then {
			_selected_item = lbCurSel 111;
			_vehicle_name = (_display displayCtrl (111)) lnbText [_selected_item, 0];
			_price =  (_display displayCtrl (111)) lnbText [_selected_item, 1];
			systemchat format ["do BUY action %1 for %2", _vehicle_name, _price];
		};

		sleep 1;
		shop_action = 0;
	};

	sleep 0.3;
};
