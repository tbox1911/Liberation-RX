waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "combat_readiness"};
waitUntil {sleep 1; !isNil "resources_intel"};

private _blufor_sectors = [];
private _combat_readiness = 0;
private _resources_intel = 0;

active_sectors = [];
publicVariable "active_sectors";

while { true } do {
	unitcap = { alive _x && local _x && (_x distance2D lhd) >= 200 } count (units GRLIB_side_friendly);
	opforcap = { alive _x && local _x && !(captive _x) } count (units GRLIB_side_enemy);
	civcap = { alive _x && local _x && (isNil {_x getVariable "GRLIB_vehicle_owner"})} count (units GRLIB_side_civilian);
	opfor_sectors = (sectors_allSectors - blufor_sectors);

	if !(blufor_sectors isEqualTo _blufor_sectors) then {
		_blufor_sectors = blufor_sectors;
		publicVariable "blufor_sectors";
	};

	if !(combat_readiness == _combat_readiness) then {
		_combat_readiness = combat_readiness;
		publicVariable "combat_readiness";
	};

	if !(resources_intel == _resources_intel) then {
		_resources_intel = resources_intel;
		publicVariable "resources_intel";
	};

	sleep 3;
	stats_playtime = stats_playtime + 3;	
};