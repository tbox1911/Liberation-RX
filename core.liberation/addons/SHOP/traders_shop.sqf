// LRX Trader Shop
// by pSiKO

if (([GRLIB_sector_size] call F_getNearestSector) in active_sectors) exitWith {
	gamelogic globalChat "You cannot access the Trader shop during combat.";
};

createDialog "Traders_Shop";
waitUntil { dialog };

private _display = findDisplay 2304;
private _ctrl_sell = _display displayCtrl (110);
private _ctrl_buy = _display displayCtrl (111);
private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
private _cfg = configFile >> "cfgVehicles";
private _ratio = (player nearEntities [SHOP_Man, 10] select 0) getvariable ["SHOP_ratio", 0.45];

private _sell_list = [];
private _sell_blacklist = [];

// Init BUY list
private _civ_blacklist = ["fuel", "service", "medevac"];
private _reputation = [player] call F_getReput;
private _civ_vehicle = [];
private _find_multiple = {
    params ["_item", "_list"]; 
    private _ret = false; 
    { if (_item find _x > 0) exitWith { _ret = true } } foreach _list;
    _ret;
};

if (_reputation >= 0) then {
	private _price = 35;
	if (_reputation >= 70) then { _price = round (_price / 2) };
	{
		if (count _civ_vehicle == 5) exitWith {};
		if (_x isKindOf "LandVehicle" && !([_x, _civ_blacklist] call _find_multiple)) then {
			_civ_vehicle pushBackUnique [_x, 5, _price];
		};
	} forEach (civilian_vehicles call BIS_fnc_arrayShuffle);
};

private _opfor_blacklist = [];
private _opfor_vehicle = opfor_recyclable select { !((_x select 0) isKindOf "Air") && !([_x, _opfor_blacklist] call _find_multiple)};

private _buy_list_veh = SHOP_list + _civ_vehicle + _opfor_vehicle;
private _rank = player getVariable ["GRLIB_Rank", "Private"];
private _buy_list_dlg = [];
{
	private _price = [_x select 0, _buy_list_veh] call F_getObjectPrice;
	_price = round (_price * (1 + _ratio));
	if (_rank == "Super Colonel") then { _price = round (_price / 2)};
	_buy_list_dlg pushBack [_x select 0, _price];
} forEach _buy_list_veh;

lbClear 111;
{
	_entrytext = [(_x select 0)] call F_getLRXName;
	if (count _entrytext > 25) then { _entrytext = _entrytext select [0,25] };
	lnbAddRow [111, [_entrytext, str (_x select 1)]];

	_icon = getText ( _cfg >> (_x select 0) >> "icon");
	if(isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
		_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
	};
	lnbSetPicture [111, [((lnbSize 111) select 0) - 1, 0],_icon];
	lnbSetData [111, [((lnbSize 111) select 0) - 1, 0], (_x select 0)];

	if ( (_x select 1) <= _ammo_collected ) then {
		_ctrl_buy lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [1,1,1,1]];
		_ctrl_buy lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [1,1,1,1]];
	} else {
		_ctrl_buy lnbSetColor [[((lnbSize 111) select 0) - 1, 0], [0.4,0.4,0.4,1]];
		_ctrl_buy lnbSetColor [[((lnbSize 111) select 0) - 1, 1], [0.4,0.4,0.4,1]];
	};
} foreach _buy_list_dlg;

_ctrl_buy ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel", "_lbSelection"];
	_control ctrlSetTooltip str (_control lnbData [_lbCurSel, 0]);
}];
lbSetCurSel [111, 0];

gamelogic globalChat "Welcome to my shop, stranger";
shop_action = 0;
private _refresh = true;

private _selected_item = 0;
private _selected_item_bak = -1;
private _price = 0;
private _picture = getMissionPath "res\preview\no_image.jpg";
private _veh_class = "";
private _vehicle_name = "";

while { dialog && alive player } do {
	if (_refresh) then {
		// Init SELL list
		private _sell_classnames = ["LandVehicle","Air","Ship_F","ReammoBox_F","Items_base_F"];
		_sell_list = (player nearEntities [_sell_classnames, 50]) select {
			alive _x && (count (crew _x) == 0 || (typeOf _x in uavs_vehicles)) &&
			locked _x != 2 &&
			!(_x getVariable ["R3F_LOG_disabled", false]) &&
			isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
			[player, _x] call is_owner &&
			!(typeOf _x in _sell_blacklist)
		};

		private _sell_list_dlg = [];
		{
			private _price = 1 max ([(typeOf _x)] call F_getObjectPrice);
			_sell_list_dlg pushBack [
				(typeOf _x),
				round ((_price * _ratio) * (1 - damage _x))
			];			
		} forEach _sell_list;

		lbClear 110;
		{
			_entrytext = [(_x select 0)] call F_getLRXName;
			if (count _entrytext > 25) then { _entrytext = _entrytext select [0,25] };	
			lnbAddRow [110, [_entrytext, str (_x select 1)]];

			_icon = getText ( _cfg >> (_x select 0) >> "icon");
			if(isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture [110, [((lnbSize 110) select 0) - 1, 0],_icon];
		} foreach _sell_list_dlg;

		lbSetCurSel [110, -1];
		_refresh = false;
	};

	_selected_item = lbCurSel 110;
	if (_selected_item != -1) then { ctrlEnable [120, true] } else { ctrlEnable [120, false] };

	_selected_item = lbCurSel 111;
	if (_selected_item != _selected_item_bak) then {
		_price = parseNumber (_ctrl_buy lnbText [_selected_item, 1]);
		if (_selected_item != -1 && _price <= _ammo_collected) then { ctrlEnable [121, true] } else { ctrlEnable [121, false] };

		_veh_class = _buy_list_dlg select _selected_item select 0;
		_picture = getText (configFile >> "CfgVehicles" >> _veh_class >> "editorPreview");
		if (_picture == "") then { _picture = getMissionPath "res\preview\no_image.jpg" };
		(_display displayCtrl (122)) ctrlSetText _picture;
		_selected_item_bak = _selected_item;
	};

	if (shop_action != 0) then {

		if (shop_action == 1) then {
			ctrlEnable [120, false];
			_selected_item = lbCurSel 110;
			private _vehicle_name = _ctrl_sell lnbText [_selected_item, 0];
			private _price = parseNumber (_ctrl_sell lnbText [_selected_item, 1]);
			private _vehicle = _sell_list select _selected_item;
			private _msg = format [localize "STR_SHOP_SELL_MSG", _vehicle_name, _price];
			private _result = [_msg, localize "STR_SHOP_SELL", true, true] call BIS_fnc_guiMessage;
			if (_result && !(isNull _vehicle) && alive _vehicle) then {
				deleteVehicle _vehicle;
				[player, _price, 0] remoteExec ["ammo_add_remote_call", 2];
				_msg = format ["%1 Sold for %2 AMMO !", _vehicle_name, _price];
				hintSilent _msg;
				gamelogic globalChat _msg;
				ctrlEnable [120, false];
				playSound "taskSucceeded";
				_refresh = true;
			};
		};

		if (shop_action == 2) then {
			ctrlEnable [121, false];
			_selected_item = lbCurSel 111;
			_vehicle_name = _ctrl_buy lnbText [_selected_item, 0];
			_price = parseNumber (_ctrl_buy lnbText [_selected_item, 1]);
			private _msg = format [localize "STR_SHOP_BUY_MSG", _vehicle_name, _price];
			private _result = [_msg, localize "STR_SHOP_BUY", true, true] call BIS_fnc_guiMessage;
			if (_result) then {
				_veh_class = _buy_list_dlg select _selected_item select 0;
				buildtype = GRLIB_BuildTypeDirect;
				build_unit = [_veh_class,[],1,[],[],[],[]];
				dobuild = 1;
				closeDialog 0;
				waitUntil { sleep 0.5; dobuild == 0};

				if (build_confirmed == 0) then {
					if (!([_price] call F_pay)) then {
						deleteVehicle build_vehicle;
					};
				};
				sleep 1;
			};
		};
		shop_action = 0;
	};

	sleep 0.3;
};
gamelogic globalChat "Have a nice day...";
