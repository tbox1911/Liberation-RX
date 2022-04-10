gamelogic globalChat localize "STR_SELL_WELCOME";

private _searchradius = 30;
private _vehicle = [player nearEntities [["LandVehicle","Air","Ship", A3W_BoxWps], _searchradius], {
		(_x distance lhd) >= GRLIB_sector_size &&
		!(typeOf _x in list_static_weapons) &&
		[player, _x] call is_owner && locked _x != 2
}] call BIS_fnc_conditionalSelect select 0;
if (isNil "_vehicle") exitWith { gamelogic globalChat localize "STR_SELL_NO_VEH" };

private _price = [_vehicle] call F_loadoutPrice;
if (_price == 0) exitWith { gamelogic globalChat localize "STR_NOTHING_TO_SELL"};

private _vehtext = getText (configOf _vehicle >> "displayName");
private _msg = format [localize "STR_SELL_CONFIRM", _vehtext, _price];
private _result = [_msg, localize "STR_SELL_BUTTON", true, true] call BIS_fnc_guiMessage;
if (_result) then {
    clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;
	[player, _price, 0] remoteExec ["ammo_add_remote_call", 2];
	hintSilent format [localize "STR_CARGO_SOLD", _vehtext, name player, _price];
	playSound "taskSucceeded";
	if (typeOf _vehicle == A3W_BoxWps) then {deleteVehicle _vehicle};
};

gamelogic globalChat "Have a nice day...";
