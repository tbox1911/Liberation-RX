params ["_unit", "_vehicle", "_magazine"];

if (_unit != gunner _vehicle) exitWith {};

private _is_arty = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "artilleryScanner");
if (_is_arty == 0) exitWith {};

private _cooldown = (1800/GRLIB_artillery_maxshot);
GRLIB_artillery_shot = GRLIB_artillery_shot + 1;

if (GRLIB_artillery_shot >= GRLIB_artillery_maxshot)  then {
	hint localize "STR_HINT_ARTILLERY_COOLDOWN";
	enableEngineArtillery false;
	[_unit, false] spawn F_ejectUnit;
	waitUntil { sleep 2; GRLIB_artillery_shot < GRLIB_artillery_maxshot };
	enableEngineArtillery true;
};

sleep _cooldown;
GRLIB_artillery_shot = 0 max (GRLIB_artillery_shot - 1);
