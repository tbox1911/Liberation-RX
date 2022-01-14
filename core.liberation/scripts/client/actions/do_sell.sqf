params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private _price = 0;
_price = [_vehicle] call F_loadoutPrice;
if (_price == 0) exitWith {hintSilent "There is nothing to sell."};

private _vehtext = getText (configOf _vehicle >> "displayName");
private _msg = format ["<t align='center'>Sell ALL %1 cargo<br/>for %2 AMMO.<br/>Are you sure ?</t>", _vehtext, _price];
private _result = [_msg, "SELL CARGO", true, true] call BIS_fnc_guiMessage;
if (_result && _price > 0) then {
    clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	[player, _price] remoteExec ["ammo_add_remote_call", 2];

	hintSilent format ["%1 Cargo Sold.\n%2 +%3 AMMO !", _vehtext, name player, _price];
};


