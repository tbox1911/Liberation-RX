params ["_unit", "_vehicle"];

if (isNil "GRLIB_artillery_shot") then { GRLIB_artillery_shot = 0 };

private _cooldown = (1800/GRLIB_artillery_maxshot);

GRLIB_artillery_shot = GRLIB_artillery_shot + 1;

if (GRLIB_artillery_shot >= GRLIB_artillery_maxshot)  then {
	hint localize "STR_HINT_ARTILLERY_COOLDOWN";
	enableEngineArtillery false;
	if (_unit == gunner _vehicle) then { [_unit, false] spawn F_ejectUnit };
	waitUntil { sleep 2; GRLIB_artillery_shot < GRLIB_artillery_maxshot };
	enableEngineArtillery true;
};

sleep _cooldown;
GRLIB_artillery_shot = GRLIB_artillery_shot - 1;
if (GRLIB_artillery_shot < 0) then { GRLIB_artillery_shot = 0 };
