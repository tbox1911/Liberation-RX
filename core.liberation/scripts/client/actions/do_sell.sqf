params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

//warn user cargo is deleted !!
private _price = 0;
_price = [_vehicle] call F_loadoutPriceCargo;

private _vehtext = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
private _msg = format ["<t align='center'>Sell Weapons in %1 Cargo<br/>for %2 AMMO.<br/>Are you sure ?</t>", _vehtext, _price];
private _result = [_msg, "SELL CARGO", true, true] call BIS_fnc_guiMessage;
if (_result && _price > 0) then {

    clearWeaponCargoGlobal _vehicle;
	private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
	player setVariable ["GREUH_ammo_count", (_ammo_collected + _price), true];

	hintSilent format ["%1 Cargo Sold.\n%2 +%3 AMMO !", _vehtext, name player, _price];
};


