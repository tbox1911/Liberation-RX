params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

//warn user cargo is deleted !!
private _result = ["<t align='center'>Vehicle's content will be LOST !!<br/>Are you sure ?</t>", "Warning !", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	//R3F
	{[_x] remoteExec ["deleteVehicle", 0]} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
	_vehicle setVariable ["R3F_LOG_objets_charges", [], true];

	//A3
    clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;

	_text = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
	hintSilent format ["%1 Cargo Cleared !", _text];
};


