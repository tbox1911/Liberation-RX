// LRX Trader Shop
// by pSiKO

createDialog "Traders_Shop";
waitUntil { dialog };

private _display = findDisplay 2304;
private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
private _cfg = configFile >> "cfgVehicles";
private _ratio = (player nearEntities [SHOP_man, 10] select 0) getvariable ["SHOP_ratio", 0.75];

private _sell_list = [];
private _sell_blacklist = [];

private _getPrice = {
	params ["_class"];
	private _ret = SHOP_list select { (_x select 0) == _class } select 0 select 2;
	if (isNil "_ret") then { _ret = 1 };
	_ret;
};

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
	private _price = round ((_x select 2) * (1 + _ratio));
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

	if ( (_x select 1) <= _ammo_collected ) then {
		(_display displayCtrl (111)) lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [1,1,1,1]];
		(_display displayCtrl (111)) lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [1,1,1,1]];
	} else {
		(_display displayCtrl (111)) lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [0.4,0.4,0.4,1]];
		(_display displayCtrl (111)) lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [0.4,0.4,0.4,1]];
	};
} foreach _buy_list_dlg1;

shop_action = 0;
_refresh = true;
gamelogic globalChat "Welcome to my shop, stranger";
while { dialog && alive player } do {
	if (_refresh) then {
		// Init SELL list

		private _sell_classnames = ["LandVehicle","Air","Ship","ReammoBox_F","Items_base_F"];
		_sell_list = [getPosATL player nearEntities [_sell_classnames, 100], {
			alive _x && (count (crew _x) == 0 || typeOf _x in uavs) &&
			locked _x != 2 &&
			!(_x getVariable ["R3F_LOG_disabled", false]) &&
			[player, _x] call is_owner &&
			!(typeOf _x in _sell_blacklist)
		}] call BIS_fnc_conditionalSelect;

		private _sell_list_dlg1 = [];
		{
			private _classname = typeOf _x;
			private _price = [_classname] call _getPrice;
			_price = round ((_price * GRLIB_recycling_percentage) * _ratio);
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
		} foreach _sell_list_dlg1;

		lbSetCurSel [110, -1];
		_refresh = false;
	};

	_selected_item = lbCurSel 110;
	if (_selected_item != -1) then { ctrlEnable [120, true] } else { ctrlEnable [120, false] };
	_selected_item = lbCurSel 111;
	private _price = parseNumber ((_display displayCtrl (111)) lnbText [_selected_item, 1]);
	if (_selected_item != -1 && _price <= _ammo_collected) then { ctrlEnable [121, true] } else { ctrlEnable [121, false] };

	if (shop_action != 0) then {

		if (shop_action == 1) then {
			_selected_item = lbCurSel 110;
			private _vehicle_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];
			private _price = parseNumber ((_display displayCtrl (110)) lnbText [_selected_item, 1]);
			private _vehicle = _sell_list select _selected_item;
			private _msg = format [localize "STR_SHOP_SELL_MSG", _vehicle_name, _price];
			private _result = [_msg, localize "STR_SHOP_SELL", true, true] call BIS_fnc_guiMessage;
			if (_result && !(isNull _vehicle) && alive _vehicle) then {
				[_vehicle] remoteExec ["deleteVehicle", 2];
				player setVariable ["GREUH_ammo_count", (_ammo_collected + _price), true];
				hintSilent format ["%1 Sold for %2 AMMO !", _vehicle_name, _price];
				ctrlEnable [120, false];
				playSound "taskSucceeded";
			};
			_refresh = true;
		};

		if (shop_action == 2) then {
			_selected_item = lbCurSel 111;
			private _vehicle_name = (_display displayCtrl (111)) lnbText [_selected_item, 0];
			private _price = parseNumber ((_display displayCtrl (111)) lnbText [_selected_item, 1]);
			private _msg = format [localize "STR_SHOP_BUY_MSG", _vehicle_name, _price];
			private _result = [_msg, localize "STR_SHOP_BUY", true, true] call BIS_fnc_guiMessage;
			if (_result) then {
				player setVariable ["GREUH_ammo_count", (_ammo_collected - _price), true];
				private _veh_class = _buy_list_dlg1 select _selected_item select 0;
				buildtype = 9;
				build_unit = [_veh_class,[],1,[],[]];
				dobuild = 1;
				closeDialog 0;
			};
		};
		shop_action = 0;
	};

	sleep 0.3;
};
gamelogic globalChat "Have a nice day...";
