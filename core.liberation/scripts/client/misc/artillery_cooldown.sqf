if (isNil "GRLIB_artillery_shot") then { GRLIB_artillery_shot = 0 };

// max 15 shot in 30 min 
private _max_shot = 15;
private _cooldown = (1800/_max_shot);

GRLIB_artillery_shot = GRLIB_artillery_shot + 1;

if (GRLIB_artillery_shot >= _max_shot)  then {
	hint "Artillery Cooldown!\nYou are overusing artillery fire, slow down!";
	enableEngineArtillery false;
	waitUntil { sleep 2; GRLIB_artillery_shot < _max_shot };
	enableEngineArtillery true;
};

sleep _cooldown;
GRLIB_artillery_shot = GRLIB_artillery_shot - 1;
if (GRLIB_artillery_shot < 0) then { GRLIB_artillery_shot = 0 };
