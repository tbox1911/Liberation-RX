// LRX SELL Shop
// by pSiKO

createDialog "Sell_Shop";
waitUntil { dialog };

private _sell_list = [];
private _display = findDisplay 2305;
private _cfg = configFile >> "cfgVehicles";

private _nearfob = ((player distance2D ([] call F_getNearestFob)) < 100);
if (_nearfob) then {
	gamelogic globalChat localize "STR_SELL_WELCOME_FOB";
} else {
	gamelogic globalChat localize "STR_SELL_WELCOME";
};
sell_action = 0;
private _refresh = true;
private _price = 0;

while { dialog && alive player } do {
	if (_refresh) then {
		// Init SELL list
		private _sell_classnames = ["LandVehicle","Air","Ship","ReammoBox_F"] + GRLIB_Ammobox_keep;
		_sell_list = [getPosATL player nearEntities [_sell_classnames, 50], {
			alive _x &&
			(_x distance2D lhd > GRLIB_fob_range) &&
			!(typeOf _x in list_static_weapons) &&
			!(_x getVariable ['R3F_LOG_disabled', false]) &&
			[player, _x] call is_owner && locked _x != 2
		}] call BIS_fnc_conditionalSelect;

		private _sell_list_dlg = [];
		{
			_price = [_x] call F_loadoutPrice;
			if (_nearfob) then {
				_price = round (_price * GRLIB_recycling_percentage);
			} else {
				_price = round (_price / GRLIB_recycling_percentage);
			};		
			_sell_list_dlg pushBack [(typeOf _x), _price];
		} forEach _sell_list;

		lbClear 110;
		{
			_entrytext = [(_x select 0)] call F_getLRXName;
			if (count _entrytext > 25) then { _entrytext = _entrytext select [0,25] };	
			(_display displayCtrl (110)) lnbAddRow [_entrytext, str(_x select 1)];

			_icon = getText ( _cfg >> (_x select 0) >> "icon");
			if(isText  (configFile >> "CfgVehicleIcons" >> _icon)) then {
				_icon = (getText (configFile >> "CfgVehicleIcons" >> _icon));
			};
			lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0],_icon];
		} foreach _sell_list_dlg;

		lbSetCurSel [110, -1];
		_refresh = false;
	};

	_selected_item = lbCurSel 110;
	if (_selected_item != -1) then { ctrlEnable [120, true] } else { ctrlEnable [120, false] };
	_selected_item = lbCurSel 111;

	if (sell_action != 0) then {
		if (sell_action == 1) then {
			private _selected_item = lbCurSel 110;
			private _vehicle_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];
			_price = parseNumber ((_display displayCtrl (110)) lnbText [_selected_item, 1]);
			if (_price == 0) then {
				gamelogic globalChat localize "STR_NOTHING_TO_SELL";			
			} else {
				private _vehicle = _sell_list select _selected_item;
				private _msg = format [localize "STR_SELL_CONFIRM", _vehicle_name, _price];
				private _result = [_msg, localize "STR_SELL_BUTTON", true, true] call BIS_fnc_guiMessage;
				if (_result) then {
					clearWeaponCargoGlobal _vehicle;
					clearMagazineCargoGlobal _vehicle;
					clearItemCargoGlobal _vehicle;
					clearBackpackCargoGlobal _vehicle;
					[player, _price, 0] remoteExec ["ammo_add_remote_call", 2];
					hintSilent format [localize "STR_CARGO_SOLD", _vehicle_name, name player, _price];
					playSound "taskSucceeded";
					if (typeOf _vehicle in GRLIB_disabled_arsenal) then {deleteVehicle _vehicle};
				};
			_refresh = true;
			};
		};	
		sell_action = 0;
	};
	sleep 0.3;
};
gamelogic globalChat "Have a nice day...";
